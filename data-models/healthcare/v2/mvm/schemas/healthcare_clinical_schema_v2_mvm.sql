-- Schema for Domain: clinical | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`clinical` COMMENT 'Comprehensive clinical documentation and care delivery data. Owns diagnoses (ICD-10), procedures (CPT, HCPCS), clinical notes, problem lists, allergies, immunizations, vital signs, care plans, assessments, nursing documentation, clinical observations (LOINC-coded), SNOMED CT-coded clinical findings, and CDI (Clinical Documentation Improvement) workflows. Core EHR/EMR operational data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` (
    `diagnosis_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical diagnosis record in the system. Primary key for the clinical_diagnosis data product.',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed clinician (physician, NP, PA) who documented or confirmed this diagnosis. Used for provider attribution, quality reporting, and CDI workflows.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this diagnosis was documented. Links to the patient master record in the Master Patient Index (MPI).',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Diagnosis coding for HCC capture, DRG assignment, and risk adjustment is health-plan-specific — different plans under the same payer use different RAF models. Existing payer_id is insufficient for pla',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical diagnosis record.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Diagnosis coding drives claims adjudication, medical necessity determination, and prior authorization. Revenue cycle operations require payer context for each diagnosis to apply correct coding rules, ',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Clinical Documentation Improvement (CDI) programs reconcile the admit diagnosis captured at registration with coded diagnoses. Linking diagnosis to registration_event enables CDI query workflows, DRG ',
    `admit_diagnosis_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis was the stated reason for inpatient admission as documented at the time of admission. The admitting diagnosis may differ from the principal discharge diagnosis and is required on UB-04 claim form field 69.',
    `ai_suggested_flag` BOOLEAN COMMENT 'Whether diagnosis was suggested by clinical AI/NLP',
    `behavioral_health_added_flag` BOOLEAN COMMENT 'Flag indicating behavioral health domain was added via mutator.',
    `behavioral_health_domain_code` BIGINT COMMENT 'Link to behavioral health domain (placeholder)',
    `behavioral_health_flag` BOOLEAN COMMENT 'Indicates presence of behavioral health data',
    `behavioral_health_integration_marker` DECIMAL(18,2) COMMENT 'Flag indicating integration with behavioral health domain',
    `behavioral_health_protected_flag` BOOLEAN COMMENT '42 CFR Part 2 protected data flag',
    `care_setting` STRING COMMENT 'The clinical care setting in which this diagnosis was documented (e.g., ICU, ED, OR, ambulatory clinic). Supports care-setting-specific quality reporting, resource utilization analysis, and population health stratification. [ENUM-REF-CANDIDATE: inpatient|outpatient|ED|ICU|OR|ambulatory|telehealth — promote to reference product]',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates whether a CDI specialist has issued a physician query related to this diagnosis for clarification or specificity improvement. Supports CDI workflow tracking and documentation quality metrics.',
    `cdi_query_status` STRING COMMENT 'Current status of the CDI physician query associated with this diagnosis. Tracks whether the provider has responded and whether the diagnosis was amended based on the query outcome.. Valid values are `pending|agreed|disagreed|no_response|withdrawn`',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis represents a chronic condition as defined by CMS Chronic Condition Warehouse (CCW) criteria. Used for population health management, HEDIS measure attribution, and ACO quality reporting.',
    `clinical_ai_integration_marker` DECIMAL(18,2) COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_status` STRING COMMENT 'Current clinical state of the diagnosis as documented by the provider. Active indicates an ongoing condition; resolved indicates the condition has been treated or cleared; chronic conditions may persist across encounters.. Valid values are `active|resolved|inactive|recurrence|remission|unknown`',
    `coding_date` DATE COMMENT 'The date on which the ICD-10-CM code was assigned or finalized by the HIM coder. Used for coding turnaround time reporting, revenue cycle management, and compliance audits.',
    `coding_status` STRING COMMENT 'Indicates the Health Information Management (HIM) coding workflow status for this diagnosis. Finalized diagnoses are ready for claim submission; amended diagnoses reflect post-coding corrections.. Valid values are `unreviewed|coded|queried|finalized|amended`',
    `complication_comorbidity_flag` BOOLEAN COMMENT 'Indicates whether this secondary diagnosis qualifies as a Complication (CC) or Major Complication/Comorbidity (MCC) under CMS DRG grouping logic. CC/MCC status elevates DRG weight and reimbursement.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical diagnosis record.',
    `diagnosis_date` DATE COMMENT 'The date on which the diagnosis was formally documented in the EHR by the clinician. Distinct from onset date (when the condition began) and encounter date. Used as the principal business event date for this transaction record.',
    `diagnosis_status` STRING COMMENT 'The diagnosis status value classifying the clinical diagnosis record.',
    `diagnosis_type` STRING COMMENT 'Classifies the role of this diagnosis within the encounter or problem list context. Principal diagnosis drives DRG assignment; admitting diagnosis reflects the reason for admission; secondary diagnoses capture comorbidities and complications. [ENUM-REF-CANDIDATE: principal|secondary|admitting|discharge|working|chronic_problem_list — promote to reference product]. Valid values are `principal|secondary|admitting|discharge|working|chronic_problem_list`',
    `discharge_diagnosis_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis was finalized as a discharge diagnosis at the conclusion of the inpatient encounter. Discharge diagnoses are used for final DRG assignment, claim submission, and discharge summary documentation.',
    `drg_relevant_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis contributes to the DRG assignment for the associated inpatient encounter. Used by the 3M grouper and revenue cycle teams to identify diagnoses that impact reimbursement.',
    `encounter_diagnosis_source` BOOLEAN COMMENT 'Identifies the role of the person who entered or assigned this diagnosis in the EHR. Supports CDI workflow analysis, coding quality audits, and provider attribution reporting.',
    `encounter_type` STRING COMMENT 'Classifies the type of encounter in which this diagnosis was documented. Inpatient diagnoses are subject to POA reporting and DRG grouping; outpatient diagnoses follow CMS-1500 coding guidelines. Denormalized from the encounter for direct diagnosis-level analytics.. Valid values are `inpatient|outpatient|emergency|observation|telehealth`',
    `external_cause_code` STRING COMMENT 'ICD-10-CM external cause code (V, W, X, Y codes) documenting the mechanism, intent, and place of occurrence for injury-related diagnoses. Required for trauma registries, workers compensation claims, and injury surveillance reporting.. Valid values are `^[VWX][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$|^Y[0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$`',
    `genomics_relevant_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis has associated genomic/precision medicine relevance',
    `hac_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis qualifies as a CMS-designated Hospital-Acquired Condition (HAC). HAC-flagged diagnoses that were not present on admission may trigger payment reductions under the HAC Reduction Program.',
    `icd10_version` STRING COMMENT 'The CMS fiscal year version of the ICD-10-CM code set used to assign this diagnosis code (e.g., FY2024). ICD-10-CM is updated annually; version tracking ensures accurate historical code interpretation and audit defense.. Valid values are `^FY[0-9]{4}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this diagnosis record was most recently modified in the source EHR system. Used for incremental data loads, CDI amendment tracking, and audit compliance.',
    `laterality` STRING COMMENT 'Specifies the anatomical side affected by the diagnosis where applicable (e.g., left knee fracture, right breast mass). ICD-10-CM codes often encode laterality; this field provides an explicit queryable attribute for surgical scheduling and quality reporting.. Valid values are `left|right|bilateral|unspecified`',
    `mcc_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis specifically qualifies as a Major Complication or Comorbidity (MCC) — the highest severity tier in CMS DRG grouping. Distinct from the general CC flag; MCC status drives the highest DRG weight tier.',
    `mrn` STRING COMMENT 'The facility-assigned Medical Record Number (MRN) for the patient associated with this diagnosis. Denormalized from the patient record to support direct clinical documentation queries without a join.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical diagnosis record.',
    `note_text` STRING COMMENT 'Free-text clinical note or comment associated with this diagnosis entry, as documented by the provider or CDI specialist. May include clinical rationale, specificity details, or query responses. Classified as confidential due to clinical content.',
    `onset_date` DATE COMMENT 'The date on which the condition or diagnosis first began, as documented by the clinician. Used for chronic disease management, population health analytics, and longitudinal patient record construction.',
    `pharmacogenomics_impact_flag` BOOLEAN COMMENT 'Indicates whether pharmacogenomic considerations apply to treatment of this diagnosis',
    `present_on_admission` STRING COMMENT 'CMS-required Present on Admission (POA) indicator for inpatient diagnoses. Y=present at admission, N=not present at admission, U=unknown, W=clinically undetermined, 1=unreported/not used. Affects hospital-acquired condition (HAC) payment adjustments and quality reporting.. Valid values are `Y|N|U|W|1`',
    `principal_diagnosis_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is designated as the principal diagnosis for the encounter (True). The principal diagnosis is the condition established after study to be chiefly responsible for the admission and drives DRG assignment.',
    `problem_list_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is part of the patients longitudinal problem list (True) or is encounter-specific only (False). Problem list diagnoses persist across encounters and drive chronic disease management workflows.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is relevant to one or more quality measures (e.g., HEDIS, MIPS, VBP, TJC core measures). Used to identify patients for quality measure denominator and numerator attribution.',
    `rank` STRING COMMENT 'Numeric sequence indicating the ordering of diagnoses within an encounter (1 = principal, 2 = first secondary, etc.). Used for UB-04 claim form sequencing, DRG optimization, and CDI prioritization.',
    `recorded_timestamp` TIMESTAMP COMMENT 'The precise date and time when this diagnosis record was first created in the source EHR system (Epic ClinDoc or Cerner PowerChart). Supports audit trails, CDI workflow timing, and data lineage.',
    `resolution_date` DATE COMMENT 'The date on which the condition was resolved, cured, or no longer clinically active. Null for ongoing or chronic conditions. Used to calculate episode duration and support transitions of care.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is classified as a Social Determinants of Health (SDOH) condition (Z55–Z65 ICD-10-CM Z-codes). Used for population health management, care coordination, and CMS SDOH reporting initiatives.',
    `severity` STRING COMMENT 'Clinical severity level of the diagnosis as documented by the provider. Drives care intensity decisions, DRG complexity, and quality measure stratification. Aligns with SNOMED CT severity qualifiers.. Valid values are `mild|moderate|severe|critical`',
    `source_record_reference` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Sensitive diagnoses (HIV, genetic conditions, behavioral health) require documented informed consent. Regulatory workflows (42 CFR Part 2, state mental health laws) mandate linking diagnoses to consen',
    `source_system_diagnosis_code` BOOLEAN COMMENT 'The native identifier for this diagnosis record in the originating source system (e.g., Epic diagnosis ID, Cerner diagnosis ID). Enables bidirectional traceability between the lakehouse and the operational EHR.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical diagnosis record.',
    `verification_status` STRING COMMENT 'Indicates the degree of clinical certainty for this diagnosis. Confirmed diagnoses are used for billing and DRG assignment; provisional and differential diagnoses support CDI workflows and clinical decision-making. Maps to Epic ClinDoc diagnosis certainty and Cerner PowerChart diagnosis qualifier.. Valid values are `confirmed|provisional|differential|refuted|entered_in_error`',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Auto‑added by VIBE mutator to register a change',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the clinical diagnosis record.',
    CONSTRAINT pk_diagnosis PRIMARY KEY(`diagnosis_id`)
) COMMENT 'SSOT for all patient diagnoses documented in the EHR. Captures ICD-10-CM coded diagnoses, diagnosis type (principal, secondary, admitting, discharge), onset date, resolution date, clinical status (active, resolved, chronic), severity, certainty (confirmed, suspected, rule-out), and the encounter or problem list context. Sourced from Epic ClinDoc and Cerner PowerChart. Supports CDI workflows, DRG assignment, and quality reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` (
    `procedure_event_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical procedure event record in the Silver Layer lakehouse. Primary key for this entity.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Revenue integrity: each procedure event maps to a Charge Description Master entry for pricing validation and charge capture accuracy. The existing cdm_code plain attribute is a denormalized CDM refe',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Procedures are performed under specific coverage policies defining medical necessity criteria, frequency limitations, and prior auth requirements. Clinical documentation and CDI teams reference covera',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Surgical procedures require specific medications (anesthesia agents, prophylactic antibiotics, contrast media). Perioperative medication protocols and surgical safety checklists depend on procedure-to',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Procedures are billed under a group NPI for CMS claims submission. MIPS group reporting requires procedure-level RVU attribution to the practice group. Group-level surgical quality reporting (NSQIP gr',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Procedure events must be validated against the patients specific health plan for coverage determination, prior auth requirements, copay/deductible applicability, and network tier. Existing payer_id i',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient on whom the procedure was performed. Core PARTY_REFERENCE for this transaction, linking to the Master Patient Index (MPI).',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CMS hospital quality reporting (IQR/OQR programs) and Joint Commission accreditation require procedure-level facility attribution. Knowing which org_provider performed a procedure enables facility-lev',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Procedure authorization, billing, and reimbursement are payer-specific. Fee schedule lookup, prior auth requirements, and claims submission all require knowing which payer covers the procedure. Core r',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Procedures are performed for specific diagnoses. procedure_event currently stores primary_diagnosis_code (STRING) as a denormalized text field. Adding primary_diagnosis_id FK to clinical.diagnosis nor',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed clinician (surgeon, interventionalist, or proceduralist) who performed the procedure. Used for credentialing validation, RVU attribution, and quality measurement.',
    `privileging_id` BIGINT COMMENT 'Foreign key linking to provider.privileging. Business justification: Joint Commission MS.06.01.03 and CMS Conditions of Participation require that procedures be performed only by clinicians with active, facility-specific privileges. Linking procedure_event to the speci',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Procedures with abnormal findings trigger specialist referrals (e.g., colonoscopy finding triggers GI oncology referral). Core clinical workflow for care coordination and specialist consultation.',
    `tertiary_procedure_anesthesia_provider_clinician_id` BIGINT COMMENT 'Reference to the anesthesiologist or CRNA responsible for anesthesia administration during the procedure. Required for anesthesia professional fee billing and credentialing compliance.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient, outpatient, ED, surgical) during which this procedure was performed. Links procedure to the broader care episode for revenue cycle and quality reporting.',
    `anesthesia_type` STRING COMMENT 'Type of anesthesia administered during the procedure. Drives anesthesia billing (ASA base units + time units), OR scheduling requirements, and pre-operative assessment workflows.. Valid values are `general|regional|local|monitored_anesthesia_care|none`',
    `approach` STRING COMMENT 'Technique or access method used to perform the procedure (e.g., open, laparoscopic, robotic-assisted, endoscopic). Captured in ICD-10-PCS character 5 and used for surgical quality benchmarking and OR resource planning.. Valid values are `open|laparoscopic|robotic|endoscopic|percutaneous|transcatheter`',
    `asa_classification` STRING COMMENT 'ASA Physical Status Classification (I–VI) assigned by the anesthesiologist to assess patient pre-operative risk. Required for anesthesia billing, surgical risk stratification, and quality benchmarking (ACS NSQIP).. Valid values are `I|II|III|IV|V|VI`',
    `behavioral_health_flag` BOOLEAN COMMENT 'The behavioral health flag of the clinical procedure event record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the clinical procedure event record.',
    `body_site` STRING COMMENT 'Anatomical body site or region where the procedure was performed, coded using SNOMED CT body structure hierarchy. Supports surgical safety, clinical documentation completeness, and CDI workflows.',
    `cancellation_reason` STRING COMMENT 'Coded reason for procedure cancellation when procedure_status is cancelled or not-done. Used for OR cancellation rate reporting, patient safety analysis, and operational improvement initiatives. [ENUM-REF-CANDIDATE: patient_refusal|medical_contraindication|equipment_failure|scheduling_error|insurance_denial|no_show|provider_unavailable — promote to reference product]',
    `care_setting` STRING COMMENT 'The care setting of the clinical procedure event record.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Gross charge amount in USD posted to the patient account for this procedure, sourced from the CDM (Charge Description Master). Represents the facilitys list price before contractual adjustments. Used for revenue cycle charge capture reconciliation.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical procedure event record.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether documented informed consent was obtained from the patient or authorized representative prior to the procedure. Required for regulatory compliance, medical-legal documentation, and The Joint Commission RI.01.03.01.',
    `cpt_modifier_1` STRING COMMENT 'Primary AMA CPT modifier appended to the procedure code to indicate special circumstances (e.g., 22=Increased Procedural Services, 50=Bilateral, 51=Multiple Procedures, 59=Distinct Procedural Service). Required for accurate claim adjudication.. Valid values are `^[A-Z0-9]{2}$`',
    `cpt_modifier_2` STRING COMMENT 'Secondary AMA CPT modifier when multiple modifiers are required for the procedure code. Supports complex claim scenarios such as assistant surgeon (80), teaching physician (GC), or anesthesia qualifiers.. Valid values are `^[A-Z0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procedure event record was first created in the source EHR system. Serves as the RECORD_AUDIT_CREATED field for data governance, audit trail, and HIPAA audit log requirements.',
    `digital_health_relevant_flag` BOOLEAN COMMENT 'Whether this record is relevant to digital health/RPM/telehealth workflows',
    `duration_minutes` STRING COMMENT 'Total elapsed time in minutes from procedure start to procedure end. Derived from start and end timestamps at source and stored for OR utilization analytics, anesthesia billing, and surgical quality benchmarking.',
    `estimated_blood_loss_ml` STRING COMMENT 'Estimated blood loss in milliliters recorded by the surgical team during the procedure. Used for post-operative care planning, transfusion trigger assessment, and surgical quality benchmarking (ACS NSQIP).',
    `genomic_test_flag` BOOLEAN COMMENT 'Indicates whether this procedure is a genomic/genetic test',
    `icd10_pcs_code` STRING COMMENT 'ICD-10-PCS code for inpatient procedures, used on UB-04 institutional claims for DRG grouping and inpatient quality reporting. Required for CMS inpatient prospective payment system (IPPS) reimbursement.. Valid values are `^[A-Z0-9]{7}$`',
    `laterality` STRING COMMENT 'Body side on which the procedure was performed. Required for surgical safety verification (Universal Protocol), correct-site surgery compliance, and ICD-10-PCS/CPT modifier application.. Valid values are `left|right|bilateral|unilateral|not_applicable`',
    `mrn` STRING COMMENT 'The mrn of the clinical procedure event record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical procedure event record.',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical procedure event record.',
    `priority` STRING COMMENT 'Clinical urgency classification of the procedure at time of scheduling or ordering. Drives OR scheduling queue prioritization, resource allocation, and EMTALA compliance tracking for emergent cases.. Valid values are `elective|urgent|emergent|stat`',
    `procedure_category` STRING COMMENT 'High-level clinical category classifying the nature of the procedure. Used for service-line analytics, OR scheduling resource allocation, and population health stratification.. Valid values are `surgical|diagnostic|therapeutic|preventive|rehabilitative|palliative`',
    `procedure_date` DATE COMMENT 'Calendar date on which the procedure was performed. Used as the primary date dimension for reporting, HEDIS measure denominator logic, and claim date-of-service on CMS-1500 and UB-04 forms.',
    `procedure_end_datetime` TIMESTAMP COMMENT 'Date and time when the procedure was completed (wound closure for surgical cases, or final intervention for non-surgical). Used with start time to calculate procedure duration for OR scheduling, staffing, and quality metrics.',
    `procedure_event_status` STRING COMMENT 'The procedure event status value classifying the clinical procedure event record.',
    `procedure_number` STRING COMMENT 'Externally visible, human-readable business identifier for this procedure event, assigned by the source EHR system (e.g., Epic OpTime case number or Cerner SurgiNet procedure ID). Used for cross-system reconciliation and charge capture reference.',
    `procedure_start_datetime` TIMESTAMP COMMENT 'Date and time when the procedure was initiated (knife-to-skin for surgical cases, or first intervention for non-surgical). Principal BUSINESS_EVENT_TIMESTAMP for this transaction. Used for OR utilization, LOS calculation, and quality measure timing.',
    `procedure_status` STRING COMMENT 'Current lifecycle state of the procedure event per HL7 FHIR Procedure.status value set. Drives revenue cycle charge capture eligibility and quality measure inclusion/exclusion logic. [ENUM-REF-CANDIDATE: performed|in-progress|cancelled|not-done|on-hold|entered-in-error — promote to reference product]. Valid values are `performed|in-progress|cancelled|not-done|on-hold|entered-in-error`',
    `procedure_type` STRING COMMENT 'Operational classification of the procedure within the facilitys CDM (Charge Description Master), such as OR Case, Bedside Procedure, Interventional Radiology, Endoscopy, Cardiac Cath. Drives charge routing and scheduling resource assignment. [ENUM-REF-CANDIDATE: or_case|bedside|interventional_radiology|endoscopy|cardiac_cath|ambulatory_surgery|labor_delivery — promote to reference product]',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical procedure event record.',
    `rvu_work` DECIMAL(18,2) COMMENT 'CMS physician work Relative Value Unit (RVU) assigned to the CPT code for this procedure. Used for provider productivity measurement, compensation modeling, and MIPS performance reporting.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Originally scheduled date and time for the procedure. Compared against actual start time to measure on-time starts, OR schedule adherence, and first-case delay metrics.',
    `service_line` STRING COMMENT 'Hospital or health system service line under which the procedure is classified (e.g., Cardiovascular, Orthopedics, Neurosurgery, Oncology). Used for service-line P&L reporting, CMI analysis, and strategic planning. [ENUM-REF-CANDIDATE: cardiovascular|orthopedics|neurosurgery|oncology|general_surgery|obstetrics|urology|gastroenterology — promote to reference product]',
    `severity` STRING COMMENT 'The severity of the clinical procedure event record.',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT concept code representing the clinical procedure. Supports interoperability via HL7 FHIR and HIE exchange, and enables clinical decision support and population health analytics beyond billing code sets.. Valid values are `^[0-9]{6,18}$`',
    `source_record_reference` BIGINT COMMENT 'The source record reference of the clinical procedure event record.',
    `source_system_record_code` STRING COMMENT 'Native primary key or unique identifier of this procedure record in the originating source system (e.g., Epic OpTime case ID, Cerner SurgiNet procedure ID). Enables bidirectional traceability between the lakehouse Silver Layer and the operational EHR.',
    `specimen_collected` BOOLEAN COMMENT 'Indicates whether a tissue specimen or pathology sample was collected during the procedure. Triggers downstream laboratory/pathology order workflow and chain-of-custody documentation.',
    `timeout_performed` BOOLEAN COMMENT 'Indicates whether the pre-procedure surgical time-out (Universal Protocol) was completed and documented. Mandatory for Joint Commission accreditation and CMS Conditions of Participation to prevent wrong-site, wrong-procedure, wrong-patient events.',
    `udi` STRING COMMENT 'FDA-assigned Unique Device Identifier (UDI) for the primary implant or medical device used during the procedure. Required for FDA device tracking, recall management, and 21st Century Cures Act compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this procedure event record in the source EHR system. Serves as the RECORD_AUDIT_UPDATED field for change data capture (CDC), data quality monitoring, and HIPAA audit trail compliance.',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical procedure event record.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the clinical procedure event record.',
    `wound_classification` STRING COMMENT 'CDC/ACS wound classification (Clean, Clean-Contaminated, Contaminated, Dirty/Infected) assigned at time of procedure. Used for SSI (Surgical Site Infection) surveillance, HAI reporting, and infection control quality metrics.. Valid values are `clean|clean_contaminated|contaminated|dirty_infected`',
    CONSTRAINT pk_procedure_event PRIMARY KEY(`procedure_event_id`)
) COMMENT 'Records of clinical procedures performed on patients, coded using CPT, HCPCS, and ICD-10-PCS. Captures procedure date/time, performing provider, facility location, laterality, approach, anesthesia type, duration, status (performed, cancelled, in-progress), and associated encounter. Sourced from Epic OpTime, ClinDoc, and Cerner SurgiNet. Supports revenue cycle charge capture and quality measurement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`note` (
    `note_id` BIGINT COMMENT 'Unique surrogate identifier for the clinical note record in the lakehouse Silver layer. Primary key for this data product.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Clinical notes (progress notes, care coordination notes) are often authored in the context of a specific care plan. Linking note to care_plan via care_plan_id enables care plan-centric documentation r',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who is the subject of this clinical note. Core linkage to the Master Patient Index (MPI).',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical note record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the note clinician within the clinical note record.',
    `parent_note_id` BIGINT COMMENT 'Reference to the original clinical note to which this addendum or amendment is attached. Null for original notes. Enables reconstruction of the complete note history and amendment chain.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Clinical documentation of medication rationale, side effects, patient education, adherence counseling requires linking notes to prescriptions for meaningful use attestation, audit trails, clinical dec',
    `primary_note_attending_provider_clinician_id` BIGINT COMMENT 'Reference to the attending physician of record for the encounter at the time the note was authored. May differ from the note author (e.g., resident authors, attending co-signs). Used for CMS billing attribution and quality measure assignment.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Clinical notes reference a principal diagnosis (note has principal_diagnosis_code as STRING). Normalizing this to principal_diagnosis_id FK to clinical.diagnosis enables structured linkage between doc',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Problem-oriented medical records (POMR) link clinical notes to specific problem list entries. A SOAP note or progress note is typically authored in the context of a specific problem. Adding problem_id',
    `report_id` BIGINT COMMENT 'Foreign key linking to radiology.report. Business justification: Discharge summaries, progress notes, and consult notes routinely cite specific radiology reports by reference. CDI and clinical documentation integrity workflows require tracing which report informed ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: note carries a denormalized specialty plain attribute. Normalizing via FK to provider.specialty supports specialty-specific documentation compliance audits (Joint Commission), HIM coding workflows whe',
    `tertiary_note_cosigner_provider_clinician_id` BIGINT COMMENT 'Reference to the supervising or co-signing provider who attests to the note content. Required for resident/trainee notes per CMS teaching physician rules. Nullable when no co-signature is required.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this note was authored. Links the note to the patient visit context (inpatient, outpatient, ED, etc.).',
    `admission_date` DATE COMMENT 'The date of inpatient admission associated with this note. Denormalized for inpatient note timeliness compliance calculations (e.g., H&P must be completed within 24 hours of admission per TJC RC.02.01.01). Null for outpatient notes.',
    `amended_timestamp` TIMESTAMP COMMENT 'The date and time when the note was last amended (corrected). Amendments replace erroneous content while preserving the original for audit purposes. Nullable for notes that have never been amended.',
    `author_role` STRING COMMENT 'The clinical role of the provider who authored the note. Determines co-signature requirements, billing eligibility (incident-to rules), and CDI workflow routing. [ENUM-REF-CANDIDATE: attending|resident|fellow|nurse_practitioner|physician_assistant|registered_nurse|medical_student|clinical_pharmacist|case_manager|social_worker — promote to reference product]',
    `authored_timestamp` TIMESTAMP COMMENT 'The date and time when the provider began authoring or first saved the clinical note in the EHR. Represents the business event timestamp for note creation. Used for timeliness compliance reporting (e.g., H&P within 24 hours of admission per TJC).',
    `behavioral_health_flag` BOOLEAN COMMENT 'The behavioral health flag of the clinical note record.',
    `behavioral_health_note_flag` BOOLEAN COMMENT 'Flag indicating linkage to behavioral health data',
    `behavioral_health_protected_flag` BOOLEAN COMMENT '42 CFR Part 2 protected data flag',
    `care_setting` STRING COMMENT 'The clinical care setting in which the note was authored. Determines applicable documentation standards, billing rules (UB-04 vs CMS-1500), and regulatory requirements.. Valid values are `inpatient|outpatient|emergency|observation|ambulatory_surgery|telehealth`',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates whether a CDI specialist has issued a physician query against this note requesting clarification or additional specificity to support accurate ICD-10 coding and DRG assignment. Core to CDI workflow management.',
    `cdi_query_status` STRING COMMENT 'Current status of the CDI physician query associated with this note. Tracks whether the provider has responded to the query, enabling CDI team follow-up and DRG impact analysis.. Valid values are `pending|answered|withdrawn|no_query`',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical note record.',
    `confidentiality_level` STRING COMMENT 'The confidentiality classification of the note controlling access within the EHR. Restricted notes (e.g., behavioral health, substance abuse, HIV) require additional access controls per 42 CFR Part 2 and state mental health laws.. Valid values are `normal|restricted|very_restricted`',
    `cosigned_timestamp` TIMESTAMP COMMENT 'The date and time when the supervising provider co-signed the note. Required for resident and mid-level provider notes under CMS teaching physician and incident-to billing rules. Nullable when co-signature is not required.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this clinical note record was first created in the lakehouse Silver layer. Represents the ETL ingestion audit timestamp, distinct from the clinical authored timestamp.',
    `dictation_method` STRING COMMENT 'The method by which the note content was entered into the EHR. Supports provider efficiency analytics, scribe program management, and AI-assisted documentation quality assessment.. Valid values are `typed|voice_dictation|speech_recognition|scribe|imported`',
    `discharge_date` DATE COMMENT 'The date of patient discharge associated with this note. Used for discharge summary timeliness compliance (must be completed within 30 days of discharge per TJC). Null for non-discharge notes.',
    `drg_impact_flag` BOOLEAN COMMENT 'Indicates whether the documentation in this note has been identified as having a potential impact on the assigned DRG and associated reimbursement. Used by CDI and HIM teams to prioritize review queues.',
    `encounter_type` STRING COMMENT 'The type of clinical encounter associated with this note. Denormalized from the encounter for note-level analytics and CDI workflow routing without requiring a join to the encounter table.. Valid values are `inpatient|outpatient|emergency|observation|telehealth|surgical`',
    `format` STRING COMMENT 'Indicates whether the note content is unstructured free text, fully structured (discrete data elements), semi-structured (narrative with embedded structured fields), or authored from a predefined template. Drives NLP/AI processing pipelines and CDI tool integration.. Valid values are `free_text|structured|semi_structured|template_based`',
    `is_addendum` BOOLEAN COMMENT 'Indicates whether this note record is an addendum appended to a previously signed note rather than an original note. Addenda supplement but do not replace the original note content.',
    `is_copy_forwarded` BOOLEAN COMMENT 'Indicates whether the note content was copied or cloned from a prior note rather than independently authored. Copy-forward documentation is an OIG audit target and a CDI quality concern affecting medical necessity and billing integrity.',
    `is_late_entry` BOOLEAN COMMENT 'Indicates whether the note was authored after the standard documentation timeliness window (e.g., H&P authored more than 24 hours after admission). Late entries must be identified per TJC and CMS medical record standards.',
    `mrn` STRING COMMENT 'The Medical Record Number assigned to the patient in the source EHR system. Denormalized on the note for direct PHI access control enforcement and cross-system patient matching. Subject to HIPAA PHI protections.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical note record.',
    `nlp_processed_flag` BOOLEAN COMMENT 'Whether note has been processed by clinical NLP pipeline',
    `note_status` STRING COMMENT 'Current workflow state of the clinical note in the EHR documentation lifecycle. Draft notes are incomplete; signed notes are legally attested; amended notes reflect corrections; addended notes have supplemental content appended; retracted notes have been withdrawn from the medical record.. Valid values are `draft|signed|amended|addended|retracted`',
    `note_type` STRING COMMENT 'Classification of the clinical note by its documentation purpose and clinical context. Drives CDI workflows, HIM coding queues, and regulatory reporting. [ENUM-REF-CANDIDATE: History and Physical|Progress Note|Discharge Summary|Operative Note|Consult Note|Nursing Note|Procedure Note|Radiology Report|Pathology Report|Transfer Note|Referral Note|Telephone Encounter Note — promote to reference product]. Valid values are `History and Physical|Progress Note|Discharge Summary|Operative Note|Consult Note|Nursing Note`',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical note record.',
    `precision_medicine_flag` BOOLEAN COMMENT 'Indicates whether this note relates to precision medicine or genomic findings',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical note record.',
    `sensitive_note_type` STRING COMMENT 'Identifies whether the note contains sensitive clinical content subject to heightened privacy protections beyond standard HIPAA requirements. Drives break-the-glass access controls and consent management workflows.. Valid values are `behavioral_health|substance_abuse|hiv_aids|sexual_health|domestic_violence|none`',
    `service_date` DATE COMMENT 'The calendar date on which the clinical service or encounter event being documented occurred. Distinct from the note authoring date; used for billing date-of-service alignment and clinical timeline reconstruction.',
    `service_line` STRING COMMENT 'The hospital or health system service line under which the note was authored (e.g., Cardiovascular, Oncology, Womens Health, Behavioral Health). Supports service-line-level analytics and operational reporting.',
    `severity` STRING COMMENT 'The severity of the clinical note record.',
    `signed_timestamp` TIMESTAMP COMMENT 'The date and time when the author electronically signed and attested to the clinical note, making it a legally authenticated entry in the medical record. Nullable for draft notes.',
    `source_record_reference` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Clinical notes document consent discussions, patient education, and consent status changes. EHR workflows link consent conversations to notes for regulatory audits (informed consent documentation requ',
    `source_system_note_code` STRING COMMENT 'The native identifier of this note in the originating EHR system (Epic ClinDoc note ID or Cerner PowerChart document ID). Used for cross-system reconciliation and ETL lineage tracing.',
    `text` STRING COMMENT 'The full free-text or structured narrative content of the clinical note. Contains Protected Health Information (PHI) including clinical findings, diagnoses, treatment plans, and patient history. Subject to HIPAA minimum necessary standard and access controls. Core to CDI and HIM coding workflows.',
    `title` STRING COMMENT 'The human-readable title or subject line of the clinical note as displayed in the EHR (e.g., Cardiology Consult Note, Post-Op Day 1 Progress Note). Supports note navigation and CDI workflow queuing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this clinical note record was last modified in the lakehouse Silver layer. Supports incremental ETL processing, change data capture, and audit trail compliance.',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical note record.',
    `version` STRING COMMENT 'Monotonically incrementing version number for the note record, incremented with each amendment or addendum. Enables reconstruction of the complete note history and supports audit trail requirements.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the clinical note record.',
    `word_count` STRING COMMENT 'The total number of words in the clinical note text. Used for documentation quality metrics, CDI completeness scoring, and identifying copy-paste or cloned note patterns flagged by OIG compliance programs.',
    CONSTRAINT pk_note PRIMARY KEY(`note_id`)
) COMMENT 'Structured and unstructured clinical documentation authored by providers in the EHR. Includes note type (H&P, progress note, discharge summary, operative note, consult note, nursing note), author, co-signer, note status (draft, signed, amended, addended), service date, encounter context, LOINC document type code, and full note text or structured content reference. Sourced from Epic ClinDoc and Cerner PowerChart. Core to CDI and HIM workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`problem` (
    `problem_id` BIGINT COMMENT 'Unique surrogate identifier for the patient problem list entry in the lakehouse silver layer. Primary key for this entity.',
    `care_plan_id` BIGINT COMMENT 'Reference to the care plan that addresses or manages this problem. Links the problem list entry to the patients longitudinal care plan for population health management and care coordination.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: A problem list entry typically corresponds to a formal ICD-10 diagnosis. Linking problem to diagnosis via diagnosis_id establishes the normative relationship between the patient problem list and the c',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose longitudinal problem list this entry belongs to. Links to the master patient record.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who originally added this problem to the patients problem list. Distinct from ordering_provider_id which reflects the current responsible provider. Supports audit and CDI workflows.',
    `problem_clinician_id` BIGINT COMMENT 'Unique identifier for the problem clinician within the clinical problem record.',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Chronic problems trigger specialist referrals (e.g., uncontrolled diabetes → endocrinology, refractory pain → pain management). Care coordination and specialty care access requirement.',
    `tertiary_problem_last_updated_by_provider_clinician_id` BIGINT COMMENT 'Reference to the clinician who most recently modified this problem record. Supports Clinical Documentation Improvement (CDI) audit trails and accountability tracking.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this problem was first identified or most recently updated. Nullable — problems may exist independent of a specific encounter on the longitudinal problem list.',
    `behavioral_health_flag` BOOLEAN COMMENT 'Whether problem is behavioral health related (42 CFR Part 2 protected)',
    `behavioral_health_protected_flag` BOOLEAN COMMENT '42 CFR Part 2 protected data flag',
    `body_site_code` STRING COMMENT 'SNOMED CT code identifying the anatomical body site associated with this problem (e.g., 368209003 = Right arm). Supports surgical planning, radiology ordering, and clinical specificity in documentation.',
    `body_site_description` STRING COMMENT 'Human-readable description of the anatomical body site corresponding to body_site_code. Stored for reporting and display purposes.',
    `care_setting` STRING COMMENT 'The clinical care setting in which this problem was documented or is being managed. Supports population health stratification and care coordination analytics across inpatient, outpatient, Emergency Department (ED), and telehealth settings.. Valid values are `inpatient|outpatient|emergency|ambulatory|telehealth`',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates whether a Clinical Documentation Improvement (CDI) query has been raised against this problem entry, requesting clarification or specificity from the treating physician to support accurate coding and reimbursement.',
    `cdi_query_status` STRING COMMENT 'Current status of the Clinical Documentation Improvement (CDI) query associated with this problem, if applicable. Tracks whether the physician has responded to the CDI query for coding specificity.. Valid values are `pending|answered|withdrawn|no-query`',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates whether this problem is classified as a chronic condition for the purposes of population health management, care management program enrollment, and CMS Hierarchical Condition Category (HCC) risk adjustment. True = chronic condition.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical problem record.',
    `comment` STRING COMMENT 'Free-text clinical comment or note associated with this problem list entry, as entered by the clinician in the Electronic Health Record (EHR). May include clinical context, treatment notes, or documentation improvement remarks.',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether this problem has been marked as confidential in the Electronic Health Record (EHR), restricting access to authorized users only. Commonly applied to sensitive diagnoses such as HIV/AIDS, substance use disorders, and psychiatric conditions per 42 CFR Part 2 and state privacy laws.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this problem record was first created in the source Electronic Health Record (EHR) system. Establishes the audit trail origin for the problem list entry.',
    `fhir_condition_reference` STRING COMMENT 'The HL7 Fast Healthcare Interoperability Resources (FHIR) Condition resource identifier for this problem, used in Health Information Exchange (HIE) and interoperability workflows. Supports CMS Interoperability and Patient Access Rule compliance.',
    `genetic_condition_flag` BOOLEAN COMMENT 'Indicates whether this problem is a known genetic/hereditary condition',
    `hcc_category_code` STRING COMMENT 'CMS Hierarchical Condition Category (HCC) code mapped to this problem. Used for Medicare Advantage risk adjustment, capitation payment calculations, and population health risk stratification.',
    `is_encounter_diagnosis` BOOLEAN COMMENT 'Indicates whether this problem list entry was also used as an encounter-level diagnosis for billing and claims purposes. Distinguishes longitudinal problem list entries from encounter-specific diagnoses used in revenue cycle management.',
    `last_reviewed_date` DATE COMMENT 'The most recent date on which a clinician reviewed and affirmed or updated this problem on the patients problem list. Supports Clinical Documentation Improvement (CDI) workflows and problem list hygiene audits.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this problem record was most recently modified in the source Electronic Health Record (EHR) system. Used for change detection, audit trails, and incremental ETL processing.',
    `laterality` STRING COMMENT 'Anatomical laterality qualifier for the problem where applicable (e.g., left knee osteoarthritis, right breast mass). Supports precise ICD-10-CM coding specificity and surgical planning.. Valid values are `left|right|bilateral|unspecified`',
    `list_display_order` STRING COMMENT 'Numeric sequence indicating the display order of this problem on the patients problem list as configured in the Electronic Health Record (EHR). Lower numbers appear first. Supports clinical workflow and provider-defined prioritization.',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient by the facility. Denormalized here for operational reporting and audit purposes without requiring a join to the patient master.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical problem record.',
    `noted_date` DATE COMMENT 'The date on which the problem was first documented or noted in the Electronic Health Record (EHR) problem list by a clinician. May differ from onset_date if the condition predates the current care relationship.',
    `onset_age_years` STRING COMMENT 'Patients age in years at the time of problem onset, as documented or calculated. Useful for population health stratification and epidemiological analytics when exact onset date is unavailable or approximate.',
    `onset_date` DATE COMMENT 'The date on which the patients problem or condition first began, as documented by the clinician. May be approximate (e.g., year only) for historical conditions. Used in longitudinal care management, population health analytics, and chronic disease registries.',
    `principal_problem_flag` BOOLEAN COMMENT 'Indicates whether this problem is designated as the principal or primary problem driving the current episode of care or encounter. Used in Diagnosis-Related Group (DRG) assignment and revenue cycle workflows.',
    `priority` STRING COMMENT 'Clinical priority assigned to this problem indicating its relative importance in the patients care plan. high priority problems typically drive care plan goals and quality measure attribution.. Valid values are `high|medium|low|routine`',
    `problem_status` STRING COMMENT 'Current clinical lifecycle status of the problem on the patients longitudinal problem list. active indicates an ongoing condition; resolved indicates the condition has been addressed; inactive indicates the condition is not currently being managed; deleted or entered-in-error indicates administrative correction.. Valid values are `active|inactive|resolved|deleted|entered-in-error`',
    `problem_type` STRING COMMENT 'Clinical classification of the problem by its temporal and clinical nature. chronic indicates a long-standing condition; acute indicates a short-term condition; historical indicates a past condition no longer active; social indicates a social determinant of health (SDOH); surgical indicates a surgical history item; psychiatric indicates a behavioral health condition. [ENUM-REF-CANDIDATE: chronic|acute|historical|social|surgical|psychiatric|functional|genetic — promote to reference product]. Valid values are `chronic|acute|historical|social|surgical|psychiatric`',
    `resolution_date` DATE COMMENT 'The date on which the problem was clinically resolved or marked as resolved/inactive on the patients problem list. Null for active or chronic conditions. Used to calculate problem duration and track care outcomes.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether this problem represents a Social Determinant of Health (SDOH) condition (e.g., food insecurity, housing instability, transportation barriers). Supports population health management and CMS SDOH reporting requirements.',
    `severity` STRING COMMENT 'Clinical severity classification of the problem as documented by the treating clinician. Supports risk stratification, care management triage, and quality reporting.. Valid values are `mild|moderate|severe|unspecified`',
    `source_record_reference` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Chronic/sensitive problems (substance use disorder, mental health, HIV) trigger consent verification workflows. Problem list maintenance requires consent for disclosure to care team members. 42 CFR Pa',
    `source_system_problem_code` STRING COMMENT 'Native identifier for this problem record in the originating Electronic Health Record (EHR) system (e.g., Epic problem list ID or Cerner problem instance ID). Used for lineage tracing and reconciliation during ETL.',
    `stage_code` STRING COMMENT 'Clinical staging code for the problem where applicable (e.g., cancer TNM staging, chronic kidney disease stage, heart failure NYHA class). Supports oncology registries, chronic disease management, and quality reporting.',
    `stage_description` STRING COMMENT 'Human-readable description of the clinical stage corresponding to stage_code (e.g., Stage III Non-Small Cell Lung Cancer, CKD Stage 4). Stored for reporting clarity.',
    `title` STRING COMMENT 'Human-readable clinical name or title of the problem as displayed in the Electronic Health Record (EHR) problem list (e.g., Type 2 Diabetes Mellitus, Essential Hypertension). May be the SNOMED CT preferred term or a clinician-entered free-text label.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical problem record.',
    `verification_status` STRING COMMENT 'Clinical verification status indicating the degree of certainty that the problem exists for this patient. Aligns with HL7 FHIR Condition.verificationStatus. confirmed indicates a definitive diagnosis; provisional or differential indicates a working diagnosis under evaluation.. Valid values are `confirmed|unconfirmed|provisional|differential|refuted`',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the clinical problem record.',
    CONSTRAINT pk_problem PRIMARY KEY(`problem_id`)
) COMMENT 'Patient problem list entries representing active, chronic, or historical health conditions managed longitudinally across encounters. Captures SNOMED CT and ICD-10 coded problems, onset date, resolution date, problem status (active, inactive, resolved), priority, and the provider who added or last updated the problem. Distinct from encounter-level diagnoses — this is the longitudinal clinical problem list. Sourced from Epic and Cerner problem list modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`allergy` (
    `allergy_id` BIGINT COMMENT 'Unique surrogate identifier for each patient allergy or adverse reaction record in the clinical data product. Primary key for the allergy entity in the Silver Layer lakehouse.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Allergy checking against ordered/dispensed medications is critical patient safety function. Every CPOE and pharmacy system implements drug-allergy interaction screening. Required for meaningful use an',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the allergy clinician within the clinical allergy record.',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Drug/food allergies confirmed via lab testing (specific IgE panels, tryptase levels). Role prefix confirmatory_ indicates diagnostic purpose. Important for allergy verification and de-labeling initi',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this allergy or adverse reaction is documented. Links to the patient master record in the Patient domain.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical allergy record.',
    `primary_allergy_clinician_id` BIGINT COMMENT 'Reference to the clinician (physician, nurse, pharmacist) who documented or entered this allergy record into the Electronic Health Record (EHR). Supports audit and Clinical Documentation Improvement (CDI) workflows.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this allergy was first documented or most recently updated. May be null if the allergy was entered outside of a specific encounter context.',
    `alert_override_reason` STRING COMMENT 'Clinical justification documented when a provider overrides a drug allergy alert during Computerized Physician Order Entry (CPOE). Required for regulatory compliance and medication safety audits. Null if no override has occurred.',
    `allergen_name` STRING COMMENT 'The free-text or standardized name of the substance causing the allergic or adverse reaction (e.g., Penicillin, Peanuts, Latex, Iodinated Contrast Media). Primary human-readable identifier for the allergen.',
    `allergen_type` STRING COMMENT 'Classification of the allergen category. Drives clinical decision support rules and patient safety alerts. [ENUM-REF-CANDIDATE: drug|food|environmental|contrast_media|latex|insect_venom|other — promote to reference product]',
    `allergy_status` STRING COMMENT 'The allergy status value classifying the clinical allergy record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the clinical allergy record.',
    `care_setting` STRING COMMENT 'The clinical care setting in which this allergy was documented (e.g., inpatient, outpatient, Emergency Department (ED), ambulatory). Supports population health segmentation and quality reporting.. Valid values are `inpatient|outpatient|emergency|ambulatory|telehealth|other`',
    `allergy_category` STRING COMMENT 'Distinguishes between a true immunological allergy, a non-immunological intolerance (e.g., GI upset from NSAIDs), and a documented side effect. Critical for appropriate clinical decision support alert configuration and pharmacy dispensing rules.. Valid values are `allergy|intolerance|side_effect`',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_status` STRING COMMENT 'Current clinical status of the allergy indicating whether it is currently active, has become inactive, or has been resolved. Active allergies trigger clinical decision support alerts during order entry (CPOE).. Valid values are `active|inactive|resolved`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical allergy record.',
    `criticality` STRING COMMENT 'Assessment of the potential clinical risk if the patient is re-exposed to the allergen. High indicates risk of life-threatening reaction. Distinct from severity (which describes the past reaction); criticality predicts future risk. Aligns with HL7 FHIR AllergyIntolerance.criticality.. Valid values are `low|high|unable_to_assess`',
    `data_quality_flag` BOOLEAN COMMENT 'Indicates the data quality assessment status of this allergy record as determined during ETL processing into the Silver Layer. Supports data stewardship workflows and Clinical Documentation Improvement (CDI) initiatives.',
    `deleted_timestamp` TIMESTAMP COMMENT 'The date and timestamp when this allergy record was soft-deleted in the source EHR system. Null if the record has not been deleted. Supports audit trail requirements under HIPAA and HIM standards.',
    `fhir_resource_reference` STRING COMMENT 'The HL7 Fast Healthcare Interoperability Resources (FHIR) AllergyIntolerance resource identifier. Enables interoperability with Health Information Exchanges (HIE), patient portals, and external clinical systems via FHIR APIs.',
    `information_source` STRING COMMENT 'Identifies who provided the allergy information (e.g., patient self-report, caregiver, prior medical record, pharmacy records). Affects the confidence level and verification workflow for the allergy record.. Valid values are `patient|caregiver|provider|medical_record|pharmacy|other`',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether this allergy record has been soft-deleted in the source EHR system. Soft-deleted records are retained in the Silver Layer for audit and Health Information Management (HIM) compliance purposes rather than being physically removed.',
    `is_no_known_allergy` BOOLEAN COMMENT 'Indicates that the patient has been explicitly assessed and confirmed to have No Known Allergies (NKA). Distinct from an empty allergy list, which may indicate incomplete documentation. Critical for patient safety and Joint Commission compliance.',
    `is_no_known_drug_allergy` BOOLEAN COMMENT 'Indicates that the patient has been explicitly assessed and confirmed to have No Known Drug Allergies (NKDA). Specifically scoped to drug allergens to support pharmacy safety checks and CPOE alert configuration.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and timestamp when this allergy record was most recently modified in the source EHR system. Supports change detection in ETL pipelines and audit compliance.',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient by the facilitys Master Patient Index (MPI). Included here as a denormalized identifier to support direct patient safety lookups without joining to the patient master.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical allergy record.',
    `ndf_rt_code` STRING COMMENT 'The National Drug File – Reference Terminology (NDF-RT) code for drug allergens, enabling pharmacological class-level allergy checking (e.g., all penicillin-class antibiotics). Used in drug allergy cross-sensitivity analysis.',
    `note` STRING COMMENT 'Free-text clinical notes or additional comments documented by the clinician regarding this allergy record (e.g., details about the reaction, treatment administered, cross-sensitivity concerns). Supports Clinical Documentation Improvement (CDI) workflows.',
    `onset_date` DATE COMMENT 'The date on which the allergic reaction was first observed or reported by the patient. May be approximate (year only) for historical allergies. Supports longitudinal patient safety tracking.',
    `override_timestamp` TIMESTAMP COMMENT 'Date and time when the allergy alert was overridden by the provider during CPOE. Supports medication safety audit trails. Null if no override has occurred.',
    `pharmacogenomic_basis_flag` BOOLEAN COMMENT 'Indicates whether this allergy/intolerance has a pharmacogenomic basis',
    `phi_access_restricted` BOOLEAN COMMENT 'Indicates whether access to this allergy record is subject to additional Protected Health Information (PHI) access restrictions (e.g., VIP patient, sensitive condition). When true, row-level security controls are applied per HIPAA Privacy Rule requirements.',
    `reaction_description` STRING COMMENT 'Free-text clinical description of the adverse reaction observed or reported by the patient (e.g., hives and facial swelling, anaphylactic shock requiring epinephrine). Captured from clinical documentation in Epic ClinDoc or Cerner PowerChart.',
    `reaction_route` STRING COMMENT 'The route of exposure through which the allergic reaction occurred (e.g., oral ingestion, intravenous administration, topical contact). Informs clinical decision support rules for route-specific allergy alerts. [ENUM-REF-CANDIDATE: oral|intravenous|topical|inhalation|subcutaneous|intramuscular|other — promote to reference product]',
    `reaction_snomed_code` STRING COMMENT 'The SNOMED CT concept code representing the clinical manifestation of the allergic reaction (e.g., urticaria, anaphylaxis, angioedema). Enables structured clinical reporting and interoperability via HL7 FHIR.. Valid values are `^[0-9]{6,18}$`',
    `reconciliation_date` DATE COMMENT 'The date on which this allergy record was last reviewed and reconciled as part of a medication reconciliation process. Supports compliance with The Joint Commission NPSG.03.06.01 and CMS discharge planning requirements.',
    `reconciliation_status` STRING COMMENT 'Indicates whether this allergy has been reviewed and reconciled during a medication reconciliation process (e.g., at admission, discharge, or care transitions). Supports Transitions of Care compliance and The Joint Commission NPSG requirements.. Valid values are `reconciled|not_reconciled|pending`',
    `recorded_date` TIMESTAMP COMMENT 'The date and timestamp when this allergy record was first entered into the Electronic Health Record (EHR) system. Represents the RECORD_AUDIT_CREATED canonical category for this entity. Used for audit trails and Clinical Documentation Improvement (CDI) workflows.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical allergy record.',
    `severity` STRING COMMENT 'Clinical severity classification of the allergic reaction. Drives clinical decision support alert levels and patient safety protocols. Values align with HL7 FHIR AllergyIntolerance severity coding.. Valid values are `mild|moderate|severe|life_threatening`',
    `source_record_reference` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Allergy documentation for substance use-related allergens (e.g., alcohol, opioids) may require consent for disclosure under 42 CFR Part 2. Consent tracking ensures appropriate information sharing rest',
    `source_system_allergy_code` STRING COMMENT 'The native identifier for this allergy record in the originating operational system (e.g., Epic allergy ID, Cerner allergy ID). Enables traceability back to the system of record for reconciliation and audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical allergy record.',
    `verification_status` STRING COMMENT 'Clinical verification status of the allergy record indicating the confidence level of the allergy documentation. Entered-in-error records are retained for audit purposes per Health Information Management (HIM) standards.. Valid values are `confirmed|unconfirmed|refuted|entered_in_error`',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the clinical allergy record.',
    CONSTRAINT pk_allergy PRIMARY KEY(`allergy_id`)
) COMMENT 'Patient allergy and adverse reaction records including drug allergies, food allergies, environmental allergens, and contrast media reactions. Captures allergen name, allergen type, reaction description, reaction severity (mild, moderate, severe, life-threatening), onset date, verification status (confirmed, unconfirmed, entered-in-error), and the documenting provider. SNOMED CT and NDF-RT coded. Critical patient safety data sourced from Epic and Cerner allergy modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`immunization` (
    `immunization_id` BIGINT COMMENT 'Unique surrogate identifier for each immunization administration record in the lakehouse silver layer. Primary key for this data product.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Immunizations are often administered as part of preventive care plans or chronic disease management care plans (e.g., pneumococcal vaccine for COPD patients). Linking immunization to care_plan via car',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Immunizations fulfill vaccine orders. Real workflow: provider orders flu vaccine, nurse administers. Essential for vaccine order-to-administration tracking, VFC program compliance, immunization regist',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Vaccine inventory management, VFC program compliance, lot tracking, expiration management, CDC reporting require linking immunization administration to pharmacy dispense for accountability, recall man',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the immunization clinician within the clinical immunization record.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received the immunization. Links to the Master Patient Index (MPI) patient record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: VFC (Vaccines for Children) program compliance and IIS (Immunization Information System) reporting require the administering facility to be identified. CDC and state health department reporting mandat',
    `primary_care_physician_clinician_id` BIGINT COMMENT 'Reference to the patients Primary Care Physician (PCP) at the time of immunization. Supports care coordination, preventive care gap closure, and HEDIS reporting for immunization measures.',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Immunizations are frequently administered via standing orders (e.g., annual flu vaccine protocol, pneumococcal vaccine for age 65+). Operational efficiency and population health management.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Immunizations are pharmaceutical products tracked in inventory and formulary systems. Vaccine administration requires drug master reference for lot tracking, expiration management, recall notification',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the immunization was administered. Supports linkage to Admit-Discharge-Transfer (ADT) and clinical encounter context.',
    `administration_route_code` STRING COMMENT 'The coded route by which the vaccine was administered (e.g., IM for intramuscular, SC for subcutaneous, PO for oral, IN for intranasal). Follows NCI Thesaurus / HL7 route of administration codes.. Valid values are `IM|SC|ID|PO|IN|IV`',
    `administration_site_code` STRING COMMENT 'Coded anatomical site where the vaccine was injected or administered (e.g., LA for left arm deltoid, RT for right thigh). Uses HL7 v2 or SNOMED CT body site codes. Required for adverse event documentation. [ENUM-REF-CANDIDATE: LA|RA|LT|RT|LG|RG|ABD|NASAL|ORAL — promote to reference product]',
    `administration_status` STRING COMMENT 'Current lifecycle status of the immunization record indicating whether the vaccine was successfully administered, not given, or entered in error. Aligns with HL7 FHIR Immunization.status value set.. Valid values are `completed|entered-in-error|not-done`',
    `administration_timestamp` TIMESTAMP COMMENT 'The exact date and time the vaccine was administered to the patient. This is the principal real-world event timestamp for the immunization record. Sourced from Epic or Cerner immunization module.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the clinical immunization record.',
    `care_setting` STRING COMMENT 'The care setting of the clinical immunization record.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_note` STRING COMMENT 'Free-text clinical notes or comments documented by the administering provider regarding the immunization event, patient response, or special circumstances. Supports Clinical Documentation Improvement (CDI) workflows.',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical immunization record.',
    `cohort_outreach_flag` BOOLEAN COMMENT 'Whether immunization was result of population cohort outreach',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the patient or legal guardian prior to vaccine administration. Supports NCVIA compliance and risk management documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this immunization record was first created or entered into the source system. Supports audit trail, data lineage, and HIPAA compliance documentation.',
    `dose_number_in_series` STRING COMMENT 'The sequential dose number within the immunization series (e.g., 1 for first dose, 2 for second dose, 3 for booster). Used to track series completion and determine next dose eligibility.',
    `dose_quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of vaccine administered in the specified dose unit of measure (e.g., 0.5 mL). Supports clinical documentation and adverse event investigation.',
    `dose_unit` STRING COMMENT 'The unit of measure for the administered vaccine dose quantity (e.g., mL, mg). Follows UCUM (Unified Code for Units of Measure) standards as used in HL7 FHIR.. Valid values are `mL|mg|mcg|units`',
    `expiration_date` DATE COMMENT 'The manufacturer-assigned expiration date of the vaccine lot administered. Required for quality assurance, regulatory compliance, and to flag potential administration of expired product.',
    `funding_source_code` STRING COMMENT 'Code identifying the funding source for the administered vaccine. VFC indicates Vaccines for Children program eligibility; 317 indicates CDC Section 317 public health grant funding. Required for state IIS reporting and VFC program compliance.. Valid values are `VFC|317|STATE|PRIVATE|OTHER`',
    `iis_reported` BOOLEAN COMMENT 'Indicates whether this immunization record has been successfully reported to the state Immunization Information System (IIS) / immunization registry. Supports public health reporting compliance tracking.',
    `iis_reported_timestamp` TIMESTAMP COMMENT 'The date and time this immunization record was transmitted to the state Immunization Information System (IIS). Supports audit trail for public health reporting obligations.',
    `immunization_status` STRING COMMENT 'The immunization status value classifying the clinical immunization record.',
    `lot_number` STRING COMMENT 'The manufacturer-assigned lot number for the specific vaccine vial or unit administered. Critical for adverse event tracking, FDA recall management, and Vaccine Adverse Event Reporting System (VAERS) reporting.',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient by the healthcare organization. Used for cross-system patient identification and immunization registry reporting.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical immunization record.',
    `not_given_reason_code` STRING COMMENT 'Coded reason why the immunization was not administered when administration_status is not-done. Examples include patient refusal, contraindication, or vaccine unavailability. SNOMED CT coded.',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical immunization record.',
    `precision_medicine_consideration` STRING COMMENT 'Notes on precision medicine considerations for immunization (e.g., immunocompromised genetic conditions)',
    `reaction_detail` STRING COMMENT 'Free-text or coded description of the adverse reaction observed following vaccine administration. Supports VAERS reporting and clinical documentation. SNOMED CT coded when structured.',
    `reaction_observed` BOOLEAN COMMENT 'Indicates whether an adverse reaction or side effect was observed following vaccine administration. When true, triggers adverse event documentation workflow and potential VAERS reporting.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical immunization record.',
    `series_completion_status` STRING COMMENT 'Indicates the patients current completion status for the immunization series as of this administration event. Supports population health management, HEDIS measure reporting, and preventive care outreach.. Valid values are `complete|in-progress|not-started|overdue`',
    `series_doses_required` STRING COMMENT 'The total number of doses required to complete the immunization series as defined by the CDC Advisory Committee on Immunization Practices (ACIP) schedule (e.g., 2 for Hepatitis B, 3 for HPV).',
    `series_name` STRING COMMENT 'The name of the immunization series or protocol to which this dose belongs (e.g., COVID-19 Primary Series, Hepatitis B 3-Dose Series, Childhood Immunization Schedule). Supports series completion tracking.',
    `severity` STRING COMMENT 'The severity of the clinical immunization record.',
    `source_record_reference` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Immunizations require documented consent, especially for minors, research vaccines, or religious exemptions. VIS presentation and consent documentation are CDC and state-mandated. Links immunization e',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating operational system (Epic, Cerner, etc.) for this immunization administration event. Enables traceability back to the system of record for audit and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time this immunization record was last modified or updated in the source system. Supports change tracking, audit trail, and data quality monitoring.',
    `vaers_reported` BOOLEAN COMMENT 'Indicates whether an adverse event following this immunization was reported to the FDA/CDC Vaccine Adverse Event Reporting System (VAERS). Required for pharmacovigilance and regulatory compliance.',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical immunization record.',
    `vfc_eligibility_code` STRING COMMENT 'CDC-assigned Vaccines for Children (VFC) eligibility category code for the patient at time of administration (e.g., V01=Medicaid eligible, V02=Uninsured, V03=American Indian/Alaska Native, V04=Underinsured). Required for VFC program billing and compliance reporting.. Valid values are `V01|V02|V03|V04|V05|V06`',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `vis_document_type` STRING COMMENT 'The type or name of the CDC Vaccine Information Statement (VIS) provided to the patient or guardian prior to administration (e.g., Influenza VIS, COVID-19 mRNA VIS). Required by the National Childhood Vaccine Injury Act (NCVIA).',
    `vis_presentation_date` DATE COMMENT 'The date the Vaccine Information Statement (VIS) was presented to the patient or legal guardian. Documents informed consent compliance per NCVIA requirements.',
    `vis_publication_date` DATE COMMENT 'The CDC publication date of the Vaccine Information Statement (VIS) provided to the patient. Required for NCVIA compliance documentation and immunization registry reporting.',
    CONSTRAINT pk_immunization PRIMARY KEY(`immunization_id`)
) COMMENT 'Patient immunization administration records including vaccine administered, CVX code, NDC code, lot number, expiration date, manufacturer, administration site, route, dose number in series, VIS (Vaccine Information Statement) date, administering provider, and administration date/time. Tracks immunization series completion status. Sourced from Epic and Cerner immunization modules. Supports public health reporting to state immunization registries (IIS).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` (
    `vital_sign_id` BIGINT COMMENT 'Unique surrogate identifier for each vital sign measurement record in the lakehouse silver layer. Primary key for the vital_sign data product.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician (nurse, physician, or allied health professional) who recorded or validated the vital sign measurement. Supports accountability and CDI workflows.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom the vital sign measurement was recorded. Links to the master patient record in the Patient domain.',
    `previous_vital_sign_id` BIGINT COMMENT 'Reference to the prior version of this vital sign record when observation_status is amended or corrected. Enables amendment chain traceability and supports audit requirements for clinical documentation integrity.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, ED visit, outpatient visit) during which the vital sign was measured. Supports encounter-level trending and early warning score calculations.',
    `abnormal_flag` BOOLEAN COMMENT 'Interpretation flag indicating whether the measured value falls within, below, or above the reference range. critical_low and critical_high trigger immediate clinical notification per facility policy. Supports sepsis screening, EWS alerting, and clinical deterioration detection workflows.',
    `amended_reason` STRING COMMENT 'The clinical or administrative reason provided when a vital sign record is amended, corrected, or marked as entered-in-error (e.g., transcription error, wrong patient, device malfunction, duplicate entry). Populated only when observation_status is amended, corrected, or entered-in-error. Supports CDI audit trails and data quality governance.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the clinical vital sign record.',
    `body_site` STRING COMMENT 'The anatomical body site where the measurement was taken (e.g., left arm, right arm, finger, ear, forehead, toe). Encoded using SNOMED CT body structure codes. Relevant for blood pressure laterality, temperature site, and SpO2 probe placement. Affects clinical interpretation.',
    `care_setting` STRING COMMENT 'The care setting of the clinical vital sign record.',
    `care_unit` STRING COMMENT 'The clinical care unit or department where the patient was located when the vital sign was measured (e.g., ICU, ED, Medical/Surgical, OR, PACU, Step-Down). Supports unit-level benchmarking, staffing analytics, and HAI surveillance.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_note` STRING COMMENT 'Free-text clinical annotation or comment entered by the recording clinician to provide context for the vital sign measurement (e.g., patient anxious during measurement, cuff size large, post-exercise reading). Supports CDI workflows and clinical interpretation.',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical vital sign record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this vital sign record was first created in the lakehouse silver layer. Represents the ETL ingestion audit timestamp, distinct from measurement_timestamp (when the vital was taken) and documented_timestamp (when it was entered in the EHR). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `documented_timestamp` TIMESTAMP COMMENT 'The date and time when the vital sign measurement was entered or finalized in the EHR system (Epic ClinDoc flowsheet or Cerner PowerChart). May differ from measurement_timestamp when documentation is retrospective. Used for CDI audit trails and documentation timeliness reporting.',
    `ews_score_contribution` STRING COMMENT 'The numeric score contribution of this individual vital sign measurement to the composite Early Warning Score (EWS), Modified Early Warning Score (MEWS), or National Early Warning Score (NEWS/NEWS2). Scored 0–3 per parameter per NEWS2 methodology. Supports real-time clinical deterioration detection and rapid response team activation.',
    `ews_score_type` STRING COMMENT 'Identifies the specific early warning scoring system used to derive the ews_score_contribution for this vital sign (e.g., NEWS2 for adult inpatients, PEWS for pediatric patients, MEWS for general ward use). Allows multi-system EWS coexistence in the same dataset.. Valid values are `NEWS2|MEWS|EWS|PEWS|custom`',
    `flowsheet_row_code` STRING COMMENT 'The source system flowsheet row identifier from Epic ClinDoc or Cerner PowerChart that uniquely identifies the flowsheet template row from which this vital sign was extracted. Supports ETL lineage, source system reconciliation, and re-ingestion deduplication.',
    `gcs_component` STRING COMMENT 'Identifies which component of the Glasgow Coma Scale (GCS) is represented when observation_type is gcs_total or a GCS sub-score (Eye Opening E1-E4, Verbal Response V1-V5, Motor Response M1-M6, or Total 3-15). Null for non-GCS vital sign observations. Supports neurological assessment trending and ICU severity scoring.. Valid values are `eye_opening|verbal_response|motor_response|total`',
    `is_patient_reported` BOOLEAN COMMENT 'Indicates whether the vital sign value was self-reported by the patient (True), such as home blood pressure readings, pain scores, or weight from a patient portal or remote monitoring program. Distinguishes patient-generated health data (PGHD) from clinician-measured values for analytics and clinical decision support.',
    `is_telemetry_derived` BOOLEAN COMMENT 'Indicates whether the vital sign measurement was automatically captured from a continuous bedside telemetry or patient monitoring device (True) versus manually entered by a clinician (False). Supports differentiation of high-frequency device-generated data from manually documented assessments in time-series analytics.',
    `measurement_method` STRING COMMENT 'The clinical method used to obtain the vital sign measurement (e.g., auscultation for BP, pulse oximetry for SpO2, tympanic or oral or rectal or axillary for temperature, Doppler for BP). Encoded using SNOMED CT method codes where applicable. Affects clinical interpretation and normal range thresholds.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the vital sign measurement was physically taken from the patient. This is the principal clinical event time, distinct from the documentation timestamp. Critical for time-series trending, EWS/MEWS/NEWS calculations, and sepsis screening time-to-treatment metrics. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mrn` STRING COMMENT 'The Medical Record Number assigned to the patient by the facility Master Patient Index (MPI). Retained on the vital sign record to support direct clinical lookup without requiring a join to the patient master in operational workflows.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical vital sign record.',
    `numeric_value` DECIMAL(18,2) COMMENT 'The principal quantitative measured value of the vital sign observation (e.g., 120 for systolic BP in mmHg, 98.6 for temperature in °F, 98 for SpO2 in %). Stored as a decimal to accommodate fractional values such as temperature and BMI. Null when the observation is non-numeric (e.g., qualitative pain descriptors).',
    `observation_status` STRING COMMENT 'Current lifecycle status of the vital sign observation record per HL7 FHIR Observation status value set. final indicates a verified measurement; amended or corrected indicates a post-documentation change; entered-in-error flags records to be excluded from clinical calculations. Supports data quality filtering for EWS and sepsis screening. [ENUM-REF-CANDIDATE: registered|preliminary|final|amended|corrected|cancelled|entered-in-error — 7 candidates stripped; promote to reference product]',
    `observation_type` STRING COMMENT 'Standardized enumeration of the vital sign observation category captured in this record. Each row represents a single atomic observation. Supports time-series analytics, EWS/MEWS/NEWS scoring, and sepsis screening. [ENUM-REF-CANDIDATE: blood_pressure_systolic|blood_pressure_diastolic|heart_rate|respiratory_rate|temperature|spo2|height|weight|bmi|pain_score|gcs_total — promote to reference product]',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical vital sign record.',
    `oxygen_delivery_method` STRING COMMENT 'The supplemental oxygen delivery method in use at the time of SpO2 or respiratory rate measurement (e.g., room air, nasal cannula, simple mask, non-rebreather mask, high-flow nasal cannula, mechanical ventilator). Null for non-respiratory vital signs. Critical context for SpO2 interpretation and NEWS2 scoring (Scale 1 vs Scale 2).. Valid values are `room_air|nasal_cannula|simple_mask|non_rebreather|high_flow_nasal|mechanical_ventilator`',
    `pain_scale_type` STRING COMMENT 'The specific pain assessment scale used when observation_type is pain_score (e.g., Numeric Rating Scale 0-10, Visual Analog Scale, Wong-Baker FACES, FLACC for pediatric/non-verbal, CPOT for critically ill). Null for non-pain vital sign observations. Required for accurate pain score interpretation per Joint Commission pain management standards.. Valid values are `numeric_rating|visual_analog|faces|flacc|cpot|behavioral`',
    `patient_position` STRING COMMENT 'The patients body position at the time of the vital sign measurement (e.g., sitting, standing, supine). Particularly relevant for blood pressure and orthostatic vital sign assessments. Encoded using SNOMED CT observable entity codes. [ENUM-REF-CANDIDATE: sitting|standing|supine|prone|left_lateral|right_lateral|semi-recumbent — 7 candidates stripped; promote to reference product]',
    `reference_range_high` DECIMAL(18,2) COMMENT 'The upper bound of the normal reference range for this vital sign observation type, in the same unit of measure as numeric_value. Used for clinical alerting, EWS/MEWS/NEWS scoring, and out-of-range flagging.',
    `reference_range_low` DECIMAL(18,2) COMMENT 'The lower bound of the normal reference range for this vital sign observation type, in the same unit of measure as numeric_value. Used for clinical alerting, EWS/MEWS/NEWS scoring, and out-of-range flagging. Age- and condition-adjusted ranges may differ from population norms.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical vital sign record.',
    `rpm_device_source_flag` BOOLEAN COMMENT 'Indicates whether this vital sign was captured from a remote patient monitoring device',
    `severity` STRING COMMENT 'The severity of the clinical vital sign record.',
    `snomed_finding_code` STRING COMMENT 'SNOMED CT clinical finding code representing the clinical interpretation of the vital sign result (e.g., 38341003 Hypertensive disorder, 44054006 Diabetes mellitus type 2 context). Supports semantic interoperability, clinical decision support, and FHIR-based HIE exchange.. Valid values are `^[0-9]{6,18}$`',
    `source_record_reference` BIGINT COMMENT 'The source record reference of the clinical vital sign record.',
    `source_system_record_code` STRING COMMENT 'The native primary key or observation identifier from the originating source system (Epic, Cerner, MEDITECH, or device integration platform). Enables bidirectional traceability between the lakehouse silver layer record and the operational EHR record for reconciliation and audit.',
    `supplemental_oxygen_flow_rate` DECIMAL(18,2) COMMENT 'The flow rate of supplemental oxygen in liters per minute (L/min) being administered to the patient at the time of the SpO2 or respiratory vital sign measurement. Null when oxygen_delivery_method is room_air or for non-respiratory observations. Supports NEWS2 Scale 2 scoring and respiratory therapy documentation.',
    `text_value` DECIMAL(18,2) COMMENT 'Free-text or coded string value for vital sign observations that are qualitative or semi-quantitative (e.g., pain descriptor mild, moderate, severe; GCS verbal response oriented; SpO2 trend improving). Null when numeric_value is populated.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the numeric vital sign value using UCUM (Unified Code for Units of Measure) notation (e.g., mm[Hg] for blood pressure, /min for heart/respiratory rate, Cel or [degF] for temperature, % for SpO2, cm or [in_i] for height, kg or [lb_av] for weight, kg/m2 for BMI, {score} for pain/GCS).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this vital sign record was last modified in the lakehouse silver layer (e.g., due to an amendment, correction, or status change propagated from the source EHR). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical vital sign record.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `vital_sign_status` STRING COMMENT 'The vital sign status value classifying the clinical vital sign record.',
    CONSTRAINT pk_vital_sign PRIMARY KEY(`vital_sign_id`)
) COMMENT 'Patient vital sign measurements captured during clinical encounters, nursing assessments, and continuous monitoring. Includes LOINC-coded observation types: blood pressure (systolic/diastolic), heart rate, respiratory rate, temperature, SpO2, height, weight, BMI, pain score, and Glasgow Coma Scale (GCS). Captures measured value, unit of measure, measurement method, body site, patient position, device used, measurement date/time, and recording clinician. Supports early warning score (EWS/MEWS/NEWS) calculations, sepsis screening, and clinical deterioration detection. High-volume time-series clinical data sourced from Epic ClinDoc flowsheets, Cerner PowerChart, and bedside monitoring device integrations. Separated from clinical_observation due to distinct high-frequency time-series ingestion patterns, dedicated device integration pipelines, and specialized analytics (trending, alerting, waveform correlation). Maps to FHIR Observation with vitals profile (US Core Vital Signs).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`observation` (
    `observation_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical observation record in the lakehouse silver layer. Primary key for the observation data product.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Clinical observations (assessments, scored evaluations, LOINC-coded findings) are often performed as part of care plan monitoring and goal tracking. Linking observation to care_plan via care_plan_id e',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Observations fulfill assessment orders. Real workflow: order for fall risk assessment, nurse performs Morse scale. Essential for order completion tracking, nursing documentation compliance, quality me',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed clinician (nurse, physician, therapist, or other credentialed provider) who documented or performed this observation. Supports accountability and Joint Commission documentation requirements.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Clinical observations and assessments are often performed in the context of a specific diagnosis (e.g., PHQ-9 depression screening linked to a depression diagnosis, HbA1c observation linked to diabete',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this clinical observation was recorded. Core party reference linking the observation to the Master Patient Index (MPI).',
    `report_id` BIGINT COMMENT 'Foreign key linking to radiology.report. Business justification: FHIR DiagnosticReport → Observation is a standard clinical pattern: imaging-derived findings (e.g., tumor size, fracture grade) are recorded as clinical observations sourced from a radiology report. Q',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Clinical observations are directly derived from or reference specific lab results (e.g., elevated creatinine observation references the test_result, FHIR Observation→DiagnosticReport traceability). ',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Clinical observations (e.g., fall risk assessment, sepsis screening) trigger protocol-based standing orders (e.g., fall precautions, sepsis bundle). Clinical decision support and quality improvement.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit, admission, or episode of care) during which this observation was documented. Links the observation to its clinical context.',
    `ai_derived_flag` BOOLEAN COMMENT 'Indicates whether this observation was derived from an AI/ML model inference',
    `amendment_reason` STRING COMMENT 'Free-text or coded reason provided by the clinician for amending or correcting this observation after initial documentation. Required for CDI audit trails and HIPAA amendment compliance. Null when is_amended is false.',
    `assessment_component` STRING COMMENT 'The specific sub-component or domain of a multi-part assessment tool being scored in this observation record (e.g., Sensory Perception for Braden Scale, Eye Opening for GCS, Mood for PHQ-9 item 1). Enables granular component-level analysis.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Total composite score produced by the standardized assessment tool identified in assessment_tool (e.g., Braden Scale total score 6-23, Morse Fall Scale score 0-125, PHQ-9 score 0-27, GCS total 3-15). Drives clinical decision support thresholds and quality metric calculations.',
    `assessment_tool` STRING COMMENT 'Name of the standardized clinical assessment instrument or scoring tool used to generate this observation (e.g., Braden Scale, Morse Fall Scale, PHQ-9, GCS, Barthel Index, CAGE-AID, Columbia Suicide Severity Rating Scale, FIM). Supports nursing quality metrics and regulatory compliance reporting. [ENUM-REF-CANDIDATE: Braden Scale|Morse Fall Scale|PHQ-9|GCS|Barthel Index|CAGE-AID|Columbia Suicide Severity|FIM|SDOH Screening|Discharge Readiness — promote to reference product]',
    `behavioral_health_flag` BOOLEAN COMMENT 'The behavioral health flag of the clinical observation record.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the clinical observation record.',
    `body_site_code` STRING COMMENT 'SNOMED CT code identifying the anatomical body site or region where the observation was performed or applies (e.g., 368209003 for right arm for blood pressure, 368209003 for wound location). Supports wound care documentation and surgical site infection (SSI) tracking.',
    `body_system` STRING COMMENT 'Clinical body system or organ system to which this observation pertains (e.g., cardiovascular, respiratory, neurological, integumentary, musculoskeletal, gastrointestinal). Supports head-to-toe nursing assessment documentation and clinical analytics segmentation. [ENUM-REF-CANDIDATE: cardiovascular|respiratory|neurological|integumentary|musculoskeletal|gastrointestinal|genitourinary|endocrine|hematologic|psychiatric — promote to reference product]',
    `care_setting` STRING COMMENT 'The clinical care setting or unit type in which the observation was documented (e.g., inpatient, ED, ICU, OR, ambulatory, telehealth). Supports population health stratification, nursing quality metrics, and setting-specific regulatory reporting. [ENUM-REF-CANDIDATE: inpatient|outpatient|ED|ICU|OR|ambulatory|telehealth|home-health — 8 candidates stripped; promote to reference product]',
    `observation_category` STRING COMMENT 'High-level clinical category classifying the type of observation per HL7 FHIR value set (e.g., vital-signs, nursing, functional, screening, exam). Drives downstream routing, analytics segmentation, and FHIR Observation.category mapping. [ENUM-REF-CANDIDATE: vital-signs|laboratory|nursing|functional|screening|exam|social-history|imaging — 8 candidates stripped; promote to reference product]',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical observation record.',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this observation record was first created in the source system or ingested into the lakehouse. Supports audit trail requirements, data lineage, and HIPAA access log compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the clinical observation record.',
    `critical_value_notified_datetime` TIMESTAMP COMMENT 'Date and time when the responsible clinician was notified of a critical observation value, as required by The Joint Commission NPSG.02.03.01. Null when is_critical_value is false. Supports compliance auditing and response time measurement.',
    `data_absent_reason` STRING COMMENT 'Coded reason explaining why an expected observation value is missing or not available (e.g., patient declined, not performed, error in collection). Required for FHIR conformance and supports data quality monitoring and completeness reporting. [ENUM-REF-CANDIDATE: unknown|asked-unknown|temp-unknown|not-asked|asked-declined|masked|not-applicable|error|not-performed — 9 candidates stripped; promote to reference product]',
    `datetime` TIMESTAMP COMMENT 'The clinically effective date and time when the observation was made, measured, or assessed (not when it was entered into the system). This is the principal real-world event timestamp used for clinical trending, time-series analytics, and regulatory reporting.',
    `device_type` STRING COMMENT 'Type of medical device or instrument used to obtain the observation (e.g., pulse oximeter, electronic thermometer, sphygmomanometer, glucometer, bedside monitor). Supports device performance tracking and FDA medical device reporting.',
    `external_observation_code` STRING COMMENT 'Source system identifier for this observation as assigned by the originating Electronic Health Record (EHR) system (e.g., Epic ClinDoc flowsheet row ID, Cerner PowerChart result ID). Enables traceability back to the system of record.',
    `interpretation_flag` BOOLEAN COMMENT 'Clinical interpretation of the observation value relative to the reference range (e.g., normal, abnormal, critical-high, critical-low). Drives clinical alerting, nursing escalation workflows, and quality metric calculations. Maps to HL7 FHIR Observation.interpretation. [ENUM-REF-CANDIDATE: normal|abnormal|critical-high|critical-low|high|low|indeterminate — 7 candidates stripped; promote to reference product]',
    `is_amended` BOOLEAN COMMENT 'Boolean flag indicating whether this observation record has been amended or corrected after initial documentation. Supports Clinical Documentation Improvement (CDI) workflows, audit trails, and HIPAA amendment request tracking.',
    `is_critical_value` BOOLEAN COMMENT 'Boolean flag indicating whether this observation result constitutes a critical (panic) value requiring immediate clinical notification per facility policy (e.g., GCS < 8, SpO2 < 85%). Drives critical value notification workflows and Joint Commission NPSG compliance.',
    `issued_datetime` TIMESTAMP COMMENT 'The date and time the observation result was made available or released in the EHR system (e.g., when a nurse signed and released the flowsheet entry). Distinct from observation_datetime which captures when the measurement occurred.',
    `laterality` STRING COMMENT 'Specifies the side of the body for the observation when anatomical laterality is clinically relevant (e.g., left arm blood pressure, right leg wound). Supports surgical safety, wound tracking, and clinical documentation accuracy.. Valid values are `left|right|bilateral|midline|not-applicable`',
    `local_code` STRING COMMENT 'Facility- or system-specific code for the observation as defined in the source EHR (e.g., Epic flowsheet row ID, Cerner mnemonic). Used for source system reconciliation when a standard LOINC code is not yet mapped.',
    `method_code` STRING COMMENT 'SNOMED CT or LOINC method code describing the technique or procedure used to obtain the observation (e.g., 371911009 for auscultation, 113011001 for palpation, non-invasive vs invasive blood pressure measurement). Supports clinical accuracy and reproducibility.',
    `mrn` STRING COMMENT 'The mrn of the clinical observation record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical observation record.',
    `observation_status` STRING COMMENT 'Current workflow lifecycle status of the observation record per HL7 FHIR Observation.status value set. final indicates a verified, clinician-signed result; amended or corrected indicates post-signature modification; entered-in-error supports clinical documentation correction workflows. [ENUM-REF-CANDIDATE: registered|preliminary|final|amended|corrected|cancelled|entered-in-error — 7 candidates stripped; promote to reference product]',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical observation record.',
    `presence_status` STRING COMMENT 'Indicates whether the clinical finding or condition being observed is present, absent, or unknown for this patient at the time of observation. Critical for problem list management, SNOMED CT post-coordination, and population health stratification.. Valid values are `present|absent|unknown|not-applicable`',
    `reference_range_high` DECIMAL(18,2) COMMENT 'The upper bound of the normal reference range for this observation type and patient population context (e.g., 100 for heart rate upper bound). Used to compute interpretation_flag and support clinical decision support.',
    `reference_range_low` DECIMAL(18,2) COMMENT 'The lower bound of the normal reference range for this observation type and patient population context (e.g., 60 for heart rate lower bound). Used to compute interpretation_flag and support clinical decision support.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical observation record.',
    `sdoh_domain` STRING COMMENT 'For SDOH screening observations, identifies the specific Social Determinants of Health (SDOH) domain being assessed (e.g., food insecurity, housing instability, transportation barriers). Supports population health management, ACO quality reporting, and CMS SDOH initiatives. [ENUM-REF-CANDIDATE: food-insecurity|housing-instability|transportation|social-isolation|financial-strain|education|not-applicable — 7 candidates stripped; promote to reference product]',
    `severity` STRING COMMENT 'Clinician-assessed severity of the finding or symptom documented in this observation (e.g., mild pain, severe dyspnea). Used in symptom documentation, behavioral health screenings, and clinical acuity stratification.. Valid values are `mild|moderate|severe|life-threatening|not-applicable`',
    `source_record_reference` BIGINT COMMENT 'The source record reference of the clinical observation record.',
    `subcategory` STRING COMMENT 'Finer-grained clinical classification within the observation_category (e.g., fall-risk, pressure-injury, neurological, wound, intake-output, behavioral-health, sdoh, discharge-readiness). Supports nursing quality metrics and Joint Commission compliance reporting. [ENUM-REF-CANDIDATE: fall-risk|pressure-injury|neurological|wound|intake-output|behavioral-health|sdoh|discharge-readiness|pain|functional-status — promote to reference product]',
    `updated_datetime` TIMESTAMP COMMENT 'The date and time when this observation record was most recently modified in the source system or updated in the lakehouse silver layer. Supports incremental ETL processing, CDI workflows, and audit trail requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical observation record.',
    `value_coded` STRING COMMENT 'The coded result value when the observation is expressed as a standardized code (e.g., SNOMED CT code 260385009 for negative, 10828004 for positive, or a LOINC answer list code). Used for coded clinical findings, presence/absence, and assessment scale responses.',
    `value_coded_system` STRING COMMENT 'The coding system used for the coded observation value when the result is expressed as a code rather than a number (e.g., SNOMED-CT for clinical findings, LOINC answer lists). Null when value_numeric or value_text is used.. Valid values are `SNOMED-CT|LOINC|ICD-10|CPT|LOCAL`',
    `value_numeric` DECIMAL(18,2) COMMENT 'The quantitative measured value of the observation when the result is numeric (e.g., 98.6 for temperature, 120 for systolic blood pressure, 7 for GCS eye response score, 15 for Braden Scale total). Null when the observation result is coded or free-text.',
    `value_text` STRING COMMENT 'Free-text narrative value for observations that cannot be expressed numerically or as a coded value (e.g., wound description, clinical impression, nursing note excerpt). Contains Protected Health Information (PHI) and must be handled per HIPAA requirements.',
    `value_unit` STRING COMMENT 'The unit of measure for the numeric observation value using UCUM (Unified Code for Units of Measure) notation (e.g., degF, mm[Hg], kg, /min, %, mL). Required when value_numeric is populated.',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical observation record.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_observation PRIMARY KEY(`observation_id`)
) COMMENT 'SSOT for all structured clinical observations, assessments, scored evaluations, and clinical findings documented by clinicians during patient care. Encompasses LOINC-coded and SNOMED CT-coded observations across all clinical contexts including: nursing assessments (head-to-toe, skin integrity, restraint, fall risk using Morse/Braden scales, pressure injury staging, discharge readiness), functional status assessments (Barthel Index, FIM, ADL/IADL), behavioral health screenings (PHQ-9, CAGE-AID, Columbia Suicide Severity), SDOH screenings, wound assessments, intake/output measurements, neurological assessments (GCS components), physical examination findings, symptom documentation, and clinical impressions. Captures observation code, value (numeric, coded, or text), units, reference range, interpretation flag (normal, abnormal, critical), observation_category (nursing, functional, finding, screening, exam), assessment tool used, body system/site, laterality, severity, presence status (present, absent, unknown), observation date/time, and recording clinician. High-volume structured clinical data sourced from Epic ClinDoc flowsheets, Cerner PowerChart, and structured documentation modules. Supports nursing quality metrics, discharge planning, population health stratification, Joint Commission compliance, and FHIR Observation resource interoperability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` (
    `care_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the care plan record in the lakehouse Silver layer. Primary key for this entity.',
    `set_id` BIGINT COMMENT 'Foreign key linking to order.order_set. Business justification: Care plans activate order sets. Real workflow: CHF care plan triggers CHF admission order set. Essential for care pathway compliance tracking, order set utilization analysis, population health protoco',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this care plan was created. Links to the patient master record.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: MIPS group reporting and ACO Shared Savings Program require care plans to be attributed to the practice group. Group-level quality measure calculation, PCMH recognition, and CMS group practice reporti',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Care plans are structured around a patients specific health plan — covered services, care gap programs, ACO attribution, and population health programs are all plan-specific. Existing payer_id is ins',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Care plans are developed within a patients active enrollment period — benefit period dates, enrollment status, and coverage tier directly shape covered services and care plan goals. Care management p',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical care plan record.',
    `network_affiliation_id` BIGINT COMMENT 'Foreign key linking to provider.network_affiliation. Business justification: CMS ACO Shared Savings Program and value-based care contracts require care plans to be attributed to the specific network affiliation under which the clinician participates. This supports ACO performa',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: ACO attribution, PCMH program management, and value-based care contracts require knowing which org_provider owns a care plan. CMS ACO Shared Savings Program and MSSP reporting mandate facility-level c',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Care plans are often mandated by payer contracts (ACO requirements, care management programs, chronic care management billing). Payer-specific quality measures and care coordination requirements drive',
    `clinician_id` BIGINT COMMENT 'Reference to the care coordinator or case manager assigned to oversee execution of this care plan, distinct from the authoring provider. Supports ACO care coordination workflows and population health management.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: A care plan is created to address a primary diagnosis. care_plan currently stores primary_icd10_code (STRING) and primary_diagnosis_description (STRING) as denormalized text. Adding primary_diagnosis_',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Hospital admission workflows require linking the inpatient care plan to the triggering registration event. Care management teams use this to track which admission initiated the care plan, supporting t',
    `tertiary_care_pcp_clinician_id` BIGINT COMMENT 'Reference to the patients Primary Care Physician (PCP) who should receive care plan summary and transition communications. Supports care continuity, ACO attribution, and CMS transitions of care quality measures.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, outpatient visit, ED visit) during which this care plan was initiated or most recently updated.',
    `aco_attributed` BOOLEAN COMMENT 'Indicates whether this care plan is associated with a patient attributed to an Accountable Care Organization (ACO) program. Drives ACO quality reporting, shared savings calculations, and population health management workflows.',
    `advance_directive_on_file` BOOLEAN COMMENT 'Indicates whether a valid advance directive (living will, POLST, MOLST, or healthcare proxy) is on file for this patient and has been reviewed in the context of this care plan. Required for CMS Conditions of Participation and Joint Commission compliance.',
    `authored_date` DATE COMMENT 'The calendar date on which the care plan was originally authored or first documented in the EHR. Distinct from the effective start date; captures the documentation event timestamp at day granularity.',
    `behavioral_health_episode_link` STRING COMMENT 'Link to behavioral health episode (SUD or crisis) for integrated care plans',
    `behavioral_health_flag` BOOLEAN COMMENT 'Indicates whether this care plan addresses behavioral health, mental health, or substance use disorder conditions. Triggers enhanced privacy protections under 42 CFR Part 2 and state mental health parity laws, restricting downstream data sharing.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT '42 CFR Part 2 protected data flag',
    `care_gap_count` STRING COMMENT 'Number of open care gaps associated with this care plan',
    `care_plan_status` STRING COMMENT 'The care plan status value classifying the clinical care plan record.',
    `care_setting` STRING COMMENT 'The clinical care setting in which this care plan is being executed. Drives population health segmentation, ACO attribution, and CMS quality measure reporting. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|icu|home_health|snf|hospice|telehealth — promote to reference product]',
    `cdi_review_status` STRING COMMENT 'Status of the Clinical Documentation Improvement (CDI) review process for this care plan. CDI specialists review care plans to ensure diagnoses and clinical findings are accurately and completely documented to support appropriate DRG assignment and quality reporting.. Valid values are `pending|in_review|completed|not_required`',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical care plan record.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification of this care plan per HL7 v3 Confidentiality value set. restricted and very_restricted apply to sensitive conditions (e.g., behavioral health, substance use disorder, HIV) subject to 42 CFR Part 2 and state-specific privacy laws beyond standard HIPAA protections.. Valid values are `normal|restricted|very_restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this care plan record was first created in the source EHR system. Used for audit trail, CDI workflow tracking, and HIPAA audit log compliance.',
    `care_plan_description` STRING COMMENT 'Free-text narrative description of the overall care plan, including clinical rationale, patient-specific context, and summary of the care approach. Authored by the clinician in the EHR.',
    `discharge_disposition` STRING COMMENT 'Planned or actual discharge destination for the patient upon completion of this care plan. Critical for transitions of care planning, readmission risk stratification, and CMS discharge planning compliance. [ENUM-REF-CANDIDATE: home|snf|rehab|ltac|hospice|ama|expired|other — promote to reference product]',
    `effective_end_date` DATE COMMENT 'The date on which this care plan is expected to conclude or was concluded. Null for open-ended chronic disease management plans. Used for LOS and transitions of care analytics.',
    `effective_start_date` DATE COMMENT 'The date on which this care plan becomes or became clinically active and binding for the patients care. Used for transitions of care tracking and CMS discharge planning compliance.',
    `external_plan_code` STRING COMMENT 'The externally-known or source-system identifier for this care plan as assigned by the originating EHR (e.g., Epic Healthy Planet plan ID, Cerner PowerChart plan number). Supports HIE interoperability and cross-system reconciliation.',
    `fhir_resource_reference` STRING COMMENT 'The HL7 FHIR R4 logical resource identifier for this care plan as exposed via the FHIR API. Enables interoperability with HIE partners, payer systems, and patient-facing applications under the ONC 21st Century Cures Act.. Valid values are `^[A-Za-z0-9-.]{1,64}$`',
    `goal_count` STRING COMMENT 'Total number of patient goals documented within this care plan. Supports care plan completeness scoring, CDI quality metrics, and population health reporting without requiring aggregation of goal detail records.',
    `goals_achieved_count` STRING COMMENT 'Number of goals within this care plan that have reached achieved status. Used for outcomes reporting, VBP performance measurement, and ACO quality scoring.',
    `intent` STRING COMMENT 'Indicates the degree of authority and actionability of the care plan per HL7 FHIR intent value set. proposal is a suggestion; plan is an agreed-upon plan; order is a directive; option is a contingency.. Valid values are `proposal|plan|order|option`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this care plan record in the source EHR. Supports CDI workflow, version tracking, and HIPAA audit compliance.',
    `last_reviewed_date` DATE COMMENT 'Date on which this care plan was most recently formally reviewed and attested by a qualified clinician. Supports CDI workflow, compliance auditing, and care plan currency validation.',
    `mrn` STRING COMMENT 'The mrn of the clinical care plan record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical care plan record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this care plan by the responsible care team. Used for care management workflow queuing and overdue plan identification.',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical care plan record.',
    `patient_consent_date` DATE COMMENT 'Date on which the patient or authorized representative provided consent for this care plan. Required for HIPAA documentation and CMS regulatory compliance.',
    `patient_consent_obtained` BOOLEAN COMMENT 'Indicates whether the patient (or authorized representative) has provided informed consent for the care plan and its associated interventions. Required for HIPAA compliance and CMS Conditions of Participation.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the care plan per HL7 FHIR CarePlan status value set. draft indicates not yet activated; active is in use; on-hold is temporarily suspended; completed indicates all goals met; revoked indicates cancelled before completion.. Valid values are `draft|active|on-hold|completed|revoked|entered-in-error`',
    `plan_title` STRING COMMENT 'Human-readable title or name of the care plan as displayed in the EHR (e.g., Diabetes Management Plan, Post-Surgical Discharge Plan, CHF Chronic Disease Management).',
    `plan_type` STRING COMMENT 'Classification of the care plan by care setting and purpose. Drives workflow routing and regulatory reporting. [ENUM-REF-CANDIDATE: inpatient|outpatient|chronic_disease|discharge|transitional|palliative|preventive — promote to reference product]',
    `population_health_program` STRING COMMENT 'Name or code of the population health management program (e.g., Diabetes Registry, CHF Disease Management, Hypertension Control, Preventive Care Outreach) under which this care plan is managed. Supports HEDIS measure attribution and ACO program reporting.',
    `precision_medicine_plan_flag` BOOLEAN COMMENT 'Indicates whether this care plan incorporates precision medicine/genomic findings',
    `readmission_risk_level` STRING COMMENT 'Clinician-assigned or algorithmically-derived readmission risk stratification for this patient at the time of care plan creation. Drives care management intensity and post-discharge follow-up scheduling. Supports CMS Hospital Readmissions Reduction Program (HRRP) compliance.. Valid values are `low|medium|high|very_high`',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical care plan record.',
    `review_frequency` STRING COMMENT 'Prescribed frequency at which this care plan should be formally reviewed and updated by the care team. Drives scheduling of care plan review encounters and supports NCQA PCMH and CMS chronic care management billing requirements. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annually|as_needed — 7 candidates stripped; promote to reference product]',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether Social Determinants of Health (SDOH) factors (e.g., food insecurity, housing instability, transportation barriers) have been identified and incorporated into this care plan. Supports CMS SDOH screening requirements and population health management.',
    `severity` STRING COMMENT 'The severity of the clinical care plan record.',
    `source_record_reference` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Care plans require patient consent for goals, interventions, and care team access. CMS Conditions of Participation and ACO programs mandate documented patient consent for care plan development and sha',
    `transitions_of_care_flag` BOOLEAN COMMENT 'Indicates whether this care plan was created or updated specifically to support a transition of care event (e.g., hospital discharge to home, SNF transfer, ED to inpatient admission). Supports CMS Transitions of Care quality measures and readmission reduction programs.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the clinical care plan record.',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical care plan record.',
    `version_number` STRING COMMENT 'Sequential version number incremented each time the care plan is substantively revised. Supports care plan history tracking, CDI audit trails, and regulatory documentation of plan evolution.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_care_plan PRIMARY KEY(`care_plan_id`)
) COMMENT 'Patient-centered care plans documenting clinical goals, interventions, and expected outcomes across the care continuum. Captures care plan type (inpatient, outpatient, chronic disease, discharge, transitional), status (draft, active, completed, revoked), effective date range, care setting, authoring provider, care team assignment, patient goals with individual lifecycle tracking, clinical problems addressed, and care plan category (SNOMED CT coded). Includes embedded care plan goals as detail records: goal description, SNOMED CT coded goal category, target measure (LOINC coded), target value, target date, achievement status (proposed, accepted, in-progress, achieved, cancelled), priority, and responsible provider. Supports transitions of care, population health management, ACO care coordination, and CMS Conditions of Participation for discharge planning. Sourced from Epic Healthy Planet and Cerner.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_team` (
    `care_team_id` BIGINT COMMENT 'Unique surrogate identifier for the clinical care team record in the lakehouse silver layer.',
    `care_plan_id` BIGINT COMMENT 'Reference to the associated care plan that this team is responsible for executing. Links care team accountability to specific clinical goals, interventions, and outcomes defined in the care plan.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this care team is assigned. Links to the master patient record (MPI). Core PARTY_REFERENCE required by TRANSACTION_HEADER role.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Care teams are organized and credentialed within a specific facility. Joint Commission medical staff standards and CMS Conditions of Participation require care team composition to be traceable to the ',
    `clinician_id` BIGINT COMMENT 'Reference to the care team member designated as the primary point of contact for the patient and family. May differ from the attending provider (e.g., a care coordinator or NP may be the primary contact). Supports care coordination and patient communication workflows.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to insurance.provider_network. Business justification: Care team composition must be validated against the patients insurance provider network for in-network/out-of-network determination, referral authorization, and care coordination compliance. Network ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: care_team carries denormalized specialty_code and specialty_name. Normalizing via FK to provider.specialty supports network adequacy reporting (CMS network adequacy standards), specialty-based care te',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, outpatient visit, ED visit) with which this care team is associated. A care team may exist without a specific encounter for longitudinal/primary care contexts.',
    `aco_attributed` BOOLEAN COMMENT 'Indicates whether this care team is associated with an Accountable Care Organization (ACO) attribution for the patient. Relevant for value-based care reporting, MSSP program compliance, and population health management.',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the clinical care team record.',
    `care_coordination_level` STRING COMMENT 'Classification of the intensity of care coordination required for this team, based on patient complexity and care needs. Drives resource allocation, staffing decisions, and care management program enrollment.. Valid values are `standard|enhanced|complex|intensive`',
    `care_setting` STRING COMMENT 'Clinical care setting in which the team operates. Distinct from team_type — care_setting describes the physical/virtual environment of care delivery (e.g., ED, ICU, telehealth), while team_type describes the organizational model. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|observation|telehealth|home_health|skilled_nursing — promote to reference product]',
    `care_team_status` STRING COMMENT 'The care team status value classifying the clinical care team record.',
    `cdi_review_flag` BOOLEAN COMMENT 'Indicates whether this care team record has been flagged for Clinical Documentation Improvement (CDI) review. CDI specialists use this flag to identify cases where care team documentation may require clarification to support accurate coding, DRG assignment, and reimbursement.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical care team record.',
    `coverage_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this care team members coverage period ended. Used in conjunction with coverage_start_timestamp to define shift-level coverage windows and identify coverage gaps.',
    `coverage_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this care team members coverage period began (e.g., start of a shift or on-call rotation). More granular than member_start_date; used for shift-level coverage gap analysis and handoff documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care team record was first created in the source EHR system. Supports audit trail, data lineage, and regulatory compliance requirements. Aligns with RECORD_AUDIT_CREATED category.',
    `digital_health_relevant_flag` BOOLEAN COMMENT 'Whether this record is relevant to digital health/RPM/telehealth workflows',
    `discharge_disposition_code` STRING COMMENT 'CMS-standard discharge disposition code indicating the patients destination upon leaving this care teams care (e.g., 01 = Home, 03 = SNF, 20 = Expired). Populated for inpatient and transitional care teams at team closure. Required for UB-04 billing and CMS quality reporting.',
    `ehr_care_team_csn` STRING COMMENT 'Epic-specific Contact Serial Number (CSN) uniquely identifying the care team context within an Epic encounter. Used for cross-referencing Epic ClinDoc records during ETL and data reconciliation.',
    `genomics_specialist_included` BOOLEAN COMMENT 'Indicates whether a genetics counselor or genomics specialist is on the care team',
    `hie_shared` BOOLEAN COMMENT 'Indicates whether this care team record has been shared via a Health Information Exchange (HIE) to external care partners (e.g., referring providers, ACO partners, post-acute facilities). Supports care coordination across organizational boundaries and HIE participation reporting.',
    `is_multidisciplinary` BOOLEAN COMMENT 'Indicates whether this care team is formally designated as a multidisciplinary team (MDT), involving providers from two or more distinct clinical disciplines. MDT designation is relevant for complex case management, oncology tumor boards, and regulatory quality reporting.',
    `is_on_call` BOOLEAN COMMENT 'Indicates whether this care team member is currently designated as on-call for the patient. On-call designation determines who is contacted for urgent clinical decisions outside of normal coverage hours.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this care team member is designated as the primary point of contact for the patient and family within the team. Only one member per team should hold this designation at any given time.',
    `is_primary_team` BOOLEAN COMMENT 'Indicates whether this is the patients primary care team (as opposed to a consulting or specialty team). A patient may have multiple concurrent care teams; this flag identifies the team with primary clinical accountability.',
    `member_end_date` DATE COMMENT 'Date on which this individual members participation in the care team ended (e.g., due to rotation, discharge, or reassignment). Null for currently active members. Supports member lifecycle and coverage gap analysis.',
    `member_role_code` STRING COMMENT 'Standardized role code for the care team members function within the team (e.g., SNOMED CT role codes or Epic-defined role codes such as ATT for Attending, RES for Resident, CON for Consultant). More granular than member_type.',
    `member_role_name` STRING COMMENT 'Human-readable name of the care team members role (e.g., Attending Physician, Consulting Cardiologist, Charge Nurse, Clinical Pharmacist). Complements member_role_code for display in EHR panels and reports.',
    `member_start_date` DATE COMMENT 'Date on which this individual member began participating in the care team. Supports member-level assignment lifecycle tracking, transitions of care documentation, and care coordination analytics.',
    `member_status` STRING COMMENT 'Current status of the individual care team members participation. Active indicates current participation; inactive indicates the member has left the team; on_leave indicates temporary absence (e.g., vacation, LOA); removed indicates the member was explicitly removed from the team.. Valid values are `active|inactive|on_leave|removed`',
    `member_type` STRING COMMENT 'Classification of the care team member by clinical role category. Physician includes MDs and DOs; NP = Nurse Practitioner; PA = Physician Assistant; RN = Registered Nurse; social_worker covers licensed clinical social workers; pharmacist covers clinical pharmacy staff; care_coordinator covers non-clinical coordination roles. [ENUM-REF-CANDIDATE: physician|np|pa|rn|social_worker|pharmacist|care_coordinator — 7 candidates stripped; promote to reference product]',
    `mrn` STRING COMMENT 'The mrn of the clinical care team record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical care team record.',
    `npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the care team member, as assigned by CMS. Required for billing, credentialing, and regulatory reporting. Denormalized here for care team-level queries without requiring a join to the provider master.. Valid values are `^[0-9]{10}$`',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical care team record.',
    `reason_code` STRING COMMENT 'Coded reason for the care team assignment, expressed using SNOMED CT or ICD-10 codes (e.g., a specific diagnosis or condition driving the team composition). Supports clinical decision support and population health analytics.',
    `reason_description` STRING COMMENT 'Free-text or decoded description of the clinical reason for the care team assignment (e.g., Complex heart failure management, Post-surgical recovery). Complements reason_code for human-readable reporting.',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical care team record.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether this care team has been assigned to address Social Determinants of Health (SDOH) needs for the patient (e.g., housing instability, food insecurity, transportation barriers). Supports population health management and SDOH screening program reporting.',
    `severity` STRING COMMENT 'The severity of the clinical care team record.',
    `source_record_reference` BIGINT COMMENT 'The source record reference of the clinical care team record.',
    `source_system_team_code` STRING COMMENT 'Native identifier of the care team record in the originating operational system (e.g., Epic internal care team CSN or Cerner care team ID). Enables traceability back to the source EHR for reconciliation and audit.',
    `team_end_date` DATE COMMENT 'Date on which the care team was dissolved or the patient was discharged/transitioned out of this teams care. Null for currently active teams. Aligns with FHIR CareTeam.period.end.',
    `team_name` STRING COMMENT 'Human-readable name or label assigned to the care team (e.g., Cardiology Inpatient Team A, Primary Care Team — Dr. Smith). Used for display in EHR care team panels and care coordination dashboards.',
    `team_start_date` DATE COMMENT 'Date on which the care team became active and assumed clinical accountability for the patient. Used for transitions of care documentation and care coordination reporting. Aligns with FHIR CareTeam.period.start.',
    `team_status` STRING COMMENT 'Current lifecycle status of the care team record. Active indicates the team is currently providing care; inactive indicates the team has been dissolved or the patient discharged; proposed indicates a team pending activation; suspended indicates temporary pause; entered-in-error supports data correction workflows.. Valid values are `active|inactive|suspended|proposed|entered-in-error`',
    `team_type` STRING COMMENT 'Classification of the care team by care setting and organizational model. Inpatient teams are hospital-based; outpatient teams support ambulatory care; primary teams represent the patients longitudinal PCP-led team; specialty teams are disease- or organ-specific; multidisciplinary teams span disciplines; transitional teams support transitions of care (e.g., discharge to SNF).. Valid values are `inpatient|outpatient|primary|specialty|multidisciplinary|transitional`',
    `transitions_of_care_flag` BOOLEAN COMMENT 'Indicates whether this care team is specifically designated to manage a transition of care event (e.g., hospital discharge to home, SNF, or rehabilitation). Supports CMS Transitional Care Management (TCM) billing and readmission reduction programs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the care team record in the source EHR system. Supports change detection, incremental ETL processing, and audit trail requirements.',
    `vbp_program_code` STRING COMMENT 'Code identifying the value-based purchasing or alternative payment model (APM) program under which this care team operates (e.g., MSSP, BPCI-A, CPC+). Supports VBP performance tracking and regulatory reporting to CMS.',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical care team record.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_care_team PRIMARY KEY(`care_team_id`)
) COMMENT 'Clinical care team assignments for patients, documenting which providers are responsible for a patients care in a given context. Captures care team type (inpatient, outpatient, primary, specialty, multidisciplinary), team status, assignment dates, and individual member detail records: member type (physician, NP, PA, RN, social worker, pharmacist, care coordinator), role code, on-call flag, primary contact flag, participation start/end dates, and active status. Members are modeled as line items within the care team — each with their own assignment lifecycle but always in the context of a parent team. Distinct from workforce scheduling — this is the clinical accountability record. Enables care coordination queries, transitions of care documentation, and care plan team assignment. Sourced from Epic and Cerner care team modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` (
    `care_team_member_id` BIGINT COMMENT 'Unique surrogate identifier for each care team member record in the silver layer lakehouse. Primary key for this entity.',
    `care_plan_id` BIGINT COMMENT 'Reference to the care plan to which this care team members responsibilities are linked. Associates the members role with specific care plan goals, interventions, and outcomes.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this care team membership is established. Links the care team member record to the patients Master Patient Index (MPI) record.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider record for this care team member. Identifies the individual practitioner (physician, NP, PA, RN, pharmacist, social worker, care coordinator, etc.) assigned to the team.',
    `care_team_id` BIGINT COMMENT 'Reference to the parent care team to which this member belongs. Links the individual membership record to the overarching care team construct.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: care_team_member carries denormalized specialty_code and specialty_name. Normalizing via FK to provider.specialty enables specialty-specific care team member reporting for PCMH accreditation, multidis',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient, outpatient, ED visit) during which this care team membership is active. Nullable for longitudinal care team assignments not tied to a single encounter.',
    `admission_date` DATE COMMENT 'The date of the patients admission associated with this care team membership. Used to contextualize the care team assignment within the inpatient episode and for Length of Stay (LOS) analytics.',
    `assignment_end_date` DATE COMMENT 'The date on which this providers membership on the care team ended or is scheduled to end. Nullable for open-ended assignments. Used for historical care team queries and transitions of care documentation.',
    `assignment_start_date` DATE COMMENT 'The date on which this providers membership on the care team became effective. Used to determine the period of clinical responsibility and for transitions of care documentation.',
    `assignment_type` STRING COMMENT 'Classifies the nature of this providers assignment to the care team (e.g., primary responsibility, consulting, covering/cross-coverage, co-managing). Used to distinguish primary from secondary care responsibilities and for billing attribution.. Valid values are `primary|consulting|covering|co-managing|observing`',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the clinical care team member record.',
    `care_setting` STRING COMMENT 'The clinical care setting in which this care team member is providing services (e.g., inpatient, outpatient, ICU, ED, telehealth). Drives care coordination workflows and transitions of care documentation. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|icu|surgical|telehealth|home_health|skilled_nursing — promote to reference product]',
    `care_team_category` STRING COMMENT 'Classifies the care team type to which this member belongs: longitudinal (ongoing primary care), episode-based (specific inpatient stay), event-based (single procedure or visit), or condition-based (chronic disease management). Aligns with HL7 FHIR CareTeam.category.. Valid values are `longitudinal|episode|event|condition`',
    `care_team_member_status` STRING COMMENT 'The care team member status value classifying the clinical care team member record.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_focus` STRING COMMENT 'Free-text or coded description of the specific clinical focus area or condition for which this care team member is responsible (e.g., Diabetes Management, Post-Surgical Recovery, Palliative Care). Supports population health management and care coordination analytics.',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical care team member record.',
    `coverage_type` STRING COMMENT 'Indicates whether this care team members assignment represents a scheduled/permanent role, cross-coverage arrangement, locum tenens, or temporary assignment. Used for staffing analytics and care continuity tracking.. Valid values are `scheduled|cross_coverage|locum|temporary|permanent`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this care team member record was first created in the source system. Used for audit trail, data lineage, and care team history analytics.',
    `digital_health_relevant_flag` BOOLEAN COMMENT 'Whether this record is relevant to digital health/RPM/telehealth workflows',
    `discharge_date` DATE COMMENT 'The date of the patients discharge associated with this care team membership. Used for transitions of care documentation, Length of Stay (LOS) calculations, and post-discharge follow-up assignment.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The proportion of this providers Full-Time Equivalent (FTE) effort allocated to this care team assignment, expressed as a decimal (e.g., 0.50 for 50% effort). Used for workforce planning, staffing analytics, and care team capacity management.',
    `genetic_counselor_flag` BOOLEAN COMMENT 'Indicates whether this team member is a genetic counselor',
    `handoff_timestamp` TIMESTAMP COMMENT 'The date and time at which clinical responsibility was formally handed off from this care team member to another provider. Supports transitions of care documentation, Joint Commission handoff communication standards, and care continuity analytics.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this care team member record is currently active and valid. Distinct from member_status in that this flag supports soft-delete and record lifecycle management at the data platform level, while member_status reflects the clinical workflow state.',
    `is_attending` BOOLEAN COMMENT 'Indicates whether this care team member holds the attending physician designation for the encounter or care episode. The attending physician bears primary clinical and legal responsibility for the patients care. Critical for billing, documentation, and regulatory reporting.',
    `is_on_call` BOOLEAN COMMENT 'Indicates whether this care team member is currently designated as on-call for the patient. Supports after-hours care coordination and urgent clinical communication routing.',
    `is_pcp` BOOLEAN COMMENT 'Indicates whether this care team member is the patients designated Primary Care Physician (PCP). Used in population health management, care coordination, and payer attribution workflows.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this care team member is designated as the primary point of contact for the patient and/or family. Only one member per care team should have this flag set to true at any given time. Used in patient communication workflows and care coordination.',
    `member_status` STRING COMMENT 'Current participation status of this care team member. active indicates the member is currently responsible for the patients care; inactive or removed indicates the member has been discharged from the team. Drives care coordination queries and transitions of care documentation.. Valid values are `active|inactive|pending|suspended|removed`',
    `member_type` STRING COMMENT 'Broad classification of the care team members professional discipline or role category (e.g., physician, nurse practitioner, pharmacist, social worker). Drives care coordination workflows and transitions of care documentation. [ENUM-REF-CANDIDATE: physician|nurse_practitioner|physician_assistant|registered_nurse|pharmacist|social_worker|care_coordinator|other — promote to reference product]',
    `mrn` STRING COMMENT 'The mrn of the clinical care team member record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical care team member record.',
    `notes` STRING COMMENT 'Free-text notes or comments associated with this care team members assignment, such as specific responsibilities, coverage instructions, or care coordination context. Used by clinical staff for care team management.',
    `notification_preference` STRING COMMENT 'The preferred communication channel for notifying this care team member of patient updates, critical results, or care coordination messages (e.g., secure message, pager, phone, Epic In Basket). Drives clinical communication routing.. Valid values are `secure_message|pager|phone|email|in_basket`',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) assigned to this care team member by CMS. Used for billing, claims submission, and provider identity verification. Denormalized here for operational convenience in care team queries without requiring a provider join.. Valid values are `^[0-9]{10}$`',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical care team member record.',
    `relationship_to_patient` STRING COMMENT 'Describes the clinical or care relationship between this provider and the patient (e.g., Treating Physician, Consulting Specialist, Case Manager, Discharge Planner). Used in care coordination documentation and transitions of care workflows.',
    `removal_reason` STRING COMMENT 'The reason this care team member was removed or deactivated from the care team (e.g., patient discharge, transfer, provider request, coverage end, credentialing issue). Used for care team audit trails and transitions of care documentation. [ENUM-REF-CANDIDATE: discharge|transfer|provider_request|patient_request|coverage_end|credentialing|other — 7 candidates stripped; promote to reference product]',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical care team member record.',
    `role_code` STRING COMMENT 'Standardized code representing the specific functional role of this member within the care team (e.g., attending physician, consulting physician, primary nurse, case manager). Sourced from Epic or Cerner role code tables and aligned with HL7 FHIR CareTeam participant role codes.',
    `role_name` STRING COMMENT 'Human-readable display name for the care team members role (e.g., Attending Physician, Primary Care Nurse, Clinical Pharmacist, Discharge Planner). Used in clinical documentation and care coordination interfaces.',
    `sequence_number` STRING COMMENT 'Ordinal sequence number indicating the display order or priority ranking of this member within the care team. Used for care team list rendering in EHR interfaces and for determining primary vs. secondary member ordering.',
    `severity` STRING COMMENT 'The severity of the clinical care team member record.',
    `snomed_role_code` STRING COMMENT 'The SNOMED CT concept code representing the clinical role of this care team member. Enables semantic interoperability with FHIR-compliant systems and clinical decision support engines.',
    `source_record_reference` BIGINT COMMENT 'The source record reference of the clinical care team member record.',
    `source_system_member_code` STRING COMMENT 'The native identifier for this care team member record in the originating operational system (Epic ClinDoc, Cerner PowerChart, etc.). Used for data lineage, cross-system reconciliation, and ETL traceability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this care team member record was last modified in the source system. Used for change tracking, data lineage, and incremental ETL processing.',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical care team member record.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to indicate mutation applied.',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_care_team_member PRIMARY KEY(`care_team_member_id`)
) COMMENT 'Individual provider membership records within a care team, capturing the specific role, period of responsibility, and participation status of each clinician. Includes member type (physician, NP, PA, RN, social worker, pharmacist, care coordinator), role code, on-call flag, primary contact flag, and assignment dates. Enables care coordination queries and transitions of care documentation. Sourced from Epic and Cerner.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` (
    `advance_directive_id` BIGINT COMMENT 'Unique surrogate identifier for the advance directive record in the lakehouse silver layer. Primary key for this entity.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Advance directives are closely integrated with care plans — care_plan has an advance_directive_on_file flag indicating this relationship. Linking advance_directive to care_plan via care_plan_id enable',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider who documented or verified the advance directive in the Electronic Health Record (EHR). Supports audit and accountability requirements.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this advance directive was documented. Links to the patient master record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the clinical advance directive record.',
    `emergency_contact_id` BIGINT COMMENT 'Foreign key linking to patient.emergency_contact. Business justification: The healthcare proxy named in an advance directive is operationally the same person as the emergency contact. Normalizing this via FK eliminates denormalized proxy_name/proxy_relationship/proxy_phone ',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: CMS Conditions of Participation (42 CFR §489.102) require hospitals to document advance directive status at each registration/admission. Linking advance_directive to registration_event enables complia',
    `superseded_by_directive_advance_directive_id` BIGINT COMMENT 'Reference to the newer advance directive record that supersedes this one. Null if this directive has not been superseded. Enables directive version chain tracking and ensures the most current directive is applied in care decisions.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the advance directive was documented or verified. May be null if documented outside an encounter context.',
    `advance_directive_status` STRING COMMENT 'The advance directive status value classifying the clinical advance directive record.',
    `artificially_administered_nutrition` STRING COMMENT 'Patients documented preference regarding artificially administered nutrition and hydration (e.g., feeding tubes, IV fluids) as specified in the advance directive or POLST/MOLST. Critical for end-of-life care planning.. Valid values are `Accept|Decline|Trial Period|No Preference Stated`',
    `behavioral_health_protected_flag` BOOLEAN COMMENT 'The behavioral health protected flag of the clinical advance directive record.',
    `capacity_assessment_result` STRING COMMENT 'The result of the formal patient decision-making capacity assessment conducted at the time of advance directive documentation. Determines whether the patient could legally execute or modify the directive.. Valid values are `Has Capacity|Lacks Capacity|Capacity Uncertain`',
    `care_setting` STRING COMMENT 'The care setting of the clinical advance directive record.',
    `clinical_ai_integration_marker` STRING COMMENT 'Marker added to satisfy clinical AI integration requirement',
    `clinical_ai_note` STRING COMMENT 'The clinical ai note of the clinical advance directive record.',
    `clinical_notes` STRING COMMENT 'Free-text clinical notes or additional instructions documented by the provider regarding the patients advance directive, including nuances, patient-expressed wishes, or contextual information not captured in structured fields.',
    `clinical_status` STRING COMMENT 'The clinical status value classifying the clinical advance directive record.',
    `code_status` STRING COMMENT 'The patients current resuscitation code status as documented in the advance directive. Full Code = all resuscitative measures; DNR = Do Not Resuscitate; DNR/DNI = Do Not Resuscitate / Do Not Intubate; Comfort Care = palliative measures only; Limited Interventions = selective resuscitative measures as specified.. Valid values are `Full Code|DNR|DNR/DNI|Comfort Care|Limited Interventions`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this advance directive record was first created in the lakehouse data platform. Supports data lineage, audit trail, and regulatory compliance reporting.',
    `digital_health_relevant_flag` BOOLEAN COMMENT 'Whether this record is relevant to digital health/RPM/telehealth workflows',
    `directive_status` STRING COMMENT 'Current lifecycle status of the advance directive document. Active = currently in force; Revoked = patient has withdrawn the directive; Superseded = replaced by a newer directive; Expired = past the expiration date; Pending Verification = documented but not yet clinically verified.. Valid values are `active|revoked|superseded|expired|pending_verification`',
    `directive_type` STRING COMMENT 'Classification of the advance directive document type. DNR = Do Not Resuscitate; POLST = Physician Orders for Life-Sustaining Treatment; MOLST = Medical Orders for Life-Sustaining Treatment; Living Will = written legal document; Healthcare Power of Attorney = proxy designation; Comfort Care Order = palliative/comfort-focused care order.. Valid values are `DNR|POLST|MOLST|Living Will|Healthcare Power of Attorney|Comfort Care Order`',
    `document_location` STRING COMMENT 'Indicates where the physical or electronic copy of the advance directive document is stored or held. Supports retrieval during care transitions and emergency situations.. Valid values are `EHR Scanned|Patient Holds Original|Family Holds Copy|Registry|Attorney on File`',
    `documented_timestamp` TIMESTAMP COMMENT 'The date and time when the advance directive was first entered or documented in the Electronic Health Record (EHR). Serves as the BUSINESS_EVENT_TIMESTAMP for this records creation in the clinical system.',
    `effective_date` DATE COMMENT 'The date on which the advance directive becomes legally and clinically effective. Used to determine whether the directive is currently binding for care decisions.',
    `ethics_consult_requested` BOOLEAN COMMENT 'Indicates whether an ethics committee consultation was requested in connection with this advance directive. Supports quality reporting, compliance tracking, and clinical ethics workflows.',
    `expiration_date` DATE COMMENT 'The date on which the advance directive expires and is no longer legally or clinically binding. Null if the directive has no defined expiration (open-ended). Supports automated status transitions to expired.',
    `fhir_consent_reference` STRING COMMENT 'The FHIR Consent resource identifier corresponding to this advance directive, enabling interoperability with Health Information Exchange (HIE) platforms and FHIR-compliant systems.',
    `hospice_election_linked_flag` BOOLEAN COMMENT 'Indicates whether this advance directive is linked to a hospice election',
    `hospice_enrolled` BOOLEAN COMMENT 'Indicates whether the patient is currently enrolled in a hospice program at the time of advance directive documentation. Relevant for care plan alignment and CMS hospice benefit compliance.',
    `hospitalization_preference` STRING COMMENT 'Patients documented preference regarding hospitalization and transfer to acute care settings as specified in the POLST/MOLST. Guides care transitions and Emergency Department (ED) triage decisions.. Valid values are `Accept Hospitalization|Avoid Hospitalization|Comfort Care Only|No Preference Stated`',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a language interpreter was used during the advance directive discussion and documentation process. Supports compliance with Title VI of the Civil Rights Act and CMS language access requirements.',
    `life_sustaining_treatment_preference` STRING COMMENT 'Patients documented preference regarding life-sustaining treatment as captured in the POLST/MOLST or living will. Full Treatment = all medically appropriate interventions; Selective Treatment = specific interventions as detailed; Comfort Measures Only = palliative and comfort-focused care only. Core clinical decision support field.. Valid values are `Full Treatment|Selective Treatment|Comfort Measures Only`',
    `mechanical_ventilation_preference` STRING COMMENT 'Patients documented preference regarding mechanical ventilation and intubation as specified in the advance directive or POLST/MOLST. Directly informs DNR/DNI code status decisions.. Valid values are `Accept|Decline|Trial Period|No Preference Stated`',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient in the source Electronic Health Record (EHR) system. Supports cross-system patient matching via the Master Patient Index (MPI).',
    `mutator_applied_flag` BOOLEAN COMMENT 'The mutator applied flag of the clinical advance directive record.',
    `notarized` BOOLEAN COMMENT 'Indicates whether the advance directive document has been notarized. Some state jurisdictions require notarization for legal validity of living wills and healthcare power of attorney designations.',
    `onset_date` DATE COMMENT 'Timestamp capturing the onset date associated with the clinical advance directive record.',
    `organ_donation_preference` STRING COMMENT 'The organ donation preference of the clinical advance directive record.',
    `organ_donation_status` STRING COMMENT 'Patients documented preference or registered status regarding organ and tissue donation as captured in the advance directive or linked registry. Supports organ procurement coordination and UNOS compliance.. Valid values are `Donor|Non-Donor|Donor with Restrictions|Unknown`',
    `palliative_care_referral` BOOLEAN COMMENT 'Indicates whether a palliative care referral was initiated in conjunction with the advance directive documentation. Supports care coordination, population health management, and quality measure reporting.',
    `patient_capacity_assessed` BOOLEAN COMMENT 'Indicates whether the patients decision-making capacity was formally assessed at the time the advance directive was documented or verified. Relevant for legal validity and ethical compliance.',
    `patient_education_provided` BOOLEAN COMMENT 'Indicates whether the patient received education about advance directives and their rights under the Patient Self-Determination Act (PSDA) prior to or at the time of directive documentation.',
    `preferred_language` STRING COMMENT 'The patients preferred language for advance directive discussions and documentation, expressed as an ISO 639-1 or BCP-47 language code (e.g., en, es, zh-CN). Supports language access compliance and care equity reporting.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `resolution_date` DATE COMMENT 'Timestamp capturing the resolution date associated with the clinical advance directive record.',
    `resuscitation_preference` STRING COMMENT 'The resuscitation preference of the clinical advance directive record.',
    `review_date` DATE COMMENT 'Timestamp capturing the review date associated with the clinical advance directive record.',
    `revocation_timestamp` TIMESTAMP COMMENT 'The date and time when the patient formally revoked the advance directive. Null if the directive has not been revoked. Triggers status transition to revoked and inactivates the directive for care decisions.',
    `scanned_document_url` STRING COMMENT 'Secure URL or document management system path to the scanned or electronic copy of the advance directive document stored in the document management system or EHR. Supports retrieval for clinical review and legal reference.',
    `severity` STRING COMMENT 'The severity of the clinical advance directive record.',
    `source_record_reference` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Advance directives are a specialized form of consent for end-of-life care decisions. Linking to the general consent framework ensures comprehensive consent tracking, supports POLST/MOLST workflows, an',
    `source_system_directive_code` STRING COMMENT 'The native identifier of the advance directive record in the originating operational system (e.g., Epic advance care planning record ID). Supports bidirectional traceability between the lakehouse and the source Electronic Health Record (EHR).',
    `state_of_execution` STRING COMMENT 'The U.S. state (two-letter USPS abbreviation) in which the advance directive was legally executed. Determines which state-specific legal requirements and forms apply to the directives validity.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this advance directive record was last modified in the lakehouse data platform. Supports change tracking, audit trail, and data quality monitoring.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity and currency of the advance directive. Original Document = physical original reviewed; Scanned Copy = digitized copy on file; Verbal Confirmation = patient verbally confirmed; Electronic Record = verified via Health Information Exchange (HIE); Notarized Copy = legally notarized document reviewed.. Valid values are `Original Document|Scanned Copy|Verbal Confirmation|Electronic Record|Notarized Copy`',
    `verification_status` STRING COMMENT 'The verification status value classifying the clinical advance directive record.',
    `verified_timestamp` TIMESTAMP COMMENT 'The date and time when the advance directive was clinically verified by a qualified provider. Verification confirms the document is current, authentic, and reflects the patients current wishes.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag of the clinical advance directive record.',
    `vibe_ai_marker` STRING COMMENT 'Marker added by VIBE AI mutation',
    `vibe_batch_marker` STRING COMMENT 'Marker added by clinical domain batch mutator',
    `vibe_mutation_added` STRING COMMENT 'The vibe mutation added of the clinical advance directive record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the clinical advance directive record.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutation to ensure change',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `witness_name` STRING COMMENT 'Full name of the witness who attested to the patients execution of the advance directive document. Required by many state laws to validate the legal standing of the directive.',
    CONSTRAINT pk_advance_directive PRIMARY KEY(`advance_directive_id`)
) COMMENT 'Patient advance directive and end-of-life care preference documentation including DNR (Do Not Resuscitate) orders, POLST/MOLST (Physician/Medical Orders for Life-Sustaining Treatment), living wills, healthcare power of attorney designations, and code status (Full Code, DNR, DNR/DNI, Comfort Care). Captures directive type, effective date, expiration date, document status (active, revoked, superseded), healthcare proxy name and contact information, verification method, and the provider who documented or verified the directive. Critical for end-of-life care decisions, EMTALA compliance, and patient rights under the Patient Self-Determination Act. Sourced from Epic advance care planning module.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_parent_note_id` FOREIGN KEY (`parent_note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_previous_vital_sign_id` FOREIGN KEY (`previous_vital_sign_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`vital_sign`(`vital_sign_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_superseded_by_directive_advance_directive_id` FOREIGN KEY (`superseded_by_directive_advance_directive_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`advance_directive`(`advance_directive_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`clinical` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`clinical` SET TAGS ('dbx_domain' = 'clinical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Admitting Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_added_flag` SET TAGS ('dbx_sensitivity' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_added_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_added_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_added_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_added_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_added_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_added_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_added_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_domain_code` SET TAGS ('dbx_sensitivity' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_domain_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_domain_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_domain_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_domain_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_domain_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_domain_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_domain_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_sensitivity' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_integration_marker` SET TAGS ('dbx_sensitivity' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_value_regex' = 'pending|agreed|disagreed|no_response|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_sensitivity' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_value_regex' = 'active|resolved|inactive|recurrence|remission|unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_date` SET TAGS ('dbx_business_glossary_term' = 'Coding Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_value_regex' = 'unreviewed|coded|queried|finalized|amended');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `complication_comorbidity_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication or Comorbidity (CC/MCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Recorded Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_value_regex' = 'principal|secondary|admitting|discharge|working|chronic_problem_list');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Discharge Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `drg_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relevant Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Entry Source');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_business_glossary_term' = 'External Cause of Injury (ICD-10-CM) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_value_regex' = '^[VWX][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$|^Y[0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `genomics_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Genomics Relevant Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `genomics_relevant_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `genomics_relevant_flag` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `hac_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospital-Acquired Condition (HAC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_business_glossary_term' = 'ICD-10-CM Fiscal Year Version');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_value_regex' = '^FY[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mcc_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Complication or Comorbidity (MCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_tag' = 'pii_pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `note_text` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `note_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `pharmacogenomics_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacogenomics Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `pharmacogenomics_impact_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `pharmacogenomics_impact_flag` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `present_on_admission` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `present_on_admission` SET TAGS ('dbx_value_regex' = 'Y|N|U|W|1');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Problem List Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_sensitivity' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Rank');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_unity_catalog_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_pii_classification' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Recorded Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_pii_classification' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|critical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Diagnosis ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_uc_tag' = 'pii_phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'confirmed|provisional|differential|refuted|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `vibe_structure_marker` SET TAGS ('dbx_vibe_structure' = 'applied');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_value_regex' = 'general|regional|local|monitored_anesthesia_care|none');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `approach` SET TAGS ('dbx_business_glossary_term' = 'Surgical Approach');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `approach` SET TAGS ('dbx_value_regex' = 'open|laparoscopic|robotic|endoscopic|percutaneous|transcatheter');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `asa_classification` SET TAGS ('dbx_business_glossary_term' = 'American Society of Anesthesiologists (ASA) Physical Status Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `asa_classification` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|VI');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Procedure Body Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Procedure Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_business_glossary_term' = 'Estimated Blood Loss (EBL) in Milliliters');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `genomic_test_flag` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision Procedure Coding System (ICD-10-PCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Procedure Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Procedure Priority');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|stat');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_business_glossary_term' = 'Procedure Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_value_regex' = 'surgical|diagnostic|therapeutic|preventive|rehabilitative|palliative');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Procedure End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Procedure Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_value_regex' = 'performed|in-progress|cancelled|not-done|on-hold|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) — Work Component');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Procedure Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Clinical Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `snomed_ct_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `snomed_ct_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collected Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `timeout_performed` SET TAGS ('dbx_business_glossary_term' = 'Surgical Time-Out Performed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `vibe_structure_marker` SET TAGS ('dbx_vibe_structure' = 'applied');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `wound_classification` SET TAGS ('dbx_business_glossary_term' = 'Surgical Wound Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `wound_classification` SET TAGS ('dbx_value_regex' = 'clean|clean_contaminated|contaminated|dirty_infected');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `parent_note_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Note ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `primary_note_attending_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `tertiary_note_cosigner_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Co-signer Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `amended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Amended Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `author_role` SET TAGS ('dbx_business_glossary_term' = 'Note Author Role');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `authored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Authored Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_note_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_note_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_note_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_note_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_note_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_note_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_note_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|ambulatory_surgery|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_value_regex' = 'pending|answered|withdrawn|no_query');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Note Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'normal|restricted|very_restricted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cosigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Co-signed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `dictation_method` SET TAGS ('dbx_business_glossary_term' = 'Note Dictation Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `dictation_method` SET TAGS ('dbx_value_regex' = 'typed|voice_dictation|speech_recognition|scribe|imported');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `drg_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `encounter_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|telehealth|surgical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Format');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'free_text|structured|semi_structured|template_based');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_addendum` SET TAGS ('dbx_business_glossary_term' = 'Is Addendum Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_copy_forwarded` SET TAGS ('dbx_business_glossary_term' = 'Is Copy-Forward Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `is_late_entry` SET TAGS ('dbx_business_glossary_term' = 'Is Late Entry Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_value_regex' = 'draft|signed|amended|addended|retracted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_value_regex' = 'History and Physical|Progress Note|Discharge Summary|Operative Note|Consult Note|Nursing Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `precision_medicine_flag` SET TAGS ('dbx_business_glossary_term' = 'Precision Medicine Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `sensitive_note_type` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Note Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `sensitive_note_type` SET TAGS ('dbx_value_regex' = 'behavioral_health|substance_abuse|hiv_aids|sexual_health|domestic_violence|none');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `signed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Signed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `source_system_note_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Note ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Text (Protected Health Information)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Note Version Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `vibe_structure_marker` SET TAGS ('dbx_vibe_structure' = 'applied');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Note Word Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('dbx_subdomain' = 'patient_registry');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Added By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `tertiary_problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `tertiary_problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `tertiary_problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `tertiary_problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `tertiary_problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `tertiary_problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `tertiary_problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `tertiary_problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `body_site_code` SET TAGS ('dbx_business_glossary_term' = 'Body Site Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `body_site_description` SET TAGS ('dbx_business_glossary_term' = 'Body Site Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|ambulatory|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_value_regex' = 'pending|answered|withdrawn|no-query');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Problem Comment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `comment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `comment` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Problem Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_business_glossary_term' = 'HL7 FHIR Condition Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `genetic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `genetic_condition_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `genetic_condition_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `genetic_condition_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `genetic_condition_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `genetic_condition_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `genetic_condition_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `genetic_condition_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `hcc_category_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Is Encounter Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `list_display_order` SET TAGS ('dbx_business_glossary_term' = 'Problem List Display Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `noted_date` SET TAGS ('dbx_business_glossary_term' = 'Problem Noted Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_age_years` SET TAGS ('dbx_business_glossary_term' = 'Onset Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_age_years` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_age_years` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Problem Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_business_glossary_term' = 'Principal Problem Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Problem Priority');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low|routine');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_business_glossary_term' = 'Problem Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_value_regex' = 'active|inactive|resolved|deleted|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_business_glossary_term' = 'Problem Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_value_regex' = 'chronic|acute|historical|social|surgical|psychiatric');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Problem Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `resolution_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `resolution_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Problem Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Problem ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_code` SET TAGS ('dbx_business_glossary_term' = 'Problem Stage Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Stage Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Problem Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `title` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `title` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'confirmed|unconfirmed|provisional|differential|refuted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `vibe_structure_marker` SET TAGS ('dbx_vibe_structure' = 'applied');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('dbx_subdomain' = 'patient_registry');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_business_glossary_term' = 'Allergy Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmatory Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `primary_allergy_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Documenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `primary_allergy_clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `primary_allergy_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `primary_allergy_clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `primary_allergy_clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `primary_allergy_clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `primary_allergy_clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `primary_allergy_clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `alert_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Allergy Alert Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_business_glossary_term' = 'Allergen Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|ambulatory|telehealth|other');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_business_glossary_term' = 'Allergy Category Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_value_regex' = 'allergy|intolerance|side_effect');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_business_glossary_term' = 'Allergy Clinical Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_value_regex' = 'active|inactive|resolved');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Allergy Criticality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `criticality` SET TAGS ('dbx_value_regex' = 'low|high|unable_to_assess');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Deletion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'HL7 FHIR Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `information_source` SET TAGS ('dbx_business_glossary_term' = 'Allergy Information Source');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `information_source` SET TAGS ('dbx_value_regex' = 'patient|caregiver|provider|medical_record|pharmacy|other');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_business_glossary_term' = 'No Known Allergy (NKA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_business_glossary_term' = 'No Known Drug Allergy (NKDA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allergy Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `ndf_rt_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug File Reference Terminology (NDF-RT) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Allergy Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `note` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Allergy Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `onset_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `onset_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Override Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `pharmacogenomic_basis_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacogenomic Basis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `phi_access_restricted` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Access Restricted Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reaction_description` SET TAGS ('dbx_business_glossary_term' = 'Reaction Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reaction_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reaction_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reaction_route` SET TAGS ('dbx_business_glossary_term' = 'Reaction Exposure Route');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reaction_snomed_code` SET TAGS ('dbx_business_glossary_term' = 'Reaction SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reaction_snomed_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Allergy Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Allergy Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|not_reconciled|pending');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `recorded_date` SET TAGS ('dbx_business_glossary_term' = 'Allergy Recorded Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Reaction Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life_threatening');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Allergy ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Allergy Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'confirmed|unconfirmed|refuted|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `vibe_structure_marker` SET TAGS ('dbx_vibe_structure' = 'applied');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('dbx_subdomain' = 'patient_registry');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_business_glossary_term' = 'Immunization ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Immunization Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `primary_care_physician_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_route_code` SET TAGS ('dbx_business_glossary_term' = 'Administration Route Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_route_code` SET TAGS ('dbx_value_regex' = 'IM|SC|ID|PO|IN|IV');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_site_code` SET TAGS ('dbx_business_glossary_term' = 'Administration Site Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_status` SET TAGS ('dbx_business_glossary_term' = 'Immunization Administration Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_status` SET TAGS ('dbx_value_regex' = 'completed|entered-in-error|not-done');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Immunization Administration Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_business_glossary_term' = 'Immunization Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Immunization Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_business_glossary_term' = 'Dose Number in Series');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Dose Quantity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Dose Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_value_regex' = 'mL|mg|mcg|units');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Funding Source Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_value_regex' = 'VFC|317|STATE|PRIVATE|OTHER');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `iis_reported` SET TAGS ('dbx_business_glossary_term' = 'Immunization Information System (IIS) Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `iis_reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Immunization Information System (IIS) Reported Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `not_given_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Immunization Not Given Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `precision_medicine_consideration` SET TAGS ('dbx_business_glossary_term' = 'Precision Medicine Consideration');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `reaction_detail` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Detail');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `reaction_observed` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Observed Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Immunization Series Completion Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_completion_status` SET TAGS ('dbx_value_regex' = 'complete|in-progress|not-started|overdue');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_business_glossary_term' = 'Series Total Doses Required');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_business_glossary_term' = 'Immunization Series Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vaers_reported` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Adverse Event Reporting System (VAERS) Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vfc_eligibility_code` SET TAGS ('dbx_business_glossary_term' = 'Vaccines for Children (VFC) Eligibility Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vfc_eligibility_code` SET TAGS ('dbx_value_regex' = 'V01|V02|V03|V04|V05|V06');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vis_document_type` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Information Statement (VIS) Document Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vis_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Information Statement (VIS) Presentation Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vis_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Information Statement (VIS) Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('dbx_subdomain' = 'patient_registry');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Vital Sign Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `abnormal_flag` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Abnormal Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `amended_reason` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Body Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_unit` SET TAGS ('dbx_business_glossary_term' = 'Care Unit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `documented_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Documentation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `ews_score_contribution` SET TAGS ('dbx_business_glossary_term' = 'Early Warning Score (EWS) Component Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `ews_score_type` SET TAGS ('dbx_business_glossary_term' = 'Early Warning Score (EWS) Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `ews_score_type` SET TAGS ('dbx_value_regex' = 'NEWS2|MEWS|EWS|PEWS|custom');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `flowsheet_row_code` SET TAGS ('dbx_business_glossary_term' = 'EHR Flowsheet Row Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `gcs_component` SET TAGS ('dbx_business_glossary_term' = 'Glasgow Coma Scale (GCS) Component');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `gcs_component` SET TAGS ('dbx_value_regex' = 'eye_opening|verbal_response|motor_response|total');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `is_patient_reported` SET TAGS ('dbx_business_glossary_term' = 'Patient Reported Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `is_telemetry_derived` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Derived Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Measurement Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Measurement Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `numeric_value` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Numeric Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `numeric_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `numeric_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Observation Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Observation Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `oxygen_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `oxygen_delivery_method` SET TAGS ('dbx_value_regex' = 'room_air|nasal_cannula|simple_mask|non_rebreather|high_flow_nasal|mechanical_ventilator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Pain Assessment Scale Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_value_regex' = 'numeric_rating|visual_analog|faces|flacc|cpot|behavioral');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `patient_position` SET TAGS ('dbx_business_glossary_term' = 'Patient Position During Measurement');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `reference_range_high` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Reference Range High');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `reference_range_low` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Reference Range Low');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `rpm_device_source_flag` SET TAGS ('dbx_business_glossary_term' = 'RPM Device Source Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `snomed_finding_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Finding Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `snomed_finding_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `supplemental_oxygen_flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Oxygen Flow Rate (L/min)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `text_value` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Text Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `text_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `text_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Observation ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Observation Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `ai_derived_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Derived Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `assessment_component` SET TAGS ('dbx_business_glossary_term' = 'Assessment Component Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `assessment_tool` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assessment Tool');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `body_site_code` SET TAGS ('dbx_business_glossary_term' = 'Body Site SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `body_system` SET TAGS ('dbx_business_glossary_term' = 'Body System');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_business_glossary_term' = 'Observation Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `critical_value_notified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `data_absent_reason` SET TAGS ('dbx_business_glossary_term' = 'Data Absent Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Observation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Observation Device Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_business_glossary_term' = 'External Observation ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `interpretation_flag` SET TAGS ('dbx_business_glossary_term' = 'Observation Interpretation Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Observation Amended Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `is_critical_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `issued_datetime` SET TAGS ('dbx_business_glossary_term' = 'Observation Issued Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|midline|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `local_code` SET TAGS ('dbx_business_glossary_term' = 'Local Observation Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `method_code` SET TAGS ('dbx_business_glossary_term' = 'Observation Method SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `presence_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Finding Presence Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `presence_status` SET TAGS ('dbx_value_regex' = 'present|absent|unknown|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `reference_range_high` SET TAGS ('dbx_business_glossary_term' = 'Reference Range High Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `reference_range_low` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Low Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `sdoh_domain` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Domain');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Clinical Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life-threatening|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Observation Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `value_coded` SET TAGS ('dbx_business_glossary_term' = 'Coded Observation Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `value_coded_system` SET TAGS ('dbx_business_glossary_term' = 'Coded Observation Value Coding System');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `value_coded_system` SET TAGS ('dbx_value_regex' = 'SNOMED-CT|LOINC|ICD-10|CPT|LOCAL');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Numeric Observation Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `value_text` SET TAGS ('dbx_business_glossary_term' = 'Free-Text Observation Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `value_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `value_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `value_unit` SET TAGS ('dbx_business_glossary_term' = 'Observation Value Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Activated Order Set Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `network_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `tertiary_care_pcp_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `aco_attributed` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Attributed Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `advance_directive_on_file` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive on File Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `authored_date` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Authored Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_episode_link` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_episode_link` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_episode_link` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_episode_link` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_episode_link` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_episode_link` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_episode_link` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Health Care Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_gap_count` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `cdi_review_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Review Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `cdi_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed|not_required');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'normal|restricted|very_restricted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `external_plan_code` SET TAGS ('dbx_business_glossary_term' = 'External Care Plan Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'HL7 FHIR Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9-.]{1,64}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `goal_count` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Goal Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `goals_achieved_count` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Goals Achieved Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `intent` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Intent');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `intent` SET TAGS ('dbx_value_regex' = 'proposal|plan|order|option');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Care Plan Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Care Plan Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|on-hold|completed|revoked|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_business_glossary_term' = 'Population Health Program Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `precision_medicine_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Precision Medicine Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `readmission_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `readmission_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Review Frequency');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `transitions_of_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Transitions of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Version Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `aco_attributed` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Attribution Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_coordination_level` SET TAGS ('dbx_business_glossary_term' = 'Care Coordination Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_coordination_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|complex|intensive');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `cdi_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `coverage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `coverage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `ehr_care_team_csn` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Care Team Contact Serial Number (CSN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `genomics_specialist_included` SET TAGS ('dbx_business_glossary_term' = 'Genomics Specialist Included');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `hie_shared` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Shared Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_multidisciplinary` SET TAGS ('dbx_business_glossary_term' = 'Multidisciplinary Team Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_on_call` SET TAGS ('dbx_business_glossary_term' = 'On-Call Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_primary_team` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Team Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Participation End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_code` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Role Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Role Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Participation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_status` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|removed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Care Team Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Care Team Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `source_system_team_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Care Team Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Care Team Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|proposed|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|primary|specialty|multidisciplinary|transitional');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `transitions_of_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Transitions of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `vbp_program_code` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Purchasing (VBP) Program Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Assignment End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Assignment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|consulting|covering|co-managing|observing');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_category` SET TAGS ('dbx_business_glossary_term' = 'Care Team Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_category` SET TAGS ('dbx_value_regex' = 'longitudinal|episode|event|condition');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_business_glossary_term' = 'Clinical Focus');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'scheduled|cross_coverage|locum|temporary|permanent');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `genetic_counselor_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetic Counselor Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `genetic_counselor_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `genetic_counselor_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `genetic_counselor_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `genetic_counselor_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `genetic_counselor_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `genetic_counselor_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `genetic_counselor_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `handoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Care Handoff Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_attending` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_on_call` SET TAGS ('dbx_business_glossary_term' = 'On-Call Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_pcp` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_status` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|removed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'secure_message|pager|phone|email|in_basket');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `relationship_to_patient` SET TAGS ('dbx_business_glossary_term' = 'Provider Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Removal Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Care Team Role Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Care Team Role Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `snomed_role_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Role Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Care Team Member ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `advance_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Documenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `emergency_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Proxy Emergency Contact Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `superseded_by_directive_advance_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Directive ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `artificially_administered_nutrition` SET TAGS ('dbx_business_glossary_term' = 'Artificially Administered Nutrition Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `artificially_administered_nutrition` SET TAGS ('dbx_value_regex' = 'Accept|Decline|Trial Period|No Preference Stated');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `behavioral_health_protected_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Patient Decision-Making Capacity Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_value_regex' = 'Has Capacity|Lacks Capacity|Capacity Uncertain');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_integration_marker` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_note` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_note` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_note` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_note` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_ai_note` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive Clinical Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `code_status` SET TAGS ('dbx_business_glossary_term' = 'Code Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `code_status` SET TAGS ('dbx_value_regex' = 'Full Code|DNR|DNR/DNI|Comfort Care|Limited Interventions');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `digital_health_relevant_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `directive_status` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `directive_status` SET TAGS ('dbx_value_regex' = 'active|revoked|superseded|expired|pending_verification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `directive_type` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `directive_type` SET TAGS ('dbx_value_regex' = 'DNR|POLST|MOLST|Living Will|Healthcare Power of Attorney|Comfort Care Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Directive Document Location');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `document_location` SET TAGS ('dbx_value_regex' = 'EHR Scanned|Patient Holds Original|Family Holds Copy|Registry|Attorney on File');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `documented_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Directive Documented Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Directive Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `ethics_consult_requested` SET TAGS ('dbx_business_glossary_term' = 'Ethics Consultation Requested Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Directive Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `fhir_consent_reference` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Consent Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `hospice_election_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospice Election Linked');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `hospice_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Hospice Enrollment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `hospitalization_preference` SET TAGS ('dbx_business_glossary_term' = 'Hospitalization Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `hospitalization_preference` SET TAGS ('dbx_value_regex' = 'Accept Hospitalization|Avoid Hospitalization|Comfort Care Only|No Preference Stated');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_business_glossary_term' = 'Life-Sustaining Treatment Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_value_regex' = 'Full Treatment|Selective Treatment|Comfort Measures Only');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mechanical_ventilation_preference` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Ventilation Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mechanical_ventilation_preference` SET TAGS ('dbx_value_regex' = 'Accept|Decline|Trial Period|No Preference Stated');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `notarized` SET TAGS ('dbx_business_glossary_term' = 'Directive Notarized Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `organ_donation_status` SET TAGS ('dbx_business_glossary_term' = 'Organ Donation Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `organ_donation_status` SET TAGS ('dbx_value_regex' = 'Donor|Non-Donor|Donor with Restrictions|Unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `palliative_care_referral` SET TAGS ('dbx_business_glossary_term' = 'Palliative Care Referral Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_business_glossary_term' = 'Patient Decision-Making Capacity Assessed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_education_provided` SET TAGS ('dbx_business_glossary_term' = 'Patient Education Provided Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Patient Preferred Language');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Directive Revocation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `scanned_document_url` SET TAGS ('dbx_business_glossary_term' = 'Scanned Directive Document URL');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `scanned_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `source_system_directive_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Directive ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_business_glossary_term' = 'State of Directive Execution');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Directive Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'Original Document|Scanned Copy|Verbal Confirmation|Electronic Record|Notarized Copy');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Directive Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `vibe_batch_marker` SET TAGS ('dbx_batch' = 'clinical_domain_creation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('dbx_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Directive Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_mask_non_prod' = 'true');
