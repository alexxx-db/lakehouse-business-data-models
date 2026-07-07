-- Schema for Domain: quality | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`quality` COMMENT 'Quality measurement, patient safety, regulatory reporting, and clinical compliance. Owns HEDIS measures, CAHPS surveys, CMS quality programs (VBP - Value-Based Purchasing, MIPS, APM), HAI tracking (CLABSI, CAUTI, SSI), patient safety events, mortality reviews, CDI metrics, TJC survey readiness, CMS Conditions of Participation compliance, and accreditation management. Supports Healthy Planet population health analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` (
    `hedis_measure_id` BIGINT COMMENT 'Primary key',
    `code_set_version_id` BIGINT COMMENT 'FK to code set version',
    `compliance_policy_id` BIGINT COMMENT 'FK to compliance policy',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `loinc_code_id` BIGINT COMMENT 'FK to LOINC code',
    `age_range_max` STRING COMMENT 'Maximum age for measure eligibility',
    `age_range_min` STRING COMMENT 'Minimum age for measure eligibility',
    `allowable_gap_days` STRING COMMENT 'Allowable gap in continuous enrollment',
    `clinical_area` STRING COMMENT 'Clinical domain (e.g. diabetes, cardiovascular)',
    `collection_method` STRING COMMENT 'Administrative, hybrid, or survey',
    `continuous_enrollment_days` STRING COMMENT 'Required continuous enrollment period',
    `cpt_code_list` STRING COMMENT 'Comma-separated CPT codes',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `denominator_definition` STRING COMMENT 'Denominator logic',
    `domain_category` STRING COMMENT 'HEDIS domain (e.g. Effectiveness of Care)',
    `dummy_extra` STRING COMMENT 'The dummy extra of the quality hedis measure record.',
    `effective_end_date` DATE COMMENT 'Measure version end date',
    `effective_start_date` DATE COMMENT 'Measure version start date',
    `eligible_population_description` STRING COMMENT 'Eligible population narrative',
    `exception_criteria` STRING COMMENT 'Denominator exception logic',
    `exclusion_criteria` STRING COMMENT 'Denominator exclusion logic',
    `hedis_ecqm_code` STRING COMMENT 'eCQM identifier if applicable',
    `hybrid_medical_record_required` BOOLEAN COMMENT 'Hybrid methodology flag',
    `icd10_code_list` STRING COMMENT 'Comma-separated ICD-10 codes',
    `loinc_code_list` STRING COMMENT 'Comma-separated LOINC codes',
    `measure_code` STRING COMMENT 'HEDIS measure code (e.g. CBP, CDC)',
    `measure_name` STRING COMMENT 'Full measure name',
    `measure_short_name` STRING COMMENT 'Abbreviated name',
    `measure_status` STRING COMMENT 'Active, retired, or draft',
    `measure_type` STRING COMMENT 'Process, outcome, or structure',
    `measure_version` STRING COMMENT 'NCQA version year',
    `measurement_year` STRING COMMENT 'Reporting year',
    `minimum_performance_threshold` DECIMAL(18,2) COMMENT 'Minimum acceptable rate',
    `mips_eligible` BOOLEAN COMMENT 'MIPS reporting eligible flag',
    `national_average_rate` DECIMAL(18,2) COMMENT 'National average performance',
    `national_benchmark_rate` DECIMAL(18,2) COMMENT 'National benchmark',
    `ncqa_program` STRING COMMENT 'HEDIS, PCMH, etc.',
    `ncqa_specification_url` STRING COMMENT 'Link to NCQA spec',
    `notes` STRING COMMENT 'Implementation notes',
    `numerator_definition` STRING COMMENT 'Numerator logic',
    `performance_rate_direction` STRING COMMENT 'Higher or lower is better',
    `product_line` STRING COMMENT 'Commercial, Medicaid, Medicare',
    `reporting_period_end_date` DATE COMMENT 'Measurement period end',
    `reporting_period_start_date` DATE COMMENT 'Measurement period start',
    `reporting_submission_deadline` DATE COMMENT 'NCQA submission deadline',
    `responsible_program` STRING COMMENT 'Owning quality program',
    `stratification_criteria` STRING COMMENT 'Stratification logic',
    `stratification_required` BOOLEAN COMMENT 'Stratification required flag',
    `target_performance_rate` DECIMAL(18,2) COMMENT 'Internal target rate',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `value_set_oid` STRING COMMENT 'VSAC value set OID',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_hedis_measure PRIMARY KEY(`hedis_measure_id`)
) COMMENT 'NCQA HEDIS quality measure definitions for managed care performance measurement. Supports Medicare Advantage Star Ratings, Medicaid quality reporting, and commercial health plan accreditation. Business justification: Required for CMS quality reporting, payer contract compliance, and NCQA accreditation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` (
    `hedis_result_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'FK to regulatory submission',
    `fiscal_period_id` BIGINT COMMENT 'FK to fiscal period',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `hedis_measure_id` BIGINT COMMENT 'FK to HEDIS measure',
    `interface_channel_id` BIGINT COMMENT 'FK to interface channel',
    `org_provider_id` BIGINT COMMENT 'FK to org provider',
    `research_study_id` BIGINT COMMENT 'FK to research study',
    `audit_status` STRING COMMENT 'The audit status value classifying the quality hedis result record.',
    `auditor_organization` STRING COMMENT 'External auditor name',
    `benchmark_comparison_result` STRING COMMENT 'Above, at, or below benchmark',
    `calculation_run_timestamp` TIMESTAMP COMMENT 'Calculation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_source_type` STRING COMMENT 'Administrative, hybrid, or survey',
    `denominator_count` STRING COMMENT 'The denominator count of the quality hedis result record.',
    `exception_count` STRING COMMENT 'The exception count of the quality hedis result record.',
    `exclusion_count` STRING COMMENT 'The exclusion count of the quality hedis result record.',
    `gap_count` STRING COMMENT 'Care gap count',
    `hybrid_sample_size` STRING COMMENT 'The hybrid sample size of the quality hedis result record.',
    `hybrid_supplemental_data_used` BOOLEAN COMMENT 'Hybrid supplemental data flag',
    `initial_population_count` STRING COMMENT 'The initial population count of the quality hedis result record.',
    `is_reportable` BOOLEAN COMMENT 'Reportable flag',
    `is_starred_measure` BOOLEAN COMMENT 'Star rating measure flag',
    `measurement_year` STRING COMMENT 'The measurement year of the quality hedis result record.',
    `methodology_type` STRING COMMENT 'Administrative, hybrid, or survey',
    `mips_quality_category` STRING COMMENT 'The mips quality category of the quality hedis result record.',
    `ncqa_benchmark_percentile_50` DECIMAL(18,2) COMMENT 'NCQA 50th percentile',
    `ncqa_benchmark_percentile_90` DECIMAL(18,2) COMMENT 'NCQA 90th percentile',
    `numerator_count` STRING COMMENT 'The numerator count of the quality hedis result record.',
    `performance_rate` DECIMAL(18,2) COMMENT 'The performance rate of the quality hedis result record.',
    `prior_year_performance_rate` DECIMAL(18,2) COMMENT 'Prior year rate',
    `product_line` STRING COMMENT 'Commercial, Medicaid, Medicare',
    `rate_change_from_prior_year` DECIMAL(18,2) COMMENT 'Year-over-year change',
    `reporting_period_end_date` DATE COMMENT 'Reporting period end',
    `reporting_period_start_date` DATE COMMENT 'Reporting period start',
    `result_identifier` STRING COMMENT 'The result identifier of the quality hedis result record.',
    `result_notes` STRING COMMENT 'The result notes of the quality hedis result record.',
    `result_version` STRING COMMENT 'The result version of the quality hedis result record.',
    `star_rating_weight` DECIMAL(18,2) COMMENT 'The star rating weight of the quality hedis result record.',
    `stratification_category` STRING COMMENT 'The stratification category of the quality hedis result record.',
    `submission_date` DATE COMMENT 'Timestamp capturing the submission date associated with the quality hedis result record.',
    `submission_status` STRING COMMENT 'The submission status value classifying the quality hedis result record.',
    `submission_target` STRING COMMENT 'Submission target (NCQA, CMS)',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_hedis_result PRIMARY KEY(`hedis_result_id`)
) COMMENT 'Calculated HEDIS measure results by reporting period, health plan, and care site. Tracks numerator/denominator counts, performance rates, and benchmark comparisons. Business justification: Drives VBP incentive payments, Star Rating calculations, and quality improvement initiatives.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` (
    `cahps_survey_id` BIGINT COMMENT 'Primary key',
    `audit_id` BIGINT COMMENT 'FK to audit',
    `billing_coverage_id` BIGINT COMMENT 'FK to billing coverage',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI record',
    `unit_id` BIGINT COMMENT 'FK to unit',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `administration_mode` STRING COMMENT 'Mail, phone, or web',
    `cms_certification_number` STRING COMMENT 'The cms certification number of the quality cahps survey record.',
    `cms_submission_date` DATE COMMENT 'Timestamp capturing the cms submission date associated with the quality cahps survey record.',
    `cms_submission_status` STRING COMMENT 'The cms submission status value classifying the quality cahps survey record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `discharge_date` DATE COMMENT 'Timestamp capturing the discharge date associated with the quality cahps survey record.',
    `eligible_discharges` STRING COMMENT 'Eligible discharge count',
    `exclusion_reason` STRING COMMENT 'The exclusion reason of the quality cahps survey record.',
    `hcahps_linear_mean_score` DECIMAL(18,2) COMMENT 'The hcahps linear mean score of the quality cahps survey record.',
    `minimum_case_threshold_met` BOOLEAN COMMENT 'Minimum case threshold met flag',
    `mode_adjustment_applied` BOOLEAN COMMENT 'Mode adjustment applied flag',
    `overall_hospital_rating` STRING COMMENT 'Overall hospital rating (0-10)',
    `patient_mix_adjustment_applied` BOOLEAN COMMENT 'Patient mix adjustment applied flag',
    `publicly_reported` BOOLEAN COMMENT 'Publicly reported flag',
    `recommend_hospital` STRING COMMENT 'Recommend hospital (Yes/No/Maybe)',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `reporting_period_end` DATE COMMENT 'The reporting period end of the quality cahps survey record.',
    `reporting_period_start` DATE COMMENT 'The reporting period start of the quality cahps survey record.',
    `response_date` DATE COMMENT 'Timestamp capturing the response date associated with the quality cahps survey record.',
    `response_language` STRING COMMENT 'The response language of the quality cahps survey record.',
    `response_received` BOOLEAN COMMENT 'Response received flag',
    `sample_size` STRING COMMENT 'The sample size of the quality cahps survey record.',
    `sampling_methodology` STRING COMMENT 'The sampling methodology of the quality cahps survey record.',
    `score_care_transition` DECIMAL(18,2) COMMENT 'Care transition score',
    `score_cleanliness` DECIMAL(18,2) COMMENT 'Cleanliness score',
    `score_communication_doctors` DECIMAL(18,2) COMMENT 'Communication with doctors score',
    `score_communication_medicines` DECIMAL(18,2) COMMENT 'Communication about medicines score',
    `score_communication_nurses` DECIMAL(18,2) COMMENT 'Communication with nurses score',
    `score_discharge_information` DECIMAL(18,2) COMMENT 'Discharge information score',
    `score_pain_management` DECIMAL(18,2) COMMENT 'Pain management score',
    `score_quietness` DECIMAL(18,2) COMMENT 'Quietness score',
    `score_responsiveness_staff` DECIMAL(18,2) COMMENT 'Staff responsiveness score',
    `star_rating` STRING COMMENT 'Star rating (1-5)',
    `survey_followup_date` DATE COMMENT 'Timestamp capturing the survey followup date associated with the quality cahps survey record.',
    `survey_mailed_date` DATE COMMENT 'Timestamp capturing the survey mailed date associated with the quality cahps survey record.',
    `survey_program_code` STRING COMMENT 'The survey program code value classifying the quality cahps survey record.',
    `survey_status` STRING COMMENT 'The survey status value classifying the quality cahps survey record.',
    `survey_type` STRING COMMENT 'Survey type (HCAHPS, CAHPS Clinician & Group)',
    `survey_version` STRING COMMENT 'The survey version of the quality cahps survey record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vbp_patient_experience_score` DECIMAL(18,2) COMMENT 'The vbp patient experience score of the quality cahps survey record.',
    `vendor_certification_number` STRING COMMENT 'The vendor certification number of the quality cahps survey record.',
    `vendor_name` STRING COMMENT 'Survey vendor name',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_cahps_survey PRIMARY KEY(`cahps_survey_id`)
) COMMENT 'CAHPS patient experience survey administration and aggregate results. Includes HCAHPS for hospitals and CG-CAHPS for clinician groups. Business justification: CMS-mandated for Hospital VBP, Medicare Advantage Star Ratings, and public reporting on Hospital Compare.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` (
    `cahps_response_id` BIGINT COMMENT 'Primary key',
    `billing_coverage_id` BIGINT COMMENT 'FK to billing coverage',
    `cahps_survey_id` BIGINT COMMENT 'FK to CAHPS survey',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI record',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `adjusted_composite_score` DECIMAL(18,2) COMMENT 'The adjusted composite score of the quality cahps response record.',
    `administration_mode` STRING COMMENT 'Mail, phone, or web',
    `care_transition_score` STRING COMMENT 'The care transition score of the quality cahps response record.',
    `cms_certification_number` STRING COMMENT 'The cms certification number of the quality cahps response record.',
    `contact_attempt_count` STRING COMMENT 'The contact attempt count of the quality cahps response record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `discharge_date` DATE COMMENT 'Timestamp capturing the discharge date associated with the quality cahps response record.',
    `discharge_information_score` STRING COMMENT 'The discharge information score of the quality cahps response record.',
    `doctor_communication_score` STRING COMMENT 'The doctor communication score of the quality cahps response record.',
    `education_level` STRING COMMENT 'The education level of the quality cahps response record.',
    `first_contact_date` DATE COMMENT 'Timestamp capturing the first contact date associated with the quality cahps response record.',
    `hospital_environment_score` STRING COMMENT 'The hospital environment score of the quality cahps response record.',
    `ineligibility_reason` STRING COMMENT 'The ineligibility reason of the quality cahps response record.',
    `is_eligible` BOOLEAN COMMENT 'Eligible flag',
    `is_sampled` BOOLEAN COMMENT 'Sampled flag',
    `language_of_response` STRING COMMENT 'The language of response of the quality cahps response record.',
    `length_of_stay_days` STRING COMMENT 'Length of stay in days',
    `medicine_communication_score` STRING COMMENT 'The medicine communication score of the quality cahps response record.',
    `mrn` STRING COMMENT 'The mrn of the quality cahps response record.',
    `nurse_communication_score` STRING COMMENT 'The nurse communication score of the quality cahps response record.',
    `overall_hospital_rating` STRING COMMENT 'Overall hospital rating (0-10)',
    `pain_management_score` STRING COMMENT 'The pain management score of the quality cahps response record.',
    `patient_service_line` STRING COMMENT 'The patient service line of the quality cahps response record.',
    `program_year` STRING COMMENT 'The program year of the quality cahps response record.',
    `recommend_hospital` STRING COMMENT 'Recommend hospital (Yes/No/Maybe)',
    `record_number` BIGINT COMMENT 'FK to consent record',
    `reporting_quarter` STRING COMMENT 'The reporting quarter of the quality cahps response record.',
    `response_date` DATE COMMENT 'Timestamp capturing the response date associated with the quality cahps response record.',
    `response_status` STRING COMMENT 'The response status value classifying the quality cahps response record.',
    `sampling_date` DATE COMMENT 'Timestamp capturing the sampling date associated with the quality cahps response record.',
    `self_reported_health_status` STRING COMMENT 'The self reported health status value classifying the quality cahps response record.',
    `service_category` STRING COMMENT 'The service category of the quality cahps response record.',
    `staff_responsiveness_score` STRING COMMENT 'The staff responsiveness score of the quality cahps response record.',
    `survey_type` STRING COMMENT 'The survey type value classifying the quality cahps response record.',
    `top_box_doctor_communication` BOOLEAN COMMENT 'Top box doctor communication flag',
    `top_box_nurse_communication` BOOLEAN COMMENT 'Top box nurse communication flag',
    `top_box_overall_rating` BOOLEAN COMMENT 'Top box overall rating flag',
    `top_box_recommend` BOOLEAN COMMENT 'Top box recommend flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vbp_patient_experience_score` DECIMAL(18,2) COMMENT 'The vbp patient experience score of the quality cahps response record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_cahps_response PRIMARY KEY(`cahps_response_id`)
) COMMENT 'Individual CAHPS survey responses with composite scores by domain. Links to patient encounters for service recovery and quality improvement. Business justification: Enables patient-level experience analysis, service recovery workflows, and provider feedback.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` (
    `patient_safety_event_id` BIGINT COMMENT 'Primary key',
    `bed_assignment_id` BIGINT COMMENT 'FK to bed assignment',
    `bed_id` BIGINT COMMENT 'Unique identifier for the bed within the quality patient safety event record.',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `environmental_service_request_id` BIGINT COMMENT 'FK to environmental service request',
    `equipment_asset_id` BIGINT COMMENT 'FK to equipment asset',
    `hazardous_material_id` BIGINT COMMENT 'FK to hazardous material',
    `hotline_report_id` BIGINT COMMENT 'FK to hotline report',
    `investigation_id` BIGINT COMMENT 'FK to investigation',
    `maintenance_order_id` BIGINT COMMENT 'FK to maintenance order',
    `material_master_id` BIGINT COMMENT 'FK to material master',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI record',
    `or_suite_id` BIGINT COMMENT 'FK to OR suite',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `radiology_study_id` BIGINT COMMENT 'FK to radiology study',
    `room_id` BIGINT COMMENT 'FK to room',
    `triage_assessment_id` BIGINT COMMENT 'FK to triage assessment',
    `udi_record_id` BIGINT COMMENT 'FK to UDI record',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `action_plan_completion_date` DATE COMMENT 'Timestamp capturing the action plan completion date associated with the quality patient safety event record.',
    `action_plan_due_date` DATE COMMENT 'Timestamp capturing the action plan due date associated with the quality patient safety event record.',
    `action_plan_status` STRING COMMENT 'The action plan status value classifying the quality patient safety event record.',
    `action_plan_summary` STRING COMMENT 'The action plan summary of the quality patient safety event record.',
    `confidentiality_indicator` BOOLEAN COMMENT 'The confidentiality indicator of the quality patient safety event record.',
    `contributing_factors_summary` STRING COMMENT 'The contributing factors summary of the quality patient safety event record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `disclosure_date` DATE COMMENT 'Timestamp capturing the disclosure date associated with the quality patient safety event record.',
    `disclosure_status` STRING COMMENT 'The disclosure status value classifying the quality patient safety event record.',
    `effectiveness_verification_date` DATE COMMENT 'Timestamp capturing the effectiveness verification date associated with the quality patient safety event record.',
    `effectiveness_verified` BOOLEAN COMMENT 'Effectiveness verified flag',
    `event_category` STRING COMMENT 'The event category of the quality patient safety event record.',
    `event_description` STRING COMMENT 'The event description of the quality patient safety event record.',
    `event_number` STRING COMMENT 'The event number of the quality patient safety event record.',
    `event_status` STRING COMMENT 'The event status value classifying the quality patient safety event record.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp of the quality patient safety event record.',
    `event_type` STRING COMMENT 'The event type value classifying the quality patient safety event record.',
    `hai_event_type` STRING COMMENT 'The hai event type value classifying the quality patient safety event record.',
    `harm_level_code` STRING COMMENT 'The harm level code value classifying the quality patient safety event record.',
    `harm_level_description` STRING COMMENT 'The harm level description of the quality patient safety event record.',
    `immediate_actions_taken` STRING COMMENT 'The immediate actions taken of the quality patient safety event record.',
    `is_cms_reportable` BOOLEAN COMMENT 'CMS reportable flag',
    `is_sentinel_event` BOOLEAN COMMENT 'Sentinel event flag',
    `is_state_reportable` BOOLEAN COMMENT 'State reportable flag',
    `location_unit` STRING COMMENT 'The location unit of the quality patient safety event record.',
    `patient_outcome` STRING COMMENT 'The patient outcome of the quality patient safety event record.',
    `report_timestamp` TIMESTAMP COMMENT 'The report timestamp of the quality patient safety event record.',
    `review_completion_date` DATE COMMENT 'Timestamp capturing the review completion date associated with the quality patient safety event record.',
    `review_due_date` DATE COMMENT 'Timestamp capturing the review due date associated with the quality patient safety event record.',
    `review_start_date` DATE COMMENT 'Timestamp capturing the review start date associated with the quality patient safety event record.',
    `review_team_members` STRING COMMENT 'The review team members of the quality patient safety event record.',
    `review_type` STRING COMMENT 'The review type value classifying the quality patient safety event record.',
    `root_causes_identified` STRING COMMENT 'The root causes identified of the quality patient safety event record.',
    `source_event_reference` STRING COMMENT 'The source event reference of the quality patient safety event record.',
    `tjc_acknowledgment_date` DATE COMMENT 'Timestamp capturing the tjc acknowledgment date associated with the quality patient safety event record.',
    `tjc_submission_date` DATE COMMENT 'Timestamp capturing the tjc submission date associated with the quality patient safety event record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_patient_safety_event PRIMARY KEY(`patient_safety_event_id`)
) COMMENT 'Patient safety incident reports including near misses, adverse events, and sentinel events. Supports root cause analysis and corrective action tracking. Business justification: Required for TJC accreditation, state mandatory reporting, and PSO participation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` (
    `safety_event_review_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `quality_committee_id` BIGINT COMMENT 'FK to committee',
    `corrective_action_plan_id` BIGINT COMMENT 'FK to corrective action plan',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `mpi_record_id` BIGINT COMMENT 'FK to MPI record',
    `patient_safety_event_id` BIGINT COMMENT 'FK to patient safety event',
    `prior_review_safety_event_review_id` BIGINT COMMENT 'FK to prior review',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `action_plan_completed_date` DATE COMMENT 'Timestamp capturing the action plan completed date associated with the quality safety event review record.',
    `action_plan_due_date` DATE COMMENT 'Timestamp capturing the action plan due date associated with the quality safety event review record.',
    `action_plan_status` STRING COMMENT 'The action plan status value classifying the quality safety event review record.',
    `action_plan_summary` STRING COMMENT 'The action plan summary of the quality safety event review record.',
    `care_setting` STRING COMMENT 'The care setting of the quality safety event review record.',
    `cms_reportable_flag` BOOLEAN COMMENT 'The cms reportable flag of the quality safety event review record.',
    `contributing_factors_summary` STRING COMMENT 'The contributing factors summary of the quality safety event review record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `department_unit` STRING COMMENT 'The department unit of the quality safety event review record.',
    `disclosure_date` DATE COMMENT 'Timestamp capturing the disclosure date associated with the quality safety event review record.',
    `disclosure_to_patient_flag` BOOLEAN COMMENT 'The disclosure to patient flag of the quality safety event review record.',
    `effectiveness_verification_date` DATE COMMENT 'Timestamp capturing the effectiveness verification date associated with the quality safety event review record.',
    `effectiveness_verification_notes` STRING COMMENT 'The effectiveness verification notes of the quality safety event review record.',
    `effectiveness_verification_status` STRING COMMENT 'The effectiveness verification status value classifying the quality safety event review record.',
    `event_category` STRING COMMENT 'The event category of the quality safety event review record.',
    `event_date` DATE COMMENT 'Timestamp capturing the event date associated with the quality safety event review record.',
    `event_type_code` STRING COMMENT 'The event type code value classifying the quality safety event review record.',
    `event_type_description` STRING COMMENT 'The event type description of the quality safety event review record.',
    `hai_event_type` STRING COMMENT 'The hai event type value classifying the quality safety event review record.',
    `harm_level` STRING COMMENT 'The harm level of the quality safety event review record.',
    `icd10_diagnosis_code` STRING COMMENT 'The icd10 diagnosis code value classifying the quality safety event review record.',
    `patient_safety_indicator_code` STRING COMMENT 'The patient safety indicator code value classifying the quality safety event review record.',
    `quality_committee_review_flag` BOOLEAN COMMENT 'The quality committee review flag of the quality safety event review record.',
    `recurrence_flag` BOOLEAN COMMENT 'The recurrence flag of the quality safety event review record.',
    `review_approved_date` DATE COMMENT 'Timestamp capturing the review approved date associated with the quality safety event review record.',
    `review_completed_date` DATE COMMENT 'Timestamp capturing the review completed date associated with the quality safety event review record.',
    `review_initiated_date` DATE COMMENT 'Timestamp capturing the review initiated date associated with the quality safety event review record.',
    `review_number` STRING COMMENT 'The review number of the quality safety event review record.',
    `review_status` STRING COMMENT 'The review status value classifying the quality safety event review record.',
    `review_team_composition` STRING COMMENT 'The review team composition of the quality safety event review record.',
    `review_team_size` STRING COMMENT 'The review team size of the quality safety event review record.',
    `review_type` STRING COMMENT 'The review type value classifying the quality safety event review record.',
    `risk_score` STRING COMMENT 'The risk score of the quality safety event review record.',
    `root_cause_category` STRING COMMENT 'The root cause category of the quality safety event review record.',
    `root_cause_summary` STRING COMMENT 'The root cause summary of the quality safety event review record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the quality safety event review record.',
    `state_reportable_flag` BOOLEAN COMMENT 'The state reportable flag of the quality safety event review record.',
    `tjc_reportable_flag` BOOLEAN COMMENT 'The tjc reportable flag of the quality safety event review record.',
    `tjc_reported_date` DATE COMMENT 'Timestamp capturing the tjc reported date associated with the quality safety event review record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_safety_event_review PRIMARY KEY(`safety_event_review_id`)
) COMMENT 'Peer review and root cause analysis documentation for patient safety events. Protected under state peer review statutes. Business justification: Supports quality improvement, risk management, and accreditation compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` (
    `mortality_review_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality mortality review record.',
    `quality_committee_id` BIGINT COMMENT 'Unique identifier for the committee within the quality mortality review record.',
    `drg_id` BIGINT COMMENT 'Unique identifier for the drg within the quality mortality review record.',
    `investigation_id` BIGINT COMMENT 'Unique identifier for the investigation within the quality mortality review record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the quality mortality review record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the quality mortality review record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary mortality clinician within the quality mortality review record.',
    `reviewer_provider_clinician_id` BIGINT COMMENT 'Unique identifier for the reviewer provider clinician within the quality mortality review record.',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the quality mortality review record.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the quality mortality review record.',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit within the quality mortality review record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the quality mortality review record.',
    `action_plan_due_date` DATE COMMENT 'Timestamp capturing the action plan due date associated with the quality mortality review record.',
    `action_plan_required_flag` BOOLEAN COMMENT 'The action plan required flag of the quality mortality review record.',
    `care_quality_rating` STRING COMMENT 'The care quality rating of the quality mortality review record.',
    `cdi_query_initiated_flag` BOOLEAN COMMENT 'The cdi query initiated flag of the quality mortality review record.',
    `cmi_impact_flag` BOOLEAN COMMENT 'The cmi impact flag of the quality mortality review record.',
    `cms_mortality_measure_code` STRING COMMENT 'The cms mortality measure code value classifying the quality mortality review record.',
    `cms_mortality_measure_flag` BOOLEAN COMMENT 'The cms mortality measure flag of the quality mortality review record.',
    `committee_findings_summary` STRING COMMENT 'The committee findings summary of the quality mortality review record.',
    `committee_review_date` DATE COMMENT 'Timestamp capturing the committee review date associated with the quality mortality review record.',
    `confidentiality_protection_flag` BOOLEAN COMMENT 'The confidentiality protection flag of the quality mortality review record.',
    `contributing_factor_1` STRING COMMENT 'The contributing factor 1 of the quality mortality review record.',
    `contributing_factor_2` STRING COMMENT 'The contributing factor 2 of the quality mortality review record.',
    `contributing_factor_3` STRING COMMENT 'The contributing factor 3 of the quality mortality review record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `days_from_admission_to_death` STRING COMMENT 'The days from admission to death of the quality mortality review record.',
    `death_classification` STRING COMMENT 'The death classification of the quality mortality review record.',
    `death_date` DATE COMMENT 'Timestamp capturing the death date associated with the quality mortality review record.',
    `death_location_type` STRING COMMENT 'The death location type value classifying the quality mortality review record.',
    `death_timestamp` TIMESTAMP COMMENT 'The death timestamp of the quality mortality review record.',
    `dnr_status_at_death` STRING COMMENT 'The dnr status at death of the quality mortality review record.',
    `hai_related_flag` BOOLEAN COMMENT 'The hai related flag of the quality mortality review record.',
    `hai_type` STRING COMMENT 'The hai type value classifying the quality mortality review record.',
    `hospice_enrolled_flag` BOOLEAN COMMENT 'The hospice enrolled flag of the quality mortality review record.',
    `improvement_recommendation` STRING COMMENT 'The improvement recommendation of the quality mortality review record.',
    `mips_reportable_flag` BOOLEAN COMMENT 'The mips reportable flag of the quality mortality review record.',
    `palliative_care_involved_flag` BOOLEAN COMMENT 'The palliative care involved flag of the quality mortality review record.',
    `preventability_determination` STRING COMMENT 'The preventability determination of the quality mortality review record.',
    `primary_cause_of_death_description` STRING COMMENT 'The primary cause of death description of the quality mortality review record.',
    `primary_icd10_cause_of_death` STRING COMMENT 'The primary icd10 cause of death of the quality mortality review record.',
    `readmission_related_flag` BOOLEAN COMMENT 'The readmission related flag of the quality mortality review record.',
    `review_case_number` STRING COMMENT 'The review case number of the quality mortality review record.',
    `review_completed_date` DATE COMMENT 'Timestamp capturing the review completed date associated with the quality mortality review record.',
    `review_initiated_date` DATE COMMENT 'Timestamp capturing the review initiated date associated with the quality mortality review record.',
    `review_status` STRING COMMENT 'The review status value classifying the quality mortality review record.',
    `review_trigger_type` STRING COMMENT 'The review trigger type value classifying the quality mortality review record.',
    `root_cause_analysis_required_flag` BOOLEAN COMMENT 'The root cause analysis required flag of the quality mortality review record.',
    `sentinel_event_flag` BOOLEAN COMMENT 'The sentinel event flag of the quality mortality review record.',
    `surgical_case_flag` BOOLEAN COMMENT 'The surgical case flag of the quality mortality review record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_mortality_review PRIMARY KEY(`mortality_review_id`)
) COMMENT 'Mortality case review for quality assurance and peer review purposes. Tracks preventability determination and contributing factors. Business justification: Required for CMS mortality measures, TJC standards, and medical staff peer review.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` (
    `vbp_program_id` BIGINT COMMENT 'Primary key',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the compliance regulatory submission within the quality vbp program record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality vbp program record.',
    `promoting_interoperability_id` BIGINT COMMENT 'Unique identifier for the promoting interoperability within the quality vbp program record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality vbp program record.',
    `achievement_benchmark_percentile` DECIMAL(18,2) COMMENT 'The achievement benchmark percentile of the quality vbp program record.',
    `achievement_threshold_percentile` DECIMAL(18,2) COMMENT 'The achievement threshold percentile of the quality vbp program record.',
    `applicable_provider_type` STRING COMMENT 'The applicable provider type value classifying the quality vbp program record.',
    `approved_by` STRING COMMENT 'The approved by of the quality vbp program record.',
    `approved_date` DATE COMMENT 'Timestamp capturing the approved date associated with the quality vbp program record.',
    `baseline_period_end` DATE COMMENT 'The baseline period end of the quality vbp program record.',
    `baseline_period_start` DATE COMMENT 'The baseline period start of the quality vbp program record.',
    `cahps_survey_vendor_required` BOOLEAN COMMENT 'The cahps survey vendor required of the quality vbp program record.',
    `clinical_outcomes_domain_weight` DECIMAL(18,2) COMMENT 'The clinical outcomes domain weight of the quality vbp program record.',
    `cms_program_code` STRING COMMENT 'The cms program code value classifying the quality vbp program record.',
    `correction_window_end` DATE COMMENT 'The correction window end of the quality vbp program record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `efficiency_cost_reduction_weight` DECIMAL(18,2) COMMENT 'The efficiency cost reduction weight of the quality vbp program record.',
    `federal_register_notice` STRING COMMENT 'The federal register notice of the quality vbp program record.',
    `final_score_publication_date` DATE COMMENT 'Timestamp capturing the final score publication date associated with the quality vbp program record.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the quality vbp program record.',
    `is_new_measure_set` BOOLEAN COMMENT 'Boolean flag indicating the is new measure set status of the quality vbp program record.',
    `max_achievement_points` STRING COMMENT 'The max achievement points of the quality vbp program record.',
    `max_domain_score` STRING COMMENT 'The max domain score of the quality vbp program record.',
    `max_improvement_points` STRING COMMENT 'The max improvement points of the quality vbp program record.',
    `max_payment_adjustment_factor` DECIMAL(18,2) COMMENT 'The max payment adjustment factor of the quality vbp program record.',
    `max_tps` STRING COMMENT 'The max tps of the quality vbp program record.',
    `measure_set_version` STRING COMMENT 'The measure set version of the quality vbp program record.',
    `min_case_volume_required` STRING COMMENT 'The min case volume required of the quality vbp program record.',
    `min_measure_count_required` STRING COMMENT 'The min measure count required of the quality vbp program record.',
    `min_payment_adjustment_factor` DECIMAL(18,2) COMMENT 'The min payment adjustment factor of the quality vbp program record.',
    `nqf_alignment_flag` BOOLEAN COMMENT 'The nqf alignment flag of the quality vbp program record.',
    `payment_adjustment_formula` STRING COMMENT 'The payment adjustment formula of the quality vbp program record.',
    `payment_year` STRING COMMENT 'The payment year of the quality vbp program record.',
    `performance_period_end` DATE COMMENT 'The performance period end of the quality vbp program record.',
    `performance_period_start` DATE COMMENT 'The performance period start of the quality vbp program record.',
    `person_community_engagement_weight` DECIMAL(18,2) COMMENT 'The person community engagement weight of the quality vbp program record.',
    `preview_report_release_date` DATE COMMENT 'Timestamp capturing the preview report release date associated with the quality vbp program record.',
    `program_code` STRING COMMENT 'The program code value classifying the quality vbp program record.',
    `program_description` STRING COMMENT 'The program description of the quality vbp program record.',
    `program_name` STRING COMMENT 'The program name of the quality vbp program record.',
    `program_status` STRING COMMENT 'The program status value classifying the quality vbp program record.',
    `program_type` STRING COMMENT 'The program type value classifying the quality vbp program record.',
    `qualitynet_program_code` STRING COMMENT 'The qualitynet program code value classifying the quality vbp program record.',
    `regulatory_rule_citation` STRING COMMENT 'The regulatory rule citation of the quality vbp program record.',
    `safety_domain_weight` DECIMAL(18,2) COMMENT 'The safety domain weight of the quality vbp program record.',
    `total_domain_weight_check` DECIMAL(18,2) COMMENT 'The total domain weight check of the quality vbp program record.',
    `tps_methodology` STRING COMMENT 'The tps methodology of the quality vbp program record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `withhold_rate` DECIMAL(18,2) COMMENT 'The withhold rate of the quality vbp program record.',
    CONSTRAINT pk_vbp_program PRIMARY KEY(`vbp_program_id`)
) COMMENT 'Value-based purchasing program definitions including CMS Hospital VBP, MIPS, and commercial payer programs. Tracks domain weights and payment adjustment factors. Business justification: Drives reimbursement optimization and quality strategy alignment.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`measure` (
    `measure_id` BIGINT COMMENT 'Primary key',
    `compliance_policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy within the quality measure record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the quality measure record.',
    `drg_id` BIGINT COMMENT 'Unique identifier for the drg within the quality measure record.',
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the hedis measure within the quality measure record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the icd code within the quality measure record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the loinc code within the quality measure record.',
    `active_status` STRING COMMENT 'The active status value classifying the quality measure record.',
    `benchmark_percentile` DECIMAL(18,2) COMMENT 'The benchmark percentile of the quality measure record.',
    `benchmark_threshold` DECIMAL(18,2) COMMENT 'The benchmark threshold of the quality measure record.',
    `care_gap_relevant_flag` BOOLEAN COMMENT 'The care gap relevant flag of the quality measure record.',
    `care_setting` STRING COMMENT 'The care setting of the quality measure record.',
    `clinical_ai_integration_marker` STRING COMMENT 'The clinical ai integration marker of the quality measure record.',
    `clinical_domain` STRING COMMENT 'The clinical domain of the quality measure record.',
    `cms_ecqm_code` STRING COMMENT 'The cms ecqm code value classifying the quality measure record.',
    `measure_code` STRING COMMENT 'The measure code value classifying the quality measure record.',
    `cpt_code_set` STRING COMMENT 'The cpt code set of the quality measure record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_source` STRING COMMENT 'The data source of the quality measure record.',
    `denominator_definition` STRING COMMENT 'The denominator definition of the quality measure record.',
    `denominator_exception` STRING COMMENT 'The denominator exception of the quality measure record.',
    `denominator_exclusion` STRING COMMENT 'The denominator exclusion of the quality measure record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality measure record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality measure record.',
    `eligible_population_criteria` STRING COMMENT 'The eligible population criteria of the quality measure record.',
    `floor_threshold` DECIMAL(18,2) COMMENT 'The floor threshold of the quality measure record.',
    `hai_category` STRING COMMENT 'The hai category of the quality measure record.',
    `higher_is_better` BOOLEAN COMMENT 'The higher is better of the quality measure record.',
    `icd10_code_set` STRING COMMENT 'The icd10 code set of the quality measure record.',
    `loinc_code_set` STRING COMMENT 'The loinc code set of the quality measure record.',
    `measure_type` STRING COMMENT 'The measure type value classifying the quality measure record.',
    `measurement_methodology` STRING COMMENT 'The measurement methodology of the quality measure record.',
    `measurement_year` STRING COMMENT 'The measurement year of the quality measure record.',
    `minimum_sample_size` STRING COMMENT 'The minimum sample size of the quality measure record.',
    `mips_category` STRING COMMENT 'The mips category of the quality measure record.',
    `nqf_number` STRING COMMENT 'The nqf number of the quality measure record.',
    `numerator_definition` STRING COMMENT 'The numerator definition of the quality measure record.',
    `reporting_period_end` DATE COMMENT 'The reporting period end of the quality measure record.',
    `reporting_period_start` DATE COMMENT 'The reporting period start of the quality measure record.',
    `reporting_program` STRING COMMENT 'The reporting program of the quality measure record.',
    `risk_adjustment_flag` BOOLEAN COMMENT 'The risk adjustment flag of the quality measure record.',
    `risk_adjustment_model` STRING COMMENT 'The risk adjustment model of the quality measure record.',
    `short_name` STRING COMMENT 'The short name of the quality measure record.',
    `snomed_code_set` STRING COMMENT 'The snomed code set of the quality measure record.',
    `specification_url` STRING COMMENT 'The specification url of the quality measure record.',
    `steward` STRING COMMENT 'The steward of the quality measure record.',
    `stratification_criteria` STRING COMMENT 'The stratification criteria of the quality measure record.',
    `submission_deadline` DATE COMMENT 'The submission deadline of the quality measure record.',
    `title` STRING COMMENT 'The title of the quality measure record.',
    `tjc_measure_set` STRING COMMENT 'The tjc measure set of the quality measure record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vbp_domain` STRING COMMENT 'The vbp domain of the quality measure record.',
    `version` STRING COMMENT 'The version of the quality measure record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_measure PRIMARY KEY(`measure_id`)
) COMMENT 'Generic quality measure definitions supporting multiple reporting programs (CMS, TJC, state, payer). Includes measure specifications, value sets, and reporting requirements. Business justification: Centralizes measure management across diverse quality programs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`measure_result` (
    `measure_result_id` BIGINT COMMENT 'Primary key',
    `audit_id` BIGINT COMMENT 'Unique identifier for the audit within the quality measure result record.',
    `billing_coverage_id` BIGINT COMMENT 'Unique identifier for the billing coverage within the quality measure result record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality measure result record.',
    `claim_id` BIGINT COMMENT 'Unique identifier for the claim within the quality measure result record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the quality measure result record.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the compliance regulatory submission within the quality measure result record.',
    `drg_id` BIGINT COMMENT 'Unique identifier for the drg within the quality measure result record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the quality measure result record.',
    `interface_channel_id` BIGINT COMMENT 'Unique identifier for the interface channel within the quality measure result record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the measure within the quality measure result record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the quality measure result record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality measure result record.',
    `radiology_appointment_id` BIGINT COMMENT 'Unique identifier for the radiology appointment within the quality measure result record.',
    `report_id` BIGINT COMMENT 'Unique identifier for the radiology report within the quality measure result record.',
    `service_id` BIGINT COMMENT 'Unique identifier for the service within the quality measure result record.',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit within the quality measure result record.',
    `benchmark_comparison_result` STRING COMMENT 'The benchmark comparison result of the quality measure result record.',
    `cms_submission_date` DATE COMMENT 'Timestamp capturing the cms submission date associated with the quality measure result record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_completeness_rate` DECIMAL(18,2) COMMENT 'The data completeness rate of the quality measure result record.',
    `denominator_count` STRING COMMENT 'The denominator count of the quality measure result record.',
    `exception_count` STRING COMMENT 'The exception count of the quality measure result record.',
    `exclusion_count` STRING COMMENT 'The exclusion count of the quality measure result record.',
    `gap_count` STRING COMMENT 'The gap count of the quality measure result record.',
    `gap_to_target_rate` DECIMAL(18,2) COMMENT 'The gap to target rate of the quality measure result record.',
    `hai_event_type` STRING COMMENT 'The hai event type value classifying the quality measure result record.',
    `hedis_methodology_indicator` STRING COMMENT 'The hedis methodology indicator of the quality measure result record.',
    `is_publicly_reported` BOOLEAN COMMENT 'Boolean flag indicating the is publicly reported status of the quality measure result record.',
    `measure_domain` STRING COMMENT 'The measure domain of the quality measure result record.',
    `measurement_level` STRING COMMENT 'The measurement level of the quality measure result record.',
    `measurement_methodology` STRING COMMENT 'The measurement methodology of the quality measure result record.',
    `measurement_period_end_date` DATE COMMENT 'Timestamp capturing the measurement period end date associated with the quality measure result record.',
    `measurement_period_start_date` DATE COMMENT 'Timestamp capturing the measurement period start date associated with the quality measure result record.',
    `meets_reporting_threshold` BOOLEAN COMMENT 'The meets reporting threshold of the quality measure result record.',
    `mips_measure_category` STRING COMMENT 'The mips measure category of the quality measure result record.',
    `mips_points_earned` DECIMAL(18,2) COMMENT 'The mips points earned of the quality measure result record.',
    `national_benchmark_rate` DECIMAL(18,2) COMMENT 'The national benchmark rate of the quality measure result record.',
    `ncqa_submission_status` STRING COMMENT 'The ncqa submission status value classifying the quality measure result record.',
    `nqf_number` STRING COMMENT 'The nqf number of the quality measure result record.',
    `numerator_count` STRING COMMENT 'The numerator count of the quality measure result record.',
    `payer_submission_status` STRING COMMENT 'The payer submission status value classifying the quality measure result record.',
    `percentile_rank` DECIMAL(18,2) COMMENT 'The percentile rank of the quality measure result record.',
    `performance_rate` DECIMAL(18,2) COMMENT 'The performance rate of the quality measure result record.',
    `performance_year` STRING COMMENT 'The performance year of the quality measure result record.',
    `reporting_program` STRING COMMENT 'The reporting program of the quality measure result record.',
    `reporting_quarter` STRING COMMENT 'The reporting quarter of the quality measure result record.',
    `result_calculated_timestamp` TIMESTAMP COMMENT 'The result calculated timestamp of the quality measure result record.',
    `result_status` STRING COMMENT 'The result status value classifying the quality measure result record.',
    `sir_value` DECIMAL(18,2) COMMENT 'The sir value of the quality measure result record.',
    `target_rate` DECIMAL(18,2) COMMENT 'The target rate of the quality measure result record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vbp_achievement_score` DECIMAL(18,2) COMMENT 'The vbp achievement score of the quality measure result record.',
    `vbp_domain` STRING COMMENT 'The vbp domain of the quality measure result record.',
    `vbp_improvement_score` DECIMAL(18,2) COMMENT 'The vbp improvement score of the quality measure result record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_measure_result PRIMARY KEY(`measure_result_id`)
) COMMENT 'Calculated quality measure results at facility, provider, and payer levels. Supports trending, benchmarking, and regulatory submission. Business justification: Enables performance monitoring, incentive tracking, and public reporting compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` (
    `cdi_review_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality cdi review record.',
    `cdi_worksheet_id` BIGINT COMMENT 'Unique identifier for the cdi worksheet within the quality cdi review record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the quality cdi review record.',
    `drg_assignment_id` BIGINT COMMENT 'Unique identifier for the drg assignment within the quality cdi review record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the quality cdi review record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the quality cdi review record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the quality cdi review record.',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the quality cdi review record.',
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the subject enrollment within the quality cdi review record.',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit within the quality cdi review record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the quality cdi review record.',
    `drg_id` BIGINT COMMENT 'Unique identifier for the working drg within the quality cdi review record.',
    `admit_date` DATE COMMENT 'Timestamp capturing the admit date associated with the quality cdi review record.',
    `cc_mcc_opportunity_flag` BOOLEAN COMMENT 'The cc mcc opportunity flag of the quality cdi review record.',
    `cc_mcc_status` STRING COMMENT 'The cc mcc status value classifying the quality cdi review record.',
    `clinical_indicator_summary` STRING COMMENT 'The clinical indicator summary of the quality cdi review record.',
    `cmi_impact` DECIMAL(18,2) COMMENT 'The cmi impact of the quality cdi review record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `discharge_date` DATE COMMENT 'Timestamp capturing the discharge date associated with the quality cdi review record.',
    `documentation_impact` STRING COMMENT 'The documentation impact of the quality cdi review record.',
    `drg_change_flag` BOOLEAN COMMENT 'The drg change flag of the quality cdi review record.',
    `poa_status` STRING COMMENT 'The poa status value classifying the quality cdi review record.',
    `principal_diagnosis_code` STRING COMMENT 'The principal diagnosis code value classifying the quality cdi review record.',
    `query_initiated_flag` BOOLEAN COMMENT 'The query initiated flag of the quality cdi review record.',
    `query_method` STRING COMMENT 'The query method of the quality cdi review record.',
    `query_outcome` STRING COMMENT 'The query outcome of the quality cdi review record.',
    `query_response_date` DATE COMMENT 'Timestamp capturing the query response date associated with the quality cdi review record.',
    `query_response_status` STRING COMMENT 'The query response status value classifying the quality cdi review record.',
    `query_type` STRING COMMENT 'The query type value classifying the quality cdi review record.',
    `review_completion_timestamp` TIMESTAMP COMMENT 'The review completion timestamp of the quality cdi review record.',
    `review_date` DATE COMMENT 'Timestamp capturing the review date associated with the quality cdi review record.',
    `review_finding_type` STRING COMMENT 'The review finding type value classifying the quality cdi review record.',
    `review_lag_days` STRING COMMENT 'The review lag days of the quality cdi review record.',
    `review_number` STRING COMMENT 'The review number of the quality cdi review record.',
    `review_sequence_number` STRING COMMENT 'The review sequence number of the quality cdi review record.',
    `review_status` STRING COMMENT 'The review status value classifying the quality cdi review record.',
    `review_timestamp` TIMESTAMP COMMENT 'The review timestamp of the quality cdi review record.',
    `review_type` STRING COMMENT 'The review type value classifying the quality cdi review record.',
    `reviewer_credential` STRING COMMENT 'The reviewer credential of the quality cdi review record.',
    `reviewer_role` STRING COMMENT 'The reviewer role of the quality cdi review record.',
    `source_review_reference` STRING COMMENT 'The source review reference of the quality cdi review record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_cdi_review PRIMARY KEY(`cdi_review_id`)
) COMMENT 'Clinical documentation improvement review tracking for inpatient encounters. Captures query outcomes and DRG/CMI impact. Business justification: Optimizes revenue integrity, supports accurate severity capture, and improves quality measure accuracy.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` (
    `accreditation_program_id` BIGINT COMMENT 'Primary key',
    `accreditation_status_id` BIGINT COMMENT 'Unique identifier for the accreditation status within the quality accreditation program record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality accreditation program record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality accreditation program record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality accreditation program record.',
    `accreditation_coordinator_name` STRING COMMENT 'The accreditation coordinator name of the quality accreditation program record.',
    `accreditation_cycle_years` STRING COMMENT 'The accreditation cycle years of the quality accreditation program record.',
    `accreditation_decision` STRING COMMENT 'The accreditation decision of the quality accreditation program record.',
    `accrediting_body` STRING COMMENT 'The accrediting body of the quality accreditation program record.',
    `cms_acceptance_status` STRING COMMENT 'The cms acceptance status value classifying the quality accreditation program record.',
    `cms_certification_number` STRING COMMENT 'The cms certification number of the quality accreditation program record.',
    `complaint_survey_indicator` BOOLEAN COMMENT 'The complaint survey indicator of the quality accreditation program record.',
    `condition_level_deficiency_count` STRING COMMENT 'The condition level deficiency count of the quality accreditation program record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deemed_status` BOOLEAN COMMENT 'The deemed status value classifying the quality accreditation program record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the quality accreditation program record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the quality accreditation program record.',
    `finding_compliance_status` STRING COMMENT 'The finding compliance status value classifying the quality accreditation program record.',
    `finding_evidence` STRING COMMENT 'The finding evidence of the quality accreditation program record.',
    `finding_resolution_date` DATE COMMENT 'Timestamp capturing the finding resolution date associated with the quality accreditation program record.',
    `finding_resolution_status` STRING COMMENT 'The finding resolution status value classifying the quality accreditation program record.',
    `finding_standard_reference` STRING COMMENT 'The finding standard reference of the quality accreditation program record.',
    `finding_type` STRING COMMENT 'The finding type value classifying the quality accreditation program record.',
    `follow_up_required` BOOLEAN COMMENT 'The follow up required of the quality accreditation program record.',
    `follow_up_survey_date` DATE COMMENT 'Timestamp capturing the follow up survey date associated with the quality accreditation program record.',
    `immediate_threat_count` STRING COMMENT 'The immediate threat count of the quality accreditation program record.',
    `is_cms_cop_applicable` BOOLEAN COMMENT 'Boolean flag indicating the is cms cop applicable status of the quality accreditation program record.',
    `last_cms_validation_date` DATE COMMENT 'Timestamp capturing the last cms validation date associated with the quality accreditation program record.',
    `next_survey_due_date` DATE COMMENT 'Timestamp capturing the next survey due date associated with the quality accreditation program record.',
    `plan_of_correction` STRING COMMENT 'The plan of correction of the quality accreditation program record.',
    `poc_due_date` DATE COMMENT 'Timestamp capturing the poc due date associated with the quality accreditation program record.',
    `poc_submission_date` DATE COMMENT 'Timestamp capturing the poc submission date associated with the quality accreditation program record.',
    `program_name` STRING COMMENT 'The program name of the quality accreditation program record.',
    `program_number` STRING COMMENT 'The program number of the quality accreditation program record.',
    `program_status` STRING COMMENT 'The program status value classifying the quality accreditation program record.',
    `program_type` STRING COMMENT 'The program type value classifying the quality accreditation program record.',
    `readiness_assessment_date` DATE COMMENT 'Timestamp capturing the readiness assessment date associated with the quality accreditation program record.',
    `readiness_score` DECIMAL(18,2) COMMENT 'The readiness score of the quality accreditation program record.',
    `regulatory_body_contact` STRING COMMENT 'The regulatory body contact of the quality accreditation program record.',
    `standard_level_deficiency_count` STRING COMMENT 'The standard level deficiency count of the quality accreditation program record.',
    `standards_chapters_reviewed` STRING COMMENT 'The standards chapters reviewed of the quality accreditation program record.',
    `state_license_number` STRING COMMENT 'The state license number of the quality accreditation program record.',
    `state_survey_agency` STRING COMMENT 'The state survey agency of the quality accreditation program record.',
    `survey_date` DATE COMMENT 'Timestamp capturing the survey date associated with the quality accreditation program record.',
    `survey_end_date` DATE COMMENT 'Timestamp capturing the survey end date associated with the quality accreditation program record.',
    `survey_scope` STRING COMMENT 'The survey scope of the quality accreditation program record.',
    `survey_type` STRING COMMENT 'The survey type value classifying the quality accreditation program record.',
    `surveyor_team` STRING COMMENT 'The surveyor team of the quality accreditation program record.',
    `total_findings_count` STRING COMMENT 'The total findings count of the quality accreditation program record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_accreditation_program PRIMARY KEY(`accreditation_program_id`)
) COMMENT 'Accreditation program enrollment and status tracking for TJC, DNV, AAAHC, and state licensure. Business justification: Required for Medicare participation, deemed status, and payer credentialing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` (
    `accreditation_survey_id` BIGINT COMMENT 'Primary key',
    `accreditation_program_id` BIGINT COMMENT 'Unique identifier for the accreditation program within the quality accreditation survey record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality accreditation survey record.',
    `quality_committee_id` BIGINT COMMENT 'Unique identifier for the committee within the quality accreditation survey record.',
    `audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit within the quality accreditation survey record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the quality accreditation survey record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the quality accreditation survey record.',
    `accreditation_decision` STRING COMMENT 'The accreditation decision of the quality accreditation survey record.',
    `accreditation_decision_date` DATE COMMENT 'Timestamp capturing the accreditation decision date associated with the quality accreditation survey record.',
    `accreditation_expiration_date` DATE COMMENT 'Timestamp capturing the accreditation expiration date associated with the quality accreditation survey record.',
    `accreditation_standards_edition` STRING COMMENT 'The accreditation standards edition of the quality accreditation survey record.',
    `accrediting_body` STRING COMMENT 'The accrediting body of the quality accreditation survey record.',
    `cms_certification_number` STRING COMMENT 'The cms certification number of the quality accreditation survey record.',
    `condition_level_deficiency` BOOLEAN COMMENT 'The condition level deficiency of the quality accreditation survey record.',
    `cop_deficiencies_cited` STRING COMMENT 'The cop deficiencies cited of the quality accreditation survey record.',
    `corrective_action_plan_status` STRING COMMENT 'The corrective action plan status value classifying the quality accreditation survey record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `environment_of_care_included` BOOLEAN COMMENT 'The environment of care included of the quality accreditation survey record.',
    `esc_acceptance_status` STRING COMMENT 'The esc acceptance status value classifying the quality accreditation survey record.',
    `esc_submission_date` DATE COMMENT 'Timestamp capturing the esc submission date associated with the quality accreditation survey record.',
    `esc_submission_due_date` DATE COMMENT 'Timestamp capturing the esc submission due date associated with the quality accreditation survey record.',
    `findings_count_immediate_threat` STRING COMMENT 'The findings count immediate threat of the quality accreditation survey record.',
    `findings_count_observation` STRING COMMENT 'The findings count observation of the quality accreditation survey record.',
    `findings_count_requirement_improvement` STRING COMMENT 'The findings count requirement improvement of the quality accreditation survey record.',
    `findings_count_total` STRING COMMENT 'The findings count total of the quality accreditation survey record.',
    `follow_up_survey_date` DATE COMMENT 'Timestamp capturing the follow up survey date associated with the quality accreditation survey record.',
    `follow_up_survey_required` BOOLEAN COMMENT 'The follow up survey required of the quality accreditation survey record.',
    `infection_prevention_included` BOOLEAN COMMENT 'The infection prevention included of the quality accreditation survey record.',
    `is_unannounced` BOOLEAN COMMENT 'Boolean flag indicating the is unannounced status of the quality accreditation survey record.',
    `lead_surveyor_name` STRING COMMENT 'The lead surveyor name of the quality accreditation survey record.',
    `life_safety_module_included` BOOLEAN COMMENT 'The life safety module included of the quality accreditation survey record.',
    `national_patient_safety_goals_reviewed` BOOLEAN COMMENT 'The national patient safety goals reviewed of the quality accreditation survey record.',
    `next_survey_target_date` DATE COMMENT 'Timestamp capturing the next survey target date associated with the quality accreditation survey record.',
    `notification_date` DATE COMMENT 'Timestamp capturing the notification date associated with the quality accreditation survey record.',
    `overall_readiness_score` DECIMAL(18,2) COMMENT 'The overall readiness score of the quality accreditation survey record.',
    `preliminary_findings_summary` STRING COMMENT 'The preliminary findings summary of the quality accreditation survey record.',
    `standards_chapters_reviewed` STRING COMMENT 'The standards chapters reviewed of the quality accreditation survey record.',
    `survey_duration_days` STRING COMMENT 'The survey duration days of the quality accreditation survey record.',
    `survey_end_date` DATE COMMENT 'Timestamp capturing the survey end date associated with the quality accreditation survey record.',
    `survey_number` STRING COMMENT 'The survey number of the quality accreditation survey record.',
    `survey_report_received_date` DATE COMMENT 'Timestamp capturing the survey report received date associated with the quality accreditation survey record.',
    `survey_scope` STRING COMMENT 'The survey scope of the quality accreditation survey record.',
    `survey_start_date` DATE COMMENT 'Timestamp capturing the survey start date associated with the quality accreditation survey record.',
    `survey_status` STRING COMMENT 'The survey status value classifying the quality accreditation survey record.',
    `survey_type` STRING COMMENT 'The survey type value classifying the quality accreditation survey record.',
    `surveyor_team_composition` STRING COMMENT 'The surveyor team composition of the quality accreditation survey record.',
    `system_tracer_topics` STRING COMMENT 'The system tracer topics of the quality accreditation survey record.',
    `tjc_organization_code` STRING COMMENT 'The tjc organization code value classifying the quality accreditation survey record.',
    `tracer_methodology_used` BOOLEAN COMMENT 'The tracer methodology used of the quality accreditation survey record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_accreditation_survey PRIMARY KEY(`accreditation_survey_id`)
) COMMENT 'Accreditation survey events with findings, decisions, and follow-up requirements. Business justification: Tracks survey readiness, deficiency resolution, and accreditation cycle management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` (
    `standard_finding_id` BIGINT COMMENT 'Primary key',
    `accreditation_program_id` BIGINT COMMENT 'Unique identifier for the accreditation program within the quality standard finding record.',
    `accreditation_survey_id` BIGINT COMMENT 'Unique identifier for the accreditation survey within the quality standard finding record.',
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding within the quality standard finding record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality standard finding record.',
    `quality_committee_id` BIGINT COMMENT 'Unique identifier for the committee within the quality standard finding record.',
    `prior_finding_standard_finding_id` BIGINT COMMENT 'Unique identifier for the prior finding standard finding within the quality standard finding record.',
    `affected_department` STRING COMMENT 'The affected department of the quality standard finding record.',
    `cms_acceptance_date` DATE COMMENT 'Timestamp capturing the cms acceptance date associated with the quality standard finding record.',
    `cms_acceptance_status` STRING COMMENT 'The cms acceptance status value classifying the quality standard finding record.',
    `cms_certification_number` STRING COMMENT 'The cms certification number of the quality standard finding record.',
    `compliance_due_date` DATE COMMENT 'Timestamp capturing the compliance due date associated with the quality standard finding record.',
    `corrective_action_description` STRING COMMENT 'The corrective action description of the quality standard finding record.',
    `corrective_action_owner` STRING COMMENT 'The corrective action owner of the quality standard finding record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deficiency_tag_number` STRING COMMENT 'The deficiency tag number of the quality standard finding record.',
    `effectiveness_verification_date` DATE COMMENT 'Timestamp capturing the effectiveness verification date associated with the quality standard finding record.',
    `effectiveness_verified` BOOLEAN COMMENT 'The effectiveness verified of the quality standard finding record.',
    `element_of_performance` STRING COMMENT 'The element of performance of the quality standard finding record.',
    `enforcement_action` STRING COMMENT 'The enforcement action of the quality standard finding record.',
    `evidence_of_deficiency` STRING COMMENT 'The evidence of deficiency of the quality standard finding record.',
    `finding_date` DATE COMMENT 'Timestamp capturing the finding date associated with the quality standard finding record.',
    `finding_description` STRING COMMENT 'The finding description of the quality standard finding record.',
    `finding_number` STRING COMMENT 'The finding number of the quality standard finding record.',
    `finding_status` STRING COMMENT 'The finding status value classifying the quality standard finding record.',
    `finding_type` STRING COMMENT 'The finding type value classifying the quality standard finding record.',
    `immediate_jeopardy` BOOLEAN COMMENT 'The immediate jeopardy of the quality standard finding record.',
    `monitoring_frequency` STRING COMMENT 'The monitoring frequency of the quality standard finding record.',
    `monitoring_method` STRING COMMENT 'The monitoring method of the quality standard finding record.',
    `plan_of_correction` STRING COMMENT 'The plan of correction of the quality standard finding record.',
    `poc_due_date` DATE COMMENT 'Timestamp capturing the poc due date associated with the quality standard finding record.',
    `poc_submission_date` DATE COMMENT 'Timestamp capturing the poc submission date associated with the quality standard finding record.',
    `repeat_finding` BOOLEAN COMMENT 'The repeat finding of the quality standard finding record.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the quality standard finding record.',
    `revisit_date` DATE COMMENT 'Timestamp capturing the revisit date associated with the quality standard finding record.',
    `revisit_required` BOOLEAN COMMENT 'The revisit required of the quality standard finding record.',
    `root_cause_summary` STRING COMMENT 'The root cause summary of the quality standard finding record.',
    `scope_code` STRING COMMENT 'The scope code value classifying the quality standard finding record.',
    `scope_severity_grid` STRING COMMENT 'The scope severity grid of the quality standard finding record.',
    `severity_code` STRING COMMENT 'The severity code value classifying the quality standard finding record.',
    `standard_chapter` STRING COMMENT 'The standard chapter of the quality standard finding record.',
    `standard_reference_code` STRING COMMENT 'The standard reference code value classifying the quality standard finding record.',
    `standard_reference_description` STRING COMMENT 'The standard reference description of the quality standard finding record.',
    `survey_end_date` DATE COMMENT 'Timestamp capturing the survey end date associated with the quality standard finding record.',
    `survey_start_date` DATE COMMENT 'Timestamp capturing the survey start date associated with the quality standard finding record.',
    `survey_type` STRING COMMENT 'The survey type value classifying the quality standard finding record.',
    `surveying_body` STRING COMMENT 'The surveying body of the quality standard finding record.',
    `tjc_npsg_number` STRING COMMENT 'The tjc npsg number of the quality standard finding record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_standard_finding PRIMARY KEY(`standard_finding_id`)
) COMMENT 'Individual accreditation survey findings linked to standards and corrective actions. Business justification: Enables finding remediation tracking and standards compliance monitoring.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` (
    `improvement_initiative_id` BIGINT COMMENT 'Primary key',
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget within the quality improvement initiative record.',
    `capital_project_id` BIGINT COMMENT 'Unique identifier for the capital project within the quality improvement initiative record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality improvement initiative record.',
    `quality_committee_id` BIGINT COMMENT 'Unique identifier for the committee within the quality improvement initiative record.',
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan within the quality improvement initiative record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the quality improvement initiative record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the improvement sponsor employee within the quality improvement initiative record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the quality improvement initiative record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the measure within the quality improvement initiative record.',
    `onboarding_project_id` BIGINT COMMENT 'Unique identifier for the onboarding project within the quality improvement initiative record.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee within the quality improvement initiative record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality improvement initiative record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the sponsor clinician within the quality improvement initiative record.',
    `actual_completion_date` DATE COMMENT 'Timestamp capturing the actual completion date associated with the quality improvement initiative record.',
    `actual_cost_savings` DECIMAL(18,2) COMMENT 'The actual cost savings of the quality improvement initiative record.',
    `actual_end_date` DATE COMMENT 'Timestamp capturing the actual end date associated with the quality improvement initiative record.',
    `actual_savings_amount` DECIMAL(18,2) COMMENT 'The actual savings amount of the quality improvement initiative record.',
    `actual_start_date` DATE COMMENT 'Timestamp capturing the actual start date associated with the quality improvement initiative record.',
    `aim_statement` STRING COMMENT 'The aim statement of the quality improvement initiative record.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The baseline value of the quality improvement initiative record.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the quality improvement initiative record.',
    `clinical_domain` STRING COMMENT 'The clinical domain of the quality improvement initiative record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `current_value` DECIMAL(18,2) COMMENT 'The current value of the quality improvement initiative record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the quality improvement initiative record.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The estimated cost of the quality improvement initiative record.',
    `estimated_cost_savings` DECIMAL(18,2) COMMENT 'The estimated cost savings of the quality improvement initiative record.',
    `estimated_savings` DECIMAL(18,2) COMMENT 'The estimated savings of the quality improvement initiative record.',
    `improvement_achieved_flag` BOOLEAN COMMENT 'The improvement achieved flag of the quality improvement initiative record.',
    `improvement_methodology` STRING COMMENT 'The improvement methodology of the quality improvement initiative record.',
    `initiative_code` STRING COMMENT 'The initiative code value classifying the quality improvement initiative record.',
    `initiative_description` STRING COMMENT 'The initiative description of the quality improvement initiative record.',
    `initiative_name` STRING COMMENT 'The initiative name of the quality improvement initiative record.',
    `initiative_number` STRING COMMENT 'The initiative number of the quality improvement initiative record.',
    `initiative_status` STRING COMMENT 'The initiative status value classifying the quality improvement initiative record.',
    `initiative_type` STRING COMMENT 'The initiative type value classifying the quality improvement initiative record.',
    `measurement_unit` STRING COMMENT 'The measurement unit of the quality improvement initiative record.',
    `methodology` STRING COMMENT 'The methodology of the quality improvement initiative record.',
    `outcome_summary` STRING COMMENT 'The outcome summary of the quality improvement initiative record.',
    `percent_complete` STRING COMMENT 'The percent complete of the quality improvement initiative record.',
    `planned_completion_date` DATE COMMENT 'Timestamp capturing the planned completion date associated with the quality improvement initiative record.',
    `planned_end_date` DATE COMMENT 'Timestamp capturing the planned end date associated with the quality improvement initiative record.',
    `planned_start_date` DATE COMMENT 'Timestamp capturing the planned start date associated with the quality improvement initiative record.',
    `priority_level` STRING COMMENT 'The priority level of the quality improvement initiative record.',
    `problem_statement` STRING COMMENT 'The problem statement of the quality improvement initiative record.',
    `project_lead_name` STRING COMMENT 'The project lead name of the quality improvement initiative record.',
    `projected_savings_amount` DECIMAL(18,2) COMMENT 'The projected savings amount of the quality improvement initiative record.',
    `realized_savings` STRING COMMENT 'The realized savings of the quality improvement initiative record.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'The roi percentage of the quality improvement initiative record.',
    `sponsor_name` STRING COMMENT 'The sponsor name of the quality improvement initiative record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the quality improvement initiative record.',
    `improvement_initiative_status` STRING COMMENT 'The improvement initiative status value classifying the quality improvement initiative record.',
    `sustained_flag` BOOLEAN COMMENT 'The sustained flag of the quality improvement initiative record.',
    `sustainment_plan` STRING COMMENT 'The sustainment plan of the quality improvement initiative record.',
    `target_completion_date` DATE COMMENT 'Timestamp capturing the target completion date associated with the quality improvement initiative record.',
    `target_end_date` DATE COMMENT 'Timestamp capturing the target end date associated with the quality improvement initiative record.',
    `target_improvement_rate` DECIMAL(18,2) COMMENT 'The target improvement rate of the quality improvement initiative record.',
    `target_value` DECIMAL(18,2) COMMENT 'The target value of the quality improvement initiative record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the quality improvement initiative record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_improvement_initiative PRIMARY KEY(`improvement_initiative_id`)
) COMMENT 'Quality improvement projects and initiatives with goals, timelines, and outcome tracking. Business justification: Supports PI program requirements, accreditation standards, and strategic quality goals.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` (
    `quality_peer_review_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality quality peer review record.',
    `quality_committee_id` BIGINT COMMENT 'Unique identifier for the committee within the quality quality peer review record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the quality quality peer review record.',
    `patient_safety_event_id` BIGINT COMMENT 'Unique identifier for the patient safety event within the quality quality peer review record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the quality clinician within the quality quality peer review record.',
    `quality_reviewed_clinician_id` BIGINT COMMENT 'Unique identifier for the quality reviewed clinician within the quality quality peer review record.',
    `reviewer_clinician_id` BIGINT COMMENT 'Unique identifier for the reviewer clinician within the quality quality peer review record.',
    `specialty_id` BIGINT COMMENT 'Unique identifier for the specialty within the quality quality peer review record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the quality quality peer review record.',
    `action_recommended` STRING COMMENT 'The action recommended of the quality quality peer review record.',
    `action_required_flag` BOOLEAN COMMENT 'The action required flag of the quality quality peer review record.',
    `action_summary` STRING COMMENT 'The action summary of the quality quality peer review record.',
    `care_appropriateness_rating` STRING COMMENT 'The care appropriateness rating of the quality quality peer review record.',
    `care_quality_rating` STRING COMMENT 'The care quality rating of the quality quality peer review record.',
    `care_rating` STRING COMMENT 'The care rating of the quality quality peer review record.',
    `case_number` STRING COMMENT 'The case number of the quality quality peer review record.',
    `case_summary` STRING COMMENT 'The case summary of the quality quality peer review record.',
    `committee_review_date` DATE COMMENT 'Timestamp capturing the committee review date associated with the quality quality peer review record.',
    `confidentiality_protected_flag` BOOLEAN COMMENT 'The confidentiality protected flag of the quality quality peer review record.',
    `confidentiality_protection_flag` BOOLEAN COMMENT 'The confidentiality protection flag of the quality quality peer review record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deviation_identified_flag` BOOLEAN COMMENT 'The deviation identified flag of the quality quality peer review record.',
    `finding_summary` STRING COMMENT 'The finding summary of the quality quality peer review record.',
    `findings_summary` STRING COMMENT 'The findings summary of the quality quality peer review record.',
    `is_confidential` BOOLEAN COMMENT 'Boolean flag indicating the is confidential status of the quality quality peer review record.',
    `outcome_category` STRING COMMENT 'The outcome category of the quality quality peer review record.',
    `outcome_determination` STRING COMMENT 'The outcome determination of the quality quality peer review record.',
    `peer_review_privilege_status` STRING COMMENT 'The peer review privilege status value classifying the quality quality peer review record.',
    `peer_review_scope` STRING COMMENT 'The peer review scope of the quality quality peer review record.',
    `peer_review_score` STRING COMMENT 'The peer review score of the quality quality peer review record.',
    `peer_review_type` STRING COMMENT 'The peer review type value classifying the quality quality peer review record.',
    `preventability_flag` BOOLEAN COMMENT 'The preventability flag of the quality quality peer review record.',
    `preventability_rating` STRING COMMENT 'The preventability rating of the quality quality peer review record.',
    `recommendations` STRING COMMENT 'The recommendations of the quality quality peer review record.',
    `review_case_number` STRING COMMENT 'The review case number of the quality quality peer review record.',
    `review_completed_date` DATE COMMENT 'Timestamp capturing the review completed date associated with the quality quality peer review record.',
    `review_date` DATE COMMENT 'Timestamp capturing the review date associated with the quality quality peer review record.',
    `review_initiated_date` DATE COMMENT 'Timestamp capturing the review initiated date associated with the quality quality peer review record.',
    `review_level` STRING COMMENT 'The review level of the quality quality peer review record.',
    `review_number` STRING COMMENT 'The review number of the quality quality peer review record.',
    `review_outcome` STRING COMMENT 'The review outcome of the quality quality peer review record.',
    `review_score` DECIMAL(18,2) COMMENT 'The review score of the quality quality peer review record.',
    `review_stage` STRING COMMENT 'The review stage of the quality quality peer review record.',
    `review_status` STRING COMMENT 'The review status value classifying the quality quality peer review record.',
    `review_trigger` STRING COMMENT 'The review trigger of the quality quality peer review record.',
    `review_type` STRING COMMENT 'The review type value classifying the quality quality peer review record.',
    `severity_classification` STRING COMMENT 'The severity classification of the quality quality peer review record.',
    `severity_of_concern` STRING COMMENT 'The severity of concern of the quality quality peer review record.',
    `standard_of_care_determination` STRING COMMENT 'The standard of care determination of the quality quality peer review record.',
    `standard_of_care_met_flag` BOOLEAN COMMENT 'The standard of care met flag of the quality quality peer review record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_quality_peer_review PRIMARY KEY(`quality_peer_review_id`)
) COMMENT 'SSOT resolved: defer to radiology.radiology_peer_review as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` (
    `population_health_gap_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality population health gap record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the quality population health gap record.',
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the hedis measure within the quality population health gap record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the measure within the quality population health gap record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the quality population health gap record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the quality population health gap record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality population health gap record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the population clinician within the quality population health gap record.',
    `population_pcp_clinician_id` BIGINT COMMENT 'Unique identifier for the population pcp clinician within the quality population health gap record.',
    `clinical_domain` STRING COMMENT 'The clinical domain of the quality population health gap record.',
    `closed_date` DATE COMMENT 'Timestamp capturing the closed date associated with the quality population health gap record.',
    `closure_date` DATE COMMENT 'Timestamp capturing the closure date associated with the quality population health gap record.',
    `closure_method` STRING COMMENT 'The closure method of the quality population health gap record.',
    `closure_source` STRING COMMENT 'The closure source of the quality population health gap record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `due_date` DATE COMMENT 'Timestamp capturing the due date associated with the quality population health gap record.',
    `gap_category` STRING COMMENT 'The gap category of the quality population health gap record.',
    `gap_closed_date` DATE COMMENT 'Timestamp capturing the gap closed date associated with the quality population health gap record.',
    `gap_description` STRING COMMENT 'The gap description of the quality population health gap record.',
    `gap_due_date` DATE COMMENT 'Timestamp capturing the gap due date associated with the quality population health gap record.',
    `gap_identified_date` DATE COMMENT 'Timestamp capturing the gap identified date associated with the quality population health gap record.',
    `gap_identifier` STRING COMMENT 'The gap identifier of the quality population health gap record.',
    `gap_status` STRING COMMENT 'The gap status value classifying the quality population health gap record.',
    `gap_type` STRING COMMENT 'The gap type value classifying the quality population health gap record.',
    `identified_date` DATE COMMENT 'Timestamp capturing the identified date associated with the quality population health gap record.',
    `is_closed` BOOLEAN COMMENT 'Boolean flag indicating the is closed status of the quality population health gap record.',
    `is_open` BOOLEAN COMMENT 'Boolean flag indicating the is open status of the quality population health gap record.',
    `last_outreach_date` DATE COMMENT 'Timestamp capturing the last outreach date associated with the quality population health gap record.',
    `measurement_year` STRING COMMENT 'The measurement year of the quality population health gap record.',
    `outreach_attempt_count` STRING COMMENT 'The outreach attempt count of the quality population health gap record.',
    `outreach_status` STRING COMMENT 'The outreach status value classifying the quality population health gap record.',
    `priority_level` STRING COMMENT 'The priority level of the quality population health gap record.',
    `priority_score` DECIMAL(18,2) COMMENT 'The priority score of the quality population health gap record.',
    `recommended_action` STRING COMMENT 'The recommended action of the quality population health gap record.',
    `risk_score` STRING COMMENT 'The risk score of the quality population health gap record.',
    `target_close_date` DATE COMMENT 'Timestamp capturing the target close date associated with the quality population health gap record.',
    `target_closure_date` DATE COMMENT 'Timestamp capturing the target closure date associated with the quality population health gap record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_population_health_gap PRIMARY KEY(`population_health_gap_id`)
) COMMENT 'Patient-level care gaps for population health management and quality measure closure. Business justification: Drives outreach campaigns, care coordination, and VBP performance improvement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` (
    `sdoh_screening_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality sdoh screening record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the quality sdoh screening record.',
    `community_resource_id` BIGINT COMMENT 'Community resource identified during screening.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the quality sdoh screening record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the measure within the quality sdoh screening record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the quality sdoh screening record.',
    `population_health_gap_id` BIGINT COMMENT 'Unique identifier for the population health gap within the quality sdoh screening record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the screener employee within the quality sdoh screening record.',
    `sdoh_risk_stratification_id` BIGINT COMMENT 'Risk stratification associated with this screening.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the quality sdoh screening record.',
    `sdoh_need_closure_id` BIGINT COMMENT 'Unique identifier for the sdoh need closure within the quality sdoh screening record.',
    `community_resource_referred` STRING COMMENT 'The community resource referred of the quality sdoh screening record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `education_need_flag` BOOLEAN COMMENT 'The education need flag of the quality sdoh screening record.',
    `employment_need_flag` BOOLEAN COMMENT 'The employment need flag of the quality sdoh screening record.',
    `financial_strain_flag` BOOLEAN COMMENT 'The financial strain flag of the quality sdoh screening record.',
    `food_insecurity_flag` BOOLEAN COMMENT 'The food insecurity flag of the quality sdoh screening record.',
    `housing_instability_flag` BOOLEAN COMMENT 'The housing instability flag of the quality sdoh screening record.',
    `icd10_z_code` STRING COMMENT 'The icd10 z code value classifying the quality sdoh screening record.',
    `interpersonal_safety_flag` BOOLEAN COMMENT 'The interpersonal safety flag of the quality sdoh screening record.',
    `measurement_period` STRING COMMENT 'The measurement period of the quality sdoh screening record.',
    `need_closed_date` DATE COMMENT 'Timestamp capturing the need closed date associated with the quality sdoh screening record.',
    `need_closed_flag` BOOLEAN COMMENT 'The need closed flag of the quality sdoh screening record.',
    `need_closure_date` DATE COMMENT 'Timestamp capturing the need closure date associated with the quality sdoh screening record.',
    `need_closure_status` STRING COMMENT 'The need closure status value classifying the quality sdoh screening record.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'The overall risk score of the quality sdoh screening record.',
    `positive_domain_count` STRING COMMENT 'The positive domain count of the quality sdoh screening record.',
    `positive_screen_flag` BOOLEAN COMMENT 'The positive screen flag of the quality sdoh screening record.',
    `primary_z_code` STRING COMMENT 'The primary z code value classifying the quality sdoh screening record.',
    `priority_score` STRING COMMENT 'The priority score of the quality sdoh screening record.',
    `referral_date` DATE COMMENT 'Timestamp capturing the referral date associated with the quality sdoh screening record.',
    `referral_generated_flag` BOOLEAN COMMENT 'The referral generated flag of the quality sdoh screening record.',
    `referral_made_flag` BOOLEAN COMMENT 'The referral made flag of the quality sdoh screening record.',
    `referral_status` STRING COMMENT 'The referral status value classifying the quality sdoh screening record.',
    `risk_priority_score` DECIMAL(18,2) COMMENT 'The risk priority score of the quality sdoh screening record.',
    `risk_stratification` STRING COMMENT 'The risk stratification of the quality sdoh screening record.',
    `risk_stratification_level` STRING COMMENT 'The risk stratification level of the quality sdoh screening record.',
    `risk_tier` STRING COMMENT 'The risk tier of the quality sdoh screening record.',
    `screener_role` STRING COMMENT 'The screener role of the quality sdoh screening record.',
    `screening_date` DATE COMMENT 'Timestamp capturing the screening date associated with the quality sdoh screening record.',
    `screening_instrument` STRING COMMENT 'The screening instrument of the quality sdoh screening record.',
    `screening_number` STRING COMMENT 'The screening number of the quality sdoh screening record.',
    `screening_setting` STRING COMMENT 'The screening setting of the quality sdoh screening record.',
    `screening_status` STRING COMMENT 'The screening status value classifying the quality sdoh screening record.',
    `screening_tool` STRING COMMENT 'The screening tool of the quality sdoh screening record.',
    `sdoh_category` STRING COMMENT 'The sdoh category of the quality sdoh screening record.',
    `social_isolation_flag` BOOLEAN COMMENT 'The social isolation flag of the quality sdoh screening record.',
    `total_positive_domains` STRING COMMENT 'The total positive domains of the quality sdoh screening record.',
    `total_risk_score` STRING COMMENT 'The total risk score of the quality sdoh screening record.',
    `transportation_barrier_flag` BOOLEAN COMMENT 'The transportation barrier flag of the quality sdoh screening record.',
    `transportation_need_flag` BOOLEAN COMMENT 'The transportation need flag of the quality sdoh screening record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `utility_need_flag` BOOLEAN COMMENT 'The utility need flag of the quality sdoh screening record.',
    `utility_needs_flag` BOOLEAN COMMENT 'The utility needs flag of the quality sdoh screening record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `z_code_assigned` STRING COMMENT 'The z code assigned of the quality sdoh screening record.',
    `z_code_category` STRING COMMENT 'The z code category of the quality sdoh screening record.',
    `z_code_list` STRING COMMENT 'The z code list of the quality sdoh screening record.',
    `z_code_mapping` STRING COMMENT 'The z code mapping of the quality sdoh screening record.',
    `zcode_category` STRING COMMENT 'The zcode category of the quality sdoh screening record.',
    CONSTRAINT pk_sdoh_screening PRIMARY KEY(`sdoh_screening_id`)
) COMMENT 'Social determinants of health screening results using standardized instruments (AHC-HRSN, PRAPARE). Business justification: Required by CMS for ACO quality, TJC standards, and health equity initiatives.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Primary key',
    `accreditation_survey_id` BIGINT COMMENT 'Unique identifier for the accreditation survey within the quality corrective action record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality corrective action record.',
    `quality_committee_id` BIGINT COMMENT 'Unique identifier for the committee within the quality corrective action record.',
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan within the quality corrective action record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the corrective employee within the quality corrective action record.',
    `improvement_initiative_id` BIGINT COMMENT 'Unique identifier for the improvement initiative within the quality corrective action record.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee within the quality corrective action record.',
    `patient_safety_event_id` BIGINT COMMENT 'Unique identifier for the patient safety event within the quality corrective action record.',
    `standard_finding_id` BIGINT COMMENT 'Unique identifier for the standard finding within the quality corrective action record.',
    `action_description` STRING COMMENT 'The action description of the quality corrective action record.',
    `action_number` STRING COMMENT 'The action number of the quality corrective action record.',
    `action_status` STRING COMMENT 'The action status value classifying the quality corrective action record.',
    `action_type` STRING COMMENT 'The action type value classifying the quality corrective action record.',
    `actual_completion_date` DATE COMMENT 'Timestamp capturing the actual completion date associated with the quality corrective action record.',
    `assigned_department` STRING COMMENT 'The assigned department of the quality corrective action record.',
    `completed_date` DATE COMMENT 'Timestamp capturing the completed date associated with the quality corrective action record.',
    `completion_date` DATE COMMENT 'Timestamp capturing the completion date associated with the quality corrective action record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `due_date` DATE COMMENT 'Timestamp capturing the due date associated with the quality corrective action record.',
    `effectiveness_verification_date` DATE COMMENT 'Timestamp capturing the effectiveness verification date associated with the quality corrective action record.',
    `effectiveness_verified` BOOLEAN COMMENT 'The effectiveness verified of the quality corrective action record.',
    `effectiveness_verified_date` DATE COMMENT 'Timestamp capturing the effectiveness verified date associated with the quality corrective action record.',
    `effectiveness_verified_flag` BOOLEAN COMMENT 'The effectiveness verified flag of the quality corrective action record.',
    `identified_date` DATE COMMENT 'Timestamp capturing the identified date associated with the quality corrective action record.',
    `initiated_date` DATE COMMENT 'Timestamp capturing the initiated date associated with the quality corrective action record.',
    `monitoring_frequency` STRING COMMENT 'The monitoring frequency of the quality corrective action record.',
    `monitoring_method` STRING COMMENT 'The monitoring method of the quality corrective action record.',
    `outcome_summary` STRING COMMENT 'The outcome summary of the quality corrective action record.',
    `owner_name` STRING COMMENT 'The owner name of the quality corrective action record.',
    `percent_complete` STRING COMMENT 'The percent complete of the quality corrective action record.',
    `priority_level` STRING COMMENT 'The priority level of the quality corrective action record.',
    `recurrence_flag` BOOLEAN COMMENT 'The recurrence flag of the quality corrective action record.',
    `responsible_department` STRING COMMENT 'The responsible department of the quality corrective action record.',
    `responsible_party` STRING COMMENT 'The responsible party of the quality corrective action record.',
    `responsible_party_name` STRING COMMENT 'The responsible party name of the quality corrective action record.',
    `root_cause` STRING COMMENT 'The root cause of the quality corrective action record.',
    `root_cause_summary` STRING COMMENT 'The root cause summary of the quality corrective action record.',
    `target_completion_date` DATE COMMENT 'Timestamp capturing the target completion date associated with the quality corrective action record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `verification_date` DATE COMMENT 'Timestamp capturing the verification date associated with the quality corrective action record.',
    `verification_method` STRING COMMENT 'The verification method of the quality corrective action record.',
    `verification_status` STRING COMMENT 'The verification status value classifying the quality corrective action record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective action tracking for quality findings, audit deficiencies, and improvement opportunities. Business justification: Ensures timely remediation and compliance with accreditation requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` (
    `program_measure_assignment_id` BIGINT COMMENT 'Primary key',
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the hedis measure within the quality program measure assignment record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the measure within the quality program measure assignment record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality program measure assignment record.',
    `vbp_program_id` BIGINT COMMENT 'Unique identifier for the vbp program within the quality program measure assignment record.',
    `assignment_status` STRING COMMENT 'The assignment status value classifying the quality program measure assignment record.',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'The benchmark rate of the quality program measure assignment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `display_order` STRING COMMENT 'The display order of the quality program measure assignment record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality program measure assignment record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality program measure assignment record.',
    `is_required` BOOLEAN COMMENT 'Boolean flag indicating the is required status of the quality program measure assignment record.',
    `is_scored` BOOLEAN COMMENT 'Boolean flag indicating the is scored status of the quality program measure assignment record.',
    `measure_domain` STRING COMMENT 'The measure domain of the quality program measure assignment record.',
    `measure_weight` DECIMAL(18,2) COMMENT 'The measure weight of the quality program measure assignment record.',
    `measurement_year` STRING COMMENT 'The measurement year of the quality program measure assignment record.',
    `performance_target_rate` DECIMAL(18,2) COMMENT 'The performance target rate of the quality program measure assignment record.',
    `performance_threshold` STRING COMMENT 'The performance threshold of the quality program measure assignment record.',
    `performance_year` STRING COMMENT 'The performance year of the quality program measure assignment record.',
    `program_year` STRING COMMENT 'The program year of the quality program measure assignment record.',
    `reporting_end_date` DATE COMMENT 'Timestamp capturing the reporting end date associated with the quality program measure assignment record.',
    `reporting_frequency` STRING COMMENT 'The reporting frequency of the quality program measure assignment record.',
    `reporting_priority` STRING COMMENT 'The reporting priority of the quality program measure assignment record.',
    `reporting_start_date` DATE COMMENT 'Timestamp capturing the reporting start date associated with the quality program measure assignment record.',
    `target_rate` DECIMAL(18,2) COMMENT 'The target rate of the quality program measure assignment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `weight` DECIMAL(18,2) COMMENT 'The weight of the quality program measure assignment record.',
    CONSTRAINT pk_program_measure_assignment PRIMARY KEY(`program_measure_assignment_id`)
) COMMENT 'Assignment of quality measures to reporting programs with effective dates and targets. Business justification: Manages measure portfolio across multiple quality programs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` (
    `initiative_measure_target_id` BIGINT COMMENT 'Primary key',
    `improvement_initiative_id` BIGINT COMMENT 'Unique identifier for the improvement initiative within the quality initiative measure target record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the measure within the quality initiative measure target record.',
    `measure_result_id` BIGINT COMMENT 'Unique identifier for the measure result within the quality initiative measure target record.',
    `achieved_date` DATE COMMENT 'Timestamp capturing the achieved date associated with the quality initiative measure target record.',
    `baseline_date` DATE COMMENT 'Timestamp capturing the baseline date associated with the quality initiative measure target record.',
    `baseline_rate` DECIMAL(18,2) COMMENT 'The baseline rate of the quality initiative measure target record.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The baseline value of the quality initiative measure target record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `current_rate` DECIMAL(18,2) COMMENT 'The current rate of the quality initiative measure target record.',
    `current_value` DECIMAL(18,2) COMMENT 'The current value of the quality initiative measure target record.',
    `direction_of_improvement` STRING COMMENT 'The direction of improvement of the quality initiative measure target record.',
    `is_achieved` BOOLEAN COMMENT 'Boolean flag indicating the is achieved status of the quality initiative measure target record.',
    `measurement_period` STRING COMMENT 'The measurement period of the quality initiative measure target record.',
    `measurement_period_end` STRING COMMENT 'The measurement period end of the quality initiative measure target record.',
    `measurement_period_start` STRING COMMENT 'The measurement period start of the quality initiative measure target record.',
    `measurement_unit` STRING COMMENT 'The measurement unit of the quality initiative measure target record.',
    `measurement_year` STRING COMMENT 'The measurement year of the quality initiative measure target record.',
    `initiative_measure_target_status` STRING COMMENT 'The initiative measure target status value classifying the quality initiative measure target record.',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'The stretch target value of the quality initiative measure target record.',
    `target_achievement_date` DATE COMMENT 'Timestamp capturing the target achievement date associated with the quality initiative measure target record.',
    `target_date` DATE COMMENT 'Timestamp capturing the target date associated with the quality initiative measure target record.',
    `target_direction` STRING COMMENT 'The target direction of the quality initiative measure target record.',
    `target_met_flag` BOOLEAN COMMENT 'The target met flag of the quality initiative measure target record.',
    `target_rate` DECIMAL(18,2) COMMENT 'The target rate of the quality initiative measure target record.',
    `target_status` STRING COMMENT 'The target status value classifying the quality initiative measure target record.',
    `target_value` DECIMAL(18,2) COMMENT 'The target value of the quality initiative measure target record.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value of the quality initiative measure target record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `variance` DECIMAL(18,2) COMMENT 'The variance of the quality initiative measure target record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `weight` STRING COMMENT 'The weight of the quality initiative measure target record.',
    CONSTRAINT pk_initiative_measure_target PRIMARY KEY(`initiative_measure_target_id`)
) COMMENT 'Performance targets for measures within quality improvement initiatives. Business justification: Tracks goal attainment and initiative effectiveness.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` (
    `contract_initiative_id` BIGINT COMMENT 'Primary key',
    `improvement_initiative_id` BIGINT COMMENT 'Unique identifier for the improvement initiative within the quality contract initiative record.',
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract within the quality contract initiative record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality contract initiative record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality contract initiative record.',
    `contract_year` STRING COMMENT 'The contract year of the quality contract initiative record.',
    `contractual_metric` STRING COMMENT 'The contractual metric of the quality contract initiative record.',
    `contractual_target` STRING COMMENT 'The contractual target of the quality contract initiative record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the quality contract initiative record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality contract initiative record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality contract initiative record.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'The incentive amount of the quality contract initiative record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the quality contract initiative record.',
    `link_status` STRING COMMENT 'The link status value classifying the quality contract initiative record.',
    `link_type` STRING COMMENT 'The link type value classifying the quality contract initiative record.',
    `linkage_status` STRING COMMENT 'The linkage status value classifying the quality contract initiative record.',
    `linkage_type` STRING COMMENT 'The linkage type value classifying the quality contract initiative record.',
    `measurement_period_end` STRING COMMENT 'The measurement period end of the quality contract initiative record.',
    `measurement_period_start` STRING COMMENT 'The measurement period start of the quality contract initiative record.',
    `payment_at_risk_pct` DECIMAL(18,2) COMMENT 'The payment at risk pct of the quality contract initiative record.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The penalty amount of the quality contract initiative record.',
    `performance_period` STRING COMMENT 'The performance period of the quality contract initiative record.',
    `performance_status` STRING COMMENT 'The performance status value classifying the quality contract initiative record.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'The shared savings rate of the quality contract initiative record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_contract_initiative PRIMARY KEY(`contract_initiative_id`)
) COMMENT 'Links quality initiatives to payer contracts for VBP and shared savings programs. Business justification: Aligns quality improvement with financial incentives.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` (
    `program_study_participation_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality program study participation record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality program study participation record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the quality program study participation record.',
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site within the quality program study participation record.',
    `completion_date` DATE COMMENT 'Timestamp capturing the completion date associated with the quality program study participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality program study participation record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality program study participation record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the quality program study participation record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the quality program study participation record.',
    `irb_reference` STRING COMMENT 'The irb reference of the quality program study participation record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the quality program study participation record.',
    `linkage_purpose` STRING COMMENT 'The linkage purpose of the quality program study participation record.',
    `participation_role` STRING COMMENT 'The participation role of the quality program study participation record.',
    `participation_status` STRING COMMENT 'The participation status value classifying the quality program study participation record.',
    `participation_type` STRING COMMENT 'The participation type value classifying the quality program study participation record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the quality program study participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_program_study_participation PRIMARY KEY(`program_study_participation_id`)
) COMMENT 'Links quality programs to research studies for quality improvement research. Business justification: Supports QI research, learning health system initiatives, and grant compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` (
    `measure_budget_allocation_id` BIGINT COMMENT 'Primary key',
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget within the quality measure budget allocation record.',
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line within the quality measure budget allocation record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the quality measure budget allocation record.',
    `measure_id` BIGINT COMMENT 'Unique identifier for the measure within the quality measure budget allocation record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality measure budget allocation record.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the quality measure budget allocation record.',
    `allocation_basis` STRING COMMENT 'The allocation basis of the quality measure budget allocation record.',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The allocation pct of the quality measure budget allocation record.',
    `allocation_percent` DECIMAL(18,2) COMMENT 'The allocation percent of the quality measure budget allocation record.',
    `allocation_period` STRING COMMENT 'The allocation period of the quality measure budget allocation record.',
    `allocation_status` STRING COMMENT 'The allocation status value classifying the quality measure budget allocation record.',
    `committed_amount` DECIMAL(18,2) COMMENT 'The committed amount of the quality measure budget allocation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality measure budget allocation record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality measure budget allocation record.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the quality measure budget allocation record.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The remaining amount of the quality measure budget allocation record.',
    `spent_amount` DECIMAL(18,2) COMMENT 'The spent amount of the quality measure budget allocation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_measure_budget_allocation PRIMARY KEY(`measure_budget_allocation_id`)
) COMMENT 'Budget allocation for quality measure improvement activities. Business justification: Tracks quality investment and ROI for improvement initiatives.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` (
    `measure_attribution_id` BIGINT COMMENT 'Primary key for measure attribution record',
    `attribution_panel_id` BIGINT COMMENT 'Unique identifier for the attribution panel within the quality measure attribution record.',
    `care_site_id` BIGINT COMMENT 'FK to attributed care site',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the quality measure attribution record.',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the quality measure attribution record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the quality measure attribution record.',
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the hedis measure within the quality measure attribution record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the measure attributed clinician within the quality measure attribution record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the measure attributed org provider within the quality measure attribution record.',
    `measure_clinician_id` BIGINT COMMENT 'FK to attributed clinician',
    `measure_id` BIGINT COMMENT 'FK to quality measure definition',
    `measure_org_provider_id` BIGINT COMMENT 'Unique identifier for the measure org provider within the quality measure attribution record.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `organization_id` BIGINT COMMENT 'FK to attributed organization',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality measure attribution record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality measure attribution record.',
    `vbp_program_id` BIGINT COMMENT 'FK to value-based program',
    `assignment_basis` STRING COMMENT 'The assignment basis of the quality measure attribution record.',
    `attributed_date` DATE COMMENT 'Timestamp capturing the attributed date associated with the quality measure attribution record.',
    `attributed_npi` STRING COMMENT 'The attributed npi of the quality measure attribution record.',
    `attribution_basis` STRING COMMENT 'The attribution basis of the quality measure attribution record.',
    `attribution_confidence_score` DECIMAL(18,2) COMMENT 'The attribution confidence score of the quality measure attribution record.',
    `attribution_effective_date` DATE COMMENT 'Timestamp capturing the attribution effective date associated with the quality measure attribution record.',
    `attribution_end_date` DATE COMMENT 'End date of attribution period',
    `attribution_logic` STRING COMMENT 'The attribution logic of the quality measure attribution record.',
    `attribution_method` STRING COMMENT 'Method used for attribution (e.g., plurality, prospective)',
    `attribution_model` STRING COMMENT 'The attribution model of the quality measure attribution record.',
    `attribution_period_end` DATE COMMENT 'The attribution period end of the quality measure attribution record.',
    `attribution_period_end_date` DATE COMMENT 'Timestamp capturing the attribution period end date associated with the quality measure attribution record.',
    `attribution_period_start` DATE COMMENT 'The attribution period start of the quality measure attribution record.',
    `attribution_period_start_date` DATE COMMENT 'Timestamp capturing the attribution period start date associated with the quality measure attribution record.',
    `attribution_reason` STRING COMMENT 'Reason for attribution assignment',
    `attribution_score` STRING COMMENT 'The attribution score of the quality measure attribution record.',
    `attribution_source` STRING COMMENT 'The attribution source of the quality measure attribution record.',
    `attribution_start_date` DATE COMMENT 'Start date of attribution period',
    `attribution_status` STRING COMMENT 'Current attribution status',
    `attribution_type` STRING COMMENT 'Type of attribution: Primary, Secondary, Shared',
    `attribution_weight` DECIMAL(18,2) COMMENT 'Weight factor for shared attribution',
    `clinical_ai_integration_marker` STRING COMMENT 'The clinical ai integration marker of the quality measure attribution record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `denominator_eligible_flag` BOOLEAN COMMENT 'The denominator eligible flag of the quality measure attribution record.',
    `denominator_flag` BOOLEAN COMMENT 'The denominator flag of the quality measure attribution record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the quality measure attribution record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality measure attribution record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality measure attribution record.',
    `eligible_flag` BOOLEAN COMMENT 'The eligible flag of the quality measure attribution record.',
    `eligible_population_flag` BOOLEAN COMMENT 'The eligible population flag of the quality measure attribution record.',
    `exception_flag` BOOLEAN COMMENT 'The exception flag of the quality measure attribution record.',
    `exclusion_flag` BOOLEAN COMMENT 'The exclusion flag of the quality measure attribution record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the quality measure attribution record.',
    `is_attributed` BOOLEAN COMMENT 'Boolean flag indicating the is attributed status of the quality measure attribution record.',
    `is_eligible_for_measure` BOOLEAN COMMENT 'Boolean flag indicating the is eligible for measure status of the quality measure attribution record.',
    `is_primary_attribution` BOOLEAN COMMENT 'Boolean flag indicating the is primary attribution status of the quality measure attribution record.',
    `is_prospective` BOOLEAN COMMENT 'Boolean flag indicating the is prospective status of the quality measure attribution record.',
    `last_visit_date` DATE COMMENT 'Date of most recent visit',
    `lookback_period_months` STRING COMMENT 'The lookback period months of the quality measure attribution record.',
    `measurement_period` STRING COMMENT 'The measurement period of the quality measure attribution record.',
    `measurement_period_end` DATE COMMENT 'The measurement period end of the quality measure attribution record.',
    `measurement_period_end_date` DATE COMMENT 'Timestamp capturing the measurement period end date associated with the quality measure attribution record.',
    `measurement_period_start` DATE COMMENT 'The measurement period start of the quality measure attribution record.',
    `measurement_period_start_date` DATE COMMENT 'Timestamp capturing the measurement period start date associated with the quality measure attribution record.',
    `measurement_year` STRING COMMENT 'The measurement year of the quality measure attribution record.',
    `numerator_compliant_flag` BOOLEAN COMMENT 'The numerator compliant flag of the quality measure attribution record.',
    `numerator_eligible_flag` BOOLEAN COMMENT 'The numerator eligible flag of the quality measure attribution record.',
    `numerator_flag` BOOLEAN COMMENT 'The numerator flag of the quality measure attribution record.',
    `numerator_met_flag` BOOLEAN COMMENT 'The numerator met flag of the quality measure attribution record.',
    `override_by` STRING COMMENT 'User who performed override',
    `override_flag` BOOLEAN COMMENT 'Whether attribution was manually overridden',
    `override_reason` STRING COMMENT 'Reason for manual override',
    `performance_year` STRING COMMENT 'The performance year of the quality measure attribution record.',
    `plurality_provider_flag` BOOLEAN COMMENT 'The plurality provider flag of the quality measure attribution record.',
    `primary_attribution_flag` BOOLEAN COMMENT 'The primary attribution flag of the quality measure attribution record.',
    `primary_care_visit_count` STRING COMMENT 'Number of primary care visits',
    `specialty_visit_count` STRING COMMENT 'Number of specialty visits',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the quality measure attribution record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the quality measure attribution record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `visit_count` STRING COMMENT 'Number of visits driving attribution',
    CONSTRAINT pk_measure_attribution PRIMARY KEY(`measure_attribution_id`)
) COMMENT 'Quality measure attribution linking patient to measure/clinician/contract.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` (
    `care_gap_closure_id` BIGINT COMMENT 'Primary key for care gap closure record',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the care attributed clinician within the quality care gap closure record.',
    `care_clinician_id` BIGINT COMMENT 'FK to attributed clinician',
    `care_closed_by_clinician_id` BIGINT COMMENT 'Unique identifier for the care closed by clinician within the quality care gap closure record.',
    `care_gap_id` BIGINT COMMENT 'Unique identifier for the care gap within the quality care gap closure record.',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order within the quality care gap closure record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the closed by employee within the quality care gap closure record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the quality care gap closure record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the quality care gap closure record.',
    `hedis_measure_id` BIGINT COMMENT 'Unique identifier for the hedis measure within the quality care gap closure record.',
    `measure_attribution_id` BIGINT COMMENT 'Unique identifier for the measure attribution within the quality care gap closure record.',
    `measure_id` BIGINT COMMENT 'FK to quality measure definition',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality care gap closure record.',
    `population_health_gap_id` BIGINT COMMENT 'Unique identifier for the population health gap within the quality care gap closure record.',
    `sdoh_referral_id` BIGINT COMMENT 'Unique identifier for the sdoh referral within the quality care gap closure record.',
    `visit_id` BIGINT COMMENT 'FK to visit that closed the gap',
    `attribution_basis` STRING COMMENT 'The attribution basis of the quality care gap closure record.',
    `clinical_ai_integration_marker` STRING COMMENT 'The clinical ai integration marker of the quality care gap closure record.',
    `closed_by` STRING COMMENT 'The closed by of the quality care gap closure record.',
    `closed_flag` BOOLEAN COMMENT 'The closed flag of the quality care gap closure record.',
    `closure_code` STRING COMMENT 'CPT/HCPCS code that closed the gap',
    `closure_date` DATE COMMENT 'Timestamp capturing the closure date associated with the quality care gap closure record.',
    `closure_documented_flag` BOOLEAN COMMENT 'The closure documented flag of the quality care gap closure record.',
    `closure_evidence` STRING COMMENT 'The closure evidence of the quality care gap closure record.',
    `closure_evidence_source` STRING COMMENT 'The closure evidence source of the quality care gap closure record.',
    `closure_evidence_type` STRING COMMENT 'Type of evidence for closure',
    `closure_method` STRING COMMENT 'Method of closure: Clinical, Administrative, Supplemental',
    `closure_service_code` STRING COMMENT 'The closure service code value classifying the quality care gap closure record.',
    `closure_source` STRING COMMENT 'The closure source of the quality care gap closure record.',
    `closure_source_system` STRING COMMENT 'The closure source system of the quality care gap closure record.',
    `closure_status` STRING COMMENT 'The closure status value classifying the quality care gap closure record.',
    `closure_verified_by` STRING COMMENT 'The closure verified by of the quality care gap closure record.',
    `closure_verified_flag` BOOLEAN COMMENT 'The closure verified flag of the quality care gap closure record.',
    `compliant_flag` BOOLEAN COMMENT 'The compliant flag of the quality care gap closure record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `days_open` STRING COMMENT 'The days open of the quality care gap closure record.',
    `days_to_close` STRING COMMENT 'The days to close of the quality care gap closure record.',
    `days_to_closure` STRING COMMENT 'The days to closure of the quality care gap closure record.',
    `due_date` DATE COMMENT 'Timestamp capturing the due date associated with the quality care gap closure record.',
    `evidence_source` STRING COMMENT 'The evidence source of the quality care gap closure record.',
    `exception_reason` STRING COMMENT 'Reason for exception if applicable',
    `excluded_flag` BOOLEAN COMMENT 'The excluded flag of the quality care gap closure record.',
    `exclusion_flag` BOOLEAN COMMENT 'The exclusion flag of the quality care gap closure record.',
    `exclusion_reason` STRING COMMENT 'Reason for exclusion if applicable',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of gap',
    `gap_closed_date` DATE COMMENT 'Timestamp capturing the gap closed date associated with the quality care gap closure record.',
    `gap_closure_date` DATE COMMENT 'Date gap was closed',
    `gap_due_date` DATE COMMENT 'Timestamp capturing the gap due date associated with the quality care gap closure record.',
    `gap_identified_date` DATE COMMENT 'Date gap was identified',
    `gap_open_date` DATE COMMENT 'Timestamp capturing the gap open date associated with the quality care gap closure record.',
    `gap_status` STRING COMMENT 'Current gap status: Open, Closed, Excluded, Pending',
    `gap_type` STRING COMMENT 'The gap type value classifying the quality care gap closure record.',
    `icd10_code` STRING COMMENT 'The icd10 code value classifying the quality care gap closure record.',
    `intervention_count` STRING COMMENT 'The intervention count of the quality care gap closure record.',
    `is_closed` BOOLEAN COMMENT 'Boolean flag indicating the is closed status of the quality care gap closure record.',
    `is_closed_flag` BOOLEAN COMMENT 'Boolean flag indicating the is closed flag status of the quality care gap closure record.',
    `is_excluded` BOOLEAN COMMENT 'Boolean flag indicating the is excluded status of the quality care gap closure record.',
    `is_supplemental_data` BOOLEAN COMMENT 'Boolean flag indicating the is supplemental data status of the quality care gap closure record.',
    `last_outreach_date` DATE COMMENT 'Date of last outreach attempt',
    `measure_compliant_flag` BOOLEAN COMMENT 'The measure compliant flag of the quality care gap closure record.',
    `measurement_period` STRING COMMENT 'The measurement period of the quality care gap closure record.',
    `measurement_period_end` DATE COMMENT 'The measurement period end of the quality care gap closure record.',
    `measurement_period_end_date` DATE COMMENT 'End of measurement period',
    `measurement_period_start` DATE COMMENT 'The measurement period start of the quality care gap closure record.',
    `measurement_period_start_date` DATE COMMENT 'Start of measurement period',
    `measurement_year` STRING COMMENT 'Measurement year for the gap',
    `mrn` STRING COMMENT 'The mrn of the quality care gap closure record.',
    `next_action_due_date` DATE COMMENT 'Timestamp capturing the next action due date associated with the quality care gap closure record.',
    `next_outreach_date` DATE COMMENT 'Scheduled next outreach date',
    `outreach_attempt_count` STRING COMMENT 'The outreach attempt count of the quality care gap closure record.',
    `outreach_attempts` STRING COMMENT 'The outreach attempts of the quality care gap closure record.',
    `outreach_count` STRING COMMENT 'Number of outreach attempts',
    `performance_year` STRING COMMENT 'The performance year of the quality care gap closure record.',
    `priority_score` STRING COMMENT 'Priority score for gap closure',
    `responsible_clinician_npi` STRING COMMENT 'The responsible clinician npi of the quality care gap closure record.',
    `responsible_owner` STRING COMMENT 'The responsible owner of the quality care gap closure record.',
    `responsible_provider_name` STRING COMMENT 'The responsible provider name of the quality care gap closure record.',
    `sdoh_barrier_flag` BOOLEAN COMMENT 'The sdoh barrier flag of the quality care gap closure record.',
    `supplemental_data_flag` BOOLEAN COMMENT 'The supplemental data flag of the quality care gap closure record.',
    `supplemental_data_source` STRING COMMENT 'Source of supplemental data if used',
    `supplemental_data_used_flag` BOOLEAN COMMENT 'The supplemental data used flag of the quality care gap closure record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `verification_source` STRING COMMENT 'The verification source of the quality care gap closure record.',
    `verified_by` STRING COMMENT 'User who verified closure',
    `verified_flag` BOOLEAN COMMENT 'Whether closure has been verified',
    `verified_timestamp` TIMESTAMP COMMENT 'Timestamp of verification',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the quality care gap closure record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_care_gap_closure PRIMARY KEY(`care_gap_closure_id`)
) COMMENT 'Care gap closure tracking per patient per payer contract per measurement period.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`raf_score` (
    `raf_score_id` BIGINT COMMENT 'Primary key for RAF score record',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the quality raf score record.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the enrolled member enrollment within the quality raf score record.',
    `member_member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member member enrollment within the quality raf score record.',
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract within the quality raf score record.',
    `payer_id` BIGINT COMMENT 'FK to payer',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality raf score record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the raf attributed clinician within the quality raf score record.',
    `raf_clinician_id` BIGINT COMMENT 'FK to attributed clinician',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `raf_pcp_clinician_id` BIGINT COMMENT 'Unique identifier for the raf pcp clinician within the quality raf score record.',
    `calculation_date` DATE COMMENT 'Date RAF score was calculated',
    `change` DECIMAL(18,2) COMMENT 'Change in RAF score from prior year',
    `clinical_ai_integration_marker` STRING COMMENT 'The clinical ai integration marker of the quality raf score record.',
    `coding_completeness_pct` DECIMAL(18,2) COMMENT 'The coding completeness pct of the quality raf score record.',
    `coding_gap_count` STRING COMMENT 'The coding gap count of the quality raf score record.',
    `coding_gap_flag` BOOLEAN COMMENT 'The coding gap flag of the quality raf score record.',
    `coding_intensity_adjustment` DECIMAL(18,2) COMMENT 'The coding intensity adjustment of the quality raf score record.',
    `coding_intensity_factor` DECIMAL(18,2) COMMENT 'The coding intensity factor of the quality raf score record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_collection_year` STRING COMMENT 'The data collection year of the quality raf score record.',
    `data_source` STRING COMMENT 'The data source of the quality raf score record.',
    `date_of_birth` DATE COMMENT 'The date of birth of the quality raf score record.',
    `date_of_service_year` STRING COMMENT 'The date of service year of the quality raf score record.',
    `delta` DECIMAL(18,2) COMMENT 'The delta of the quality raf score record.',
    `demographic_raf` DECIMAL(18,2) COMMENT 'The demographic raf of the quality raf score record.',
    `demographic_raf_component` DECIMAL(18,2) COMMENT 'The demographic raf component of the quality raf score record.',
    `demographic_score` DECIMAL(18,2) COMMENT 'Demographic component of RAF score',
    `disability_status_flag` BOOLEAN COMMENT 'The disability status flag of the quality raf score record.',
    `disabled_flag` BOOLEAN COMMENT 'Whether member has disabled status',
    `disease_raf` DECIMAL(18,2) COMMENT 'The disease raf of the quality raf score record.',
    `disease_raf_component` DECIMAL(18,2) COMMENT 'The disease raf component of the quality raf score record.',
    `disease_score` DECIMAL(18,2) COMMENT 'Disease/HCC component of RAF score',
    `documented_hcc_list` STRING COMMENT 'The documented hcc list of the quality raf score record.',
    `dos_year` STRING COMMENT 'Date of service year',
    `dual_eligible_flag` BOOLEAN COMMENT 'The dual eligible flag of the quality raf score record.',
    `dual_eligible_status` STRING COMMENT 'The dual eligible status value classifying the quality raf score record.',
    `enrollment_months` STRING COMMENT 'The enrollment months of the quality raf score record.',
    `esrd_flag` BOOLEAN COMMENT 'Whether member has ESRD status',
    `esrd_status_flag` BOOLEAN COMMENT 'The esrd status flag of the quality raf score record.',
    `hcc_code_list` STRING COMMENT 'The hcc code list of the quality raf score record.',
    `hcc_count` STRING COMMENT 'Number of HCCs captured',
    `hcc_list` STRING COMMENT 'Comma-separated list of HCC codes',
    `hcc_model_type` STRING COMMENT 'The hcc model type value classifying the quality raf score record.',
    `hcc_model_version` STRING COMMENT 'The hcc model version of the quality raf score record.',
    `hospice_flag` BOOLEAN COMMENT 'The hospice flag of the quality raf score record.',
    `institutional_flag` BOOLEAN COMMENT 'Whether member is institutionalized',
    `institutional_status_flag` BOOLEAN COMMENT 'The institutional status flag of the quality raf score record.',
    `interaction_raf` DECIMAL(18,2) COMMENT 'The interaction raf of the quality raf score record.',
    `interaction_raf_component` DECIMAL(18,2) COMMENT 'The interaction raf component of the quality raf score record.',
    `interaction_score` DECIMAL(18,2) COMMENT 'Interaction component of RAF score',
    `is_disabled` BOOLEAN COMMENT 'Boolean flag indicating the is disabled status of the quality raf score record.',
    `is_esrd` BOOLEAN COMMENT 'Boolean flag indicating the is esrd status of the quality raf score record.',
    `is_final` BOOLEAN COMMENT 'Boolean flag indicating the is final status of the quality raf score record.',
    `measurement_period_end` DATE COMMENT 'The measurement period end of the quality raf score record.',
    `measurement_period_start` DATE COMMENT 'The measurement period start of the quality raf score record.',
    `measurement_year` STRING COMMENT 'The measurement year of the quality raf score record.',
    `medicare_beneficiary_number` STRING COMMENT 'The medicare beneficiary number of the quality raf score record.',
    `member_months` STRING COMMENT 'The member months of the quality raf score record.',
    `member_year` STRING COMMENT 'The member year of the quality raf score record.',
    `model_type` STRING COMMENT 'The model type value classifying the quality raf score record.',
    `model_version` STRING COMMENT 'The model version of the quality raf score record.',
    `new_enrollee_flag` BOOLEAN COMMENT 'Whether member is new enrollee',
    `normalization_factor` DECIMAL(18,2) COMMENT 'The normalization factor of the quality raf score record.',
    `normalized_raf_score` DECIMAL(18,2) COMMENT 'Normalized RAF score after CMS adjustment',
    `open_hcc_count` STRING COMMENT 'The open hcc count of the quality raf score record.',
    `open_hcc_gap_count` STRING COMMENT 'The open hcc gap count of the quality raf score record.',
    `payment_year` STRING COMMENT 'Payment year for RAF score',
    `performance_year` STRING COMMENT 'The performance year of the quality raf score record.',
    `prior_year_raf` DECIMAL(18,2) COMMENT 'The prior year raf of the quality raf score record.',
    `prior_year_raf_score` DECIMAL(18,2) COMMENT 'RAF score from prior year',
    `raf_change` STRING COMMENT 'The raf change of the quality raf score record.',
    `raf_delta` DECIMAL(18,2) COMMENT 'The raf delta of the quality raf score record.',
    `raf_gap_amount` DECIMAL(18,2) COMMENT 'Potential RAF score from suspected HCCs',
    `raf_model` STRING COMMENT 'The raf model of the quality raf score record.',
    `raf_model_type` STRING COMMENT 'Model type: CNA, CND, CFA, CFD, CPA, CPD, INS',
    `raf_model_version` STRING COMMENT 'CMS-HCC model version (e.g., V24, V28)',
    `raf_score` DECIMAL(18,2) COMMENT 'The raf score of the quality raf score record.',
    `raf_status` STRING COMMENT 'The raf status value classifying the quality raf score record.',
    `raf_value` DECIMAL(18,2) COMMENT 'The raf value of the quality raf score record.',
    `recapture_gap_count` STRING COMMENT 'The recapture gap count of the quality raf score record.',
    `recapture_opportunity_flag` BOOLEAN COMMENT 'The recapture opportunity flag of the quality raf score record.',
    `recapture_rate` DECIMAL(18,2) COMMENT 'The recapture rate of the quality raf score record.',
    `recaptured_hcc_count` STRING COMMENT 'The recaptured hcc count of the quality raf score record.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'Estimated revenue impact of RAF score',
    `risk_adjustment_model` STRING COMMENT 'The risk adjustment model of the quality raf score record.',
    `risk_model` STRING COMMENT 'The risk model of the quality raf score record.',
    `risk_model_version` STRING COMMENT 'The risk model version of the quality raf score record.',
    `risk_segment` STRING COMMENT 'The risk segment of the quality raf score record.',
    `score_calculated_date` DATE COMMENT 'Timestamp capturing the score calculated date associated with the quality raf score record.',
    `score_calculation_date` DATE COMMENT 'Timestamp capturing the score calculation date associated with the quality raf score record.',
    `score_source` STRING COMMENT 'The score source of the quality raf score record.',
    `score_status` STRING COMMENT 'The score status value classifying the quality raf score record.',
    `submission_date` DATE COMMENT 'Timestamp capturing the submission date associated with the quality raf score record.',
    `submission_status` STRING COMMENT 'Status of RAPS/EDPS submission',
    `suspected_hcc_count` STRING COMMENT 'Number of suspected but uncaptured HCCs',
    `suspected_hcc_list` STRING COMMENT 'Comma-separated list of suspected HCCs',
    `total_hcc_count` STRING COMMENT 'The total hcc count of the quality raf score record.',
    `total_raf_score` DECIMAL(18,2) COMMENT 'The total raf score of the quality raf score record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `value` DECIMAL(18,2) COMMENT 'The value of the quality raf score record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the quality raf score record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_raf_score PRIMARY KEY(`raf_score_id`)
) COMMENT 'Risk Adjustment Factor (RAF) score per member per year.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` (
    `mips_measure_reporting_id` BIGINT COMMENT 'Primary key for MIPS measure reporting record',
    `care_site_id` BIGINT COMMENT 'FK to the care site where services rendered',
    `clinician_id` BIGINT COMMENT 'FK to the clinician being measured',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the quality mips measure reporting record.',
    `measure_id` BIGINT COMMENT 'FK to the quality measure definition',
    `measure_result_id` BIGINT COMMENT 'Unique identifier for the measure result within the quality mips measure reporting record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the quality mips measure reporting record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality mips measure reporting record.',
    `achievement_points` DECIMAL(18,2) COMMENT 'The achievement points of the quality mips measure reporting record.',
    `benchmark_decile` STRING COMMENT 'National benchmark decile for comparison',
    `benchmark_percentile` DECIMAL(18,2) COMMENT 'The benchmark percentile of the quality mips measure reporting record.',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'The benchmark rate of the quality mips measure reporting record.',
    `bonus_eligible_flag` BOOLEAN COMMENT 'The bonus eligible flag of the quality mips measure reporting record.',
    `bonus_points` DECIMAL(18,2) COMMENT 'The bonus points of the quality mips measure reporting record.',
    `mips_measure_reporting_category` STRING COMMENT 'The mips measure reporting category of the quality mips measure reporting record.',
    `category_weight_pct` DECIMAL(18,2) COMMENT 'The category weight pct of the quality mips measure reporting record.',
    `clinical_ai_integration_marker` STRING COMMENT 'The clinical ai integration marker of the quality mips measure reporting record.',
    `collection_type` STRING COMMENT 'The collection type value classifying the quality mips measure reporting record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_completeness_pct` DECIMAL(18,2) COMMENT 'The data completeness pct of the quality mips measure reporting record.',
    `data_completeness_rate` DECIMAL(18,2) COMMENT 'Data completeness percentage for the measure',
    `decile_rank` STRING COMMENT 'The decile rank of the quality mips measure reporting record.',
    `decile_score` DECIMAL(18,2) COMMENT 'The decile score of the quality mips measure reporting record.',
    `denominator` STRING COMMENT 'The denominator of the quality mips measure reporting record.',
    `denominator_count` STRING COMMENT 'Count of eligible patients in denominator',
    `eligible_population_count` STRING COMMENT 'The eligible population count of the quality mips measure reporting record.',
    `exception_count` STRING COMMENT 'Count of patients with valid exceptions',
    `exceptions` STRING COMMENT 'The exceptions of the quality mips measure reporting record.',
    `exclusion_count` STRING COMMENT 'Count of patients excluded from measure',
    `exclusions` STRING COMMENT 'The exclusions of the quality mips measure reporting record.',
    `final_mips_score` DECIMAL(18,2) COMMENT 'The final mips score of the quality mips measure reporting record.',
    `high_priority_flag` BOOLEAN COMMENT 'Whether this is a high-priority measure',
    `improvement_points` DECIMAL(18,2) COMMENT 'The improvement points of the quality mips measure reporting record.',
    `is_high_priority_measure` BOOLEAN COMMENT 'Boolean flag indicating the is high priority measure status of the quality mips measure reporting record.',
    `is_outcome_measure` BOOLEAN COMMENT 'Boolean flag indicating the is outcome measure status of the quality mips measure reporting record.',
    `is_submitted` BOOLEAN COMMENT 'Boolean flag indicating the is submitted status of the quality mips measure reporting record.',
    `is_topped_out` BOOLEAN COMMENT 'Boolean flag indicating the is topped out status of the quality mips measure reporting record.',
    `is_topped_out_flag` BOOLEAN COMMENT 'Boolean flag indicating the is topped out flag status of the quality mips measure reporting record.',
    `max_points_possible` DECIMAL(18,2) COMMENT 'Maximum possible points for this measure',
    `measure_cms_code` STRING COMMENT 'The measure cms code value classifying the quality mips measure reporting record.',
    `measure_points` DECIMAL(18,2) COMMENT 'The measure points of the quality mips measure reporting record.',
    `measure_points_earned` STRING COMMENT 'The measure points earned of the quality mips measure reporting record.',
    `measure_score` DECIMAL(18,2) COMMENT 'The measure score of the quality mips measure reporting record.',
    `measure_title` STRING COMMENT 'Title of the MIPS measure',
    `measurement_period_end` DATE COMMENT 'The measurement period end of the quality mips measure reporting record.',
    `measurement_period_end_date` DATE COMMENT 'Timestamp capturing the measurement period end date associated with the quality mips measure reporting record.',
    `measurement_period_start` DATE COMMENT 'The measurement period start of the quality mips measure reporting record.',
    `measurement_period_start_date` DATE COMMENT 'Timestamp capturing the measurement period start date associated with the quality mips measure reporting record.',
    `meets_case_minimum_flag` BOOLEAN COMMENT 'Whether minimum case threshold is met',
    `mips_category` STRING COMMENT 'MIPS category: Quality, Promoting Interoperability, Improvement Activities, Cost',
    `mips_measure_number` STRING COMMENT 'The mips measure number of the quality mips measure reporting record.',
    `npi` STRING COMMENT 'The npi of the quality mips measure reporting record.',
    `npi_number` STRING COMMENT 'The npi number of the quality mips measure reporting record.',
    `numerator` STRING COMMENT 'The numerator of the quality mips measure reporting record.',
    `numerator_count` STRING COMMENT 'Count of patients meeting measure criteria',
    `outcome_measure_flag` BOOLEAN COMMENT 'Whether this is an outcome measure',
    `payment_adjustment_pct` DECIMAL(18,2) COMMENT 'The payment adjustment pct of the quality mips measure reporting record.',
    `performance_met_count` STRING COMMENT 'The performance met count of the quality mips measure reporting record.',
    `performance_not_met_count` STRING COMMENT 'The performance not met count of the quality mips measure reporting record.',
    `performance_period_end` DATE COMMENT 'The performance period end of the quality mips measure reporting record.',
    `performance_period_start` DATE COMMENT 'The performance period start of the quality mips measure reporting record.',
    `performance_rate` DECIMAL(18,2) COMMENT 'Calculated performance rate (numerator/denominator)',
    `performance_year` STRING COMMENT 'MIPS performance year (e.g., 2024)',
    `points_earned` DECIMAL(18,2) COMMENT 'MIPS points earned for this measure',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period',
    `reporting_rate` DECIMAL(18,2) COMMENT 'The reporting rate of the quality mips measure reporting record.',
    `reporting_status` STRING COMMENT 'The reporting status value classifying the quality mips measure reporting record.',
    `submission_date` DATE COMMENT 'Timestamp capturing the submission date associated with the quality mips measure reporting record.',
    `submission_method` STRING COMMENT 'Method of submission: EHR, Registry, QCDR, Claims',
    `submission_status` STRING COMMENT 'Status of measure submission to CMS',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when measure was submitted',
    `submitted_timestamp` TIMESTAMP COMMENT 'The submitted timestamp of the quality mips measure reporting record.',
    `tin` STRING COMMENT 'The tin of the quality mips measure reporting record.',
    `tin_number` STRING COMMENT 'The tin number of the quality mips measure reporting record.',
    `topped_out_flag` BOOLEAN COMMENT 'The topped out flag of the quality mips measure reporting record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_mips_measure_reporting PRIMARY KEY(`mips_measure_reporting_id`)
) COMMENT 'MIPS clinician-level quality measure reporting per performance year.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` (
    `apm_enrollment_id` BIGINT COMMENT 'Primary key for APM enrollment record',
    `accountable_care_organization_id` BIGINT COMMENT 'Unique identifier for the accountable care organization within the quality apm enrollment record.',
    `care_site_id` BIGINT COMMENT 'FK to participating care site',
    `clinician_id` BIGINT COMMENT 'FK to enrolled clinician',
    `group_id` BIGINT COMMENT 'Unique identifier for the group within the quality apm enrollment record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the quality apm enrollment record.',
    `organization_id` BIGINT COMMENT 'FK to participating organization',
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract within the quality apm enrollment record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality apm enrollment record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality apm enrollment record.',
    `vbp_program_id` BIGINT COMMENT 'FK to value-based program definition',
    `advanced_apm_flag` BOOLEAN COMMENT 'The advanced apm flag of the quality apm enrollment record.',
    `apm_entity_code` STRING COMMENT 'CMS APM Entity identifier',
    `apm_entity_identifier` STRING COMMENT 'The apm entity identifier of the quality apm enrollment record.',
    `apm_entity_name` STRING COMMENT 'Name of the APM Entity',
    `apm_identifier` STRING COMMENT 'The apm identifier of the quality apm enrollment record.',
    `apm_model_code` STRING COMMENT 'APM model code (e.g., MSSP, BPCI-A, PCF)',
    `apm_model_name` STRING COMMENT 'Full name of the APM model',
    `apm_name` STRING COMMENT 'The apm name of the quality apm enrollment record.',
    `apm_participant_registry_number` BIGINT COMMENT 'The apm participant registry number of the quality apm enrollment record.',
    `apm_program_name` STRING COMMENT 'The apm program name of the quality apm enrollment record.',
    `apm_program_type` STRING COMMENT 'The apm program type value classifying the quality apm enrollment record.',
    `apm_track` STRING COMMENT 'The apm track of the quality apm enrollment record.',
    `apm_type` STRING COMMENT 'The apm type value classifying the quality apm enrollment record.',
    `attestation_date` DATE COMMENT 'Date of APM participation attestation',
    `attributed_beneficiary_count` STRING COMMENT 'The attributed beneficiary count of the quality apm enrollment record.',
    `benchmark_amount` DECIMAL(18,2) COMMENT 'The benchmark amount of the quality apm enrollment record.',
    `benchmark_expenditure` DECIMAL(18,2) COMMENT 'The benchmark expenditure of the quality apm enrollment record.',
    `clinical_ai_integration_marker` STRING COMMENT 'The clinical ai integration marker of the quality apm enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `disenrollment_date` DATE COMMENT 'Timestamp capturing the disenrollment date associated with the quality apm enrollment record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality apm enrollment record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality apm enrollment record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the quality apm enrollment record.',
    `enrollment_end_date` DATE COMMENT 'End date of APM enrollment',
    `enrollment_start_date` DATE COMMENT 'Start date of APM enrollment',
    `enrollment_status` STRING COMMENT 'Current enrollment status',
    `is_advanced_apm` BOOLEAN COMMENT 'Boolean flag indicating the is advanced apm status of the quality apm enrollment record.',
    `is_mips_apm` BOOLEAN COMMENT 'Boolean flag indicating the is mips apm status of the quality apm enrollment record.',
    `mips_apm_flag` BOOLEAN COMMENT 'The mips apm flag of the quality apm enrollment record.',
    `npi` STRING COMMENT 'National Provider Identifier',
    `partial_qp_flag` BOOLEAN COMMENT 'Whether participant is partial QP',
    `participant_npi` STRING COMMENT 'The participant npi of the quality apm enrollment record.',
    `participant_tin` STRING COMMENT 'The participant tin of the quality apm enrollment record.',
    `participation_option` STRING COMMENT 'The participation option of the quality apm enrollment record.',
    `participation_status` STRING COMMENT 'The participation status value classifying the quality apm enrollment record.',
    `participation_track` STRING COMMENT 'Participation track within the APM',
    `patient_count_threshold` STRING COMMENT 'Patient count threshold for QP status',
    `payment_amount_threshold` DECIMAL(18,2) COMMENT 'Payment amount threshold for QP status',
    `performance_year` STRING COMMENT 'APM performance year',
    `qp_status` STRING COMMENT 'The qp status value classifying the quality apm enrollment record.',
    `qp_status_flag` BOOLEAN COMMENT 'The qp status flag of the quality apm enrollment record.',
    `qp_threshold_score` STRING COMMENT 'The qp threshold score of the quality apm enrollment record.',
    `qualifying_apm_participant_flag` BOOLEAN COMMENT 'Whether participant qualifies as QP',
    `risk_arrangement` STRING COMMENT 'The risk arrangement of the quality apm enrollment record.',
    `risk_arrangement_type` STRING COMMENT 'Type of risk arrangement (one-sided, two-sided)',
    `risk_bearing_flag` BOOLEAN COMMENT 'The risk bearing flag of the quality apm enrollment record.',
    `risk_track` STRING COMMENT 'The risk track of the quality apm enrollment record.',
    `shared_loss_amount` DECIMAL(18,2) COMMENT 'The shared loss amount of the quality apm enrollment record.',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'Shared loss rate percentage',
    `shared_savings_amount` DECIMAL(18,2) COMMENT 'The shared savings amount of the quality apm enrollment record.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'Shared savings rate percentage',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the quality apm enrollment record.',
    `threshold_score` DECIMAL(18,2) COMMENT 'APM threshold score achieved',
    `tin` STRING COMMENT 'Tax Identification Number',
    `tin_number` STRING COMMENT 'The tin number of the quality apm enrollment record.',
    `total_cost_of_care` DECIMAL(18,2) COMMENT 'The total cost of care of the quality apm enrollment record.',
    `total_risk_percent` DECIMAL(18,2) COMMENT 'The total risk percent of the quality apm enrollment record.',
    `two_sided_risk_flag` BOOLEAN COMMENT 'The two sided risk flag of the quality apm enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_apm_enrollment PRIMARY KEY(`apm_enrollment_id`)
) COMMENT 'APM program enrollment per participant per performance year.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` (
    `quality_program_participation_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality quality program participation record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the quality quality program participation record.',
    `network_contract_id` BIGINT COMMENT 'Unique identifier for the network contract within the quality quality program participation record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the quality quality program participation record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality quality program participation record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality quality program participation record.',
    `apm_entity_identifier` STRING COMMENT 'The apm entity identifier of the quality quality program participation record.',
    `attestation_date` DATE COMMENT 'Timestamp capturing the attestation date associated with the quality quality program participation record.',
    `attestation_status` STRING COMMENT 'The attestation status value classifying the quality quality program participation record.',
    `attributed_beneficiary_count` STRING COMMENT 'The attributed beneficiary count of the quality quality program participation record.',
    `attributed_member_count` STRING COMMENT 'The attributed member count of the quality quality program participation record.',
    `attribution_method` STRING COMMENT 'The attribution method of the quality quality program participation record.',
    `contract_reference` STRING COMMENT 'The contract reference of the quality quality program participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality quality program participation record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality quality program participation record.',
    `enrollment_date` DATE COMMENT 'Timestamp capturing the enrollment date associated with the quality quality program participation record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the quality quality program participation record.',
    `group_npi` STRING COMMENT 'The group npi of the quality quality program participation record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the quality quality program participation record.',
    `participant_type` STRING COMMENT 'The participant type value classifying the quality quality program participation record.',
    `participation_role` STRING COMMENT 'The participation role of the quality quality program participation record.',
    `participation_scope` STRING COMMENT 'The participation scope of the quality quality program participation record.',
    `participation_status` STRING COMMENT 'The participation status value classifying the quality quality program participation record.',
    `performance_year` STRING COMMENT 'The performance year of the quality quality program participation record.',
    `program_year` STRING COMMENT 'The program year of the quality quality program participation record.',
    `reporting_option` STRING COMMENT 'The reporting option of the quality quality program participation record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: facility.facility_program_participation (duplicate reconciled to canonical)',
    `submission_status` STRING COMMENT 'The submission status value classifying the quality quality program participation record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the quality quality program participation record.',
    `tin` STRING COMMENT 'The tin of the quality quality program participation record.',
    `tin_number` STRING COMMENT 'The tin number of the quality quality program participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_quality_program_participation PRIMARY KEY(`quality_program_participation_id`)
) COMMENT 'Facility and provider participation in quality programs with enrollment dates and status. Business justification: Tracks program eligibility and reporting obligations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` (
    `quality_committee_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality quality committee record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the chair clinician within the quality quality committee record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the chair employee within the quality quality committee record.',
    `parent_committee_id` BIGINT COMMENT 'Unique identifier for the parent committee within the quality quality committee record.',
    `quality_program_id` BIGINT COMMENT 'Unique identifier for the quality program within the quality quality committee record.',
    `chair_name` STRING COMMENT 'The chair name of the quality quality committee record.',
    `chairperson_name` STRING COMMENT 'The chairperson name of the quality quality committee record.',
    `charter_reference` STRING COMMENT 'The charter reference of the quality quality committee record.',
    `charter_summary` STRING COMMENT 'The charter summary of the quality quality committee record.',
    `committee_charter` STRING COMMENT 'The committee charter of the quality quality committee record.',
    `committee_code` STRING COMMENT 'The committee code value classifying the quality quality committee record.',
    `committee_name` STRING COMMENT 'The committee name of the quality quality committee record.',
    `committee_number` STRING COMMENT 'The committee number of the quality quality committee record.',
    `committee_scope` STRING COMMENT 'The committee scope of the quality quality committee record.',
    `committee_status` STRING COMMENT 'The committee status value classifying the quality quality committee record.',
    `committee_type` STRING COMMENT 'The committee type value classifying the quality quality committee record.',
    `confidentiality_protected_flag` BOOLEAN COMMENT 'The confidentiality protected flag of the quality quality committee record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality quality committee record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality quality committee record.',
    `established_date` DATE COMMENT 'Timestamp capturing the established date associated with the quality quality committee record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the quality quality committee record.',
    `is_peer_review_protected` BOOLEAN COMMENT 'Boolean flag indicating the is peer review protected status of the quality quality committee record.',
    `last_meeting_date` DATE COMMENT 'Timestamp capturing the last meeting date associated with the quality quality committee record.',
    `meeting_frequency` STRING COMMENT 'The meeting frequency of the quality quality committee record.',
    `member_count` STRING COMMENT 'The member count of the quality quality committee record.',
    `next_meeting_date` DATE COMMENT 'Timestamp capturing the next meeting date associated with the quality quality committee record.',
    `quorum_count` STRING COMMENT 'The quorum count of the quality quality committee record.',
    `quorum_requirement` STRING COMMENT 'The quorum requirement of the quality quality committee record.',
    `reporting_authority` STRING COMMENT 'The reporting authority of the quality quality committee record.',
    `reporting_body` STRING COMMENT 'The reporting body of the quality quality committee record.',
    `reporting_relationship` STRING COMMENT 'The reporting relationship of the quality quality committee record.',
    `reporting_structure` STRING COMMENT 'The reporting structure of the quality quality committee record.',
    `scope_description` STRING COMMENT 'The scope description of the quality quality committee record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: provider.committee (duplicate reconciled to canonical)',
    `ssot_reference` STRING COMMENT 'The ssot reference of the quality quality committee record.',
    `quality_committee_status` STRING COMMENT 'The quality committee status value classifying the quality quality committee record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_quality_committee PRIMARY KEY(`quality_committee_id`)
) COMMENT 'Quality committee definitions for governance, peer review, and quality oversight. Business justification: Supports medical staff governance, accreditation requirements, and quality program structure.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`quality`.`quality_program` (
    `quality_program_id` BIGINT COMMENT 'Primary key',
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget within the quality quality program record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the quality quality program record.',
    `compliance_program_id` BIGINT COMMENT 'SSOT cross-reference to canonical compliance.compliance_program',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the quality quality program record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee within the quality quality program record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the quality quality program record.',
    `committee_id` BIGINT COMMENT 'Unique identifier for the committee within the quality quality program record.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the quality quality program record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `quality_program_description` STRING COMMENT 'The quality program description of the quality quality program record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the quality quality program record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the quality quality program record.',
    `goal_statement` STRING COMMENT 'The goal statement of the quality quality program record.',
    `governing_committee` STRING COMMENT 'The governing committee of the quality quality program record.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating the is mandatory status of the quality quality program record.',
    `is_pay_for_performance` BOOLEAN COMMENT 'Boolean flag indicating the is pay for performance status of the quality quality program record.',
    `measurement_year` STRING COMMENT 'The measurement year of the quality quality program record.',
    `payment_at_risk_amount` DECIMAL(18,2) COMMENT 'The payment at risk amount of the quality quality program record.',
    `payment_at_risk_flag` BOOLEAN COMMENT 'The payment at risk flag of the quality quality program record.',
    `program_category` STRING COMMENT 'The program category of the quality quality program record.',
    `program_code` STRING COMMENT 'The program code value classifying the quality quality program record.',
    `program_description` STRING COMMENT 'The program description of the quality quality program record.',
    `program_name` STRING COMMENT 'The program name of the quality quality program record.',
    `program_owner_name` STRING COMMENT 'The program owner name of the quality quality program record.',
    `program_owner_role` STRING COMMENT 'The program owner role of the quality quality program record.',
    `program_scope` STRING COMMENT 'The program scope of the quality quality program record.',
    `program_status` STRING COMMENT 'The program status value classifying the quality quality program record.',
    `program_type` STRING COMMENT 'The program type value classifying the quality quality program record.',
    `program_year` STRING COMMENT 'The program year of the quality quality program record.',
    `regulatory_authority` STRING COMMENT 'The regulatory authority of the quality quality program record.',
    `regulatory_basis` STRING COMMENT 'The regulatory basis of the quality quality program record.',
    `regulatory_body` STRING COMMENT 'The regulatory body of the quality quality program record.',
    `regulatory_driver` STRING COMMENT 'The regulatory driver of the quality quality program record.',
    `reporting_framework` STRING COMMENT 'The reporting framework of the quality quality program record.',
    `reporting_frequency` STRING COMMENT 'The reporting frequency of the quality quality program record.',
    `reporting_period_end` STRING COMMENT 'The reporting period end of the quality quality program record.',
    `reporting_period_start` STRING COMMENT 'The reporting period start of the quality quality program record.',
    `reporting_year` STRING COMMENT 'The reporting year of the quality quality program record.',
    `responsible_department` STRING COMMENT 'The responsible department of the quality quality program record.',
    `sponsoring_body` STRING COMMENT 'The sponsoring body of the quality quality program record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: compliance.compliance_program (duplicate reconciled to canonical)',
    `submission_deadline` DATE COMMENT 'The submission deadline of the quality quality program record.',
    `submission_method` STRING COMMENT 'The submission method of the quality quality program record.',
    `target_population_description` STRING COMMENT 'The target population description of the quality quality program record.',
    `total_program_budget` DECIMAL(18,2) COMMENT 'The total program budget of the quality quality program record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_quality_program PRIMARY KEY(`quality_program_id`)
) COMMENT 'SSOT resolved: defer to compliance.compliance_program as the single source of truth for this concept. This table is a domain-specific extension/reference.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_cahps_survey_id` FOREIGN KEY (`cahps_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`cahps_survey`(`cahps_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_prior_review_safety_event_review_id` FOREIGN KEY (`prior_review_safety_event_review_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`safety_event_review`(`safety_event_review_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ADD CONSTRAINT `fk_quality_accreditation_program_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_program`(`accreditation_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_prior_finding_standard_finding_id` FOREIGN KEY (`prior_finding_standard_finding_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`standard_finding`(`standard_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`population_health_gap`(`population_health_gap_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_quality_committee_id` FOREIGN KEY (`quality_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_standard_finding_id` FOREIGN KEY (`standard_finding_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`standard_finding`(`standard_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ADD CONSTRAINT `fk_quality_program_measure_assignment_vbp_program_id` FOREIGN KEY (`vbp_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`vbp_program`(`vbp_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_vbp_program_id` FOREIGN KEY (`vbp_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`vbp_program`(`vbp_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_measure_attribution_id` FOREIGN KEY (`measure_attribution_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure_attribution`(`measure_attribution_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`population_health_gap`(`population_health_gap_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ADD CONSTRAINT `fk_quality_mips_measure_reporting_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ADD CONSTRAINT `fk_quality_mips_measure_reporting_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ADD CONSTRAINT `fk_quality_mips_measure_reporting_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_vbp_program_id` FOREIGN KEY (`vbp_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`vbp_program`(`vbp_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ADD CONSTRAINT `fk_quality_quality_committee_parent_committee_id` FOREIGN KEY (`parent_committee_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_committee`(`quality_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ADD CONSTRAINT `fk_quality_quality_committee_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`quality` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`quality` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_subdomain' = 'hedis');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `clinical_area` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `continuous_enrollment_days` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `continuous_enrollment_days` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `continuous_enrollment_days` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `continuous_enrollment_days` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `continuous_enrollment_days` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `continuous_enrollment_days` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `continuous_enrollment_days` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hybrid_medical_record_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `hybrid_medical_record_required` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `icd10_code_list` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `measure_short_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ALTER COLUMN `reporting_submission_deadline` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_subdomain' = 'hedis');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `result_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `star_rating_weight` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `star_rating_weight` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `star_rating_weight` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `star_rating_weight` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `star_rating_weight` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `star_rating_weight` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ALTER COLUMN `star_rating_weight` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `patient_mix_adjustment_applied` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `star_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `star_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `star_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `star_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `star_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `star_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `star_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vbp_patient_experience_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ALTER COLUMN `vendor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `overall_hospital_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `patient_service_line` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `self_reported_health_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_overall_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_overall_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_overall_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_overall_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_overall_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_overall_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `top_box_overall_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ALTER COLUMN `vbp_patient_experience_score` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_subdomain' = 'patient_safety');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `harm_level_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel_event` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel_event` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel_event` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel_event` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel_event` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel_event` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_sentinel_event` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_state_reportable` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_state_reportable` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_state_reportable` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_state_reportable` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_state_reportable` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `is_state_reportable` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ALTER COLUMN `patient_outcome` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_subdomain' = 'patient_safety');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `contributing_factors_summary` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `disclosure_to_patient_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `harm_level` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `icd10_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `patient_safety_indicator_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `state_reportable_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `state_reportable_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `state_reportable_flag` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `state_reportable_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `state_reportable_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ALTER COLUMN `state_reportable_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_subdomain' = 'patient_safety');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `drg_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_1` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_1` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_2` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_2` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_3` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_3` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_3` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_3` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_3` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_3` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `contributing_factor_3` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `days_from_admission_to_death` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_classification` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_location_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `death_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `dnr_status_at_death` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_cause_of_death_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `primary_icd10_cause_of_death` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `sentinel_event_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `sentinel_event_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `sentinel_event_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `sentinel_event_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `sentinel_event_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `sentinel_event_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ALTER COLUMN `sentinel_event_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_subdomain' = 'value_based_care');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `clinical_outcomes_domain_weight` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `drg_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `clinical_domain` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `icd10_code_set` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `reporting_program` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `short_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ALTER COLUMN `submission_deadline` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `drg_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `meets_reporting_threshold` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `meets_reporting_threshold` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `meets_reporting_threshold` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `meets_reporting_threshold` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `meets_reporting_threshold` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `meets_reporting_threshold` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `meets_reporting_threshold` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_program` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_program` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_program` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_program` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_program` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_program` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_program` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ALTER COLUMN `reporting_quarter` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_assignment_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `clinical_indicator_summary` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `drg_change_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_credential` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ALTER COLUMN `reviewer_role` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_subdomain' = 'accreditation_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_subdomain' = 'accreditation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accreditation_coordinator_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `accrediting_body` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `condition_level_deficiency_count` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `state_survey_agency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ALTER COLUMN `surveyor_team` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_subdomain' = 'accreditation_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_subdomain' = 'accreditation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `accrediting_body` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `condition_level_deficiency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `findings_count_observation` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `lead_surveyor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `national_patient_safety_goals_reviewed` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `surveyor_team_composition` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `system_tracer_topics` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `system_tracer_topics` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `tracer_methodology_used` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ALTER COLUMN `tracer_methodology_used` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_subdomain' = 'accreditation_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_subdomain' = 'accreditation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_subdomain' = 'accreditation_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_subdomain' = 'quality_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `aim_statement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `aim_statement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `aim_statement` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `aim_statement` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `aim_statement` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `aim_statement` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `clinical_domain` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `clinical_domain` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `clinical_domain` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `clinical_domain` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `clinical_domain` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `clinical_domain` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `clinical_domain` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `initiative_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `problem_statement` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `project_lead_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `project_lead_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `project_lead_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `project_lead_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `project_lead_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `project_lead_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `project_lead_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ALTER COLUMN `sponsor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_subdomain' = 'peer_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_ssot_pair' = 'radiology.radiology_peer_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_ssot_reference' = 'radiology.radiology_peer_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_ssot_primary' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_appropriateness_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_appropriateness_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_appropriateness_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_appropriateness_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_appropriateness_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_appropriateness_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_appropriateness_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_quality_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `care_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `peer_review_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `preventability_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `preventability_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `preventability_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `preventability_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `preventability_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `preventability_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ALTER COLUMN `preventability_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_subdomain' = 'population_health');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_domain` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_domain` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_domain` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_domain` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_domain` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_domain` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `clinical_domain` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ALTER COLUMN `gap_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_subdomain' = 'sdoh');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `icd10_z_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `primary_z_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `primary_z_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ALTER COLUMN `screening_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_subdomain' = 'accreditation_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_subdomain' = 'quality_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `patient_safety_event_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_association_edges' = 'quality.quality_program,quality.measure');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_end_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_end_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_end_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_end_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_end_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_priority` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_priority` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_priority` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_priority` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_priority` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_priority` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_priority` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_measure_assignment` ALTER COLUMN `reporting_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_association_edges' = 'quality.improvement_initiative,quality.measure');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_subdomain' = 'quality_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`initiative_measure_target` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_subdomain' = 'accreditation_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_association_edges' = 'quality.improvement_initiative,insurance.payer_contract');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_subdomain' = 'value_based_care');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_subdomain' = 'accreditation_improvement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_association_edges' = 'quality.quality_program,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_subdomain' = 'research_quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_association_edges' = 'quality.measure,finance.budget_line');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_subdomain' = 'quality_measurement');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` SET TAGS ('pii_subdomain' = 'value_based_care');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `attributed_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `attributed_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `attributed_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `attributed_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `attributed_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `attributed_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `attributed_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `attributed_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` SET TAGS ('pii_subdomain' = 'patient_experience');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` SET TAGS ('pii_subdomain' = 'value_based_care');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` SET TAGS ('pii_grain' = 'patient x payer_contract x measurement_period');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `closed_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `closure_service_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `closure_service_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `icd10_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_clinician_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_clinician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_clinician_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_clinician_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_clinician_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_clinician_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_clinician_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_clinician_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_owner` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_provider_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_provider_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_provider_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_provider_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_provider_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_provider_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ALTER COLUMN `responsible_provider_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` SET TAGS ('pii_subdomain' = 'value_based_care');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` SET TAGS ('pii_grain' = 'member x year');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `demographics_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `member_member_enrollment_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `date_of_birth` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `date_of_birth` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `disability_status_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `disability_status_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` SET TAGS ('pii_subdomain' = 'value_based_care');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_category` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `mips_measure_reporting_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `npi_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_rate` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_rate` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_rate` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_rate` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_rate` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_rate` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_rate` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `reporting_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ALTER COLUMN `tin_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` SET TAGS ('pii_subdomain' = 'value_based_care');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_entity_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_model_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `apm_program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_tin` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_tin` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_tin` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_tin` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_tin` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_tin` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_tin` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `participant_tin` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ALTER COLUMN `tin_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_ssot_canonical' = 'facility.facility_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_ssot_pair' = 'facility.facility_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_ssot_duplicate_of' = 'facility.facility_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_duplicate_of' = 'facility.facility_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `apm_entity_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `group_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `group_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `group_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `group_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `group_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `group_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `group_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `participation_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_option` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_option` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_option` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_option` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_option` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_option` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `reporting_option` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ALTER COLUMN `tin_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_subdomain' = 'safety_review');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_subdomain' = 'governance');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_ssot_primary' = 'provider.committee');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_ssot_duplicate_of' = 'provider.committee');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_ssot_canonical' = 'provider.committee');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_duplicate_of' = 'provider.committee');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chair_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chair_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chair_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chair_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chair_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chair_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chair_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `chairperson_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `committee_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `committee_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_authority` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_authority` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_authority` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_authority` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_authority` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_authority` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_authority` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_body` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_body` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_body` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_body` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_body` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_body` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_body` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_relationship` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_relationship` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_relationship` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_relationship` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_relationship` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_relationship` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_relationship` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_structure` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_structure` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_structure` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_structure` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_structure` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_structure` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ALTER COLUMN `reporting_structure` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_subdomain' = 'measure_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_domain' = 'quality');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_subdomain' = 'program_management');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_ssot_canonical' = 'compliance.compliance_program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_ssot_note' = 'Retain both with distinct scope tags');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_ssot_pair' = 'compliance.compliance_program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_ssot_duplicate_of' = 'compliance.compliance_program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_ssot_reference' = 'compliance.compliance_program');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `goal_statement` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `goal_statement` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `goal_statement` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `goal_statement` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `goal_statement` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `goal_statement` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `program_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_framework` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_framework` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_framework` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_framework` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_framework` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_framework` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_framework` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_year` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_year` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_year` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_year` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_year` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_year` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `reporting_year` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `submission_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `submission_deadline` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `submission_deadline` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `submission_deadline` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `submission_deadline` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `submission_deadline` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ALTER COLUMN `submission_deadline` SET TAGS ('pii_mask_non_prod' = 'true');
