-- Schema for Domain: encounter | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`encounter` COMMENT 'Core operational record of every patient-provider interaction. Owns ADT (Admit, Discharge, Transfer) events, visit types (inpatient, outpatient, ED, observation, telehealth), admission source and disposition, attending and consulting providers, LOS (Length of Stay), DRG assignment, discharge status, and care setting transitions. Central hub linking patient, provider, clinical, and billing domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit` (
    `visit_id` BIGINT COMMENT 'Surrogate primary key for the visit/encounter record.',
    `insurance_coverage_id` BIGINT COMMENT 'FK to the patient insurance coverage record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Visits occur at a specific facility (org_provider). CMS billing, regulatory reporting, and hospital operations require knowing which organizational provider hosted each visit. A healthcare domain expe',
    `clinician_id` BIGINT COMMENT 'FK to the admitting provider clinician.',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient MPI record.',
    `tertiary_visit_discharging_provider_clinician_id` BIGINT COMMENT 'FK to the discharging provider clinician.',
    `admission_source` STRING COMMENT 'Source of admission (e.g., ED, physician referral).. Valid values are `emergency_department|direct_admission|transfer|referral|birth`',
    `admission_timestamp` TIMESTAMP COMMENT 'Date and time of patient admission.',
    `admission_type` STRING COMMENT 'Type of admission (e.g., elective, emergency, urgent).. Valid values are `elective|urgent|emergent|newborn|trauma`',
    `admitting_diagnosis_code` STRING COMMENT 'ICD-10 code for the admitting diagnosis.. Valid values are `^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$`',
    `care_setting` STRING COMMENT 'Care setting (inpatient, outpatient, observation, ED).',
    `care_transition_plan_completed` BOOLEAN COMMENT 'Flag indicating care transition plan was completed.',
    `consent_obtained` BOOLEAN COMMENT 'Flag indicating patient consent was obtained.',
    `converted_to_inpatient` BOOLEAN COMMENT 'Flag indicating observation status converted to inpatient.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `discharge_disposition` STRING COMMENT 'Discharge disposition description.. Valid values are `home|snf|rehab|ama|expired|hospice`',
    `discharge_instructions_issued` BOOLEAN COMMENT 'Flag indicating discharge instructions were issued.',
    `discharge_timestamp` TIMESTAMP COMMENT 'Date and time of patient discharge.',
    `drg_type` STRING COMMENT 'DRG type (MS-DRG, APR-DRG).. Valid values are `MS-DRG|APR-DRG|AP-DRG`',
    `drg_weight` DECIMAL(18,2) COMMENT 'DRG relative weight for reimbursement calculation.',
    `emtala_compliant` BOOLEAN COMMENT 'Flag indicating EMTALA compliance.',
    `encounter_number` STRING COMMENT 'Unique encounter/visit number from source system.',
    `expected_los_days` DECIMAL(18,2) COMMENT 'Expected length of stay in days.',
    `financial_class` STRING COMMENT 'Financial class of the visit (Medicare, Medicaid, Commercial).. Valid values are `commercial|medicare|medicaid|self_pay|workers_comp`',
    `follow_up_scheduled` BOOLEAN COMMENT 'Flag indicating follow-up appointment was scheduled.',
    `inpatient_conversion_timestamp` TIMESTAMP COMMENT 'Timestamp when observation was converted to inpatient.',
    `length_of_stay_days` STRING COMMENT 'Actual length of stay in days.',
    `moon_delivered_timestamp` TIMESTAMP COMMENT 'Timestamp when Medicare Outpatient Observation Notice was delivered.',
    `mrn` STRING COMMENT 'Medical record number.',
    `observation_hours` DECIMAL(18,2) COMMENT 'Total hours patient was in observation status.',
    `observation_status` BOOLEAN COMMENT 'Flag indicating patient is in observation status.',
    `point_of_service_code` STRING COMMENT 'CMS point of service code.',
    `principal_icd10_diagnosis_code` STRING COMMENT 'The principal icd10 diagnosis code value classifying the encounter visit record.. Valid values are `^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$`',
    `readmission_flag` BOOLEAN COMMENT 'Flag indicating this visit is a readmission.',
    `readmission_risk_score` DECIMAL(18,2) COMMENT 'Readmission risk score at time of admission.',
    `source_encounter_code` STRING COMMENT 'Source system encounter code.',
    `structural_fk_reconciled_flag` BOOLEAN COMMENT 'The structural fk reconciled flag of the encounter visit record.',
    `telehealth_connection_quality` STRING COMMENT 'Quality rating of telehealth connection.. Valid values are `excellent|good|fair|poor|failed`',
    `telehealth_platform` STRING COMMENT 'Telehealth platform used for the visit.',
    `two_midnight_compliant` BOOLEAN COMMENT 'Flag indicating compliance with CMS two-midnight rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter visit record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter visit record.',
    `visit_status` STRING COMMENT 'Current status of the visit.. Valid values are `scheduled|arrived|in_progress|discharged|cancelled|no_show`',
    `visit_type` STRING COMMENT 'Type of visit (inpatient, outpatient, ED, telehealth).. Valid values are `inpatient|outpatient|emergency|observation|telehealth|ambulatory`',
    CONSTRAINT pk_visit PRIMARY KEY(`visit_id`)
) COMMENT 'Core encounter/visit record representing a patient interaction with the health system.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` (
    `adt_event_id` BIGINT COMMENT 'Surrogate primary key for the ADT event.',
    `clinician_id` BIGINT COMMENT 'FK to the clinician associated with the ADT event.',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the encounter adt event record.',
    `prior_event_adt_event_id` BIGINT COMMENT 'Self-referential FK to the prior ADT event.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: ADT transfer events require identifying the sending facility (org_provider) for EMTALA compliance, inter-facility transfer tracking, and HL7 ADT message reconciliation. The plain sending_facility co',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `accepting_provider_npi` STRING COMMENT 'NPI of the accepting provider.. Valid values are `^[0-9]{10}$`',
    `admission_source_code` STRING COMMENT 'The admission source code value classifying the encounter adt event record.',
    `adt_event_status` STRING COMMENT 'The adt event status value classifying the encounter adt event record.',
    `ama_flag` BOOLEAN COMMENT 'Flag indicating against medical advice discharge.',
    `bed_assigned_timestamp` TIMESTAMP COMMENT 'Timestamp when bed was assigned.',
    `bed_request_timestamp` TIMESTAMP COMMENT 'Timestamp when bed was requested.',
    `cancel_reason` STRING COMMENT 'Reason for event cancellation.',
    `clinical_reason_for_transfer` STRING COMMENT 'Clinical reason for patient transfer.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `discharge_disposition_code` STRING COMMENT 'The discharge disposition code value classifying the encounter adt event record.',
    `drg_type` STRING COMMENT 'DRG type associated with the event.. Valid values are `MS-DRG|APR-DRG|IR-DRG`',
    `emtala_compliant` BOOLEAN COMMENT 'EMTALA compliance flag.',
    `emtala_transfer_form_completed` BOOLEAN COMMENT 'Flag indicating EMTALA transfer form was completed.',
    `event_recorded_timestamp` TIMESTAMP COMMENT 'Timestamp when event was recorded in system.',
    `event_status` STRING COMMENT 'Current status of the ADT event.. Valid values are `active|cancelled|corrected|pending`',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the ADT event occurred.',
    `event_type_code` STRING COMMENT 'HL7 ADT event type code (A01, A02, A03, etc.).. Valid values are `A01|A02|A03|A04|A05|A06`',
    `event_type_description` STRING COMMENT 'Description of the ADT event type.',
    `from_bed_code` STRING COMMENT 'Bed code patient is transferring from.',
    `from_unit_code` STRING COMMENT 'Unit code patient is transferring from.',
    `isolation_flag` BOOLEAN COMMENT 'Flag indicating patient requires isolation.',
    `isolation_type` STRING COMMENT 'Type of isolation required.. Valid values are `contact|droplet|airborne|protective|none`',
    `leave_of_absence_reason` STRING COMMENT 'Reason for leave of absence.',
    `level_of_care_code` STRING COMMENT 'The level of care code value classifying the encounter adt event record.',
    `patient_class_code` STRING COMMENT 'Patient class code (inpatient, outpatient, etc.).',
    `patient_stability_score` STRING COMMENT 'Patient stability score at time of event.. Valid values are `stable|guarded|critical|unstable`',
    `readmission_risk_flag` BOOLEAN COMMENT 'Flag indicating elevated readmission risk.',
    `sending_application` STRING COMMENT 'HL7 sending application identifier.',
    `sequence_number` STRING COMMENT 'Sequence number of the event within the visit.',
    `source_system_event_code` STRING COMMENT 'The source system event code value classifying the encounter adt event record.',
    `source_system_name` STRING COMMENT 'The source system name of the encounter adt event record.. Valid values are `EPIC|CERNER|MEDITECH`',
    `to_bed_code` STRING COMMENT 'Bed code patient is transferring to.',
    `to_room_code` STRING COMMENT 'Room code patient is transferring to.',
    `to_unit_code` STRING COMMENT 'Unit code patient is transferring to.',
    `transition_type` STRING COMMENT 'Type of care transition.. Valid values are `inter_unit|level_of_care_change|inter_facility|internal_transfer|external_transfer`',
    `transport_mode` STRING COMMENT 'Mode of patient transport.. Valid values are `ambulance|helicopter|wheelchair|stretcher|ambulatory|private_vehicle`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter adt event record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter adt event record.',
    `visit_type_code` STRING COMMENT 'The visit type code value classifying the encounter adt event record.. Valid values are `inpatient|outpatient|emergency|observation|telehealth|ambulatory`',
    CONSTRAINT pk_adt_event PRIMARY KEY(`adt_event_id`)
) COMMENT 'Admit-Discharge-Transfer event record capturing patient movement events within and between facilities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` (
    `visit_provider_id` BIGINT COMMENT 'Surrogate primary key for the visit-provider association.',
    `network_affiliation_id` BIGINT COMMENT 'FK to provider network affiliation.',
    `payer_id` BIGINT COMMENT 'FK to the payer.',
    `clinician_id` BIGINT COMMENT 'FK to the primary clinician for this visit.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to insurance.provider_network. Business justification: In-network/out-of-network determination at provider assignment level: linking visit_provider to insurance.provider_network enables real-time network status verification for patient cost-sharing calcul',
    `referral_order_id` BIGINT COMMENT 'FK to the referral order.',
    `tertiary_visit_supervising_provider_clinician_id` BIGINT COMMENT 'FK to the tertiary supervising provider.',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `admission_source_role` STRING COMMENT 'Role of the provider at admission.. Valid values are `admitting|referring|transferring|none`',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Timestamp when provider assignment ended.',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Timestamp when provider assignment started.',
    `assignment_status` STRING COMMENT 'Current status of the provider assignment.. Valid values are `active|inactive|pending|cancelled|transferred`',
    `assignment_type` STRING COMMENT 'Type of provider assignment.. Valid values are `scheduled|unscheduled|emergency|coverage|consult_request`',
    `billing_provider_npi` STRING COMMENT 'NPI of the billing provider.. Valid values are `^[0-9]{10}$`',
    `care_setting` STRING COMMENT 'Care setting for this provider assignment.',
    `care_team_sequence` STRING COMMENT 'Sequence number within the care team.',
    `comments` STRING COMMENT 'Free-text comments about the assignment.',
    `cosignature_required` BOOLEAN COMMENT 'Flag indicating co-signature is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credentialing_verified_flag` BOOLEAN COMMENT 'Flag indicating credentialing was verified.',
    `drg_attribution_flag` BOOLEAN COMMENT 'Flag indicating provider is attributed for DRG.',
    `effective_date` DATE COMMENT 'Effective date of the provider assignment.',
    `handoff_reference` STRING COMMENT 'Reference to handoff documentation.',
    `is_attending_of_record` BOOLEAN COMMENT 'Flag indicating provider is the attending of record.',
    `is_primary_provider` BOOLEAN COMMENT 'Flag indicating this is the primary provider.',
    `locum_tenens_flag` BOOLEAN COMMENT 'Flag indicating locum tenens provider.',
    `mips_eligible_flag` BOOLEAN COMMENT 'Flag indicating provider is MIPS eligible.',
    `note_count` STRING COMMENT 'Number of notes authored by this provider for this visit.',
    `npi` STRING COMMENT 'National Provider Identifier.. Valid values are `^[0-9]{10}$`',
    `on_call_flag` BOOLEAN COMMENT 'Flag indicating provider was on call.',
    `order_count` STRING COMMENT 'Number of orders placed by this provider for this visit.',
    `participation_duration_minutes` STRING COMMENT 'Duration of provider participation in minutes.',
    `place_of_service_code` STRING COMMENT 'CMS place of service code.. Valid values are `^[0-9]{2}$`',
    `privilege_type` STRING COMMENT 'Type of clinical privilege exercised.. Valid values are `full|provisional|temporary|locum_tenens|telemedicine`',
    `provider_role` STRING COMMENT 'Role of the provider (attending, resident, consultant).',
    `provider_type` STRING COMMENT 'Type of provider (physician, NP, PA).',
    `rendering_provider_npi` STRING COMMENT 'NPI of the rendering provider.. Valid values are `^[0-9]{10}$`',
    `rvu_credit_flag` BOOLEAN COMMENT 'Flag indicating RVU credit is assigned.',
    `rvu_work_units` DECIMAL(18,2) COMMENT 'Work RVU units credited to this provider.',
    `source_system_record_code` STRING COMMENT 'The source system record code value classifying the encounter visit provider record.',
    `specialty_at_assignment` STRING COMMENT 'Provider specialty at time of assignment.',
    `telehealth_flag` BOOLEAN COMMENT 'Flag indicating telehealth visit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter visit provider record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter visit provider record.',
    `visit_provider_status` STRING COMMENT 'The visit provider status value classifying the encounter visit provider record.',
    CONSTRAINT pk_visit_provider PRIMARY KEY(`visit_provider_id`)
) COMMENT 'Association between a visit and the providers involved in care delivery.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` (
    `drg_assignment_id` BIGINT COMMENT 'Surrogate primary key for the DRG assignment.',
    `clinician_id` BIGINT COMMENT 'FK to the responsible clinician.',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule. Business justification: DRG reimbursement calculation: the fee_schedule governs MS-DRG base payment rates and outlier thresholds. Linking drg_assignment to fee_schedule enables automated expected reimbursement calculation, c',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient MPI record.',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Contract-level DRG reconciliation: payer_contract specifies stop-loss thresholds, outlier payment terms, and base reimbursement rates that govern DRG payment. Revenue cycle analysts require this link ',
    `payer_id` BIGINT COMMENT 'FK to the payer.',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `actual_los` DECIMAL(18,2) COMMENT 'Actual length of stay in days.',
    `admit_source_code` STRING COMMENT 'Admission source code.. Valid values are `^[0-9]{1,2}$`',
    `appeal_status` STRING COMMENT 'Status of any DRG appeal.. Valid values are `not_appealed|pending|upheld|overturned|withdrawn`',
    `arithmetic_mean_los` DECIMAL(18,2) COMMENT 'Arithmetic mean length of stay for this DRG.',
    `assignment_status` STRING COMMENT 'Status of the DRG assignment.. Valid values are `preliminary|final|amended|voided`',
    `assignment_type` STRING COMMENT 'Type of DRG assignment (initial, final, appeal).. Valid values are `initial|working|final|appeal|rac_review`',
    `base_payment_rate` DECIMAL(18,2) COMMENT 'Base payment rate for this DRG.',
    `cc_mcc_flag` BOOLEAN COMMENT 'Flag indicating presence of CC or MCC.',
    `cdi_query_count` STRING COMMENT 'Number of CDI queries associated with this assignment.',
    `cdi_query_response_flag` BOOLEAN COMMENT 'Flag indicating CDI query was responded to.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `discharge_status_code` STRING COMMENT 'The discharge status code value classifying the encounter drg assignment record.. Valid values are `^[0-9]{2}$`',
    `drg_assignment_status` STRING COMMENT 'The drg assignment status value classifying the encounter drg assignment record.',
    `drg_changed_flag` BOOLEAN COMMENT 'Flag indicating DRG was changed from initial assignment.',
    `drg_description` STRING COMMENT 'Description of the assigned DRG.',
    `drg_version` STRING COMMENT 'DRG version (e.g., MS-DRG v40).. Valid values are `MS-DRG|APR-DRG|IR-DRG`',
    `drg_version_number` STRING COMMENT 'The drg version number of the encounter drg assignment record.. Valid values are `^v?[0-9]{1,2}(.[0-9]{1,2})?$`',
    `drg_weight` DECIMAL(18,2) COMMENT 'DRG relative weight.',
    `expected_reimbursement` DECIMAL(18,2) COMMENT 'Expected reimbursement amount.',
    `finalized_timestamp` TIMESTAMP COMMENT 'Timestamp when DRG assignment was finalized.',
    `geometric_mean_los` DECIMAL(18,2) COMMENT 'Geometric mean length of stay for this DRG.',
    `grouper_software` STRING COMMENT 'DRG grouper software used.',
    `grouper_software_version` STRING COMMENT 'Version of the DRG grouper software.',
    `grouping_date` DATE COMMENT 'Date when DRG grouping was performed.',
    `initial_drg_code` STRING COMMENT 'Initial DRG code before any changes.. Valid values are `^[0-9]{3}$`',
    `initial_drg_weight` DECIMAL(18,2) COMMENT 'Initial DRG weight before any changes.',
    `is_outlier` BOOLEAN COMMENT 'Flag indicating this is a cost or day outlier case.',
    `mdc_code` STRING COMMENT 'Major Diagnostic Category code.. Valid values are `^(P[RR]E|[0-9]{1,2})$`',
    `mdc_description` STRING COMMENT 'Major Diagnostic Category description.',
    `outlier_payment` DECIMAL(18,2) COMMENT 'Outlier payment amount.',
    `patient_type` STRING COMMENT 'Patient type (medical, surgical).. Valid values are `inpatient|observation|short_stay`',
    `principal_diagnosis_code` STRING COMMENT 'Principal diagnosis ICD-10 code.. Valid values are `^[A-Z][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$`',
    `principal_diagnosis_description` STRING COMMENT 'The principal diagnosis description of the encounter drg assignment record.',
    `principal_procedure_code` STRING COMMENT 'The principal procedure code value classifying the encounter drg assignment record.. Valid values are `^[0-9A-Z]{7}$`',
    `procedure_count` STRING COMMENT 'Total number of procedures.',
    `rac_review_flag` BOOLEAN COMMENT 'Flag indicating RAC review was performed.',
    `transfer_case_flag` BOOLEAN COMMENT 'Flag indicating this is a transfer case.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter drg assignment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter drg assignment record.',
    CONSTRAINT pk_drg_assignment PRIMARY KEY(`drg_assignment_id`)
) COMMENT 'DRG assignment record capturing grouper results, weights, and reimbursement data for inpatient visits.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` (
    `visit_diagnosis_id` BIGINT COMMENT 'Surrogate primary key for the visit diagnosis.',
    `clinician_id` BIGINT COMMENT 'FK to the diagnosing clinician.',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: Clinical diagnoses directly contribute to DRG grouping. Linking visit_diagnosis to the drg_assignment record enables clinical documentation improvement (CDI) workflows to trace which diagnoses drove t',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient MPI record.',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `bill_indicator` BOOLEAN COMMENT 'Flag indicating diagnosis should be billed.',
    `cc_mcc_indicator` STRING COMMENT 'CC/MCC indicator (CC, MCC, or blank).. Valid values are `CC|MCC|HAC|none`',
    `chronic_condition_flag` BOOLEAN COMMENT 'Flag indicating chronic condition.',
    `coded_date` DATE COMMENT 'Date when diagnosis was coded.',
    `coding_provider_npi` STRING COMMENT 'NPI of the coding provider.. Valid values are `^[0-9]{10}$`',
    `coding_status` STRING COMMENT 'Status of the coding (pending, complete, queried).. Valid values are `pending|coded|validated|queried|amended|final`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `diagnosis_rank` STRING COMMENT 'Rank/sequence of the diagnosis.',
    `diagnosis_seq_num` STRING COMMENT 'Sequence number of the diagnosis.',
    `diagnosis_source` STRING COMMENT 'Source of the diagnosis (physician, coder, etc.).. Valid values are `physician|coder|cdi_specialist|system|imported`',
    `diagnosis_type` STRING COMMENT 'Type of diagnosis (admitting, principal, secondary).. Valid values are `admitting|principal|secondary|discharge|working|final`',
    `drg_code` STRING COMMENT 'DRG code associated with this diagnosis.. Valid values are `^[0-9]{3}$`',
    `drg_relevance_flag` BOOLEAN COMMENT 'Flag indicating relevance to DRG assignment.',
    `drg_type` STRING COMMENT 'The drg type value classifying the encounter visit diagnosis record.. Valid values are `MS-DRG|APR-DRG|IR-DRG`',
    `encounter_diagnosis_comment` STRING COMMENT 'Free-text comment about the diagnosis.',
    `encounter_diagnosis_source_code` STRING COMMENT 'Source system code for the diagnosis.',
    `external_cause_code` STRING COMMENT 'External cause ICD-10 code (E-code).. Valid values are `^[VWX][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$|^Y[0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$`',
    `hai_flag` BOOLEAN COMMENT 'Flag indicating healthcare-associated infection.',
    `hcc_category_code` STRING COMMENT 'HCC category code for risk adjustment.',
    `hcc_flag` BOOLEAN COMMENT 'Flag indicating HCC-relevant diagnosis.',
    `icd10_code` STRING COMMENT 'ICD-10 diagnosis code.. Valid values are `^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$`',
    `icd10_description` STRING COMMENT 'ICD-10 diagnosis description.',
    `icd10_version` STRING COMMENT 'ICD-10 version year.. Valid values are `^FY[0-9]{4}$`',
    `mental_health_flag` BOOLEAN COMMENT 'Flag indicating mental health diagnosis.',
    `onset_date` DATE COMMENT 'Date of diagnosis onset.',
    `poa_indicator` STRING COMMENT 'Present on admission indicator (Y, N, U, W, 1).. Valid values are `Y|N|U|W|1`',
    `primary_diagnosis_flag` BOOLEAN COMMENT 'Flag indicating this is the primary diagnosis.',
    `quality_measure_flag` BOOLEAN COMMENT 'Flag indicating relevance to quality measures.',
    `reportable_condition_flag` BOOLEAN COMMENT 'Flag indicating reportable condition.',
    `resolved_date` DATE COMMENT 'Date when diagnosis was resolved.',
    `sdoh_flag` BOOLEAN COMMENT 'Flag indicating SDOH-related diagnosis (Z-code).',
    `snomed_code` STRING COMMENT 'SNOMED CT code.. Valid values are `^[0-9]{6,18}$`',
    `substance_use_flag` BOOLEAN COMMENT 'Flag indicating substance use disorder diagnosis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter visit diagnosis record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter visit diagnosis record.',
    `visit_diagnosis_status` STRING COMMENT 'The visit diagnosis status value classifying the encounter visit diagnosis record.',
    CONSTRAINT pk_visit_diagnosis PRIMARY KEY(`visit_diagnosis_id`)
) COMMENT 'Diagnosis codes associated with a visit, including POA indicators, DRG relevance, and coding status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` (
    `visit_procedure_id` BIGINT COMMENT 'Surrogate primary key for the visit procedure.',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: Procedures performed during a visit directly influence DRG assignment (principal procedure code, CC/MCC flags). Linking visit_procedure to drg_assignment enables traceability between specific procedur',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Procedure reimbursement and underpayment detection: each visit_procedure maps to a fee_schedule_line (by CPT/HCPCS code) for contracted rate lookup. Revenue cycle teams use this link for charge captur',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient MPI record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Procedures are performed at a specific facility (org_provider). Facility-level surgical credentialing verification, place-of-service billing, and quality registries (NSQIP, STS) require linking each p',
    `clinician_id` BIGINT COMMENT 'FK to the primary performing clinician.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Procedure-level prior authorization compliance: utilization management teams must verify each procedure against the applicable prior_auth_rule before or during the encounter. This link supports auth c',
    `privileging_id` BIGINT COMMENT 'FK to the provider privileging record.',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `anesthesia_type` STRING COMMENT 'Type of anesthesia used.. Valid values are `general|regional|local|monitored_anesthesia_care|none`',
    `asa_class` STRING COMMENT 'ASA physical status classification.. Valid values are `I|II|III|IV|V|VI`',
    `body_site` STRING COMMENT 'Body site of the procedure.',
    `cancellation_reason` STRING COMMENT 'Reason for procedure cancellation.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Charge amount for the procedure.',
    `charge_code` STRING COMMENT 'Charge master code.',
    `complication_description` STRING COMMENT 'Description of any complications.',
    `complication_flag` BOOLEAN COMMENT 'Flag indicating a complication occurred.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Flag indicating informed consent was obtained.',
    `cpt_code` STRING COMMENT 'CPT procedure code.. Valid values are `^[0-9]{4}[0-9A-Z]$`',
    `cpt_modifier_1` STRING COMMENT 'First CPT modifier.. Valid values are `^[A-Z0-9]{2}$`',
    `cpt_modifier_2` STRING COMMENT 'Second CPT modifier.. Valid values are `^[A-Z0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `drg_relevant_flag` BOOLEAN COMMENT 'Flag indicating procedure is DRG-relevant.',
    `hcpcs_code` STRING COMMENT 'HCPCS procedure code.. Valid values are `^[A-Z][0-9]{4}$`',
    `icd10_pcs_code` STRING COMMENT 'ICD-10-PCS procedure code.. Valid values are `^[0-9A-HJ-NP-Z]{7}$`',
    `implant_flag` BOOLEAN COMMENT 'Flag indicating an implant was used.',
    `is_cancelled` BOOLEAN COMMENT 'Flag indicating procedure was cancelled.',
    `is_elective` BOOLEAN COMMENT 'Flag indicating elective procedure.',
    `is_principal_procedure` BOOLEAN COMMENT 'Flag indicating this is the principal procedure.',
    `laterality` STRING COMMENT 'Laterality of the procedure (left, right, bilateral).. Valid values are `left|right|bilateral|unilateral|not_applicable`',
    `performing_provider_npi` STRING COMMENT 'NPI of the performing provider.. Valid values are `^[0-9]{10}$`',
    `procedure_date` DATE COMMENT 'Date the procedure was performed.',
    `procedure_description` STRING COMMENT 'Description of the procedure.',
    `procedure_end_timestamp` TIMESTAMP COMMENT 'Timestamp when procedure ended.',
    `procedure_number` STRING COMMENT 'Procedure number from source system.',
    `procedure_start_timestamp` TIMESTAMP COMMENT 'Timestamp when procedure started.',
    `procedure_status` STRING COMMENT 'Status of the procedure.. Valid values are `completed|in-progress|not-done|entered-in-error|unknown`',
    `procedure_type` STRING COMMENT 'Type of procedure (surgical, diagnostic, therapeutic).',
    `quantity` STRING COMMENT 'Quantity of procedure performed.',
    `rvu_total` DECIMAL(18,2) COMMENT 'Total RVU value.',
    `rvu_work` DECIMAL(18,2) COMMENT 'Work RVU value.',
    `sequence_number` STRING COMMENT 'Sequence number of the procedure.',
    `snomed_code` STRING COMMENT 'SNOMED CT code.. Valid values are `^[0-9]{6,18}$`',
    `source_system_procedure_code` STRING COMMENT 'The source system procedure code value classifying the encounter visit procedure record.',
    `surgical_approach` STRING COMMENT 'Surgical approach (open, laparoscopic, robotic).. Valid values are `open|laparoscopic|robotic|endoscopic|percutaneous|other`',
    `timeout_performed_flag` BOOLEAN COMMENT 'Flag indicating surgical timeout was performed.',
    `udi` STRING COMMENT 'Unique Device Identifier for implanted device.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter visit procedure record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter visit procedure record.',
    `visit_procedure_status` STRING COMMENT 'The visit procedure status value classifying the encounter visit procedure record.',
    `wound_class` STRING COMMENT 'Wound classification (clean, clean-contaminated, contaminated, dirty).. Valid values are `clean|clean_contaminated|contaminated|dirty_infected`',
    CONSTRAINT pk_visit_procedure PRIMARY KEY(`visit_procedure_id`)
) COMMENT 'Procedures performed during a visit, including CPT/ICD-10-PCS codes, RVUs, and surgical details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` (
    `bed_assignment_id` BIGINT COMMENT 'Surrogate primary key for the bed assignment.',
    `adt_event_id` BIGINT COMMENT 'Foreign key linking to encounter.adt_event. Business justification: A bed assignment is operationally triggered by an ADT event (Admit, Transfer). Linking bed_assignment to the specific adt_event that initiated the placement enables full ADT-to-bed traceability. bed_a',
    `clinician_id` BIGINT COMMENT 'FK to the responsible clinician.',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient MPI record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Bed assignments are physically located within a specific facility (org_provider). CMS bed-count compliance, hospital census reporting, and capacity management all require facility-level bed assignment',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `admission_date` DATE COMMENT 'Date of admission.',
    `admission_source_code` STRING COMMENT 'The admission source code value classifying the encounter bed assignment record.',
    `adt_event_type` STRING COMMENT 'ADT event type triggering this assignment.',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Timestamp when bed assignment ended.',
    `assignment_number` STRING COMMENT 'Bed assignment number.',
    `assignment_reason` STRING COMMENT 'Reason for bed assignment.',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Timestamp when bed assignment started.',
    `assignment_status` STRING COMMENT 'Current status of the bed assignment.. Valid values are `pending|active|completed|cancelled|transferred`',
    `bed_assignment_status` STRING COMMENT 'The bed assignment status value classifying the encounter bed assignment record.',
    `bed_class` STRING COMMENT 'Class of bed (ICU, step-down, med-surg).. Valid values are `inpatient|outpatient|observation|emergency|behavioral_health|rehabilitation`',
    `bed_gender_designation` STRING COMMENT 'Gender designation of the bed.. Valid values are `male|female|any`',
    `bed_hold_reason` STRING COMMENT 'Reason for bed hold.. Valid values are `procedure|imaging|therapy|family_request|clinical_hold|none`',
    `bed_request_source` STRING COMMENT 'Source of the bed request.',
    `bed_type` STRING COMMENT 'Type of bed.. Valid values are `icu|telemetry|med_surg|isolation|observation|step_down`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `discharge_date` DATE COMMENT 'Date of discharge.',
    `discharge_disposition_code` STRING COMMENT 'The discharge disposition code value classifying the encounter bed assignment record.',
    `expected_discharge_date` DATE COMMENT 'Timestamp capturing the expected discharge date associated with the encounter bed assignment record.',
    `floor_number` STRING COMMENT 'The floor number of the encounter bed assignment record.',
    `housekeeping_status_at_assignment` STRING COMMENT 'Housekeeping status when bed was assigned.. Valid values are `clean|dirty|in_progress|inspected|out_of_service`',
    `is_isolation_bed` BOOLEAN COMMENT 'Flag indicating isolation bed.',
    `is_observation_status` BOOLEAN COMMENT 'Flag indicating observation status.',
    `is_private_room` BOOLEAN COMMENT 'Flag indicating private room.',
    `is_telemetry_monitored` BOOLEAN COMMENT 'Flag indicating telemetry monitoring.',
    `isolation_type` STRING COMMENT 'Type of isolation.. Valid values are `contact|droplet|airborne|protective|none`',
    `los_days` DECIMAL(18,2) COMMENT 'Length of stay in this bed in days.',
    `nursing_station_code` STRING COMMENT 'The nursing station code value classifying the encounter bed assignment record.',
    `patient_class` STRING COMMENT 'The patient class of the encounter bed assignment record.. Valid values are `inpatient|outpatient|observation|emergency|recurring|preadmit`',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp of bed request.',
    `request_to_assignment_minutes` STRING COMMENT 'Minutes from bed request to assignment.',
    `room_number` STRING COMMENT 'The room number of the encounter bed assignment record.',
    `sequence` STRING COMMENT 'Sequence number of this bed assignment within the visit.',
    `source_system_assignment_code` STRING COMMENT 'The source system assignment code value classifying the encounter bed assignment record.',
    `unit_code` STRING COMMENT 'The unit code value classifying the encounter bed assignment record.',
    `unit_name` STRING COMMENT 'The unit name of the encounter bed assignment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter bed assignment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter bed assignment record.',
    `wing_or_pod` STRING COMMENT 'Wing or pod designation.',
    CONSTRAINT pk_bed_assignment PRIMARY KEY(`bed_assignment_id`)
) COMMENT 'Bed assignment record tracking patient bed placements throughout a visit.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` (
    `visit_insurance_id` BIGINT COMMENT 'Surrogate primary key for the visit insurance record.',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: DRG assignment determines expected reimbursement for a specific payer. Linking visit_insurance to drg_assignment enables payer-specific DRG reimbursement analysis — the drg_assignment record contains ',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to insurance.eligibility_span. Business justification: Revenue cycle eligibility verification: visit_insurance must reference the specific eligibility_span active at time of service for claims submission, denial management, and COB adjudication. Revenue c',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `insurance_coverage_id` BIGINT COMMENT 'FK to patient insurance coverage.',
    `payer_contract_id` BIGINT COMMENT 'FK to the payer contract.',
    `payer_id` BIGINT COMMENT 'FK to the payer.',
    `mpi_record_id` BIGINT COMMENT 'FK to the member MPI record.',
    `subscriber_id` BIGINT COMMENT 'FK to the subscriber.',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `authorization_effective_date` DATE COMMENT 'Effective date of the authorization.',
    `authorization_expiration_date` DATE COMMENT 'Expiration date of the authorization.',
    `authorization_number` STRING COMMENT 'Prior authorization number.',
    `authorization_status` STRING COMMENT 'Status of the authorization.. Valid values are `APPROVED|PENDING|DENIED|NOT_REQUIRED|EXPIRED`',
    `billing_npi` STRING COMMENT 'The billing npi of the encounter visit insurance record.. Valid values are `^[0-9]{10}$`',
    `claim_form_type` STRING COMMENT 'Claim form type (UB-04, CMS-1500).. Valid values are `CMS_1500|UB_04|ELECTRONIC_837P|ELECTRONIC_837I`',
    `cob_notes` STRING COMMENT 'Coordination of benefits notes.',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'The coinsurance rate of the encounter visit insurance record.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The copay amount of the encounter visit insurance record.',
    `coverage_effective_date` DATE COMMENT 'Timestamp capturing the coverage effective date associated with the encounter visit insurance record.',
    `coverage_sequence` STRING COMMENT 'Coverage sequence (primary=1, secondary=2).',
    `coverage_termination_date` DATE COMMENT 'Timestamp capturing the coverage termination date associated with the encounter visit insurance record.',
    `coverage_type` STRING COMMENT 'Type of coverage.. Valid values are `MEDICAL|DENTAL|VISION|BEHAVIORAL_HEALTH|PHARMACY`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The deductible amount of the encounter visit insurance record.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'Deductible amount met.',
    `eligibility_status` STRING COMMENT 'The eligibility status value classifying the encounter visit insurance record.. Valid values are `VERIFIED|PENDING|INACTIVE|UNABLE_TO_VERIFY|NOT_ELIGIBLE`',
    `eligibility_verification_method` STRING COMMENT 'Method used to verify eligibility.. Valid values are `ELECTRONIC|PHONE|PORTAL|MANUAL|REAL_TIME`',
    `eligibility_verified_date` DATE COMMENT 'Date eligibility was verified.',
    `financial_class` STRING COMMENT 'The financial class of the encounter visit insurance record.',
    `group_number` STRING COMMENT 'Insurance group number.',
    `insurance_type_code` STRING COMMENT 'The insurance type code value classifying the encounter visit insurance record.',
    `insurance_verification_source` STRING COMMENT 'Source of insurance verification.. Valid values are `EPIC|CERNER|CHANGE_HEALTHCARE|AVAILITY|MANUAL|PAYER_PORTAL`',
    `network_status` STRING COMMENT 'Network status (in-network, out-of-network).. Valid values are `IN_NETWORK|OUT_OF_NETWORK|UNKNOWN`',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Out-of-pocket maximum.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'Out-of-pocket amount met.',
    `payer_phone` STRING COMMENT 'Payer phone number.. Valid values are `^+?[0-9-s().]{7,20}$`',
    `preauth_required` BOOLEAN COMMENT 'Flag indicating pre-authorization is required.',
    `referral_number` STRING COMMENT 'The referral number of the encounter visit insurance record.',
    `reimbursement_method` STRING COMMENT 'Reimbursement method (DRG, fee-for-service, capitation).. Valid values are `FFS|CAPITATION|BUNDLED|VBP|DRG|PER_DIEM`',
    `subscriber_dob` DATE COMMENT 'Subscriber date of birth.',
    `subscriber_relationship` STRING COMMENT 'Relationship of subscriber to patient.. Valid values are `SELF|SPOUSE|CHILD|OTHER`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter visit insurance record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter visit insurance record.',
    `visit_insurance_status` STRING COMMENT 'The visit insurance status value classifying the encounter visit insurance record.',
    CONSTRAINT pk_visit_insurance PRIMARY KEY(`visit_insurance_id`)
) COMMENT 'Insurance coverage details associated with a visit, including eligibility, authorization, and financial responsibility.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` (
    `triage_assessment_id` BIGINT COMMENT 'Surrogate primary key for the triage assessment.',
    `clinician_id` BIGINT COMMENT 'FK to the clinician.',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient MPI record.',
    `prior_triage_assessment_id` BIGINT COMMENT 'Self-referential FK to prior triage assessment.',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `vital_sign_id` BIGINT COMMENT 'Foreign key linking to clinical.vital_sign. Business justification: ED quality metrics (door-to-triage time with initial vitals), sepsis screening workflows, and ESI level validation require linking the triage assessment to the corresponding clinical vital_sign flowsh',
    `acuity_change_reason` STRING COMMENT 'Reason for acuity level change.',
    `ama_flag` BOOLEAN COMMENT 'Flag indicating against medical advice.',
    `arrival_mode` STRING COMMENT 'Mode of arrival (ambulance, walk-in, helicopter).. Valid values are `ambulance|walk_in|helicopter|police|private_vehicle|transfer`',
    `chief_complaint` STRING COMMENT 'Patient chief complaint.',
    `chief_complaint_code` STRING COMMENT 'Coded chief complaint.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the encounter triage assessment record.',
    `diastolic_bp_mmhg` STRING COMMENT 'Diastolic blood pressure in mmHg.',
    `door_arrival_timestamp` TIMESTAMP COMMENT 'Timestamp of patient arrival at door.',
    `esi_level` STRING COMMENT 'Emergency Severity Index level (1-5).',
    `glasgow_coma_score` STRING COMMENT 'Glasgow Coma Scale score.',
    `heart_rate_bpm` STRING COMMENT 'Heart rate in beats per minute.',
    `interpreter_language` STRING COMMENT 'Language for interpreter services.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Flag indicating interpreter is required.',
    `isolation_required_flag` BOOLEAN COMMENT 'Flag indicating isolation is required.',
    `isolation_type` STRING COMMENT 'Type of isolation required.. Valid values are `airborne|droplet|contact|neutropenic|standard`',
    `lwbs_flag` BOOLEAN COMMENT 'Flag indicating left without being seen.',
    `lwbs_timestamp` TIMESTAMP COMMENT 'Timestamp when patient left without being seen.',
    `mental_health_flag` BOOLEAN COMMENT 'Flag indicating mental health presentation.',
    `pain_scale_type` STRING COMMENT 'Type of pain scale used.. Valid values are `numeric|faces|flacc|verbal|behavioral`',
    `pain_score` STRING COMMENT 'The pain score of the encounter triage assessment record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `respiratory_rate_bpm` STRING COMMENT 'Respiratory rate in breaths per minute.',
    `sepsis_alert_flag` BOOLEAN COMMENT 'Flag indicating sepsis alert was triggered.',
    `source_system_record_code` STRING COMMENT 'The source system record code value classifying the encounter triage assessment record.',
    `spo2_percent` DECIMAL(18,2) COMMENT 'Oxygen saturation percentage.',
    `stroke_alert_flag` BOOLEAN COMMENT 'Flag indicating stroke alert was triggered.',
    `systolic_bp_mmhg` STRING COMMENT 'Systolic blood pressure in mmHg.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Body temperature in Celsius.',
    `temperature_route` STRING COMMENT 'Route of temperature measurement.. Valid values are `oral|rectal|axillary|tympanic|temporal`',
    `trauma_activation_flag` BOOLEAN COMMENT 'Flag indicating trauma activation.',
    `trauma_level` STRING COMMENT 'Trauma activation level.. Valid values are `level_1|level_2|level_3`',
    `triage_assessment_status` STRING COMMENT 'The triage assessment status value classifying the encounter triage assessment record.',
    `triage_category` STRING COMMENT 'The triage category of the encounter triage assessment record.. Valid values are `emergent|urgent|semi_urgent|non_urgent|immediate`',
    `triage_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when triage was completed.',
    `triage_number` STRING COMMENT 'The triage number of the encounter triage assessment record.',
    `triage_nurse_npi` STRING COMMENT 'NPI of the triage nurse.. Valid values are `^[0-9]{10}$`',
    `triage_reassessment_flag` BOOLEAN COMMENT 'Flag indicating this is a reassessment.',
    `triage_status` STRING COMMENT 'Status of the triage assessment.. Valid values are `in_progress|completed|amended|voided`',
    `triage_timestamp` TIMESTAMP COMMENT 'Timestamp of triage.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the encounter triage assessment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter triage assessment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter triage assessment record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Patient weight in kilograms.',
    CONSTRAINT pk_triage_assessment PRIMARY KEY(`triage_assessment_id`)
) COMMENT 'Emergency department triage assessment capturing vital signs, acuity level, and chief complaint.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` (
    `discharge_summary_id` BIGINT COMMENT 'Surrogate primary key for the discharge summary.',
    `addended_discharge_summary_id` BIGINT COMMENT 'Self-referential FK to the original discharge summary being addended.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: CMS Conditions of Participation require discharge planning documentation to reference the patients care plan. Transitions-of-care workflows and readmission reduction programs depend on linking the di',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics.',
    `drg_assignment_id` BIGINT COMMENT 'FK to the DRG assignment.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the encounter discharge summary record.',
    `clinician_id` BIGINT COMMENT 'FK to the primary discharging clinician.',
    `tertiary_discharge_follow_up_provider_clinician_id` BIGINT COMMENT 'FK to the follow-up provider clinician.',
    `visit_id` BIGINT COMMENT 'FK to the parent visit.',
    `activity_restrictions` STRING COMMENT 'Activity restrictions at discharge.',
    `care_transition_plan_completed` BOOLEAN COMMENT 'Flag indicating care transition plan was completed.',
    `compliance_flag` BOOLEAN COMMENT 'Flag indicating compliance issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `diet_instructions` STRING COMMENT 'Dietary instructions at discharge.',
    `discharge_condition` STRING COMMENT 'Patient condition at discharge.. Valid values are `improved|stable|deteriorated|unchanged|expired`',
    `discharge_date` DATE COMMENT 'Date of discharge.',
    `discharge_disposition` STRING COMMENT 'The discharge disposition of the encounter discharge summary record.',
    `discharge_disposition_code` STRING COMMENT 'The discharge disposition code value classifying the encounter discharge summary record.',
    `discharge_instructions_issued` BOOLEAN COMMENT 'Flag indicating discharge instructions were issued.',
    `discharge_instructions_text` STRING COMMENT 'Text of discharge instructions.',
    `discharge_medications_prescribed` STRING COMMENT 'Medications prescribed at discharge.',
    `discharge_summary_number` STRING COMMENT 'Discharge summary document number.',
    `discharge_summary_status` STRING COMMENT 'The discharge summary status value classifying the encounter discharge summary record.',
    `discharge_timestamp` TIMESTAMP COMMENT 'Timestamp of discharge.',
    `discharging_provider_npi` STRING COMMENT 'NPI of the discharging provider.',
    `durable_medical_equipment_ordered` STRING COMMENT 'DME ordered at discharge.',
    `follow_up_appointment_date` DATE COMMENT 'Date of follow-up appointment.',
    `follow_up_instructions` STRING COMMENT 'The follow up instructions of the encounter discharge summary record.',
    `follow_up_scheduled` BOOLEAN COMMENT 'Flag indicating follow-up was scheduled.',
    `functional_status_at_discharge` STRING COMMENT 'The functional status at discharge of the encounter discharge summary record.',
    `home_health_referral_made` BOOLEAN COMMENT 'Flag indicating home health referral was made.',
    `hospital_course_narrative` STRING COMMENT 'Narrative of hospital course.',
    `length_of_stay_days` STRING COMMENT 'Length of stay in days.',
    `medication_reconciliation_completed` BOOLEAN COMMENT 'Flag indicating medication reconciliation was completed.',
    `mrn` STRING COMMENT 'Medical record number.',
    `patient_education_provided` BOOLEAN COMMENT 'Flag indicating patient education was provided.',
    `patient_education_topics` STRING COMMENT 'Topics covered in patient education.',
    `principal_diagnosis_code` STRING COMMENT 'The principal diagnosis code value classifying the encounter discharge summary record.',
    `principal_diagnosis_description` STRING COMMENT 'The principal diagnosis description of the encounter discharge summary record.',
    `procedures_performed_summary` STRING COMMENT 'Summary of procedures performed.',
    `summary_authored_timestamp` TIMESTAMP COMMENT 'Timestamp when summary was authored.',
    `summary_finalized_timestamp` TIMESTAMP COMMENT 'Timestamp when summary was finalized.',
    `summary_of_hospitalization` STRING COMMENT 'The summary of hospitalization of the encounter discharge summary record.',
    `summary_status` STRING COMMENT 'Status of the discharge summary.. Valid values are `draft|preliminary|final|amended|corrected|cancelled`',
    `time_to_completion_hours` DECIMAL(18,2) COMMENT 'Time to complete the discharge summary in hours.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the encounter discharge summary record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the encounter discharge summary record.',
    `warning_signs` STRING COMMENT 'Warning signs to watch for after discharge.',
    `wound_care_instructions` STRING COMMENT 'The wound care instructions of the encounter discharge summary record.',
    CONSTRAINT pk_discharge_summary PRIMARY KEY(`discharge_summary_id`)
) COMMENT 'Discharge summary document capturing hospital course, discharge instructions, and follow-up plan.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_prior_event_adt_event_id` FOREIGN KEY (`prior_event_adt_event_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`adt_event`(`adt_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_adt_event_id` FOREIGN KEY (`adt_event_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`adt_event`(`adt_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_prior_triage_assessment_id` FOREIGN KEY (`prior_triage_assessment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`triage_assessment`(`triage_assessment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_addended_discharge_summary_id` FOREIGN KEY (`addended_discharge_summary_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`discharge_summary`(`discharge_summary_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`encounter` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`encounter` SET TAGS ('dbx_domain' = 'encounter');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Admitting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `tertiary_visit_discharging_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Discharging Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_source` SET TAGS ('dbx_business_glossary_term' = 'Admission Source');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_source` SET TAGS ('dbx_value_regex' = 'emergency_department|direct_admission|transfer|referral|birth');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Admission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|newborn|trauma');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Admitting Diagnosis ICD-10 Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `admitting_diagnosis_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `care_transition_plan_completed` SET TAGS ('dbx_business_glossary_term' = 'Care Transition Plan Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `converted_to_inpatient` SET TAGS ('dbx_business_glossary_term' = 'Converted to Inpatient Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_value_regex' = 'home|snf|rehab|ama|expired|hospice');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_instructions_issued` SET TAGS ('dbx_business_glossary_term' = 'Discharge Instructions Issued Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `discharge_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_type` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|AP-DRG');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `emtala_compliant` SET TAGS ('dbx_business_glossary_term' = 'Emergency Medical Treatment and Labor Act (EMTALA) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `encounter_number` SET TAGS ('dbx_business_glossary_term' = 'Encounter Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `encounter_number` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `expected_los_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Length of Stay (LOS) in Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `financial_class` SET TAGS ('dbx_business_glossary_term' = 'Financial Class');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `financial_class` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|self_pay|workers_comp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `follow_up_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Appointment Scheduled Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `inpatient_conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Conversion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `length_of_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) in Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `moon_delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Medicare Outpatient Observation Notice (MOON) Delivery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `moon_delivered_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Observation Hours');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_hours` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `observation_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `point_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Principal ICD-10 Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `principal_icd10_diagnosis_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `readmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Readmission Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `readmission_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `source_encounter_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Connection Quality');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_connection_quality` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `two_midnight_compliant` SET TAGS ('dbx_business_glossary_term' = 'Two-Midnight Rule Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|arrived|in_progress|discharged|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|telehealth|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Admit Discharge Transfer (ADT) Event ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `prior_event_adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prior ADT Event ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Accepting Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `accepting_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `ama_flag` SET TAGS ('dbx_business_glossary_term' = 'Against Medical Advice (AMA) Discharge Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `bed_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Assigned Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `bed_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `cancel_reason` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_business_glossary_term' = 'Clinical Reason for Transfer');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `clinical_reason_for_transfer` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `drg_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `drg_type` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `emtala_compliant` SET TAGS ('dbx_business_glossary_term' = 'Emergency Medical Treatment and Labor Act (EMTALA) Transfer Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `emtala_transfer_form_completed` SET TAGS ('dbx_business_glossary_term' = 'EMTALA Transfer Form Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Recorded Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|corrected|pending');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Type Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_value_regex' = 'A01|A02|A03|A04|A05|A06');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `event_type_description` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Type Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `from_bed_code` SET TAGS ('dbx_business_glossary_term' = 'From Bed Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `from_unit_code` SET TAGS ('dbx_business_glossary_term' = 'From Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `isolation_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Isolation Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_value_regex' = 'contact|droplet|airborne|protective|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `leave_of_absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave of Absence Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `level_of_care_code` SET TAGS ('dbx_business_glossary_term' = 'Level of Care Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_class_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Class Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_stability_score` SET TAGS ('dbx_business_glossary_term' = 'Patient Stability Score at Transfer');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `patient_stability_score` SET TAGS ('dbx_value_regex' = 'stable|guarded|critical|unstable');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `readmission_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `sending_application` SET TAGS ('dbx_business_glossary_term' = 'Sending Application');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'ADT Event Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ADT Event ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_value_regex' = 'EPIC|CERNER|MEDITECH');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `to_bed_code` SET TAGS ('dbx_business_glossary_term' = 'To Bed Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `to_room_code` SET TAGS ('dbx_business_glossary_term' = 'To Room Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `to_unit_code` SET TAGS ('dbx_business_glossary_term' = 'To Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `transition_type` SET TAGS ('dbx_business_glossary_term' = 'Care Transition Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `transition_type` SET TAGS ('dbx_value_regex' = 'inter_unit|level_of_care_change|inter_facility|internal_transfer|external_transfer');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'ambulance|helicopter|wheelchair|stretcher|ambulatory|private_vehicle');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `vibe_structure_marker` SET TAGS ('dbx_vibe_structure' = 'applied');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `visit_type_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Type Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ALTER COLUMN `visit_type_code` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|telehealth|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `visit_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `network_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Consult Request ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `tertiary_visit_supervising_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `admission_source_role` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Role');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `admission_source_role` SET TAGS ('dbx_value_regex' = 'admitting|referring|transferring|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|cancelled|transferred');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'scheduled|unscheduled|emergency|coverage|consult_request');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `care_team_sequence` SET TAGS ('dbx_business_glossary_term' = 'Care Team Sequence');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assignment Comments');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `cosignature_required` SET TAGS ('dbx_business_glossary_term' = 'Co-Signature Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `credentialing_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `drg_attribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Attribution Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `handoff_reference` SET TAGS ('dbx_business_glossary_term' = 'Handoff Documentation Reference');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `is_attending_of_record` SET TAGS ('dbx_business_glossary_term' = 'Attending of Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `is_primary_provider` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `locum_tenens_flag` SET TAGS ('dbx_business_glossary_term' = 'Locum Tenens Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `mips_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `note_count` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Count');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Call Assignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `participation_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Provider Participation Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `privilege_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `privilege_type` SET TAGS ('dbx_value_regex' = 'full|provisional|temporary|locum_tenens|telemedicine');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `provider_role` SET TAGS ('dbx_business_glossary_term' = 'Provider Role');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rvu_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Credit Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `rvu_work_units` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Units');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `specialty_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty at Assignment');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Encounter Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `telehealth_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `actual_los` SET TAGS ('dbx_business_glossary_term' = 'Actual Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `admit_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `admit_source_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'DRG Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|pending|upheld|overturned|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `arithmetic_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Arithmetic Mean Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'DRG Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|amended|voided');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'DRG Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'initial|working|final|appeal|rac_review');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `base_payment_rate` SET TAGS ('dbx_business_glossary_term' = 'DRG Base Payment Rate');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `cc_mcc_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication and Comorbidity / Major Complication and Comorbidity (CC/MCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `cdi_query_count` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Count');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `cdi_query_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Response Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Discharge Status Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_changed_flag` SET TAGS ('dbx_business_glossary_term' = 'DRG Changed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Version');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version_number` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Version Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_version_number` SET TAGS ('dbx_value_regex' = '^v?[0-9]{1,2}(.[0-9]{1,2})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `expected_reimbursement` SET TAGS ('dbx_business_glossary_term' = 'Expected DRG Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'DRG Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Geometric Mean Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `grouper_software` SET TAGS ('dbx_business_glossary_term' = 'Grouper Software Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `grouper_software_version` SET TAGS ('dbx_business_glossary_term' = 'Grouper Software Version');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `grouping_date` SET TAGS ('dbx_business_glossary_term' = 'DRG Grouping Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `initial_drg_code` SET TAGS ('dbx_business_glossary_term' = 'Initial Working Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `initial_drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `initial_drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Initial Working Diagnosis-Related Group (DRG) Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `is_outlier` SET TAGS ('dbx_business_glossary_term' = 'Cost Outlier Indicator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mdc_code` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category (MDC) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mdc_code` SET TAGS ('dbx_value_regex' = '^(P[RR]E|[0-9]{1,2})$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `mdc_description` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category (MDC) Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `outlier_payment` SET TAGS ('dbx_business_glossary_term' = 'Outlier Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `patient_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `patient_type` SET TAGS ('dbx_value_regex' = 'inpatient|observation|short_stay');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis ICD-10-CM Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure ICD-10-PCS Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code Count');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `procedure_count` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `rac_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `transfer_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Case Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `bill_indicator` SET TAGS ('dbx_business_glossary_term' = 'Billable Diagnosis Indicator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `cc_mcc_indicator` SET TAGS ('dbx_business_glossary_term' = 'Complication/Comorbidity (CC) / Major Complication/Comorbidity (MCC) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `cc_mcc_indicator` SET TAGS ('dbx_value_regex' = 'CC|MCC|HAC|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coded_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Coded Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Coding Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_value_regex' = 'pending|coded|validated|queried|amended|final');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Rank');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_rank` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_seq_num` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Source');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_value_regex' = 'physician|coder|cdi_specialist|system|imported');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_source` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_value_regex' = 'admitting|principal|secondary|discharge|working|final');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relevance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `drg_type` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_business_glossary_term' = 'Encounter Diagnosis Comment');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_comment` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_business_glossary_term' = 'Encounter Diagnosis Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `encounter_diagnosis_source_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_business_glossary_term' = 'External Cause of Injury (ICD-10-CM) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_value_regex' = '^[VWX][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$|^Y[0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `hai_flag` SET TAGS ('dbx_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `hcc_category_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Category Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `hcc_flag` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_description` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_description` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_business_glossary_term' = 'ICD-10-CM Fiscal Year Version');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_value_regex' = '^FY[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_business_glossary_term' = 'Mental Health Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_value_regex' = 'Y|N|U|W|1');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `primary_diagnosis_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `reportable_condition_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Resolved Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `snomed_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `snomed_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `substance_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Disorder (SUD) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ALTER COLUMN `visit_diagnosis_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_value_regex' = 'general|regional|local|monitored_anesthesia_care|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `asa_class` SET TAGS ('dbx_business_glossary_term' = 'American Society of Anesthesiologists (ASA) Physical Status Classification');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `asa_class` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|VI');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Procedure Body Site');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Procedure Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Description Master (CDM) Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `complication_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Complication Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `complication_description` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `complication_flag` SET TAGS ('dbx_business_glossary_term' = 'Procedure Complication Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-9A-Z]$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `drg_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relevant Procedure Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Procedure Coding System (ICD-10-PCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_value_regex' = '^[0-9A-HJ-NP-Z]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `implant_flag` SET TAGS ('dbx_business_glossary_term' = 'Implant Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_cancelled` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cancelled Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_cancelled` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_cancelled` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_cancelled` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_cancelled` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_cancelled` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_cancelled` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_elective` SET TAGS ('dbx_business_glossary_term' = 'Elective Procedure Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `is_principal_procedure` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Procedure Laterality');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Performing Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_description` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Procedure End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_business_glossary_term' = 'Procedure Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Procedure Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_value_regex' = 'completed|in-progress|not-done|entered-in-error|unknown');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Procedure Quantity');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `rvu_total` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) — Total');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) — Work Component');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Procedure Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `snomed_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `snomed_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Procedure ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `source_system_procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `surgical_approach` SET TAGS ('dbx_business_glossary_term' = 'Surgical Approach');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `surgical_approach` SET TAGS ('dbx_value_regex' = 'open|laparoscopic|robotic|endoscopic|percutaneous|other');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `timeout_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Surgical Time-Out Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `visit_procedure_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `wound_class` SET TAGS ('dbx_business_glossary_term' = 'Wound Classification');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ALTER COLUMN `wound_class` SET TAGS ('dbx_value_regex' = 'clean|clean_contaminated|contaminated|dirty_infected');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adt Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `admission_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `adt_event_type` SET TAGS ('dbx_business_glossary_term' = 'ADT (Admit, Discharge, Transfer) Event Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled|transferred');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_class` SET TAGS ('dbx_business_glossary_term' = 'Bed Class');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|emergency|behavioral_health|rehabilitation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_business_glossary_term' = 'Bed Gender Designation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_value_regex' = 'male|female|any');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_gender_designation` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Bed Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_hold_reason` SET TAGS ('dbx_value_regex' = 'procedure|imaging|therapy|family_request|clinical_hold|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_request_source` SET TAGS ('dbx_business_glossary_term' = 'Bed Request Source');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `bed_type` SET TAGS ('dbx_value_regex' = 'icu|telemetry|med_surg|isolation|observation|step_down');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `discharge_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `expected_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `housekeeping_status_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Status at Assignment');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `housekeeping_status_at_assignment` SET TAGS ('dbx_value_regex' = 'clean|dirty|in_progress|inspected|out_of_service');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_isolation_bed` SET TAGS ('dbx_business_glossary_term' = 'Is Isolation Bed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_business_glossary_term' = 'Is Observation Status Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_observation_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_private_room` SET TAGS ('dbx_business_glossary_term' = 'Is Private Room Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `is_telemetry_monitored` SET TAGS ('dbx_business_glossary_term' = 'Is Telemetry Monitored Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `isolation_type` SET TAGS ('dbx_value_regex' = 'contact|droplet|airborne|protective|none');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `los_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `nursing_station_code` SET TAGS ('dbx_business_glossary_term' = 'Nursing Station Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|emergency|recurring|preadmit');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `request_to_assignment_minutes` SET TAGS ('dbx_business_glossary_term' = 'Bed Request to Assignment Elapsed Time (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `source_system_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `unit_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `vibe_structure_marker` SET TAGS ('dbx_vibe_structure' = 'applied');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ALTER COLUMN `wing_or_pod` SET TAGS ('dbx_business_glossary_term' = 'Wing or Pod');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `visit_insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Insurance ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `authorization_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `authorization_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'APPROVED|PENDING|DENIED|NOT_REQUIRED|EXPIRED');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `billing_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `claim_form_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Form Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `claim_form_type` SET TAGS ('dbx_value_regex' = 'CMS_1500|UB_04|ELECTRONIC_837P|ELECTRONIC_837I');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `cob_notes` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Notes');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_sequence` SET TAGS ('dbx_business_glossary_term' = 'Coverage Sequence (Coordination of Benefits)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'MEDICAL|DENTAL|VISION|BEHAVIORAL_HEALTH|PHARMACY');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'VERIFIED|PENDING|INACTIVE|UNABLE_TO_VERIFY|NOT_ELIGIBLE');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_value_regex' = 'ELECTRONIC|PHONE|PORTAL|MANUAL|REAL_TIME');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `eligibility_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `financial_class` SET TAGS ('dbx_business_glossary_term' = 'Financial Class');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Group Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `group_number` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_type_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_verification_source` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Source System');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `insurance_verification_source` SET TAGS ('dbx_value_regex' = 'EPIC|CERNER|CHANGE_HEALTHCARE|AVAILITY|MANUAL|PAYER_PORTAL');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'IN_NETWORK|OUT_OF_NETWORK|UNKNOWN');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_business_glossary_term' = 'Payer Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-s().]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `payer_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `preauth_required` SET TAGS ('dbx_business_glossary_term' = 'Pre-Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Expected Reimbursement Method');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_value_regex' = 'FFS|CAPITATION|BUNDLED|VBP|DRG|PER_DIEM');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_dob` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_value_regex' = 'SELF|SPOUSE|CHILD|OTHER');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` SET TAGS ('dbx_subdomain' = 'patient_encounters');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Triage Nurse Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `prior_triage_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Triage Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `acuity_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Acuity Change Reason');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `ama_flag` SET TAGS ('dbx_business_glossary_term' = 'Against Medical Advice (AMA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `arrival_mode` SET TAGS ('dbx_business_glossary_term' = 'Mode of Arrival');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `arrival_mode` SET TAGS ('dbx_value_regex' = 'ambulance|walk_in|helicopter|police|private_vehicle|transfer');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_business_glossary_term' = 'Chief Complaint');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `chief_complaint_code` SET TAGS ('dbx_business_glossary_term' = 'Chief Complaint SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `chief_complaint_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `diastolic_bp_mmhg` SET TAGS ('dbx_business_glossary_term' = 'Diastolic Blood Pressure (BP) in mmHg');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `diastolic_bp_mmhg` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `door_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Door Arrival Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `door_arrival_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `esi_level` SET TAGS ('dbx_business_glossary_term' = 'Emergency Severity Index (ESI) Level');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `glasgow_coma_score` SET TAGS ('dbx_business_glossary_term' = 'Glasgow Coma Scale (GCS) Score');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `glasgow_coma_score` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `heart_rate_bpm` SET TAGS ('dbx_business_glossary_term' = 'Heart Rate (HR) in Beats Per Minute (BPM)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `heart_rate_bpm` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Precaution Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `isolation_type` SET TAGS ('dbx_value_regex' = 'airborne|droplet|contact|neutropenic|standard');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `lwbs_flag` SET TAGS ('dbx_business_glossary_term' = 'Left Without Being Seen (LWBS) Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `lwbs_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Left Without Being Seen (LWBS) Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_business_glossary_term' = 'Mental Health Presentation Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `mental_health_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Pain Assessment Scale Type');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_value_regex' = 'numeric|faces|flacc|verbal|behavioral');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_score` SET TAGS ('dbx_business_glossary_term' = 'Pain Score');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `pain_score` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `respiratory_rate_bpm` SET TAGS ('dbx_business_glossary_term' = 'Respiratory Rate (RR) in Breaths Per Minute');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `respiratory_rate_bpm` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `sepsis_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Sepsis Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `spo2_percent` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Saturation (SpO2) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `spo2_percent` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `stroke_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Stroke Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `systolic_bp_mmhg` SET TAGS ('dbx_business_glossary_term' = 'Systolic Blood Pressure (BP) in mmHg');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `systolic_bp_mmhg` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Body Temperature in Degrees Celsius');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_route` SET TAGS ('dbx_business_glossary_term' = 'Temperature Measurement Route');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `temperature_route` SET TAGS ('dbx_value_regex' = 'oral|rectal|axillary|tympanic|temporal');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `trauma_activation_flag` SET TAGS ('dbx_business_glossary_term' = 'Trauma Activation Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Activation Level');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_category` SET TAGS ('dbx_business_glossary_term' = 'Triage Category');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_category` SET TAGS ('dbx_value_regex' = 'emergent|urgent|semi_urgent|non_urgent|immediate');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Triage Completion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_number` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_business_glossary_term' = 'Triage Nurse National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_nurse_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_reassessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Triage Reassessment Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_status` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|amended|voided');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `triage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Triage Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Patient Weight in Kilograms');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Summary Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `addended_discharge_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Addended Discharge Summary Id');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `demographics_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Discharging Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `tertiary_discharge_follow_up_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `activity_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Activity Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `care_transition_plan_completed` SET TAGS ('dbx_business_glossary_term' = 'Care Transition Plan Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `diet_instructions` SET TAGS ('dbx_business_glossary_term' = 'Diet Instructions');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Condition');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_value_regex' = 'improved|stable|deteriorated|unchanged|expired');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_condition` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_instructions_issued` SET TAGS ('dbx_business_glossary_term' = 'Discharge Instructions Issued Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_instructions_text` SET TAGS ('dbx_business_glossary_term' = 'Discharge Instructions Text');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_instructions_text` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Discharge Medications Prescribed');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_medications_prescribed` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_summary_number` SET TAGS ('dbx_business_glossary_term' = 'Discharge Summary Number');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharge_timestamp` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Discharging Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `discharging_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `durable_medical_equipment_ordered` SET TAGS ('dbx_business_glossary_term' = 'Durable Medical Equipment (DME) Ordered');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `durable_medical_equipment_ordered` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `durable_medical_equipment_ordered` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `follow_up_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `follow_up_instructions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Instructions');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `follow_up_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Appointment Scheduled Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `functional_status_at_discharge` SET TAGS ('dbx_business_glossary_term' = 'Functional Status at Discharge');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `functional_status_at_discharge` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_business_glossary_term' = 'Home Health Referral Made Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `home_health_referral_made` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `hospital_course_narrative` SET TAGS ('dbx_business_glossary_term' = 'Hospital Course Narrative');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `hospital_course_narrative` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `length_of_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) in Days');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_business_glossary_term' = 'Medication Reconciliation Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `medication_reconciliation_completed` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `patient_education_provided` SET TAGS ('dbx_business_glossary_term' = 'Patient Education Provided Flag');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `patient_education_topics` SET TAGS ('dbx_business_glossary_term' = 'Patient Education Topics');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `principal_diagnosis_description` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_business_glossary_term' = 'Procedures Performed Summary');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `procedures_performed_summary` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_authored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Summary Authored Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Summary Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_of_hospitalization` SET TAGS ('dbx_business_glossary_term' = 'Summary of Hospitalization');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_of_hospitalization` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Summary Status');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `summary_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|amended|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `time_to_completion_hours` SET TAGS ('dbx_business_glossary_term' = 'Time to Completion in Hours');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `vibe_structure_marker` SET TAGS ('dbx_vibe_structure' = 'applied');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `warning_signs` SET TAGS ('dbx_business_glossary_term' = 'Warning Signs');
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ALTER COLUMN `wound_care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Wound Care Instructions');
