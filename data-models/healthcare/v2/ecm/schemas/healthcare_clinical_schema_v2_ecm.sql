-- Schema for Domain: clinical | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`clinical` COMMENT 'Comprehensive clinical documentation and care delivery data. Owns diagnoses (ICD-10), procedures (CPT, HCPCS), clinical notes, problem lists, allergies, immunizations, vital signs, care plans, assessments, nursing documentation, clinical observations (LOINC-coded), SNOMED CT-coded clinical findings, and CDI (Clinical Documentation Improvement) workflows. Core EHR/EMR operational data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` (
    `diagnosis_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical diagnosis record in the system. Primary key for the clinical_diagnosis data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where this diagnosis was documented. Supports multi-facility enterprise reporting, facility-level quality benchmarking, and regulatory submissions.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Diagnoses drive clinical order placement in real workflows. Clinician diagnoses pneumonia, orders chest X-ray and antibiotics. Essential for order appropriateness review, clinical decision support val',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed clinician (physician, NP, PA) who documented or confirmed this diagnosis. Used for provider attribution, quality reporting, and CDI workflows.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this diagnosis was documented. Links to the patient master record in the Master Patient Index (MPI).',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Diagnoses drive formulary decisions and contraindication checking in clinical decision support systems. Medication appropriateness reviews require diagnosis-to-drug validation for patient safety and q',
    `employee_id` BIGINT COMMENT 'Reference to the HIM coder or CDI specialist who assigned or finalized the ICD-10-CM code for this diagnosis. Supports coder productivity reporting, quality audits, and RAC audit defense.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Diagnosis coding validation, DRG grouping, quality measure reporting, and CMS submission require authoritative ICD-10 code reference. Clinical coders validate diagnosis codes against reference tables ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Diagnoses drive formulary decisions, clinical pathway supply protocols, and diagnosis-specific supply ordering (e.g., diabetes → glucose monitors). Enables diagnosis-driven supply chain analytics and ',
    `mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - diagnosis links to demographics but not mpi_record; MPI is the SSOT for patient identity',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Diagnosis coding drives claims adjudication, medical necessity determination, and prior authorization. Revenue cycle operations require payer context for each diagnosis to apply correct coding rules, ',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Quality measures frequently target diagnosis-specific cohorts (diabetes HbA1c control, heart failure readmission). Measure calculation engines filter eligible populations by diagnosis codes. Essential',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Sensitive diagnoses (HIV, genetic conditions, behavioral health) require documented informed consent. Regulatory workflows (42 CFR Part 2, state mental health laws) mandate linking diagnoses to consen',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical terminology standardization for EHR interoperability, clinical decision support rules, and quality measure calculation. SNOMED CT is the required standard for USCDI and enables semantic inter',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit, admission, or outpatient episode) during which this diagnosis was documented or confirmed. Supports encounter-level DRG assignment and billing.',
    `admit_diagnosis_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis was the stated reason for inpatient admission as documented at the time of admission. The admitting diagnosis may differ from the principal discharge diagnosis and is required on UB-04 claim form field 69.',
    `care_setting` STRING COMMENT 'The clinical care setting in which this diagnosis was documented (e.g., ICU, ED, OR, ambulatory clinic). Supports care-setting-specific quality reporting, resource utilization analysis, and population health stratification. [ENUM-REF-CANDIDATE: inpatient|outpatient|ED|ICU|OR|ambulatory|telehealth — promote to reference product]',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates whether a CDI specialist has issued a physician query related to this diagnosis for clarification or specificity improvement. Supports CDI workflow tracking and documentation quality metrics.',
    `cdi_query_status` STRING COMMENT 'Current status of the CDI physician query associated with this diagnosis. Tracks whether the provider has responded and whether the diagnosis was amended based on the query outcome.. Valid values are `pending|agreed|disagreed|no_response|withdrawn`',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis represents a chronic condition as defined by CMS Chronic Condition Warehouse (CCW) criteria. Used for population health management, HEDIS measure attribution, and ACO quality reporting.',
    `clinical_status` STRING COMMENT 'Current clinical state of the diagnosis as documented by the provider. Active indicates an ongoing condition; resolved indicates the condition has been treated or cleared; chronic conditions may persist across encounters.. Valid values are `active|resolved|inactive|recurrence|remission|unknown`',
    `coding_date` DATE COMMENT 'The date on which the ICD-10-CM code was assigned or finalized by the HIM coder. Used for coding turnaround time reporting, revenue cycle management, and compliance audits.',
    `coding_status` STRING COMMENT 'Indicates the Health Information Management (HIM) coding workflow status for this diagnosis. Finalized diagnoses are ready for claim submission; amended diagnoses reflect post-coding corrections.. Valid values are `unreviewed|coded|queried|finalized|amended`',
    `complication_comorbidity_flag` BOOLEAN COMMENT 'Indicates whether this secondary diagnosis qualifies as a Complication (CC) or Major Complication/Comorbidity (MCC) under CMS DRG grouping logic. CC/MCC status elevates DRG weight and reimbursement.',
    `diagnosis_date` DATE COMMENT 'The date on which the diagnosis was formally documented in the EHR by the clinician. Distinct from onset date (when the condition began) and encounter date. Used as the principal business event date for this transaction record.',
    `discharge_diagnosis_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis was finalized as a discharge diagnosis at the conclusion of the inpatient encounter. Discharge diagnoses are used for final DRG assignment, claim submission, and discharge summary documentation.',
    `drg_relevant_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis contributes to the DRG assignment for the associated inpatient encounter. Used by the 3M grouper and revenue cycle teams to identify diagnoses that impact reimbursement.',
    `encounter_diagnosis_source` STRING COMMENT 'Identifies the role of the person who entered or assigned this diagnosis in the EHR. Supports CDI workflow analysis, coding quality audits, and provider attribution reporting.. Valid values are `physician|cdi_specialist|coder|nurse|imported`',
    `encounter_type` STRING COMMENT 'Classifies the type of encounter in which this diagnosis was documented. Inpatient diagnoses are subject to POA reporting and DRG grouping; outpatient diagnoses follow CMS-1500 coding guidelines. Denormalized from the encounter for direct diagnosis-level analytics.. Valid values are `inpatient|outpatient|emergency|observation|telehealth`',
    `external_cause_code` STRING COMMENT 'ICD-10-CM external cause code (V, W, X, Y codes) documenting the mechanism, intent, and place of occurrence for injury-related diagnoses. Required for trauma registries, workers compensation claims, and injury surveillance reporting.. Valid values are `^[VWX][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$|^Y[0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$`',
    `hac_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis qualifies as a CMS-designated Hospital-Acquired Condition (HAC). HAC-flagged diagnoses that were not present on admission may trigger payment reductions under the HAC Reduction Program.',
    `icd10_version` STRING COMMENT 'The CMS fiscal year version of the ICD-10-CM code set used to assign this diagnosis code (e.g., FY2024). ICD-10-CM is updated annually; version tracking ensures accurate historical code interpretation and audit defense.. Valid values are `^FY[0-9]{4}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this diagnosis record was most recently modified in the source EHR system. Used for incremental data loads, CDI amendment tracking, and audit compliance.',
    `laterality` STRING COMMENT 'Specifies the anatomical side affected by the diagnosis where applicable (e.g., left knee fracture, right breast mass). ICD-10-CM codes often encode laterality; this field provides an explicit queryable attribute for surgical scheduling and quality reporting.. Valid values are `left|right|bilateral|unspecified`',
    `mcc_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis specifically qualifies as a Major Complication or Comorbidity (MCC) — the highest severity tier in CMS DRG grouping. Distinct from the general CC flag; MCC status drives the highest DRG weight tier.',
    `mrn` STRING COMMENT 'The facility-assigned Medical Record Number (MRN) for the patient associated with this diagnosis. Denormalized from the patient record to support direct clinical documentation queries without a join.',
    `note_text` STRING COMMENT 'Free-text clinical note or comment associated with this diagnosis entry, as documented by the provider or CDI specialist. May include clinical rationale, specificity details, or query responses. Classified as confidential due to clinical content.',
    `onset_date` DATE COMMENT 'The date on which the condition or diagnosis first began, as documented by the clinician. Used for chronic disease management, population health analytics, and longitudinal patient record construction.',
    `present_on_admission` STRING COMMENT 'CMS-required Present on Admission (POA) indicator for inpatient diagnoses. Y=present at admission, N=not present at admission, U=unknown, W=clinically undetermined, 1=unreported/not used. Affects hospital-acquired condition (HAC) payment adjustments and quality reporting.. Valid values are `Y|N|U|W|1`',
    `principal_diagnosis_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is designated as the principal diagnosis for the encounter (True). The principal diagnosis is the condition established after study to be chiefly responsible for the admission and drives DRG assignment.',
    `problem_list_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is part of the patients longitudinal problem list (True) or is encounter-specific only (False). Problem list diagnoses persist across encounters and drive chronic disease management workflows.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is relevant to one or more quality measures (e.g., HEDIS, MIPS, VBP, TJC core measures). Used to identify patients for quality measure denominator and numerator attribution.',
    `rank` STRING COMMENT 'Numeric sequence indicating the ordering of diagnoses within an encounter (1 = principal, 2 = first secondary, etc.). Used for UB-04 claim form sequencing, DRG optimization, and CDI prioritization.',
    `recorded_timestamp` TIMESTAMP COMMENT 'The precise date and time when this diagnosis record was first created in the source EHR system (Epic ClinDoc or Cerner PowerChart). Supports audit trails, CDI workflow timing, and data lineage.',
    `resolution_date` DATE COMMENT 'The date on which the condition was resolved, cured, or no longer clinically active. Null for ongoing or chronic conditions. Used to calculate episode duration and support transitions of care.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis is classified as a Social Determinants of Health (SDOH) condition (Z55–Z65 ICD-10-CM Z-codes). Used for population health management, care coordination, and CMS SDOH reporting initiatives.',
    `severity` STRING COMMENT 'Clinical severity level of the diagnosis as documented by the provider. Drives care intensity decisions, DRG complexity, and quality measure stratification. Aligns with SNOMED CT severity qualifiers.. Valid values are `mild|moderate|severe|critical`',
    `source_system_diagnosis_code` STRING COMMENT 'The native identifier for this diagnosis record in the originating source system (e.g., Epic diagnosis ID, Cerner diagnosis ID). Enables bidirectional traceability between the lakehouse and the operational EHR.',
    `diagnosis_type` STRING COMMENT 'Classifies the role of this diagnosis within the encounter or problem list context. Principal diagnosis drives DRG assignment; admitting diagnosis reflects the reason for admission; secondary diagnoses capture comorbidities and complications. [ENUM-REF-CANDIDATE: principal|secondary|admitting|discharge|working|chronic_problem_list — promote to reference product]. Valid values are `principal|secondary|admitting|discharge|working|chronic_problem_list`',
    `verification_status` STRING COMMENT 'Indicates the degree of clinical certainty for this diagnosis. Confirmed diagnoses are used for billing and DRG assignment; provisional and differential diagnoses support CDI workflows and clinical decision-making. Maps to Epic ClinDoc diagnosis certainty and Cerner PowerChart diagnosis qualifier.. Valid values are `confirmed|provisional|differential|refuted|entered_in_error`',
    CONSTRAINT pk_diagnosis PRIMARY KEY(`diagnosis_id`)
) COMMENT 'SSOT for all patient diagnoses documented in the EHR. Captures ICD-10-CM coded diagnoses, diagnosis type (principal, secondary, admitting, discharge), onset date, resolution date, clinical status (active, resolved, chronic), severity, certainty (confirmed, suspected, rule-out), and the encounter or problem list context. Sourced from Epic ClinDoc and Cerner PowerChart. Supports CDI workflows, DRG assignment, and quality reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` (
    `procedure_event_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical procedure event record in the Silver Layer lakehouse. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, ambulatory surgery center, clinic) where the procedure was performed. Used for facility-level quality reporting and charge capture.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Procedures are primary cost and revenue drivers in healthcare. Finance requires direct cost center attribution for procedure costing, profitability analysis, RVU-based budgeting, and service line fina',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure billing, RVU calculation for physician payment, NCCI edit validation, and charge capture require authoritative CPT code reference. Revenue cycle operations depend on accurate CPT coding for ',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Inpatient reimbursement calculation, case mix index reporting, and financial forecasting require DRG reference with relative weights and ALOS. Finance and case management teams use DRG data for paymen',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Surgical procedures require specific medications (anesthesia agents, prophylactic antibiotics, contrast media). Perioperative medication protocols and surgical safety checklists depend on procedure-to',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: DME, supply, and drug billing require HCPCS code validation for Medicare/Medicaid claims. Revenue cycle teams use HCPCS reference for coverage determination, prior authorization, and accurate charge c',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Surgical/interventional procedures require pre-operative imaging for planning and intra-operative imaging for guidance. Critical for surgical safety protocols, pre-op checklists, and image-guided proc',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Procedures consume specific supplies/implants tracked for cost accounting, utilization review, and regulatory compliance. Enables procedure-specific supply cost analysis and clinical variation reducti',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient on whom the procedure was performed. Core PARTY_REFERENCE for this transaction, linking to the Master Patient Index (MPI).',
    `room_id` BIGINT COMMENT 'Reference to the specific operating room, procedure room, or interventional suite where the procedure was performed. Used for OR utilization reporting, room turnover analytics, and facility scheduling.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Procedures fulfill clinical orders. Real workflow: surgeon orders appendectomy, OR performs procedure. Critical for order-to-fulfillment tracking, charge reconciliation, turnaround time analysis, and ',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Procedure authorization, billing, and reimbursement are payer-specific. Fee schedule lookup, prior auth requirements, and claims submission all require knowing which payer covers the procedure. Core r',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Surgical procedures require pre-operative lab clearance (CBC, coagulation panels, type & screen). Role prefix preop_ indicates timing. Standard surgical safety protocol and regulatory requirement fo',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed clinician (surgeon, interventionalist, or proceduralist) who performed the procedure. Used for credentialing validation, RVU attribution, and quality measurement.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Surgical quality measures (SSI rates, VTE prophylaxis, antibiotic timing) are procedure-specific. Quality programs track procedure-level compliance. Direct linkage enables automated measure calculatio',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Surgical/interventional procedures generate specimens sent to pathology/lab for analysis. Essential for cancer staging, infection diagnosis, and quality documentation. Links procedure to pathology rep',
    `tertiary_procedure_anesthesia_provider_clinician_id` BIGINT COMMENT 'Reference to the anesthesiologist or CRNA responsible for anesthesia administration during the procedure. Required for anesthesia professional fee billing and credentialing compliance.',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Joint Commission and CMS mandate documented treatment consent for procedures. Clinical workflows verify consent before procedure start; surgical safety checklists require consent_obtained flag validat',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient, outpatient, ED, surgical) during which this procedure was performed. Links procedure to the broader care episode for revenue cycle and quality reporting.',
    `anesthesia_type` STRING COMMENT 'Type of anesthesia administered during the procedure. Drives anesthesia billing (ASA base units + time units), OR scheduling requirements, and pre-operative assessment workflows.. Valid values are `general|regional|local|monitored_anesthesia_care|none`',
    `approach` STRING COMMENT 'Technique or access method used to perform the procedure (e.g., open, laparoscopic, robotic-assisted, endoscopic). Captured in ICD-10-PCS character 5 and used for surgical quality benchmarking and OR resource planning.. Valid values are `open|laparoscopic|robotic|endoscopic|percutaneous|transcatheter`',
    `asa_classification` STRING COMMENT 'ASA Physical Status Classification (I–VI) assigned by the anesthesiologist to assess patient pre-operative risk. Required for anesthesia billing, surgical risk stratification, and quality benchmarking (ACS NSQIP).. Valid values are `I|II|III|IV|V|VI`',
    `body_site` STRING COMMENT 'Anatomical body site or region where the procedure was performed, coded using SNOMED CT body structure hierarchy. Supports surgical safety, clinical documentation completeness, and CDI workflows.',
    `cancellation_reason` STRING COMMENT 'Coded reason for procedure cancellation when procedure_status is cancelled or not-done. Used for OR cancellation rate reporting, patient safety analysis, and operational improvement initiatives. [ENUM-REF-CANDIDATE: patient_refusal|medical_contraindication|equipment_failure|scheduling_error|insurance_denial|no_show|provider_unavailable — promote to reference product]',
    `cdm_code` STRING COMMENT 'Internal facility CDM (Charge Description Master) code identifying the specific charge item for this procedure. Links clinical documentation to the revenue cycle charge capture process.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Gross charge amount in USD posted to the patient account for this procedure, sourced from the CDM (Charge Description Master). Represents the facilitys list price before contractual adjustments. Used for revenue cycle charge capture reconciliation.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether documented informed consent was obtained from the patient or authorized representative prior to the procedure. Required for regulatory compliance, medical-legal documentation, and The Joint Commission RI.01.03.01.',
    `cpt_modifier_1` STRING COMMENT 'Primary AMA CPT modifier appended to the procedure code to indicate special circumstances (e.g., 22=Increased Procedural Services, 50=Bilateral, 51=Multiple Procedures, 59=Distinct Procedural Service). Required for accurate claim adjudication.. Valid values are `^[A-Z0-9]{2}$`',
    `cpt_modifier_2` STRING COMMENT 'Secondary AMA CPT modifier when multiple modifiers are required for the procedure code. Supports complex claim scenarios such as assistant surgeon (80), teaching physician (GC), or anesthesia qualifiers.. Valid values are `^[A-Z0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procedure event record was first created in the source EHR system. Serves as the RECORD_AUDIT_CREATED field for data governance, audit trail, and HIPAA audit log requirements.',
    `duration_minutes` STRING COMMENT 'Total elapsed time in minutes from procedure start to procedure end. Derived from start and end timestamps at source and stored for OR utilization analytics, anesthesia billing, and surgical quality benchmarking.',
    `estimated_blood_loss_ml` STRING COMMENT 'Estimated blood loss in milliliters recorded by the surgical team during the procedure. Used for post-operative care planning, transfusion trigger assessment, and surgical quality benchmarking (ACS NSQIP).',
    `icd10_pcs_code` STRING COMMENT 'ICD-10-PCS code for inpatient procedures, used on UB-04 institutional claims for DRG grouping and inpatient quality reporting. Required for CMS inpatient prospective payment system (IPPS) reimbursement.. Valid values are `^[A-Z0-9]{7}$`',
    `laterality` STRING COMMENT 'Body side on which the procedure was performed. Required for surgical safety verification (Universal Protocol), correct-site surgery compliance, and ICD-10-PCS/CPT modifier application.. Valid values are `left|right|bilateral|unilateral|not_applicable`',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code representing the primary indication for the procedure. Required for medical necessity validation, DRG grouping, and claim adjudication by payers.. Valid values are `^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$`',
    `priority` STRING COMMENT 'Clinical urgency classification of the procedure at time of scheduling or ordering. Drives OR scheduling queue prioritization, resource allocation, and EMTALA compliance tracking for emergent cases.. Valid values are `elective|urgent|emergent|stat`',
    `procedure_category` STRING COMMENT 'High-level clinical category classifying the nature of the procedure. Used for service-line analytics, OR scheduling resource allocation, and population health stratification.. Valid values are `surgical|diagnostic|therapeutic|preventive|rehabilitative|palliative`',
    `procedure_date` DATE COMMENT 'Calendar date on which the procedure was performed. Used as the primary date dimension for reporting, HEDIS measure denominator logic, and claim date-of-service on CMS-1500 and UB-04 forms.',
    `procedure_end_datetime` TIMESTAMP COMMENT 'Date and time when the procedure was completed (wound closure for surgical cases, or final intervention for non-surgical). Used with start time to calculate procedure duration for OR scheduling, staffing, and quality metrics.',
    `procedure_number` STRING COMMENT 'Externally visible, human-readable business identifier for this procedure event, assigned by the source EHR system (e.g., Epic OpTime case number or Cerner SurgiNet procedure ID). Used for cross-system reconciliation and charge capture reference.',
    `procedure_start_datetime` TIMESTAMP COMMENT 'Date and time when the procedure was initiated (knife-to-skin for surgical cases, or first intervention for non-surgical). Principal BUSINESS_EVENT_TIMESTAMP for this transaction. Used for OR utilization, LOS calculation, and quality measure timing.',
    `procedure_status` STRING COMMENT 'Current lifecycle state of the procedure event per HL7 FHIR Procedure.status value set. Drives revenue cycle charge capture eligibility and quality measure inclusion/exclusion logic. [ENUM-REF-CANDIDATE: performed|in-progress|cancelled|not-done|on-hold|entered-in-error — promote to reference product]. Valid values are `performed|in-progress|cancelled|not-done|on-hold|entered-in-error`',
    `procedure_type` STRING COMMENT 'Operational classification of the procedure within the facilitys CDM (Charge Description Master), such as OR Case, Bedside Procedure, Interventional Radiology, Endoscopy, Cardiac Cath. Drives charge routing and scheduling resource assignment. [ENUM-REF-CANDIDATE: or_case|bedside|interventional_radiology|endoscopy|cardiac_cath|ambulatory_surgery|labor_delivery — promote to reference product]',
    `rvu_work` DECIMAL(18,2) COMMENT 'CMS physician work Relative Value Unit (RVU) assigned to the CPT code for this procedure. Used for provider productivity measurement, compensation modeling, and MIPS performance reporting.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Originally scheduled date and time for the procedure. Compared against actual start time to measure on-time starts, OR schedule adherence, and first-case delay metrics.',
    `service_line` STRING COMMENT 'Hospital or health system service line under which the procedure is classified (e.g., Cardiovascular, Orthopedics, Neurosurgery, Oncology). Used for service-line P&L reporting, CMI analysis, and strategic planning. [ENUM-REF-CANDIDATE: cardiovascular|orthopedics|neurosurgery|oncology|general_surgery|obstetrics|urology|gastroenterology — promote to reference product]',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT concept code representing the clinical procedure. Supports interoperability via HL7 FHIR and HIE exchange, and enables clinical decision support and population health analytics beyond billing code sets.. Valid values are `^[0-9]{6,18}$`',
    `source_system_record_code` STRING COMMENT 'Native primary key or unique identifier of this procedure record in the originating source system (e.g., Epic OpTime case ID, Cerner SurgiNet procedure ID). Enables bidirectional traceability between the lakehouse Silver Layer and the operational EHR.',
    `specimen_collected` BOOLEAN COMMENT 'Indicates whether a tissue specimen or pathology sample was collected during the procedure. Triggers downstream laboratory/pathology order workflow and chain-of-custody documentation.',
    `timeout_performed` BOOLEAN COMMENT 'Indicates whether the pre-procedure surgical time-out (Universal Protocol) was completed and documented. Mandatory for Joint Commission accreditation and CMS Conditions of Participation to prevent wrong-site, wrong-procedure, wrong-patient events.',
    `udi` STRING COMMENT 'FDA-assigned Unique Device Identifier (UDI) for the primary implant or medical device used during the procedure. Required for FDA device tracking, recall management, and 21st Century Cures Act compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this procedure event record in the source EHR system. Serves as the RECORD_AUDIT_UPDATED field for change data capture (CDC), data quality monitoring, and HIPAA audit trail compliance.',
    `wound_classification` STRING COMMENT 'CDC/ACS wound classification (Clean, Clean-Contaminated, Contaminated, Dirty/Infected) assigned at time of procedure. Used for SSI (Surgical Site Infection) surveillance, HAI reporting, and infection control quality metrics.. Valid values are `clean|clean_contaminated|contaminated|dirty_infected`',
    CONSTRAINT pk_procedure_event PRIMARY KEY(`procedure_event_id`)
) COMMENT 'Records of clinical procedures performed on patients, coded using CPT, HCPCS, and ICD-10-PCS. Captures procedure date/time, performing provider, facility location, laterality, approach, anesthesia type, duration, status (performed, cancelled, in-progress), and associated encounter. Sourced from Epic OpTime, ClinDoc, and Cerner SurgiNet. Supports revenue cycle charge capture and quality measurement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`note` (
    `note_id` BIGINT COMMENT 'Unique surrogate identifier for the clinical note record in the lakehouse Silver layer. Primary key for this data product.',
    `accreditation_survey_id` BIGINT COMMENT 'Foreign key linking to quality.accreditation_survey. Business justification: Accreditation surveyors review clinical notes for documentation standards compliance. Tracer methodology examines specific notes. Essential for accreditation survey preparation and response.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site where the clinical note was authored. Supports multi-facility enterprise reporting and regulatory submissions.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Clinical notes document rationale for orders. Real workflow: progress note states ordered CBC due to fever. Essential for CDI queries, medical necessity review, audit defense, and clinical decision ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who is the subject of this clinical note. Core linkage to the Master Patient Index (MPI).',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Document type classification for C-CDA generation, HIE document exchange, and clinical document architecture compliance. Health information management uses LOINC document codes for interoperable clini',
    `clinician_id` BIGINT COMMENT 'Reference to the attending physician of record for the encounter at the time the note was authored. May differ from the note author (e.g., resident authors, attending co-signs). Used for CMS billing attribution and quality measure assignment.',
    `note_clinician_id` BIGINT COMMENT 'Reference to the licensed provider who authored and is primarily responsible for the clinical note content. Used for CDI attribution and provider productivity reporting.',
    `note_cosigner_provider_clinician_id` BIGINT COMMENT 'Reference to the supervising or co-signing provider who attests to the note content. Required for resident/trainee notes per CMS teaching physician rules. Nullable when no co-signature is required.',
    `note_template_id` BIGINT COMMENT 'The identifier of the EHR documentation template used to author this note (e.g., Epic SmartText or Cerner PowerNote template ID). Supports template utilization analytics and standardization initiatives.',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department or unit where the note was authored (e.g., ICU, ED, Cardiology Clinic). Supports departmental productivity and documentation compliance reporting.',
    `parent_note_id` BIGINT COMMENT 'Reference to the original clinical note to which this addendum or amendment is attached. Null for original notes. Enables reconstruction of the complete note history and amendment chain.',
    `mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - clinical notes link to demographics but not mpi_record; MPI is the SSOT for patient identity',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Clinical notes document consent discussions, patient education, and consent status changes. EHR workflows link consent conversations to notes for regulatory audits (informed consent documentation requ',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this note was authored. Links the note to the patient visit context (inpatient, outpatient, ED, etc.).',
    `admission_date` DATE COMMENT 'The date of inpatient admission associated with this note. Denormalized for inpatient note timeliness compliance calculations (e.g., H&P must be completed within 24 hours of admission per TJC RC.02.01.01). Null for outpatient notes.',
    `amended_timestamp` TIMESTAMP COMMENT 'The date and time when the note was last amended (corrected). Amendments replace erroneous content while preserving the original for audit purposes. Nullable for notes that have never been amended.',
    `author_role` STRING COMMENT 'The clinical role of the provider who authored the note. Determines co-signature requirements, billing eligibility (incident-to rules), and CDI workflow routing. [ENUM-REF-CANDIDATE: attending|resident|fellow|nurse_practitioner|physician_assistant|registered_nurse|medical_student|clinical_pharmacist|case_manager|social_worker — promote to reference product]',
    `authored_timestamp` TIMESTAMP COMMENT 'The date and time when the provider began authoring or first saved the clinical note in the EHR. Represents the business event timestamp for note creation. Used for timeliness compliance reporting (e.g., H&P within 24 hours of admission per TJC).',
    `care_setting` STRING COMMENT 'The clinical care setting in which the note was authored. Determines applicable documentation standards, billing rules (UB-04 vs CMS-1500), and regulatory requirements.. Valid values are `inpatient|outpatient|emergency|observation|ambulatory_surgery|telehealth`',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates whether a CDI specialist has issued a physician query against this note requesting clarification or additional specificity to support accurate ICD-10 coding and DRG assignment. Core to CDI workflow management.',
    `cdi_query_status` STRING COMMENT 'Current status of the CDI physician query associated with this note. Tracks whether the provider has responded to the query, enabling CDI team follow-up and DRG impact analysis.. Valid values are `pending|answered|withdrawn|no_query`',
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
    `principal_diagnosis_code` STRING COMMENT 'The ICD-10-CM diagnosis code for the principal condition documented in this note, as identified by the authoring provider. Particularly relevant for discharge summaries and H&P notes. Supports HIM coding validation and CDI workflows.. Valid values are `^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$`',
    `sensitive_note_type` STRING COMMENT 'Identifies whether the note contains sensitive clinical content subject to heightened privacy protections beyond standard HIPAA requirements. Drives break-the-glass access controls and consent management workflows.. Valid values are `behavioral_health|substance_abuse|hiv_aids|sexual_health|domestic_violence|none`',
    `service_date` DATE COMMENT 'The calendar date on which the clinical service or encounter event being documented occurred. Distinct from the note authoring date; used for billing date-of-service alignment and clinical timeline reconstruction.',
    `service_line` STRING COMMENT 'The hospital or health system service line under which the note was authored (e.g., Cardiovascular, Oncology, Womens Health, Behavioral Health). Supports service-line-level analytics and operational reporting.',
    `signed_timestamp` TIMESTAMP COMMENT 'The date and time when the author electronically signed and attested to the clinical note, making it a legally authenticated entry in the medical record. Nullable for draft notes.',
    `source_system_note_code` STRING COMMENT 'The native identifier of this note in the originating EHR system (Epic ClinDoc note ID or Cerner PowerChart document ID). Used for cross-system reconciliation and ETL lineage tracing.',
    `specialty` STRING COMMENT 'The medical or clinical specialty associated with the note (e.g., Cardiology, Orthopedics, Nursing, Anesthesiology). Derived from the authoring providers specialty or the ordering service. Used for specialty-specific CDI and quality reporting.',
    `note_status` STRING COMMENT 'Current workflow state of the clinical note in the EHR documentation lifecycle. Draft notes are incomplete; signed notes are legally attested; amended notes reflect corrections; addended notes have supplemental content appended; retracted notes have been withdrawn from the medical record.. Valid values are `draft|signed|amended|addended|retracted`',
    `text` STRING COMMENT 'The full free-text or structured narrative content of the clinical note. Contains Protected Health Information (PHI) including clinical findings, diagnoses, treatment plans, and patient history. Subject to HIPAA minimum necessary standard and access controls. Core to CDI and HIM coding workflows.',
    `title` STRING COMMENT 'The human-readable title or subject line of the clinical note as displayed in the EHR (e.g., Cardiology Consult Note, Post-Op Day 1 Progress Note). Supports note navigation and CDI workflow queuing.',
    `note_type` STRING COMMENT 'Classification of the clinical note by its documentation purpose and clinical context. Drives CDI workflows, HIM coding queues, and regulatory reporting. [ENUM-REF-CANDIDATE: History and Physical|Progress Note|Discharge Summary|Operative Note|Consult Note|Nursing Note|Procedure Note|Radiology Report|Pathology Report|Transfer Note|Referral Note|Telephone Encounter Note — promote to reference product]. Valid values are `History and Physical|Progress Note|Discharge Summary|Operative Note|Consult Note|Nursing Note`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this clinical note record was last modified in the lakehouse Silver layer. Supports incremental ETL processing, change data capture, and audit trail compliance.',
    `version` STRING COMMENT 'Monotonically incrementing version number for the note record, incremented with each amendment or addendum. Enables reconstruction of the complete note history and supports audit trail requirements.',
    `word_count` STRING COMMENT 'The total number of words in the clinical note text. Used for documentation quality metrics, CDI completeness scoring, and identifying copy-paste or cloned note patterns flagged by OIG compliance programs.',
    CONSTRAINT pk_note PRIMARY KEY(`note_id`)
) COMMENT 'Structured and unstructured clinical documentation authored by providers in the EHR. Includes note type (H&P, progress note, discharge summary, operative note, consult note, nursing note), author, co-signer, note status (draft, signed, amended, addended), service date, encounter context, LOINC document type code, and full note text or structured content reference. Sourced from Epic ClinDoc and Cerner PowerChart. Core to CDI and HIM workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`problem` (
    `problem_id` BIGINT COMMENT 'Unique surrogate identifier for the patient problem list entry in the lakehouse silver layer. Primary key for this entity.',
    `care_plan_id` BIGINT COMMENT 'Reference to the care plan that addresses or manages this problem. Links the problem list entry to the patients longitudinal care plan for population health management and care coordination.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where this problem was documented. Supports multi-facility enterprise analytics and population health segmentation.',
    `diagnosis_link_id` BIGINT COMMENT 'Foreign key linking to claim.diagnosis_link. Business justification: Problem list entries translate to claim diagnosis codes. HCC coding, risk adjustment, and quality reporting require linking clinical problems to submitted claim diagnoses for accuracy validation and R',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Problem-to-diagnosis mapping for HCC risk adjustment, quality measure attribution, and chronic condition reporting. Risk adjustment teams use ICD-10 codes on problem lists to calculate RAF scores and ',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Chronic conditions on problem list drive surveillance imaging protocols (cancer follow-up, chronic disease monitoring). Essential for population health management, care gap closure, and protocol adher',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Chronic conditions drive DME orders, formulary management, and condition-specific supply protocols (e.g., COPD → nebulizers). Enables condition-based supply planning and population health supply manag',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose longitudinal problem list this entry belongs to. Links to the master patient record.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Problem lists drive HCC coding and risk adjustment submissions, which are payer-specific (Medicare Advantage, ACA marketplace). Quality reporting and care gap closure programs also require payer conte',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Chronic conditions on problem lists drive ongoing prescription management. Used to validate prescription appropriateness, manage polypharmacy, and track medication adherence against chronic disease ma',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who originally added this problem to the patients problem list. Distinct from ordering_provider_id which reflects the current responsible provider. Supports audit and CDI workflows.',
    `problem_clinician_id` BIGINT COMMENT 'Reference to the clinician (physician, NP, PA) who added or owns this problem on the patients problem list. Corresponds to the responsible provider in Epic and Cerner problem list modules.',
    `problem_last_updated_by_provider_clinician_id` BIGINT COMMENT 'Reference to the clinician who most recently modified this problem record. Supports Clinical Documentation Improvement (CDI) audit trails and accountability tracking.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Problem list standardization for care coordination, clinical decision support, and USCDI compliance. SNOMED CT problem codes enable semantic matching for care gaps, drug-disease interactions, and popu',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Active problems trigger standing and recurring orders. Real workflow: diabetes problem triggers quarterly A1C orders. Essential for chronic disease management protocols, population health order compli',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this problem was first identified or most recently updated. Nullable — problems may exist independent of a specific encounter on the longitudinal problem list.',
    `body_site_code` STRING COMMENT 'SNOMED CT code identifying the anatomical body site associated with this problem (e.g., 368209003 = Right arm). Supports surgical planning, radiology ordering, and clinical specificity in documentation.',
    `body_site_description` STRING COMMENT 'Human-readable description of the anatomical body site corresponding to body_site_code. Stored for reporting and display purposes.',
    `care_setting` STRING COMMENT 'The clinical care setting in which this problem was documented or is being managed. Supports population health stratification and care coordination analytics across inpatient, outpatient, Emergency Department (ED), and telehealth settings.. Valid values are `inpatient|outpatient|emergency|ambulatory|telehealth`',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates whether a Clinical Documentation Improvement (CDI) query has been raised against this problem entry, requesting clarification or specificity from the treating physician to support accurate coding and reimbursement.',
    `cdi_query_status` STRING COMMENT 'Current status of the Clinical Documentation Improvement (CDI) query associated with this problem, if applicable. Tracks whether the physician has responded to the CDI query for coding specificity.. Valid values are `pending|answered|withdrawn|no-query`',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates whether this problem is classified as a chronic condition for the purposes of population health management, care management program enrollment, and CMS Hierarchical Condition Category (HCC) risk adjustment. True = chronic condition.',
    `comment` STRING COMMENT 'Free-text clinical comment or note associated with this problem list entry, as entered by the clinician in the Electronic Health Record (EHR). May include clinical context, treatment notes, or documentation improvement remarks.',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether this problem has been marked as confidential in the Electronic Health Record (EHR), restricting access to authorized users only. Commonly applied to sensitive diagnoses such as HIV/AIDS, substance use disorders, and psychiatric conditions per 42 CFR Part 2 and state privacy laws.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this problem record was first created in the source Electronic Health Record (EHR) system. Establishes the audit trail origin for the problem list entry.',
    `fhir_condition_reference` STRING COMMENT 'The HL7 Fast Healthcare Interoperability Resources (FHIR) Condition resource identifier for this problem, used in Health Information Exchange (HIE) and interoperability workflows. Supports CMS Interoperability and Patient Access Rule compliance.',
    `hcc_category_code` STRING COMMENT 'CMS Hierarchical Condition Category (HCC) code mapped to this problem. Used for Medicare Advantage risk adjustment, capitation payment calculations, and population health risk stratification.',
    `is_encounter_diagnosis` BOOLEAN COMMENT 'Indicates whether this problem list entry was also used as an encounter-level diagnosis for billing and claims purposes. Distinguishes longitudinal problem list entries from encounter-specific diagnoses used in revenue cycle management.',
    `last_reviewed_date` DATE COMMENT 'The most recent date on which a clinician reviewed and affirmed or updated this problem on the patients problem list. Supports Clinical Documentation Improvement (CDI) workflows and problem list hygiene audits.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this problem record was most recently modified in the source Electronic Health Record (EHR) system. Used for change detection, audit trails, and incremental ETL processing.',
    `laterality` STRING COMMENT 'Anatomical laterality qualifier for the problem where applicable (e.g., left knee osteoarthritis, right breast mass). Supports precise ICD-10-CM coding specificity and surgical planning.. Valid values are `left|right|bilateral|unspecified`',
    `list_display_order` STRING COMMENT 'Numeric sequence indicating the display order of this problem on the patients problem list as configured in the Electronic Health Record (EHR). Lower numbers appear first. Supports clinical workflow and provider-defined prioritization.',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient by the facility. Denormalized here for operational reporting and audit purposes without requiring a join to the patient master.',
    `noted_date` DATE COMMENT 'The date on which the problem was first documented or noted in the Electronic Health Record (EHR) problem list by a clinician. May differ from onset_date if the condition predates the current care relationship.',
    `onset_age_years` STRING COMMENT 'Patients age in years at the time of problem onset, as documented or calculated. Useful for population health stratification and epidemiological analytics when exact onset date is unavailable or approximate.',
    `onset_date` DATE COMMENT 'The date on which the patients problem or condition first began, as documented by the clinician. May be approximate (e.g., year only) for historical conditions. Used in longitudinal care management, population health analytics, and chronic disease registries.',
    `principal_problem_flag` BOOLEAN COMMENT 'Indicates whether this problem is designated as the principal or primary problem driving the current episode of care or encounter. Used in Diagnosis-Related Group (DRG) assignment and revenue cycle workflows.',
    `priority` STRING COMMENT 'Clinical priority assigned to this problem indicating its relative importance in the patients care plan. high priority problems typically drive care plan goals and quality measure attribution.. Valid values are `high|medium|low|routine`',
    `resolution_date` DATE COMMENT 'The date on which the problem was clinically resolved or marked as resolved/inactive on the patients problem list. Null for active or chronic conditions. Used to calculate problem duration and track care outcomes.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether this problem represents a Social Determinant of Health (SDOH) condition (e.g., food insecurity, housing instability, transportation barriers). Supports population health management and CMS SDOH reporting requirements.',
    `severity` STRING COMMENT 'Clinical severity classification of the problem as documented by the treating clinician. Supports risk stratification, care management triage, and quality reporting.. Valid values are `mild|moderate|severe|unspecified`',
    `source_system_problem_code` STRING COMMENT 'Native identifier for this problem record in the originating Electronic Health Record (EHR) system (e.g., Epic problem list ID or Cerner problem instance ID). Used for lineage tracing and reconciliation during ETL.',
    `stage_code` STRING COMMENT 'Clinical staging code for the problem where applicable (e.g., cancer TNM staging, chronic kidney disease stage, heart failure NYHA class). Supports oncology registries, chronic disease management, and quality reporting.',
    `stage_description` STRING COMMENT 'Human-readable description of the clinical stage corresponding to stage_code (e.g., Stage III Non-Small Cell Lung Cancer, CKD Stage 4). Stored for reporting clarity.',
    `problem_status` STRING COMMENT 'Current clinical lifecycle status of the problem on the patients longitudinal problem list. active indicates an ongoing condition; resolved indicates the condition has been addressed; inactive indicates the condition is not currently being managed; deleted or entered-in-error indicates administrative correction.. Valid values are `active|inactive|resolved|deleted|entered-in-error`',
    `title` STRING COMMENT 'Human-readable clinical name or title of the problem as displayed in the Electronic Health Record (EHR) problem list (e.g., Type 2 Diabetes Mellitus, Essential Hypertension). May be the SNOMED CT preferred term or a clinician-entered free-text label.',
    `problem_type` STRING COMMENT 'Clinical classification of the problem by its temporal and clinical nature. chronic indicates a long-standing condition; acute indicates a short-term condition; historical indicates a past condition no longer active; social indicates a social determinant of health (SDOH); surgical indicates a surgical history item; psychiatric indicates a behavioral health condition. [ENUM-REF-CANDIDATE: chronic|acute|historical|social|surgical|psychiatric|functional|genetic — promote to reference product]. Valid values are `chronic|acute|historical|social|surgical|psychiatric`',
    `verification_status` STRING COMMENT 'Clinical verification status indicating the degree of certainty that the problem exists for this patient. Aligns with HL7 FHIR Condition.verificationStatus. confirmed indicates a definitive diagnosis; provisional or differential indicates a working diagnosis under evaluation.. Valid values are `confirmed|unconfirmed|provisional|differential|refuted`',
    CONSTRAINT pk_problem PRIMARY KEY(`problem_id`)
) COMMENT 'Patient problem list entries representing active, chronic, or historical health conditions managed longitudinally across encounters. Captures SNOMED CT and ICD-10 coded problems, onset date, resolution date, problem status (active, inactive, resolved), priority, and the provider who added or last updated the problem. Distinct from encounter-level diagnoses — this is the longitudinal clinical problem list. Sourced from Epic and Cerner problem list modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`allergy` (
    `allergy_id` BIGINT COMMENT 'Unique surrogate identifier for each patient allergy or adverse reaction record in the clinical data product. Primary key for the allergy entity in the Silver Layer lakehouse.',
    `cpoe_alert_id` BIGINT COMMENT 'Foreign key linking to order.cpoe_alert. Business justification: Allergies trigger CPOE alerts for contraindicated orders. Real workflow: penicillin allergy fires alert when ordering amoxicillin. Critical for patient safety event investigation, alert override analy',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Allergy checking against ordered/dispensed medications is critical patient safety function. Every CPOE and pharmacy system implements drug-allergy interaction screening. Required for meaningful use an',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician (physician, nurse, pharmacist) who documented or entered this allergy record into the Electronic Health Record (EHR). Supports audit and Clinical Documentation Improvement (CDI) workflows.',
    `allergy_override_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who overrode the allergy alert during CPOE. Supports medication safety audit trails and compliance reporting. Null if no override has occurred.',
    `claim_attachment_id` BIGINT COMMENT 'Foreign key linking to claim.claim_attachment. Business justification: Allergy documentation may be required to justify alternative drug selection for pharmacy claims. Prior authorization and medical necessity reviews require linking allergy records to supporting documen',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where this allergy was documented. Supports multi-facility enterprise reporting and population health analytics.',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Drug/food allergies confirmed via lab testing (specific IgE panels, tryptase levels). Role prefix confirmatory_ indicates diagnostic purpose. Important for allergy verification and de-labeling initi',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this allergy or adverse reaction is documented. Links to the patient master record in the Patient domain.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Drug/material allergies prevent ordering of specific supplies/medications. Enables allergy-based supply contraindication checking, patient safety alerts, and formulary restriction enforcement in CPOE ',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Drug allergy identification for medication reconciliation, e-prescribing safety checks, and formulary management. Pharmacy systems use NDC codes to link allergies to specific drug products and active ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Allergen standardization for clinical decision support, drug-allergy interaction checking, and allergy reconciliation across care settings. Pharmacy and clinical systems use SNOMED allergen codes to t',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this allergy was first documented or most recently updated. May be null if the allergy was entered outside of a specific encounter context.',
    `alert_override_reason` STRING COMMENT 'Clinical justification documented when a provider overrides a drug allergy alert during Computerized Physician Order Entry (CPOE). Required for regulatory compliance and medication safety audits. Null if no override has occurred.',
    `allergen_name` STRING COMMENT 'The free-text or standardized name of the substance causing the allergic or adverse reaction (e.g., Penicillin, Peanuts, Latex, Iodinated Contrast Media). Primary human-readable identifier for the allergen.',
    `allergen_type` STRING COMMENT 'Classification of the allergen category. Drives clinical decision support rules and patient safety alerts. [ENUM-REF-CANDIDATE: drug|food|environmental|contrast_media|latex|insect_venom|other — promote to reference product]',
    `care_setting` STRING COMMENT 'The clinical care setting in which this allergy was documented (e.g., inpatient, outpatient, Emergency Department (ED), ambulatory). Supports population health segmentation and quality reporting.. Valid values are `inpatient|outpatient|emergency|ambulatory|telehealth|other`',
    `allergy_category` STRING COMMENT 'Distinguishes between a true immunological allergy, a non-immunological intolerance (e.g., GI upset from NSAIDs), and a documented side effect. Critical for appropriate clinical decision support alert configuration and pharmacy dispensing rules.. Valid values are `allergy|intolerance|side_effect`',
    `clinical_status` STRING COMMENT 'Current clinical status of the allergy indicating whether it is currently active, has become inactive, or has been resolved. Active allergies trigger clinical decision support alerts during order entry (CPOE).. Valid values are `active|inactive|resolved`',
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
    `ndf_rt_code` STRING COMMENT 'The National Drug File – Reference Terminology (NDF-RT) code for drug allergens, enabling pharmacological class-level allergy checking (e.g., all penicillin-class antibiotics). Used in drug allergy cross-sensitivity analysis.',
    `note` STRING COMMENT 'Free-text clinical notes or additional comments documented by the clinician regarding this allergy record (e.g., details about the reaction, treatment administered, cross-sensitivity concerns). Supports Clinical Documentation Improvement (CDI) workflows.',
    `onset_date` DATE COMMENT 'The date on which the allergic reaction was first observed or reported by the patient. May be approximate (year only) for historical allergies. Supports longitudinal patient safety tracking.',
    `override_timestamp` TIMESTAMP COMMENT 'Date and time when the allergy alert was overridden by the provider during CPOE. Supports medication safety audit trails. Null if no override has occurred.',
    `phi_access_restricted` BOOLEAN COMMENT 'Indicates whether access to this allergy record is subject to additional Protected Health Information (PHI) access restrictions (e.g., VIP patient, sensitive condition). When true, row-level security controls are applied per HIPAA Privacy Rule requirements.',
    `reaction_description` STRING COMMENT 'Free-text clinical description of the adverse reaction observed or reported by the patient (e.g., hives and facial swelling, anaphylactic shock requiring epinephrine). Captured from clinical documentation in Epic ClinDoc or Cerner PowerChart.',
    `reaction_route` STRING COMMENT 'The route of exposure through which the allergic reaction occurred (e.g., oral ingestion, intravenous administration, topical contact). Informs clinical decision support rules for route-specific allergy alerts. [ENUM-REF-CANDIDATE: oral|intravenous|topical|inhalation|subcutaneous|intramuscular|other — promote to reference product]',
    `reaction_snomed_code` STRING COMMENT 'The SNOMED CT concept code representing the clinical manifestation of the allergic reaction (e.g., urticaria, anaphylaxis, angioedema). Enables structured clinical reporting and interoperability via HL7 FHIR.. Valid values are `^[0-9]{6,18}$`',
    `reconciliation_date` DATE COMMENT 'The date on which this allergy record was last reviewed and reconciled as part of a medication reconciliation process. Supports compliance with The Joint Commission NPSG.03.06.01 and CMS discharge planning requirements.',
    `reconciliation_status` STRING COMMENT 'Indicates whether this allergy has been reviewed and reconciled during a medication reconciliation process (e.g., at admission, discharge, or care transitions). Supports Transitions of Care compliance and The Joint Commission NPSG requirements.. Valid values are `reconciled|not_reconciled|pending`',
    `recorded_date` TIMESTAMP COMMENT 'The date and timestamp when this allergy record was first entered into the Electronic Health Record (EHR) system. Represents the RECORD_AUDIT_CREATED canonical category for this entity. Used for audit trails and Clinical Documentation Improvement (CDI) workflows.',
    `severity` STRING COMMENT 'Clinical severity classification of the allergic reaction. Drives clinical decision support alert levels and patient safety protocols. Values align with HL7 FHIR AllergyIntolerance severity coding.. Valid values are `mild|moderate|severe|life_threatening`',
    `source_system_allergy_code` STRING COMMENT 'The native identifier for this allergy record in the originating operational system (e.g., Epic allergy ID, Cerner allergy ID). Enables traceability back to the system of record for reconciliation and audit.',
    `verification_status` STRING COMMENT 'Clinical verification status of the allergy record indicating the confidence level of the allergy documentation. Entered-in-error records are retained for audit purposes per Health Information Management (HIM) standards.. Valid values are `confirmed|unconfirmed|refuted|entered_in_error`',
    CONSTRAINT pk_allergy PRIMARY KEY(`allergy_id`)
) COMMENT 'Patient allergy and adverse reaction records including drug allergies, food allergies, environmental allergens, and contrast media reactions. Captures allergen name, allergen type, reaction description, reaction severity (mild, moderate, severe, life-threatening), onset date, verification status (confirmed, unconfirmed, entered-in-error), and the documenting provider. SNOMED CT and NDF-RT coded. Critical patient safety data sourced from Epic and Cerner allergy modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`immunization` (
    `immunization_id` BIGINT COMMENT 'Unique surrogate identifier for each immunization administration record in the lakehouse silver layer. Primary key for this data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or clinic location where the immunization was administered. Supports public health reporting by site.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Immunizations fulfill vaccine orders. Real workflow: provider orders flu vaccine, nurse administers. Essential for vaccine order-to-administration tracking, VFC program compliance, immunization regist',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Immunization billing for vaccine administration charges, counseling services, and combination vaccine coding. Revenue cycle teams use CPT codes for vaccine administration to generate accurate claims a',
    `hedis_measure_id` BIGINT COMMENT 'Foreign key linking to quality.hedis_measure. Business justification: HEDIS immunization measures (childhood vaccines, flu shots, pneumococcal) directly reference immunization records for numerator compliance. Essential for HEDIS reporting and health plan quality rating',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider who administered the vaccine. Corresponds to the National Provider Identifier (NPI)-registered provider.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Vaccines are inventory items with lot tracking, expiration management, and recall requirements. Enables vaccine inventory management, VFC program compliance, and immunization registry reporting. Remov',
    `immunization_ordering_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who ordered or authorized the immunization, which may differ from the administering provider. Supports Computerized Physician Order Entry (CPOE) traceability.',
    `immunization_supply_lot_number_material_master_id` BIGINT COMMENT 'add column supply_lot_number_material_master_id (BIGINT) with FK to supply.material_master.material_master_id - immunization already links to drug_master but should also track the physical supply/lot via material_master for recall traceabil',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received the immunization. Links to the Master Patient Index (MPI) patient record.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Vaccine product identification for inventory management, lot tracking, recall management, and VFC program compliance. Pharmacy and immunization registries use NDC codes to track specific vaccine produ',
    `primary_care_physician_clinician_id` BIGINT COMMENT 'Reference to the patients Primary Care Physician (PCP) at the time of immunization. Supports care coordination, preventive care gap closure, and HEDIS reporting for immunization measures.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Immunizations require documented consent, especially for minors, research vaccines, or religious exemptions. VIS presentation and consent documentation are CDC and state-mandated. Links immunization e',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Immunizations are pharmaceutical products tracked in inventory and formulary systems. Vaccine administration requires drug master reference for lot tracking, expiration management, recall notification',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the immunization was administered. Supports linkage to Admit-Discharge-Transfer (ADT) and clinical encounter context.',
    `administration_route_code` STRING COMMENT 'The coded route by which the vaccine was administered (e.g., IM for intramuscular, SC for subcutaneous, PO for oral, IN for intranasal). Follows NCI Thesaurus / HL7 route of administration codes.. Valid values are `IM|SC|ID|PO|IN|IV`',
    `administration_site_code` STRING COMMENT 'Coded anatomical site where the vaccine was injected or administered (e.g., LA for left arm deltoid, RT for right thigh). Uses HL7 v2 or SNOMED CT body site codes. Required for adverse event documentation. [ENUM-REF-CANDIDATE: LA|RA|LT|RT|LG|RG|ABD|NASAL|ORAL — promote to reference product]',
    `administration_status` STRING COMMENT 'Current lifecycle status of the immunization record indicating whether the vaccine was successfully administered, not given, or entered in error. Aligns with HL7 FHIR Immunization.status value set.. Valid values are `completed|entered-in-error|not-done`',
    `administration_timestamp` TIMESTAMP COMMENT 'The exact date and time the vaccine was administered to the patient. This is the principal real-world event timestamp for the immunization record. Sourced from Epic or Cerner immunization module.',
    `clinical_note` STRING COMMENT 'Free-text clinical notes or comments documented by the administering provider regarding the immunization event, patient response, or special circumstances. Supports Clinical Documentation Improvement (CDI) workflows.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the patient or legal guardian prior to vaccine administration. Supports NCVIA compliance and risk management documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this immunization record was first created or entered into the source system. Supports audit trail, data lineage, and HIPAA compliance documentation.',
    `dose_number_in_series` STRING COMMENT 'The sequential dose number within the immunization series (e.g., 1 for first dose, 2 for second dose, 3 for booster). Used to track series completion and determine next dose eligibility.',
    `dose_quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of vaccine administered in the specified dose unit of measure (e.g., 0.5 mL). Supports clinical documentation and adverse event investigation.',
    `dose_unit` STRING COMMENT 'The unit of measure for the administered vaccine dose quantity (e.g., mL, mg). Follows UCUM (Unified Code for Units of Measure) standards as used in HL7 FHIR.. Valid values are `mL|mg|mcg|units`',
    `expiration_date` DATE COMMENT 'The manufacturer-assigned expiration date of the vaccine lot administered. Required for quality assurance, regulatory compliance, and to flag potential administration of expired product.',
    `funding_source_code` STRING COMMENT 'Code identifying the funding source for the administered vaccine. VFC indicates Vaccines for Children program eligibility; 317 indicates CDC Section 317 public health grant funding. Required for state IIS reporting and VFC program compliance.. Valid values are `VFC|317|STATE|PRIVATE|OTHER`',
    `iis_reported` BOOLEAN COMMENT 'Indicates whether this immunization record has been successfully reported to the state Immunization Information System (IIS) / immunization registry. Supports public health reporting compliance tracking.',
    `iis_reported_timestamp` TIMESTAMP COMMENT 'The date and time this immunization record was transmitted to the state Immunization Information System (IIS). Supports audit trail for public health reporting obligations.',
    `lot_number` STRING COMMENT 'The manufacturer-assigned lot number for the specific vaccine vial or unit administered. Critical for adverse event tracking, FDA recall management, and Vaccine Adverse Event Reporting System (VAERS) reporting.',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient by the healthcare organization. Used for cross-system patient identification and immunization registry reporting.',
    `not_given_reason_code` STRING COMMENT 'Coded reason why the immunization was not administered when administration_status is not-done. Examples include patient refusal, contraindication, or vaccine unavailability. SNOMED CT coded.',
    `reaction_detail` STRING COMMENT 'Free-text or coded description of the adverse reaction observed following vaccine administration. Supports VAERS reporting and clinical documentation. SNOMED CT coded when structured.',
    `reaction_observed` BOOLEAN COMMENT 'Indicates whether an adverse reaction or side effect was observed following vaccine administration. When true, triggers adverse event documentation workflow and potential VAERS reporting.',
    `series_completion_status` STRING COMMENT 'Indicates the patients current completion status for the immunization series as of this administration event. Supports population health management, HEDIS measure reporting, and preventive care outreach.. Valid values are `complete|in-progress|not-started|overdue`',
    `series_doses_required` STRING COMMENT 'The total number of doses required to complete the immunization series as defined by the CDC Advisory Committee on Immunization Practices (ACIP) schedule (e.g., 2 for Hepatitis B, 3 for HPV).',
    `series_name` STRING COMMENT 'The name of the immunization series or protocol to which this dose belongs (e.g., COVID-19 Primary Series, Hepatitis B 3-Dose Series, Childhood Immunization Schedule). Supports series completion tracking.',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating operational system (Epic, Cerner, etc.) for this immunization administration event. Enables traceability back to the system of record for audit and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time this immunization record was last modified or updated in the source system. Supports change tracking, audit trail, and data quality monitoring.',
    `vaers_reported` BOOLEAN COMMENT 'Indicates whether an adverse event following this immunization was reported to the FDA/CDC Vaccine Adverse Event Reporting System (VAERS). Required for pharmacovigilance and regulatory compliance.',
    `vfc_eligibility_code` STRING COMMENT 'CDC-assigned Vaccines for Children (VFC) eligibility category code for the patient at time of administration (e.g., V01=Medicaid eligible, V02=Uninsured, V03=American Indian/Alaska Native, V04=Underinsured). Required for VFC program billing and compliance reporting.. Valid values are `V01|V02|V03|V04|V05|V06`',
    `vis_document_type` STRING COMMENT 'The type or name of the CDC Vaccine Information Statement (VIS) provided to the patient or guardian prior to administration (e.g., Influenza VIS, COVID-19 mRNA VIS). Required by the National Childhood Vaccine Injury Act (NCVIA).',
    `vis_presentation_date` DATE COMMENT 'The date the Vaccine Information Statement (VIS) was presented to the patient or legal guardian. Documents informed consent compliance per NCVIA requirements.',
    `vis_publication_date` DATE COMMENT 'The CDC publication date of the Vaccine Information Statement (VIS) provided to the patient. Required for NCVIA compliance documentation and immunization registry reporting.',
    CONSTRAINT pk_immunization PRIMARY KEY(`immunization_id`)
) COMMENT 'Patient immunization administration records including vaccine administered, CVX code, NDC code, lot number, expiration date, manufacturer, administration site, route, dose number in series, VIS (Vaccine Information Statement) date, administering provider, and administration date/time. Tracks immunization series completion status. Sourced from Epic and Cerner immunization modules. Supports public health reporting to state immunization registries (IIS).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` (
    `vital_sign_id` BIGINT COMMENT 'Unique surrogate identifier for each vital sign measurement record in the lakehouse silver layer. Primary key for the vital_sign data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where the vital sign measurement was taken. Supports multi-facility analytics, population health management, and facility-level quality reporting.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Vital signs fulfill monitoring orders. Real workflow: order for q4h vitals, nurse documents BP/HR. Essential for order compliance tracking, nursing workload analysis, sepsis protocol adherence, and re',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician (nurse, physician, or allied health professional) who recorded or validated the vital sign measurement. Supports accountability and CDI workflows.',
    `equipment_asset_id` BIGINT COMMENT 'Reference to the medical device (bedside monitor, pulse oximeter, thermometer, sphygmomanometer) used to capture the measurement. Supports device integration pipeline traceability and device-level quality audits.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Vital sign observation standardization for clinical surveillance, early warning scores, quality measure calculation, and interoperable data exchange. Clinical systems use LOINC codes to aggregate vita',
    `mar_record_id` BIGINT COMMENT 'Foreign key linking to pharmacy.mar_record. Business justification: Vital signs documented at medication administration time for high-risk medications (BP before antihypertensives, HR before beta-blockers, glucose before insulin). Required for safe medication administ',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom the vital sign measurement was recorded. Links to the master patient record in the Patient domain.',
    `previous_vital_sign_id` BIGINT COMMENT 'Reference to the prior version of this vital sign record when observation_status is amended or corrected. Enables amendment chain traceability and supports audit requirements for clinical documentation integrity.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Many quality measures have vital sign thresholds (BP control in hypertension, BMI documentation). Direct linkage supports automated measure calculation and clinical decision support for quality improv',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, ED visit, outpatient visit) during which the vital sign was measured. Supports encounter-level trending and early warning score calculations.',
    `abnormal_flag` BOOLEAN COMMENT 'Interpretation flag indicating whether the measured value falls within, below, or above the reference range. critical_low and critical_high trigger immediate clinical notification per facility policy. Supports sepsis screening, EWS alerting, and clinical deterioration detection workflows.',
    `amended_reason` STRING COMMENT 'The clinical or administrative reason provided when a vital sign record is amended, corrected, or marked as entered-in-error (e.g., transcription error, wrong patient, device malfunction, duplicate entry). Populated only when observation_status is amended, corrected, or entered-in-error. Supports CDI audit trails and data quality governance.',
    `body_site` STRING COMMENT 'The anatomical body site where the measurement was taken (e.g., left arm, right arm, finger, ear, forehead, toe). Encoded using SNOMED CT body structure codes. Relevant for blood pressure laterality, temperature site, and SpO2 probe placement. Affects clinical interpretation.',
    `care_unit` STRING COMMENT 'The clinical care unit or department where the patient was located when the vital sign was measured (e.g., ICU, ED, Medical/Surgical, OR, PACU, Step-Down). Supports unit-level benchmarking, staffing analytics, and HAI surveillance.',
    `clinical_note` STRING COMMENT 'Free-text clinical annotation or comment entered by the recording clinician to provide context for the vital sign measurement (e.g., patient anxious during measurement, cuff size large, post-exercise reading). Supports CDI workflows and clinical interpretation.',
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
    `numeric_value` DECIMAL(18,2) COMMENT 'The principal quantitative measured value of the vital sign observation (e.g., 120 for systolic BP in mmHg, 98.6 for temperature in °F, 98 for SpO2 in %). Stored as a decimal to accommodate fractional values such as temperature and BMI. Null when the observation is non-numeric (e.g., qualitative pain descriptors).',
    `observation_status` STRING COMMENT 'Current lifecycle status of the vital sign observation record per HL7 FHIR Observation status value set. final indicates a verified measurement; amended or corrected indicates a post-documentation change; entered-in-error flags records to be excluded from clinical calculations. Supports data quality filtering for EWS and sepsis screening. [ENUM-REF-CANDIDATE: registered|preliminary|final|amended|corrected|cancelled|entered-in-error — 7 candidates stripped; promote to reference product]',
    `observation_type` STRING COMMENT 'Standardized enumeration of the vital sign observation category captured in this record. Each row represents a single atomic observation. Supports time-series analytics, EWS/MEWS/NEWS scoring, and sepsis screening. [ENUM-REF-CANDIDATE: blood_pressure_systolic|blood_pressure_diastolic|heart_rate|respiratory_rate|temperature|spo2|height|weight|bmi|pain_score|gcs_total — promote to reference product]',
    `oxygen_delivery_method` STRING COMMENT 'The supplemental oxygen delivery method in use at the time of SpO2 or respiratory rate measurement (e.g., room air, nasal cannula, simple mask, non-rebreather mask, high-flow nasal cannula, mechanical ventilator). Null for non-respiratory vital signs. Critical context for SpO2 interpretation and NEWS2 scoring (Scale 1 vs Scale 2).. Valid values are `room_air|nasal_cannula|simple_mask|non_rebreather|high_flow_nasal|mechanical_ventilator`',
    `pain_scale_type` STRING COMMENT 'The specific pain assessment scale used when observation_type is pain_score (e.g., Numeric Rating Scale 0-10, Visual Analog Scale, Wong-Baker FACES, FLACC for pediatric/non-verbal, CPOT for critically ill). Null for non-pain vital sign observations. Required for accurate pain score interpretation per Joint Commission pain management standards.. Valid values are `numeric_rating|visual_analog|faces|flacc|cpot|behavioral`',
    `patient_position` STRING COMMENT 'The patients body position at the time of the vital sign measurement (e.g., sitting, standing, supine). Particularly relevant for blood pressure and orthostatic vital sign assessments. Encoded using SNOMED CT observable entity codes. [ENUM-REF-CANDIDATE: sitting|standing|supine|prone|left_lateral|right_lateral|semi-recumbent — 7 candidates stripped; promote to reference product]',
    `reference_range_high` DECIMAL(18,2) COMMENT 'The upper bound of the normal reference range for this vital sign observation type, in the same unit of measure as numeric_value. Used for clinical alerting, EWS/MEWS/NEWS scoring, and out-of-range flagging.',
    `reference_range_low` DECIMAL(18,2) COMMENT 'The lower bound of the normal reference range for this vital sign observation type, in the same unit of measure as numeric_value. Used for clinical alerting, EWS/MEWS/NEWS scoring, and out-of-range flagging. Age- and condition-adjusted ranges may differ from population norms.',
    `snomed_finding_code` STRING COMMENT 'SNOMED CT clinical finding code representing the clinical interpretation of the vital sign result (e.g., 38341003 Hypertensive disorder, 44054006 Diabetes mellitus type 2 context). Supports semantic interoperability, clinical decision support, and FHIR-based HIE exchange.. Valid values are `^[0-9]{6,18}$`',
    `source_system_record_code` STRING COMMENT 'The native primary key or observation identifier from the originating source system (Epic, Cerner, MEDITECH, or device integration platform). Enables bidirectional traceability between the lakehouse silver layer record and the operational EHR record for reconciliation and audit.',
    `supplemental_oxygen_flow_rate` DECIMAL(18,2) COMMENT 'The flow rate of supplemental oxygen in liters per minute (L/min) being administered to the patient at the time of the SpO2 or respiratory vital sign measurement. Null when oxygen_delivery_method is room_air or for non-respiratory observations. Supports NEWS2 Scale 2 scoring and respiratory therapy documentation.',
    `text_value` DECIMAL(18,2) COMMENT 'Free-text or coded string value for vital sign observations that are qualitative or semi-quantitative (e.g., pain descriptor mild, moderate, severe; GCS verbal response oriented; SpO2 trend improving). Null when numeric_value is populated.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the numeric vital sign value using UCUM (Unified Code for Units of Measure) notation (e.g., mm[Hg] for blood pressure, /min for heart/respiratory rate, Cel or [degF] for temperature, % for SpO2, cm or [in_i] for height, kg or [lb_av] for weight, kg/m2 for BMI, {score} for pain/GCS).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this vital sign record was last modified in the lakehouse silver layer (e.g., due to an amendment, correction, or status change propagated from the source EHR). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_vital_sign PRIMARY KEY(`vital_sign_id`)
) COMMENT 'Patient vital sign measurements captured during clinical encounters, nursing assessments, and continuous monitoring. Includes LOINC-coded observation types: blood pressure (systolic/diastolic), heart rate, respiratory rate, temperature, SpO2, height, weight, BMI, pain score, and Glasgow Coma Scale (GCS). Captures measured value, unit of measure, measurement method, body site, patient position, device used, measurement date/time, and recording clinician. Supports early warning score (EWS/MEWS/NEWS) calculations, sepsis screening, and clinical deterioration detection. High-volume time-series clinical data sourced from Epic ClinDoc flowsheets, Cerner PowerChart, and bedside monitoring device integrations. Separated from clinical_observation due to distinct high-frequency time-series ingestion patterns, dedicated device integration pipelines, and specialized analytics (trending, alerting, waveform correlation). Maps to FHIR Observation with vitals profile (US Core Vital Signs).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`observation` (
    `observation_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical observation record in the lakehouse silver layer. Primary key for the observation data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where the observation was recorded. Supports multi-facility reporting and regulatory submissions.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Observations fulfill assessment orders. Real workflow: order for fall risk assessment, nurse performs Morse scale. Essential for order completion tracking, nursing documentation compliance, quality me',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed clinician (nurse, physician, therapist, or other credentialed provider) who documented or performed this observation. Supports accountability and Joint Commission documentation requirements.',
    `flowsheet_row_id` BIGINT COMMENT 'The source EHR flowsheet row or template identifier that defines the observation type in the originating system (e.g., Epic ClinDoc flowsheet row ID, Cerner PowerChart flowsheet mnemonic). Enables precise source system reconciliation and CDI workflow support.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Lab result and clinical observation standardization for result interpretation, reference range application, critical value alerting, and public health reporting. Laboratory information systems use LOI',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this clinical observation was recorded. Core party reference linking the observation to the Master Patient Index (MPI).',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Lab-based measures (HbA1c, LDL-C) and assessment-based measures (depression screening PHQ-9) require observation data for numerator determination. Essential for automated quality measure calculation a',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical finding and assessment coding for structured documentation, clinical decision support, and quality measure calculation. SNOMED codes on observations enable semantic reasoning for care pathway',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit, admission, or episode of care) during which this observation was documented. Links the observation to its clinical context.',
    `amendment_reason` STRING COMMENT 'Free-text or coded reason provided by the clinician for amending or correcting this observation after initial documentation. Required for CDI audit trails and HIPAA amendment compliance. Null when is_amended is false.',
    `assessment_component` STRING COMMENT 'The specific sub-component or domain of a multi-part assessment tool being scored in this observation record (e.g., Sensory Perception for Braden Scale, Eye Opening for GCS, Mood for PHQ-9 item 1). Enables granular component-level analysis.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Total composite score produced by the standardized assessment tool identified in assessment_tool (e.g., Braden Scale total score 6-23, Morse Fall Scale score 0-125, PHQ-9 score 0-27, GCS total 3-15). Drives clinical decision support thresholds and quality metric calculations.',
    `assessment_tool` STRING COMMENT 'Name of the standardized clinical assessment instrument or scoring tool used to generate this observation (e.g., Braden Scale, Morse Fall Scale, PHQ-9, GCS, Barthel Index, CAGE-AID, Columbia Suicide Severity Rating Scale, FIM). Supports nursing quality metrics and regulatory compliance reporting. [ENUM-REF-CANDIDATE: Braden Scale|Morse Fall Scale|PHQ-9|GCS|Barthel Index|CAGE-AID|Columbia Suicide Severity|FIM|SDOH Screening|Discharge Readiness — promote to reference product]',
    `body_site_code` STRING COMMENT 'SNOMED CT code identifying the anatomical body site or region where the observation was performed or applies (e.g., 368209003 for right arm for blood pressure, 368209003 for wound location). Supports wound care documentation and surgical site infection (SSI) tracking.',
    `body_system` STRING COMMENT 'Clinical body system or organ system to which this observation pertains (e.g., cardiovascular, respiratory, neurological, integumentary, musculoskeletal, gastrointestinal). Supports head-to-toe nursing assessment documentation and clinical analytics segmentation. [ENUM-REF-CANDIDATE: cardiovascular|respiratory|neurological|integumentary|musculoskeletal|gastrointestinal|genitourinary|endocrine|hematologic|psychiatric — promote to reference product]',
    `care_setting` STRING COMMENT 'The clinical care setting or unit type in which the observation was documented (e.g., inpatient, ED, ICU, OR, ambulatory, telehealth). Supports population health stratification, nursing quality metrics, and setting-specific regulatory reporting. [ENUM-REF-CANDIDATE: inpatient|outpatient|ED|ICU|OR|ambulatory|telehealth|home-health — 8 candidates stripped; promote to reference product]',
    `observation_category` STRING COMMENT 'High-level clinical category classifying the type of observation per HL7 FHIR value set (e.g., vital-signs, nursing, functional, screening, exam). Drives downstream routing, analytics segmentation, and FHIR Observation.category mapping. [ENUM-REF-CANDIDATE: vital-signs|laboratory|nursing|functional|screening|exam|social-history|imaging — 8 candidates stripped; promote to reference product]',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this observation record was first created in the source system or ingested into the lakehouse. Supports audit trail requirements, data lineage, and HIPAA access log compliance.',
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
    `presence_status` STRING COMMENT 'Indicates whether the clinical finding or condition being observed is present, absent, or unknown for this patient at the time of observation. Critical for problem list management, SNOMED CT post-coordination, and population health stratification.. Valid values are `present|absent|unknown|not-applicable`',
    `reference_range_high` DECIMAL(18,2) COMMENT 'The upper bound of the normal reference range for this observation type and patient population context (e.g., 100 for heart rate upper bound). Used to compute interpretation_flag and support clinical decision support.',
    `reference_range_low` DECIMAL(18,2) COMMENT 'The lower bound of the normal reference range for this observation type and patient population context (e.g., 60 for heart rate lower bound). Used to compute interpretation_flag and support clinical decision support.',
    `sdoh_domain` STRING COMMENT 'For SDOH screening observations, identifies the specific Social Determinants of Health (SDOH) domain being assessed (e.g., food insecurity, housing instability, transportation barriers). Supports population health management, ACO quality reporting, and CMS SDOH initiatives. [ENUM-REF-CANDIDATE: food-insecurity|housing-instability|transportation|social-isolation|financial-strain|education|not-applicable — 7 candidates stripped; promote to reference product]',
    `severity` STRING COMMENT 'Clinician-assessed severity of the finding or symptom documented in this observation (e.g., mild pain, severe dyspnea). Used in symptom documentation, behavioral health screenings, and clinical acuity stratification.. Valid values are `mild|moderate|severe|life-threatening|not-applicable`',
    `observation_status` STRING COMMENT 'Current workflow lifecycle status of the observation record per HL7 FHIR Observation.status value set. final indicates a verified, clinician-signed result; amended or corrected indicates post-signature modification; entered-in-error supports clinical documentation correction workflows. [ENUM-REF-CANDIDATE: registered|preliminary|final|amended|corrected|cancelled|entered-in-error — 7 candidates stripped; promote to reference product]',
    `subcategory` STRING COMMENT 'Finer-grained clinical classification within the observation_category (e.g., fall-risk, pressure-injury, neurological, wound, intake-output, behavioral-health, sdoh, discharge-readiness). Supports nursing quality metrics and Joint Commission compliance reporting. [ENUM-REF-CANDIDATE: fall-risk|pressure-injury|neurological|wound|intake-output|behavioral-health|sdoh|discharge-readiness|pain|functional-status — promote to reference product]',
    `updated_datetime` TIMESTAMP COMMENT 'The date and time when this observation record was most recently modified in the source system or updated in the lakehouse silver layer. Supports incremental ETL processing, CDI workflows, and audit trail requirements.',
    `value_coded` STRING COMMENT 'The coded result value when the observation is expressed as a standardized code (e.g., SNOMED CT code 260385009 for negative, 10828004 for positive, or a LOINC answer list code). Used for coded clinical findings, presence/absence, and assessment scale responses.',
    `value_coded_system` STRING COMMENT 'The coding system used for the coded observation value when the result is expressed as a code rather than a number (e.g., SNOMED-CT for clinical findings, LOINC answer lists). Null when value_numeric or value_text is used.. Valid values are `SNOMED-CT|LOINC|ICD-10|CPT|LOCAL`',
    `value_numeric` DECIMAL(18,2) COMMENT 'The quantitative measured value of the observation when the result is numeric (e.g., 98.6 for temperature, 120 for systolic blood pressure, 7 for GCS eye response score, 15 for Braden Scale total). Null when the observation result is coded or free-text.',
    `value_text` STRING COMMENT 'Free-text narrative value for observations that cannot be expressed numerically or as a coded value (e.g., wound description, clinical impression, nursing note excerpt). Contains Protected Health Information (PHI) and must be handled per HIPAA requirements.',
    `value_unit` STRING COMMENT 'The unit of measure for the numeric observation value using UCUM (Unified Code for Units of Measure) notation (e.g., degF, mm[Hg], kg, /min, %, mL). Required when value_numeric is populated.',
    CONSTRAINT pk_observation PRIMARY KEY(`observation_id`)
) COMMENT 'SSOT for all structured clinical observations, assessments, scored evaluations, and clinical findings documented by clinicians during patient care. Encompasses LOINC-coded and SNOMED CT-coded observations across all clinical contexts including: nursing assessments (head-to-toe, skin integrity, restraint, fall risk using Morse/Braden scales, pressure injury staging, discharge readiness), functional status assessments (Barthel Index, FIM, ADL/IADL), behavioral health screenings (PHQ-9, CAGE-AID, Columbia Suicide Severity), SDOH screenings, wound assessments, intake/output measurements, neurological assessments (GCS components), physical examination findings, symptom documentation, and clinical impressions. Captures observation code, value (numeric, coded, or text), units, reference range, interpretation flag (normal, abnormal, critical), observation_category (nursing, functional, finding, screening, exam), assessment tool used, body system/site, laterality, severity, presence status (present, absent, unknown), observation date/time, and recording clinician. High-volume structured clinical data sourced from Epic ClinDoc flowsheets, Cerner PowerChart, and structured documentation modules. Supports nursing quality metrics, discharge planning, population health stratification, Joint Commission compliance, and FHIR Observation resource interoperability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` (
    `care_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the care plan record in the lakehouse Silver layer. Primary key for this entity.',
    `accreditation_survey_id` BIGINT COMMENT 'Foreign key linking to quality.accreditation_survey. Business justification: Care plan documentation is reviewed during accreditation surveys for compliance with care planning standards. Surveyors assess care plan quality during tracer methodology. Essential for accreditation ',
    `order_set_id` BIGINT COMMENT 'Foreign key linking to order.order_set. Business justification: Care plans activate order sets. Real workflow: CHF care plan triggers CHF admission order set. Essential for care pathway compliance tracking, order set utilization analysis, population health protoco',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or care setting (hospital, outpatient clinic, SNF, home health) where this care plan is being managed.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this care plan was created. Links to the patient master record.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Care plans specify DME, supplies, and medications required for patient management. Enables care plan-driven supply provisioning, discharge planning supply coordination, and transitions-of-care supply ',
    `mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - care_plan links to patient.demographics but not mpi_record; since mpi_record is the SSOT for patient identity, this FK is essential',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Care plans are often mandated by payer contracts (ACO requirements, care management programs, chronic care management billing). Payer-specific quality measures and care coordination requirements drive',
    `clinician_id` BIGINT COMMENT 'Reference to the care coordinator or case manager assigned to oversee execution of this care plan, distinct from the authoring provider. Supports ACO care coordination workflows and population health management.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Care plan measures (care plan documented for chronic conditions, advance care planning) require linking care plans to quality metrics. Essential for care coordination quality reporting and value-based',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Care plans require patient consent for goals, interventions, and care team access. CMS Conditions of Participation and ACO programs mandate documented patient consent for care plan development and sha',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Care plan categorization for care coordination workflows, population health program assignment, and FHIR CarePlan resource generation. Care management teams use SNOMED categories to route patients to ',
    `tertiary_care_pcp_clinician_id` BIGINT COMMENT 'Reference to the patients Primary Care Physician (PCP) who should receive care plan summary and transition communications. Supports care continuity, ACO attribution, and CMS transitions of care quality measures.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, outpatient visit, ED visit) during which this care plan was initiated or most recently updated.',
    `aco_attributed` BOOLEAN COMMENT 'Indicates whether this care plan is associated with a patient attributed to an Accountable Care Organization (ACO) program. Drives ACO quality reporting, shared savings calculations, and population health management workflows.',
    `advance_directive_on_file` BOOLEAN COMMENT 'Indicates whether a valid advance directive (living will, POLST, MOLST, or healthcare proxy) is on file for this patient and has been reviewed in the context of this care plan. Required for CMS Conditions of Participation and Joint Commission compliance.',
    `authored_date` DATE COMMENT 'The calendar date on which the care plan was originally authored or first documented in the EHR. Distinct from the effective start date; captures the documentation event timestamp at day granularity.',
    `behavioral_health_flag` BOOLEAN COMMENT 'Indicates whether this care plan addresses behavioral health, mental health, or substance use disorder conditions. Triggers enhanced privacy protections under 42 CFR Part 2 and state mental health parity laws, restricting downstream data sharing.',
    `care_setting` STRING COMMENT 'The clinical care setting in which this care plan is being executed. Drives population health segmentation, ACO attribution, and CMS quality measure reporting. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|icu|home_health|snf|hospice|telehealth — promote to reference product]',
    `cdi_review_status` STRING COMMENT 'Status of the Clinical Documentation Improvement (CDI) review process for this care plan. CDI specialists review care plans to ensure diagnoses and clinical findings are accurately and completely documented to support appropriate DRG assignment and quality reporting.. Valid values are `pending|in_review|completed|not_required`',
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
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this care plan by the responsible care team. Used for care management workflow queuing and overdue plan identification.',
    `patient_consent_date` DATE COMMENT 'Date on which the patient or authorized representative provided consent for this care plan. Required for HIPAA documentation and CMS regulatory compliance.',
    `patient_consent_obtained` BOOLEAN COMMENT 'Indicates whether the patient (or authorized representative) has provided informed consent for the care plan and its associated interventions. Required for HIPAA compliance and CMS Conditions of Participation.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the care plan per HL7 FHIR CarePlan status value set. draft indicates not yet activated; active is in use; on-hold is temporarily suspended; completed indicates all goals met; revoked indicates cancelled before completion.. Valid values are `draft|active|on-hold|completed|revoked|entered-in-error`',
    `plan_title` STRING COMMENT 'Human-readable title or name of the care plan as displayed in the EHR (e.g., Diabetes Management Plan, Post-Surgical Discharge Plan, CHF Chronic Disease Management).',
    `plan_type` STRING COMMENT 'Classification of the care plan by care setting and purpose. Drives workflow routing and regulatory reporting. [ENUM-REF-CANDIDATE: inpatient|outpatient|chronic_disease|discharge|transitional|palliative|preventive — promote to reference product]',
    `population_health_program` STRING COMMENT 'Name or code of the population health management program (e.g., Diabetes Registry, CHF Disease Management, Hypertension Control, Preventive Care Outreach) under which this care plan is managed. Supports HEDIS measure attribution and ACO program reporting.',
    `primary_diagnosis_description` STRING COMMENT 'Plain-text description of the primary diagnosis or clinical problem driving this care plan, corresponding to the primary ICD-10 code. Stored for reporting and display without requiring a code lookup.',
    `primary_icd10_code` STRING COMMENT 'The primary ICD-10-CM diagnosis code representing the principal clinical problem or condition being addressed by this care plan. Supports DRG grouping, quality measure attribution, and population health stratification.. Valid values are `^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$`',
    `readmission_risk_level` STRING COMMENT 'Clinician-assigned or algorithmically-derived readmission risk stratification for this patient at the time of care plan creation. Drives care management intensity and post-discharge follow-up scheduling. Supports CMS Hospital Readmissions Reduction Program (HRRP) compliance.. Valid values are `low|medium|high|very_high`',
    `review_frequency` STRING COMMENT 'Prescribed frequency at which this care plan should be formally reviewed and updated by the care team. Drives scheduling of care plan review encounters and supports NCQA PCMH and CMS chronic care management billing requirements. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annually|as_needed — 7 candidates stripped; promote to reference product]',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether Social Determinants of Health (SDOH) factors (e.g., food insecurity, housing instability, transportation barriers) have been identified and incorporated into this care plan. Supports CMS SDOH screening requirements and population health management.',
    `transitions_of_care_flag` BOOLEAN COMMENT 'Indicates whether this care plan was created or updated specifically to support a transition of care event (e.g., hospital discharge to home, SNF transfer, ED to inpatient admission). Supports CMS Transitions of Care quality measures and readmission reduction programs.',
    `version_number` STRING COMMENT 'Sequential version number incremented each time the care plan is substantively revised. Supports care plan history tracking, CDI audit trails, and regulatory documentation of plan evolution.',
    CONSTRAINT pk_care_plan PRIMARY KEY(`care_plan_id`)
) COMMENT 'Patient-centered care plans documenting clinical goals, interventions, and expected outcomes across the care continuum. Captures care plan type (inpatient, outpatient, chronic disease, discharge, transitional), status (draft, active, completed, revoked), effective date range, care setting, authoring provider, care team assignment, patient goals with individual lifecycle tracking, clinical problems addressed, and care plan category (SNOMED CT coded). Includes embedded care plan goals as detail records: goal description, SNOMED CT coded goal category, target measure (LOINC coded), target value, target date, achievement status (proposed, accepted, in-progress, achieved, cancelled), priority, and responsible provider. Supports transitions of care, population health management, ACO care coordination, and CMS Conditions of Participation for discharge planning. Sourced from Epic Healthy Planet and Cerner.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` (
    `care_plan_goal_id` BIGINT COMMENT 'Unique surrogate identifier for each individual clinical goal within a care plan. Primary key for this entity in the Silver Layer lakehouse.',
    `care_plan_id` BIGINT COMMENT 'Reference to the parent care plan under which this goal is defined. Each goal belongs to exactly one care plan.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician (physician, nurse practitioner, care manager) accountable for monitoring and advancing this specific goal.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this clinical goal is established. Links to the Master Patient Index (MPI) patient record.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Goal-to-condition linkage for chronic disease management, quality measure attribution, and care gap closure. Population health teams use ICD-10 codes to associate goals with specific conditions for HE',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Specific care plan goals require imaging to measure achievement (tumor reduction, fracture healing). Essential for goal progress tracking and outcome measurement in value-based care programs.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Goals may require specific DME or supplies (e.g., mobility goals → walkers, wound healing goals → wound care supplies). Enables goal-driven supply ordering and care plan supply cost tracking.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Specific goals (achieve BP <140/90, HbA1c <7%) linked to prescribed medication regimens for outcome tracking. Required for population health management and HEDIS measure reporting.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Care plan goals are created to address specific problems on the patients problem list. This is a core clinical workflow: problem identified → goal created → interventions planned → outcomes measured.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Individual goals (especially behavioral health, genetic testing, SDOH interventions) may require separate consent beyond the care plan. Patient agreement tracking and consent for goal-specific interve',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Care plan goals drive specific orders. Real workflow: goal to reduce A1C below 7 triggers quarterly lab orders. Essential for goal-directed care tracking, care gap closure, value-based care reporting,',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Measurable goal definition for care plan tracking, outcome measurement, and patient engagement. Care coordinators use LOINC-coded goals to automatically track progress from lab results, vital signs, a',
    `observation_id` BIGINT COMMENT 'Foreign key linking to clinical.observation. Business justification: Care plan goals often target specific observable measures (e.g., reduce HbA1c to <7%, maintain systolic BP <140). Linking care_plan_goal to observation allows tracking goal achievement against act',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Goal achievement measured by lab values (HbA1c<7% for diabetes control). Role prefix target_ indicates goal measurement. Essential for value-based care reporting and patient engagement dashboards.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this goal was established or most recently reviewed. May be null for goals created outside a discrete encounter context.',
    `achieved_date` DATE COMMENT 'The date on which the clinical goal was documented as achieved. Populated only when goal_status is achieved. Used for outcome measurement and quality reporting.',
    `achievement_status` STRING COMMENT 'Clinical assessment of the degree to which the patient is progressing toward or has achieved the goal. Distinct from lifecycle status — captures clinical trajectory rather than workflow state. Aligns with HL7 FHIR R4 Goal.achievementStatus.. Valid values are `in-progress|improving|worsening|no-change|achieved|not-achieved`',
    `barrier_notes` STRING COMMENT 'Free-text documentation of identified barriers preventing the patient from achieving this goal (e.g., financial constraints, transportation issues, health literacy). Supports Social Determinants of Health (SDOH) analysis and care coordination.',
    `cancellation_reason` STRING COMMENT 'Clinical or administrative reason for cancelling this goal (e.g., Patient declined, Goal no longer clinically appropriate, Superseded by updated goal). Required for care plan audit and CDI workflows.',
    `cancelled_date` DATE COMMENT 'The date on which this clinical goal was cancelled or discontinued. Populated only when goal_status is cancelled. Supports care plan audit and quality review.',
    `care_gap_related` BOOLEAN COMMENT 'Indicates whether this goal was created in response to an identified care gap (e.g., overdue preventive screening, uncontrolled chronic condition measure). Supports HEDIS gap closure tracking and value-based care reporting.',
    `care_team_role` STRING COMMENT 'Clinical role of the care team member primarily responsible for this goal (e.g., Primary Care Physician, Care Manager, Registered Nurse, Dietitian). Supports care team coordination and workload analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this care plan goal record was first created in the system. Used for audit trail, data lineage, and regulatory compliance with medical record retention requirements.',
    `current_value` DECIMAL(18,2) COMMENT 'Most recently recorded value for the LOINC-coded target measure, representing the patients current status relative to the goal target. Enables real-time progress tracking and gap analysis.',
    `current_value_date` DATE COMMENT 'Date on which the current measured value was recorded. Used to assess recency of progress data and identify goals with stale measurements.',
    `expressed_by_type` STRING COMMENT 'Indicates who expressed or originated this goal — the patient themselves, a practitioner, a related person (family member), or a caregiver. Supports patient-centered care analytics and CAHPS reporting.. Valid values are `patient|practitioner|related-person|caregiver`',
    `fhir_goal_reference` STRING COMMENT 'HL7 FHIR R4 logical resource ID for this goal, enabling interoperability with external systems, Health Information Exchanges (HIE), and patient-facing applications via FHIR APIs.. Valid values are `^[A-Za-z0-9-.]{1,64}$`',
    `goal_category_display` STRING COMMENT 'Human-readable display name corresponding to the SNOMED CT goal category code (e.g., Dietary Goal, Exercise Goal, Medication Adherence). Used in clinical reporting and care plan summaries.',
    `goal_category_snomed_code` STRING COMMENT 'SNOMED CT coded category classifying the clinical domain of this goal (e.g., dietary goal, exercise goal, medication adherence goal, physiological goal). Enables standardized population health analytics and HEDIS reporting.. Valid values are `^[0-9]{6,18}$`',
    `goal_description` STRING COMMENT 'Detailed narrative description of the clinical goal, including clinical rationale, patient-specific context, and any relevant instructions. Supports Clinical Documentation Improvement (CDI) and care coordination.',
    `goal_external_code` STRING COMMENT 'Source system identifier for this goal as assigned by the originating Electronic Health Record (EHR) system (e.g., Epic Healthy Planet goal ID). Supports cross-system reconciliation and audit traceability.',
    `goal_status` STRING COMMENT 'Current lifecycle status of the clinical goal reflecting its progression from proposal through achievement or cancellation. Aligns with HL7 FHIR R4 Goal.lifecycleStatus value set.. Valid values are `proposed|accepted|in-progress|achieved|cancelled`',
    `goal_title` STRING COMMENT 'Short, human-readable title summarizing the clinical goal (e.g., Reduce HbA1c to below 7%, Achieve 10,000 steps daily). Used in clinical dashboards and patient-facing care plan summaries.',
    `last_reviewed_date` DATE COMMENT 'Date on which the care team last formally reviewed this goals progress. Used for care management workflows, overdue review identification, and regulatory compliance with care plan review requirements.',
    `note` STRING COMMENT 'Free-text clinical annotation or progress note associated with this goal, capturing care team observations, patient feedback, or contextual information not captured in structured fields.',
    `patient_agreement` BOOLEAN COMMENT 'Indicates whether the patient has agreed to and accepted this clinical goal as part of their care plan. Supports shared decision-making documentation and patient engagement analytics.',
    `priority` STRING COMMENT 'Clinical priority level assigned to this goal relative to other goals in the care plan. Guides care team focus and resource allocation. Aligns with HL7 FHIR R4 Goal.priority value set.. Valid values are `high-priority|medium-priority|low-priority`',
    `review_frequency` STRING COMMENT 'Prescribed frequency at which this goal should be reviewed by the care team. Drives care management workflow scheduling and compliance monitoring.. Valid values are `daily|weekly|monthly|quarterly|annually|as-needed`',
    `sdoh_related` BOOLEAN COMMENT 'Indicates whether this goal is related to Social Determinants of Health (SDOH) factors such as food insecurity, housing instability, or transportation barriers. Enables SDOH-stratified population health reporting.',
    `start_date` DATE COMMENT 'The date on which work toward this clinical goal was initiated or the goal became active. Used for goal duration calculations and longitudinal care analytics.',
    `status_changed_timestamp` TIMESTAMP COMMENT 'Timestamp when the goal_status was most recently changed (e.g., from proposed to accepted, or from in-progress to achieved). Enables lifecycle duration analytics and care management SLA reporting.',
    `target_date` DATE COMMENT 'The date by which the patient is expected to achieve this clinical goal. Used for care plan timeline management, overdue goal identification, and population health reporting.',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target value the patient is expected to achieve for the specified LOINC-coded measure (e.g., 7.0 for HbA1c percentage, 130 for systolic blood pressure in mmHg). Used in progress tracking and outcome analytics.',
    `target_value_comparator` STRING COMMENT 'Relational comparator indicating the direction of the target (e.g., <= means the measured value should be less than or equal to the target). Enables precise goal evaluation logic in clinical decision support.. Valid values are `<|<=|>=|>`',
    `target_value_unit` STRING COMMENT 'Unit of measure for the numeric target value, expressed using UCUM (Unified Code for Units of Measure) notation (e.g., %, mm[Hg], kg, steps/d). Required for clinical interpretation and interoperability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this care plan goal record. Used for change detection, incremental ETL processing, and audit compliance.',
    `version_number` STRING COMMENT 'Sequential version number incremented each time this goal record is substantively updated. Supports audit trail requirements and longitudinal goal history tracking.',
    CONSTRAINT pk_care_plan_goal PRIMARY KEY(`care_plan_goal_id`)
) COMMENT 'Individual clinical goals within a care plan, each with its own lifecycle, target values, and achievement status. Captures goal description, SNOMED CT coded goal category, target measure (LOINC coded), target value, target date, current status (proposed, accepted, in-progress, achieved, cancelled), priority, and the provider responsible for the goal. Enables granular tracking of patient progress toward clinical objectives. Sourced from Epic Healthy Planet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_team` (
    `care_team_id` BIGINT COMMENT 'Unique surrogate identifier for the clinical care team record in the lakehouse silver layer.',
    `clinician_id` BIGINT COMMENT 'Unique surrogate identifier for an individual care team member record (line item within the care team). Each member has their own assignment lifecycle within the parent team. Supports the member-level detail model described in the product specification.',
    `care_plan_id` BIGINT COMMENT 'Reference to the associated care plan that this team is responsible for executing. Links care team accountability to specific clinical goals, interventions, and outcomes defined in the care plan.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, clinic, outpatient center) where this care team operates. Supports multi-facility enterprise analytics and regulatory reporting by facility.',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to quality.improvement_initiative. Business justification: Quality initiatives often involve specific care teams (sepsis team, stroke team). Direct linkage enables tracking team-based initiative impact. Essential for care team performance improvement and acco',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this care team is assigned. Links to the master patient record (MPI). Core PARTY_REFERENCE required by TRANSACTION_HEADER role.',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department or unit (e.g., ICU, Cardiology, ED, Oncology) to which this care team is assigned. Enables department-level care coordination and staffing analytics.',
    `primary_contact_provider_clinician_id` BIGINT COMMENT 'Reference to the care team member designated as the primary point of contact for the patient and family. May differ from the attending provider (e.g., a care coordinator or NP may be the primary contact). Supports care coordination and patient communication workflows.',
    `tertiary_care_member_provider_clinician_id` BIGINT COMMENT 'Reference to the provider (clinician) record for this care team member. Links to the clinician master record for NPI, credentials, and specialty information.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, outpatient visit, ED visit) with which this care team is associated. A care team may exist without a specific encounter for longitudinal/primary care contexts.',
    `aco_attributed` BOOLEAN COMMENT 'Indicates whether this care team is associated with an Accountable Care Organization (ACO) attribution for the patient. Relevant for value-based care reporting, MSSP program compliance, and population health management.',
    `care_coordination_level` STRING COMMENT 'Classification of the intensity of care coordination required for this team, based on patient complexity and care needs. Drives resource allocation, staffing decisions, and care management program enrollment.. Valid values are `standard|enhanced|complex|intensive`',
    `care_setting` STRING COMMENT 'Clinical care setting in which the team operates. Distinct from team_type — care_setting describes the physical/virtual environment of care delivery (e.g., ED, ICU, telehealth), while team_type describes the organizational model. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|observation|telehealth|home_health|skilled_nursing — promote to reference product]',
    `cdi_review_flag` BOOLEAN COMMENT 'Indicates whether this care team record has been flagged for Clinical Documentation Improvement (CDI) review. CDI specialists use this flag to identify cases where care team documentation may require clarification to support accurate coding, DRG assignment, and reimbursement.',
    `coverage_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this care team members coverage period ended. Used in conjunction with coverage_start_timestamp to define shift-level coverage windows and identify coverage gaps.',
    `coverage_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this care team members coverage period began (e.g., start of a shift or on-call rotation). More granular than member_start_date; used for shift-level coverage gap analysis and handoff documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the care team record was first created in the source EHR system. Supports audit trail, data lineage, and regulatory compliance requirements. Aligns with RECORD_AUDIT_CREATED category.',
    `discharge_disposition_code` STRING COMMENT 'CMS-standard discharge disposition code indicating the patients destination upon leaving this care teams care (e.g., 01 = Home, 03 = SNF, 20 = Expired). Populated for inpatient and transitional care teams at team closure. Required for UB-04 billing and CMS quality reporting.',
    `ehr_care_team_csn` STRING COMMENT 'Epic-specific Contact Serial Number (CSN) uniquely identifying the care team context within an Epic encounter. Used for cross-referencing Epic ClinDoc records during ETL and data reconciliation.',
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
    `npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the care team member, as assigned by CMS. Required for billing, credentialing, and regulatory reporting. Denormalized here for care team-level queries without requiring a join to the provider master.. Valid values are `^[0-9]{10}$`',
    `reason_code` STRING COMMENT 'Coded reason for the care team assignment, expressed using SNOMED CT or ICD-10 codes (e.g., a specific diagnosis or condition driving the team composition). Supports clinical decision support and population health analytics.',
    `reason_description` STRING COMMENT 'Free-text or decoded description of the clinical reason for the care team assignment (e.g., Complex heart failure management, Post-surgical recovery). Complements reason_code for human-readable reporting.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether this care team has been assigned to address Social Determinants of Health (SDOH) needs for the patient (e.g., housing instability, food insecurity, transportation barriers). Supports population health management and SDOH screening program reporting.',
    `source_system_team_code` STRING COMMENT 'Native identifier of the care team record in the originating operational system (e.g., Epic internal care team CSN or Cerner care team ID). Enables traceability back to the source EHR for reconciliation and audit.',
    `specialty_code` STRING COMMENT 'Standardized code representing the primary clinical specialty of the care team (e.g., 207R00000X for Internal Medicine per NUCC taxonomy). Enables specialty-based care coordination queries and referral management.',
    `specialty_name` STRING COMMENT 'Human-readable name of the primary clinical specialty of the care team (e.g., Cardiology, Oncology, Pediatrics). Complements specialty_code for display and reporting purposes.',
    `team_end_date` DATE COMMENT 'Date on which the care team was dissolved or the patient was discharged/transitioned out of this teams care. Null for currently active teams. Aligns with FHIR CareTeam.period.end.',
    `team_name` STRING COMMENT 'Human-readable name or label assigned to the care team (e.g., Cardiology Inpatient Team A, Primary Care Team — Dr. Smith). Used for display in EHR care team panels and care coordination dashboards.',
    `team_start_date` DATE COMMENT 'Date on which the care team became active and assumed clinical accountability for the patient. Used for transitions of care documentation and care coordination reporting. Aligns with FHIR CareTeam.period.start.',
    `team_status` STRING COMMENT 'Current lifecycle status of the care team record. Active indicates the team is currently providing care; inactive indicates the team has been dissolved or the patient discharged; proposed indicates a team pending activation; suspended indicates temporary pause; entered-in-error supports data correction workflows.. Valid values are `active|inactive|suspended|proposed|entered-in-error`',
    `team_type` STRING COMMENT 'Classification of the care team by care setting and organizational model. Inpatient teams are hospital-based; outpatient teams support ambulatory care; primary teams represent the patients longitudinal PCP-led team; specialty teams are disease- or organ-specific; multidisciplinary teams span disciplines; transitional teams support transitions of care (e.g., discharge to SNF).. Valid values are `inpatient|outpatient|primary|specialty|multidisciplinary|transitional`',
    `transitions_of_care_flag` BOOLEAN COMMENT 'Indicates whether this care team is specifically designated to manage a transition of care event (e.g., hospital discharge to home, SNF, or rehabilitation). Supports CMS Transitional Care Management (TCM) billing and readmission reduction programs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the care team record in the source EHR system. Supports change detection, incremental ETL processing, and audit trail requirements.',
    `vbp_program_code` STRING COMMENT 'Code identifying the value-based purchasing or alternative payment model (APM) program under which this care team operates (e.g., MSSP, BPCI-A, CPC+). Supports VBP performance tracking and regulatory reporting to CMS.',
    CONSTRAINT pk_care_team PRIMARY KEY(`care_team_id`)
) COMMENT 'Clinical care team assignments for patients, documenting which providers are responsible for a patients care in a given context. Captures care team type (inpatient, outpatient, primary, specialty, multidisciplinary), team status, assignment dates, and individual member detail records: member type (physician, NP, PA, RN, social worker, pharmacist, care coordinator), role code, on-call flag, primary contact flag, participation start/end dates, and active status. Members are modeled as line items within the care team — each with their own assignment lifecycle but always in the context of a parent team. Distinct from workforce scheduling — this is the clinical accountability record. Enables care coordination queries, transitions of care documentation, and care plan team assignment. Sourced from Epic and Cerner care team modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` (
    `care_team_member_id` BIGINT COMMENT 'Unique surrogate identifier for each care team member record in the silver layer lakehouse. Primary key for this entity.',
    `care_plan_id` BIGINT COMMENT 'Reference to the care plan to which this care team members responsibilities are linked. Associates the members role with specific care plan goals, interventions, and outcomes.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, clinic, outpatient center) where this care team member is providing care. Supports multi-facility enterprise care team queries and transitions of care documentation.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this care team membership is established. Links the care team member record to the patients Master Patient Index (MPI) record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department or unit to which this care team member is assigned (e.g., ICU, ED, Cardiology, Oncology). Used for care team composition reporting and operational analytics.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider record for this care team member. Identifies the individual practitioner (physician, NP, PA, RN, pharmacist, social worker, care coordinator, etc.) assigned to the team.',
    `employee_id` BIGINT COMMENT 'The system user identifier of the clinician or staff member who added this provider to the care team. Used for audit trail, accountability, and CDI (Clinical Documentation Improvement) workflows.',
    `care_team_id` BIGINT COMMENT 'Reference to the parent care team to which this member belongs. Links the individual membership record to the overarching care team construct.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient, outpatient, ED visit) during which this care team membership is active. Nullable for longitudinal care team assignments not tied to a single encounter.',
    `admission_date` DATE COMMENT 'The date of the patients admission associated with this care team membership. Used to contextualize the care team assignment within the inpatient episode and for Length of Stay (LOS) analytics.',
    `assignment_end_date` DATE COMMENT 'The date on which this providers membership on the care team ended or is scheduled to end. Nullable for open-ended assignments. Used for historical care team queries and transitions of care documentation.',
    `assignment_start_date` DATE COMMENT 'The date on which this providers membership on the care team became effective. Used to determine the period of clinical responsibility and for transitions of care documentation.',
    `assignment_type` STRING COMMENT 'Classifies the nature of this providers assignment to the care team (e.g., primary responsibility, consulting, covering/cross-coverage, co-managing). Used to distinguish primary from secondary care responsibilities and for billing attribution.. Valid values are `primary|consulting|covering|co-managing|observing`',
    `care_setting` STRING COMMENT 'The clinical care setting in which this care team member is providing services (e.g., inpatient, outpatient, ICU, ED, telehealth). Drives care coordination workflows and transitions of care documentation. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|icu|surgical|telehealth|home_health|skilled_nursing — promote to reference product]',
    `care_team_category` STRING COMMENT 'Classifies the care team type to which this member belongs: longitudinal (ongoing primary care), episode-based (specific inpatient stay), event-based (single procedure or visit), or condition-based (chronic disease management). Aligns with HL7 FHIR CareTeam.category.. Valid values are `longitudinal|episode|event|condition`',
    `clinical_focus` STRING COMMENT 'Free-text or coded description of the specific clinical focus area or condition for which this care team member is responsible (e.g., Diabetes Management, Post-Surgical Recovery, Palliative Care). Supports population health management and care coordination analytics.',
    `coverage_type` STRING COMMENT 'Indicates whether this care team members assignment represents a scheduled/permanent role, cross-coverage arrangement, locum tenens, or temporary assignment. Used for staffing analytics and care continuity tracking.. Valid values are `scheduled|cross_coverage|locum|temporary|permanent`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this care team member record was first created in the source system. Used for audit trail, data lineage, and care team history analytics.',
    `discharge_date` DATE COMMENT 'The date of the patients discharge associated with this care team membership. Used for transitions of care documentation, Length of Stay (LOS) calculations, and post-discharge follow-up assignment.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The proportion of this providers Full-Time Equivalent (FTE) effort allocated to this care team assignment, expressed as a decimal (e.g., 0.50 for 50% effort). Used for workforce planning, staffing analytics, and care team capacity management.',
    `handoff_timestamp` TIMESTAMP COMMENT 'The date and time at which clinical responsibility was formally handed off from this care team member to another provider. Supports transitions of care documentation, Joint Commission handoff communication standards, and care continuity analytics.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this care team member record is currently active and valid. Distinct from member_status in that this flag supports soft-delete and record lifecycle management at the data platform level, while member_status reflects the clinical workflow state.',
    `is_attending` BOOLEAN COMMENT 'Indicates whether this care team member holds the attending physician designation for the encounter or care episode. The attending physician bears primary clinical and legal responsibility for the patients care. Critical for billing, documentation, and regulatory reporting.',
    `is_on_call` BOOLEAN COMMENT 'Indicates whether this care team member is currently designated as on-call for the patient. Supports after-hours care coordination and urgent clinical communication routing.',
    `is_pcp` BOOLEAN COMMENT 'Indicates whether this care team member is the patients designated Primary Care Physician (PCP). Used in population health management, care coordination, and payer attribution workflows.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this care team member is designated as the primary point of contact for the patient and/or family. Only one member per care team should have this flag set to true at any given time. Used in patient communication workflows and care coordination.',
    `member_status` STRING COMMENT 'Current participation status of this care team member. active indicates the member is currently responsible for the patients care; inactive or removed indicates the member has been discharged from the team. Drives care coordination queries and transitions of care documentation.. Valid values are `active|inactive|pending|suspended|removed`',
    `member_type` STRING COMMENT 'Broad classification of the care team members professional discipline or role category (e.g., physician, nurse practitioner, pharmacist, social worker). Drives care coordination workflows and transitions of care documentation. [ENUM-REF-CANDIDATE: physician|nurse_practitioner|physician_assistant|registered_nurse|pharmacist|social_worker|care_coordinator|other — promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments associated with this care team members assignment, such as specific responsibilities, coverage instructions, or care coordination context. Used by clinical staff for care team management.',
    `notification_preference` STRING COMMENT 'The preferred communication channel for notifying this care team member of patient updates, critical results, or care coordination messages (e.g., secure message, pager, phone, Epic In Basket). Drives clinical communication routing.. Valid values are `secure_message|pager|phone|email|in_basket`',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) assigned to this care team member by CMS. Used for billing, claims submission, and provider identity verification. Denormalized here for operational convenience in care team queries without requiring a provider join.. Valid values are `^[0-9]{10}$`',
    `relationship_to_patient` STRING COMMENT 'Describes the clinical or care relationship between this provider and the patient (e.g., Treating Physician, Consulting Specialist, Case Manager, Discharge Planner). Used in care coordination documentation and transitions of care workflows.',
    `removal_reason` STRING COMMENT 'The reason this care team member was removed or deactivated from the care team (e.g., patient discharge, transfer, provider request, coverage end, credentialing issue). Used for care team audit trails and transitions of care documentation. [ENUM-REF-CANDIDATE: discharge|transfer|provider_request|patient_request|coverage_end|credentialing|other — 7 candidates stripped; promote to reference product]',
    `role_code` STRING COMMENT 'Standardized code representing the specific functional role of this member within the care team (e.g., attending physician, consulting physician, primary nurse, case manager). Sourced from Epic or Cerner role code tables and aligned with HL7 FHIR CareTeam participant role codes.',
    `role_name` STRING COMMENT 'Human-readable display name for the care team members role (e.g., Attending Physician, Primary Care Nurse, Clinical Pharmacist, Discharge Planner). Used in clinical documentation and care coordination interfaces.',
    `sequence_number` STRING COMMENT 'Ordinal sequence number indicating the display order or priority ranking of this member within the care team. Used for care team list rendering in EHR interfaces and for determining primary vs. secondary member ordering.',
    `snomed_role_code` STRING COMMENT 'The SNOMED CT concept code representing the clinical role of this care team member. Enables semantic interoperability with FHIR-compliant systems and clinical decision support engines.',
    `source_system_member_code` STRING COMMENT 'The native identifier for this care team member record in the originating operational system (Epic ClinDoc, Cerner PowerChart, etc.). Used for data lineage, cross-system reconciliation, and ETL traceability.',
    `specialty_code` STRING COMMENT 'Standardized code representing the clinical specialty of this care team member (e.g., internal medicine, cardiology, oncology). Sourced from the provider taxonomy code set. Used for care team composition analytics and referral management.',
    `specialty_name` STRING COMMENT 'Human-readable display name for the clinical specialty of this care team member (e.g., Cardiology, Internal Medicine, Oncology). Used in care team displays, clinical documentation, and care coordination interfaces.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this care team member record was last modified in the source system. Used for change tracking, data lineage, and incremental ETL processing.',
    CONSTRAINT pk_care_team_member PRIMARY KEY(`care_team_member_id`)
) COMMENT 'Individual provider membership records within a care team, capturing the specific role, period of responsibility, and participation status of each clinician. Includes member type (physician, NP, PA, RN, social worker, pharmacist, care coordinator), role code, on-call flag, primary contact flag, and assignment dates. Enables care coordination queries and transitions of care documentation. Sourced from Epic and Cerner.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` (
    `cdi_query_id` BIGINT COMMENT 'Unique surrogate identifier for each CDI query record issued to a provider. Primary key for the cdi_query data product. Entity role: TRANSACTION_HEADER — represents a discrete CDI workflow event with a full lifecycle (open, answered, expired, withdrawn).',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: CDI query diagnosis validation for clinical documentation improvement, CC/MCC capture, and SOI/ROM assignment. CDI specialists use ICD-10 code attributes (CC flag, MCC flag, POA exempt) to identify do',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or hospital where the encounter and CDI query activity occurred. Enables multi-facility CDI program performance benchmarking and site-level reporting.',
    `cdi_worksheet_id` BIGINT COMMENT 'Reference to the CDI encounter review worksheet from which this query was generated. Links individual queries to the broader encounter-level CDI review activity for holistic CDI program reporting.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: CDI queries directly impact claim DRG assignment and reimbursement. Revenue integrity requires linking query to claim for tracking documentation improvement impact, measuring query effectiveness, and ',
    `clinician_id` BIGINT COMMENT 'Reference to the attending or responsible provider to whom the CDI query was directed. Used to track query response rates by provider and support CDI program performance reporting.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: CDI (Clinical Documentation Improvement) queries are frequently raised about specific diagnosis documentation to clarify clinical details, severity, or specificity for accurate coding. Linking cdi_que',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Working DRG analysis for CDI opportunity identification and baseline reimbursement calculation. CDI teams compare working DRG relative weight against expected DRG to quantify documentation improvement',
    `employee_id` BIGINT COMMENT 'Reference to the CDI specialist who authored and issued this query. Used for workload tracking, productivity reporting, and CDI program performance metrics.',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to quality.improvement_initiative. Business justification: CDI query response rates and outcomes are common quality improvement targets. Direct linkage enables tracking initiative impact on CDI program performance. Essential for CDI quality improvement workfl',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: CDI queries impact final DRG assignment and reimbursement for specific invoices. Revenue integrity operations track which invoices had CDI intervention to measure program ROI. Query outcomes directly ',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient associated with the encounter under CDI review. Protected Health Information (PHI) per HIPAA. Used to link CDI activity to the Master Patient Index (MPI).',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.note. Business justification: CDI specialists review clinical notes (H&Ps, progress notes, discharge summaries) to identify documentation gaps and opportunities for clarification. Linking cdi_query.note_id → note.note_id connects ',
    `payer_id` BIGINT COMMENT 'Reference to the primary payer for the encounter associated with this CDI query. Payer type (Medicare, Medicaid, commercial) determines applicable DRG grouper, reimbursement rates, and CDI program priority.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: CDI queries can target procedure documentation to clarify procedural details, approach, or complications for accurate CPT/ICD-10-PCS coding. Linking cdi_query.procedure_event_id → procedure_event.proc',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: CDI queries reference orders for documentation clarification. Real workflow: CDI specialist queries why antibiotic ordered without documented infection. Essential for clinical documentation improvemen',
    `report_id` BIGINT COMMENT 'Foreign key linking to radiology.report. Business justification: CDI specialists review radiology reports to identify undocumented diagnoses from incidental findings. Critical for DRG optimization, documentation improvement programs, and ensuring clinical documenta',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: CDI queries for sensitive diagnoses (substance use, mental health, HIV) require consent verification before querying providers. Compliance workflows ensure queries respect patient consent restrictions',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: CDI queries reference lab results to support diagnosis clarification (elevated troponin→query for MI). Role prefix supporting_ indicates documentation evidence. Critical for DRG optimization and com',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient or outpatient encounter against which this CDI query was issued. Links the query to the clinical encounter for DRG assignment and reimbursement analysis.',
    `actual_reimbursement_impact` DECIMAL(18,2) COMMENT 'Realized change in reimbursement (in USD) based on the final DRG assigned after CDI query resolution. Compared against expected_reimbursement_impact to measure CDI program effectiveness and forecast accuracy.',
    `appeal_support_flag` BOOLEAN COMMENT 'Indicates whether this CDI query was issued or retained specifically to support a payer denial appeal or Recovery Audit Contractor (RAC) audit response. Flags queries with dual-purpose CDI and denial management utility.',
    `cc_mcc_status` STRING COMMENT 'Indicates whether the diagnosis associated with this CDI query qualifies as a Complication or Comorbidity (CC) or Major Complication or Comorbidity (MCC) under CMS DRG grouping rules. CC/MCC capture is a primary driver of DRG weight and reimbursement optimization.. Valid values are `CC|MCC|none|undetermined`',
    `coding_impact_flag` BOOLEAN COMMENT 'Indicates whether the resolution of this CDI query resulted in a change to the coded diagnoses or procedures on the claim. True when the query outcome led to a coding modification. Used to measure CDI program effectiveness on coding accuracy.',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates whether this CDI query has been flagged for compliance review due to potential leading query language, inappropriate query format, or OIG audit risk. Supports CDI compliance program monitoring and AHIMA/ACDIS query format auditing.',
    `concurrent_review_flag` BOOLEAN COMMENT 'Indicates whether this CDI query was issued during a concurrent (real-time, while patient is still admitted) review as opposed to a retrospective review after discharge. Concurrent CDI is the preferred model for maximizing documentation accuracy and DRG optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CDI query record was first created in the source system. Satisfies RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role. Used for data lineage and audit trail.',
    `documentation_gap_description` STRING COMMENT 'Narrative description of the specific clinical documentation deficiency or opportunity identified by the CDI specialist that prompted this query. Examples include missing specificity for a diagnosis, absent linkage between conditions, or undocumented clinical indicators.',
    `drg_type` STRING COMMENT 'Indicates the DRG classification system used for this encounter (Medicare Severity DRG, All Patient Refined DRG, or All Patient DRG). Determines the applicable grouper logic and reimbursement methodology.. Valid values are `MS-DRG|APR-DRG|AP-DRG`',
    `encounter_type` STRING COMMENT 'Classification of the encounter type associated with this CDI query. CDI activity is most prevalent for inpatient encounters but may extend to observation and outpatient surgical cases. Drives applicable DRG grouper and reimbursement rules.. Valid values are `inpatient|observation|outpatient|ED|surgical`',
    `expected_drg_code` STRING COMMENT 'The DRG code anticipated if the provider responds affirmatively and documentation is improved per the CDI query. Used to calculate expected DRG impact and projected reimbursement change.',
    `expected_drg_description` STRING COMMENT 'Human-readable description of the expected DRG if the CDI query results in documentation improvement. Supports revenue impact analysis and CDI program ROI reporting.',
    `expected_reimbursement_impact` DECIMAL(18,2) COMMENT 'Projected change in reimbursement (in USD) if the CDI query results in a DRG change. Calculated as the difference between the expected DRG payment weight and the working DRG payment weight multiplied by the applicable base rate. Satisfies MONETARY_TRIPLET / QUANTITATIVE_RESULT category for TRANSACTION_HEADER role. Critical for CDI program ROI and revenue integrity reporting.',
    `final_drg_code` STRING COMMENT 'The DRG code actually assigned to the encounter after the CDI query was resolved and coding was finalized. Used to measure actual DRG change rate and realized revenue impact versus expected.',
    `physician_query_method` STRING COMMENT 'Method by which the CDI query was delivered to the provider (electronic via EHR, verbal, written paper form, or secure message). Affects response rate tracking and compliance with AHIMA/ACDIS query format guidelines.. Valid values are `electronic|verbal|written|secure_message`',
    `poa_indicator` STRING COMMENT 'Indicates whether the diagnosis associated with this CDI query was present at the time of inpatient admission. POA status affects CC/MCC eligibility, HAI reporting, and value-based purchasing penalties. Standard CMS POA indicator values: Y=Yes, N=No, U=Unknown, W=Clinically undetermined, 1=Unreported/not used.. Valid values are `Y|N|U|W|1`',
    `provider_response_text` STRING COMMENT 'Free-text or structured response provided by the queried physician or provider. Captures the clinical clarification or documentation addendum. Classified as confidential due to clinical content.',
    `query_category` STRING COMMENT 'Clinical category or topic area of the query (e.g., principal diagnosis clarification, secondary diagnosis specificity, procedure clarification, POA status, CC/MCC capture, clinical validity). Used for trend analysis and CDI program focus areas. [ENUM-REF-CANDIDATE: principal_diagnosis|secondary_diagnosis|procedure|poa_status|cc_mcc_capture|clinical_validity|discharge_disposition|severity_of_illness — promote to reference product]',
    `query_expiration_date` DATE COMMENT 'Date by which the provider must respond before the query is automatically expired per CDI program policy. Drives escalation workflows and expired query reporting.',
    `query_issue_date` DATE COMMENT 'Calendar date on which the CDI query was formally issued to the provider. Satisfies BUSINESS_EVENT_TIMESTAMP category for TRANSACTION_HEADER role. Used to calculate response turnaround time and query aging.',
    `query_number` STRING COMMENT 'Externally-known alphanumeric identifier for the CDI query, as assigned by the source system (3M CDI or Epic CDI). Used for cross-system reference, audit trails, and provider communication. Satisfies BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.',
    `query_opportunity_flag` BOOLEAN COMMENT 'Indicates whether the CDI review identified a query opportunity for this encounter. True when a documentation gap with potential DRG or quality impact was identified. Used to calculate query opportunity rates and CDI program reach.',
    `query_outcome` STRING COMMENT 'Final disposition of the CDI query after provider response. Indicates whether the provider agreed with the CDI specialists suggested documentation change, disagreed, or the query had no DRG impact. Drives DRG change rate and revenue impact reporting.. Valid values are `agreed|disagreed|no_impact|unable_to_determine|withdrawn`',
    `query_response_date` DATE COMMENT 'Date on which the queried provider responded to the CDI query. Null if the query is still open, expired, or withdrawn. Used to calculate response turnaround time and provider response rate metrics.',
    `query_status` STRING COMMENT 'Current lifecycle state of the CDI query. Drives workflow routing, response rate calculations, and CDI program performance dashboards. Satisfies LIFECYCLE_STATUS category for TRANSACTION_HEADER role.. Valid values are `open|answered|expired|withdrawn|pending_review`',
    `query_text` STRING COMMENT 'Full narrative text of the CDI query as presented to the provider. Contains the clinical question, supporting documentation references, and response options. Classified as confidential due to clinical content and potential PHI context.',
    `query_type` STRING COMMENT 'Classification of the query format per ACDIS/AHIMA compliant query guidelines. Compliant queries are non-leading and clinically supported. Leading queries may introduce compliance risk. Multiple choice and yes/no formats are common structured query types. Critical for compliance auditing and OIG risk management.. Valid values are `compliant|leading|multiple_choice|yes_no|open_ended`',
    `response_turnaround_hours` STRING COMMENT 'Number of hours elapsed between query issuance and provider response. Used to measure CDI program efficiency, provider engagement, and compliance with internal SLA targets for query response time.',
    `retrospective_review_flag` BOOLEAN COMMENT 'Indicates whether this CDI query was issued during a retrospective review after the patient was discharged. Retrospective queries may have limited impact on DRG assignment if coding is already finalized but are used for denial management and appeal support.',
    `risk_of_mortality_level` STRING COMMENT 'APR-DRG risk of mortality subclass for the encounter at the time of CDI query issuance (1=Minor, 2=Moderate, 3=Major, 4=Extreme). Supports quality reporting, mortality review, and CDI program impact on risk-adjusted outcomes.. Valid values are `1|2|3|4`',
    `severity_of_illness_level` STRING COMMENT 'APR-DRG severity of illness subclass for the encounter at the time of CDI query issuance (1=Minor, 2=Moderate, 3=Major, 4=Extreme). Used in APR-DRG environments to assess documentation completeness and CDI opportunity.. Valid values are `1|2|3|4`',
    `source_system_query_code` STRING COMMENT 'Native identifier of this CDI query record in the originating source system (3M CDI or Epic CDI). Enables cross-system reconciliation, ETL traceability, and support case resolution without exposing internal surrogate keys.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CDI query record was last modified in the source system. Satisfies RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role. Used for incremental ETL processing and change tracking.',
    CONSTRAINT pk_cdi_query PRIMARY KEY(`cdi_query_id`)
) COMMENT 'SSOT for all Clinical Documentation Improvement (CDI) activities including encounter-level review worksheets and provider queries. Models the full CDI review lifecycle: encounter review worksheets (review date, CDI specialist, encounter type, working DRG, final DRG, CC/MCC capture status, documentation gaps identified, query opportunity flags, review outcome) and individual queries issued to providers (query type — compliant/leading/multiple choice, query status — open/answered/expired/withdrawn, queried provider, associated diagnosis, expected DRG impact, query outcome). Tracks CDI program performance metrics including query response rates, DRG change rates, and revenue impact. Sourced from 3M Health Information Systems CDI module and Epic CDI workflows. Critical for accurate DRG assignment, reimbursement optimization, and revenue integrity.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` (
    `cdi_worksheet_id` BIGINT COMMENT 'Unique surrogate identifier for the CDI specialist review worksheet record in the Silver layer lakehouse.',
    `care_site_id` BIGINT COMMENT 'Reference to the hospital or care facility where the encounter under CDI review occurred. Supports multi-facility CDI program performance benchmarking.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: CDI worksheets document clinical review findings that determine final claim coding and DRG. Revenue cycle operations require linking worksheet to claim for audit trail, coding validation, and measurin',
    `clinician_id` BIGINT COMMENT 'Reference to the attending physician responsible for the encounter being reviewed. Used to route physician queries and track query response rates by provider.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: DRG validation audits and clinical documentation improvement program reviews examine CDI worksheets for compliance with CMS coding guidelines. Compliance teams audit CDI worksheet accuracy, completene',
    `compliance_program_id` BIGINT COMMENT 'Reference to the CDI program or initiative under which this worksheet was generated (e.g., inpatient CDI program, outpatient CDI program, HAC-focused program). Supports program-level performance tracking.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: CDI worksheet working DRG tracking for concurrent review and documentation opportunity identification. CDI specialists use working DRG attributes (relative weight, GMLOS, complication level) to assess',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Principal diagnosis validation for DRG grouping accuracy and coding compliance. CDI specialists use ICD-10 code attributes (unacceptable principal DX flag, MDC assignment) to ensure principal diagnosi',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: CDI worksheets document DRG determination and expected reimbursement for specific encounters. Revenue cycle operations require linking worksheets to invoices to reconcile expected vs. actual reimburse',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose encounter is under CDI review. Protected Health Information (PHI) per HIPAA.',
    `employee_id` BIGINT COMMENT 'Reference to the CDI specialist who performed the documentation review. Used for workload tracking and performance reporting.',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient or outpatient encounter under CDI review. Links the worksheet to the clinical encounter record.',
    `admit_date` DATE COMMENT 'The date the patient was admitted for the encounter under CDI review. Used to calculate Length of Stay (LOS) at time of review and to sequence concurrent CDI reviews.',
    `cc_mcc_captured` BOOLEAN COMMENT 'Indicates whether the CDI review successfully captured a CC or MCC that was not previously documented, resulting in a DRG upgrade. Key metric for CDI program performance reporting.',
    `cc_mcc_status` STRING COMMENT 'Indicates whether the encounter has a captured Complication or Comorbidity (CC) or Major Complication or Comorbidity (MCC) that affects DRG assignment and reimbursement. Values: none (no CC/MCC), CC (complication or comorbidity present), MCC (major complication or comorbidity present).. Valid values are `none|CC|MCC`',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when the CDI specialist marked the worksheet review as completed. Distinct from created and updated timestamps; used to measure CDI review cycle time and productivity.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the CDI worksheet record was first created in the source system. Used for audit trail and data lineage tracking per HIPAA and HITRUST requirements.',
    `discharge_date` DATE COMMENT 'The date the patient was discharged from the encounter. Populated for post-discharge CDI reviews; null for concurrent reviews on active encounters.',
    `documentation_gap_count` STRING COMMENT 'Number of distinct clinical documentation gaps identified during the CDI review (e.g., unspecified diagnoses, missing severity qualifiers, undocumented comorbidities). Supports CDI program gap analysis.',
    `documentation_gap_notes` STRING COMMENT 'Free-text narrative describing the specific clinical documentation gaps identified by the CDI specialist during review. Supports CDI education and physician feedback programs. Treated as confidential clinical operational data.',
    `drg_grouper_version` STRING COMMENT 'Version identifier of the DRG grouper software (e.g., CMS MS-DRG v41.0 or 3M APR-DRG v39) used to assign working and final DRG codes. Required for audit reproducibility.',
    `drg_weight_change` DECIMAL(18,2) COMMENT 'The arithmetic difference between the final DRG relative weight and the working DRG relative weight (final minus working). Positive values indicate a CDI-driven DRG upgrade; negative values indicate a downgrade. Key CDI program performance metric.',
    `encounter_type` STRING COMMENT 'Classification of the clinical encounter under review (e.g., inpatient admission, observation stay, outpatient, Emergency Department (ED), surgical). Determines applicable DRG grouping methodology.. Valid values are `inpatient|observation|outpatient|ED|surgical`',
    `expected_reimbursement_impact` DECIMAL(18,2) COMMENT 'Estimated dollar impact on Medicare/Medicaid reimbursement resulting from the DRG change driven by CDI review, calculated as the DRG weight change multiplied by the facilitys base payment rate. Supports Revenue Cycle Management (RCM) and revenue integrity reporting.',
    `final_drg_code` STRING COMMENT 'The DRG code assigned after CDI specialist review and any physician query responses have been incorporated. Represents the post-CDI reimbursement outcome.',
    `final_drg_description` STRING COMMENT 'Human-readable description of the final DRG code after CDI review completion, providing clinical context for the post-CDI grouping.',
    `final_drg_weight` DECIMAL(18,2) COMMENT 'The CMS-published relative weight associated with the final DRG after CDI review. Compared against working DRG weight to quantify CDI program impact on Case Mix Index (CMI).',
    `hac_risk_flag` BOOLEAN COMMENT 'Indicates whether the CDI review identified a potential Hospital-Acquired Condition (HAC) that could affect DRG payment under CMS HAC Reduction Program. Triggers compliance review workflow.',
    `los_at_review` STRING COMMENT 'Number of inpatient days elapsed from admission to the CDI review date. Used to assess timeliness of CDI intervention relative to the encounter Length of Stay (LOS).',
    `mdc_code` STRING COMMENT 'The CMS Major Diagnostic Category (MDC) code derived from the principal diagnosis, representing the broad clinical grouping used in DRG assignment (e.g., MDC 05 — Diseases of the Circulatory System).',
    `mrn` STRING COMMENT 'The facility-assigned Medical Record Number (MRN) for the patient, used to cross-reference the CDI worksheet with the Electronic Health Record (EHR). PHI per HIPAA.',
    `payer_type` STRING COMMENT 'Classification of the primary payer for the encounter under CDI review. Determines applicable DRG grouper, reimbursement methodology, and regulatory reporting requirements.. Valid values are `Medicare|Medicaid|commercial|self_pay|other`',
    `poa_status` STRING COMMENT 'Present on Admission (POA) indicator for the principal diagnosis as assessed during CDI review. Values follow CMS POA guidelines: Y=present on admission, N=not present, U=unknown, W=clinically undetermined, 1=exempt from POA reporting.. Valid values are `Y|N|U|W|1`',
    `query_count` STRING COMMENT 'Total number of physician queries generated from this CDI worksheet review. Used to measure CDI specialist productivity and query volume per encounter.',
    `query_opportunity_flag` BOOLEAN COMMENT 'Indicates whether the CDI specialist identified a documentation gap that warrants a physician query to clarify, add, or amend a diagnosis or procedure. Drives query workflow initiation.',
    `query_response_status` STRING COMMENT 'Aggregate status of physician query responses for this worksheet: not_applicable (no query issued), pending (awaiting response), agreed (physician confirmed CDI suggestion), disagreed (physician declined), unable_to_determine (physician could not clarify).. Valid values are `not_applicable|pending|agreed|disagreed|unable_to_determine`',
    `review_date` DATE COMMENT 'The calendar date on which the CDI specialist performed the documentation review for the encounter. Principal business event date for the worksheet.',
    `review_notes` STRING COMMENT 'Free-text clinical notes entered by the CDI specialist summarizing review findings, clinical reasoning, and recommended documentation improvements. Confidential clinical operational data used for CDI education and physician engagement.',
    `review_outcome` STRING COMMENT 'The clinical and financial outcome of the CDI review: no_change (documentation adequate), drg_upgrade (DRG moved to higher weight), drg_downgrade (DRG moved to lower weight), cc_mcc_added (CC or MCC captured), principal_dx_changed (principal diagnosis revised). [ENUM-REF-CANDIDATE: no_change|drg_upgrade|drg_downgrade|cc_mcc_added|principal_dx_changed|query_pending — promote to reference product]. Valid values are `no_change|drg_upgrade|drg_downgrade|cc_mcc_added|principal_dx_changed`',
    `review_status` STRING COMMENT 'Current lifecycle state of the CDI worksheet: open (assigned, not started), in_progress (review underway), pending_query (awaiting physician query response), completed (review finalized), or cancelled.. Valid values are `open|in_progress|pending_query|completed|cancelled`',
    `review_timestamp` TIMESTAMP COMMENT 'Precise date and time when the CDI specialist initiated or completed the review session, used for audit trail and productivity measurement.',
    `review_type` STRING COMMENT 'Classifies the stage of the CDI review cycle: initial (first review on admission), concurrent (ongoing during stay), follow_up (subsequent concurrent review), final (pre-discharge), or post_discharge (retrospective). Drives workflow routing in 3M CDI.. Valid values are `initial|concurrent|follow_up|final|post_discharge`',
    `service_line` STRING COMMENT 'The clinical service line or specialty associated with the encounter (e.g., Cardiology, Orthopedics, Neurology, General Medicine). Used to segment CDI performance by clinical program.',
    `source_system_worksheet_code` STRING COMMENT 'The native worksheet identifier assigned by the 3M Health Information Systems CDI source system. Preserved for data lineage, reconciliation, and audit trail back to the operational system of record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the CDI worksheet record was last modified in the source system. Supports incremental ETL processing and change data capture in the Databricks Silver layer.',
    `worksheet_number` STRING COMMENT 'Externally visible alphanumeric identifier assigned to the CDI worksheet by the 3M Health Information Systems CDI module. Used for cross-referencing with source system records.',
    CONSTRAINT pk_cdi_worksheet PRIMARY KEY(`cdi_worksheet_id`)
) COMMENT 'CDI specialist review worksheets documenting the clinical documentation review process for an encounter. Captures review date, CDI specialist, encounter type, working DRG (before CDI), final DRG (after CDI), CC/MCC capture status, query opportunity flags, documentation gaps identified, and review outcome. Supports CDI program performance tracking and revenue integrity. Sourced from 3M Health Information Systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` (
    `functional_status_id` BIGINT COMMENT 'Unique surrogate identifier for each functional status assessment record in the clinical data product. Primary key for the functional_status table in the Databricks Silver Layer.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Functional status assessments (ADL, IADL, mobility, cognitive assessments) directly inform care plan creation and updates. Linking functional_status.care_plan_id → care_plan.care_plan_id establishes t',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this functional status assessment was performed. Links to the master patient record in the Patient domain.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Functional impairment diagnosis coding for HCC risk adjustment, disability determination, and post-acute care reimbursement. Coding and case management teams use ICD-10 codes for functional impairment',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Functional assessments trigger imaging when decline suggests underlying pathology (fall with injury, mobility loss prompting spine imaging). Required for linking functional changes to diagnostic worku',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Functional assessment standardization for post-acute care planning, IRF/SNF admission criteria, and quality measure reporting. Case management and therapy teams use LOINC codes for functional assessme',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Functional assessments drive DME orders (ADL scores → assistive devices, mobility scores → wheelchairs). Enables functional assessment-based DME provisioning, discharge planning, and post-acute care s',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed clinician (nurse, therapist, physician, social worker) who performed and documented the functional status assessment. Supports accountability and care team attribution.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Functional status measures (ADL assessment post-discharge, functional improvement) require functional assessment data. Essential for post-acute care quality reporting and rehabilitation program evalua',
    `therapy_order_id` BIGINT COMMENT 'Foreign key linking to order.therapy_order. Business justification: Functional assessments drive therapy orders. Real workflow: ADL score shows mobility deficit, triggers PT order. Essential for therapy medical necessity documentation, authorization support, outcome t',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Functional status coding for care planning, rehabilitation goal setting, and outcome tracking. Therapy and care coordination teams use SNOMED codes to document functional limitations and track improve',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Functional assessments incorporate lab data (albumin for nutritional status, hemoglobin for fatigue). Role prefix supporting_ indicates assessment basis. Important for rehabilitation planning and di',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, outpatient visit, ED visit) during which this functional status assessment was conducted. Supports contextualizing assessment within care episode.',
    `adl_score` DECIMAL(18,2) COMMENT 'Sub-score measuring the patients ability to perform basic Activities of Daily Living (ADL) including bathing, dressing, grooming, toileting, transferring, and feeding. Core component of Barthel Index, Katz ADL, and FIM assessments.',
    `advance_directive_on_file` BOOLEAN COMMENT 'Indicates whether a valid advance directive (living will, healthcare proxy, POLST/MOLST) is documented in the patients medical record. Required documentation element under the Patient Self-Determination Act and CMS Conditions of Participation.',
    `assessing_discipline` STRING COMMENT 'Clinical discipline of the licensed professional who performed the functional status assessment. Determines scope of practice, assessment tool applicability, and care plan ownership. Required for interdisciplinary team documentation. [ENUM-REF-CANDIDATE: nursing|physical_therapy|occupational_therapy|speech_therapy|social_work|physician|psychology — 7 candidates stripped; promote to reference product]',
    `assessment_date` DATE COMMENT 'Calendar date on which the functional status assessment was administered to the patient. Used for trending functional decline or improvement over time and for discharge planning timelines.',
    `assessment_duration_minutes` STRING COMMENT 'Total time in minutes required to complete the functional status assessment. Used for therapy billing (timed CPT codes), productivity reporting, and staffing analysis. Required for Medicare Part B therapy billing documentation.',
    `assessment_location` STRING COMMENT 'Physical or virtual location where the functional status assessment was conducted (e.g., bedside, therapy gym, outpatient clinic, telehealth). Supports operational reporting and care setting analytics.',
    `assessment_status` STRING COMMENT 'Current workflow status of the functional status assessment record. Completed indicates a finalized, signed assessment; amended indicates a correction was made post-completion; entered_in_error supports clinical data quality management.. Valid values are `completed|in_progress|cancelled|amended|entered_in_error`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the functional status assessment was completed and documented in the EHR. Supports clinical workflow sequencing and audit trail requirements.',
    `assessment_tool` STRING COMMENT 'Standardized clinical instrument used to evaluate the patients functional status. Common tools include Barthel Index, Functional Independence Measure (FIM), PHQ-9 (depression), CAGE-AID (substance use), Katz ADL Scale, Lawton IADL Scale, Mini-Mental State Examination (MMSE), Montreal Cognitive Assessment (MoCA), and SDOH screening tools. [ENUM-REF-CANDIDATE: Barthel Index|FIM|PHQ-9|CAGE-AID|Katz ADL|Lawton IADL|MMSE|MoCA|SDOH Screening|Berg Balance Scale|Braden Scale|Morse Fall Scale — promote to reference product]',
    `assessment_type` STRING COMMENT 'Classification of when in the care continuum the assessment was performed. Admission assessments establish baseline; discharge assessments support post-acute placement; interim assessments track progress; annual assessments support population health programs.. Valid values are `admission|discharge|interim|annual|follow_up|referral`',
    `cage_aid_score` STRING COMMENT 'Total score from the CAGE-AID (Cut down, Annoyed, Guilty, Eye-opener — Adapted to Include Drugs) substance use disorder screening tool, ranging from 0 to 4. A score of 2 or higher is considered a positive screen for alcohol or drug use disorder.',
    `care_setting` STRING COMMENT 'Clinical care setting in which the functional status assessment was performed. Drives assessment tool selection, regulatory reporting requirements (MDS for SNF, OASIS for home health), and post-acute care placement decisions. [ENUM-REF-CANDIDATE: inpatient|outpatient|ed|icu|snf|home_health|hospice|rehabilitation — 8 candidates stripped; promote to reference product]',
    `caregiver_support_available` BOOLEAN COMMENT 'Indicates whether the patient has an identified informal caregiver (family member, friend, or unpaid caregiver) available to assist with post-discharge care needs. Critical factor in discharge planning and community care placement decisions.',
    `clinical_notes` STRING COMMENT 'Free-text narrative documentation by the assessing clinician providing qualitative context, clinical observations, and nuanced findings beyond the structured scoring fields. Contains Protected Health Information (PHI) and is subject to HIPAA minimum necessary standards.',
    `cognitive_score` DECIMAL(18,2) COMMENT 'Sub-score measuring cognitive function including orientation, memory, attention, language, and executive function. Derived from MMSE (0–30), MoCA (0–30), FIM cognitive subscale, or BIMS (Brief Interview for Mental Status). Supports dementia screening and care planning.',
    `communication_status` STRING COMMENT 'Assessment of the patients ability to communicate effectively, including speech, language, hearing, and vision. Impacts assessment validity, informed consent processes, and care plan communication. Triggers speech-language pathology referrals.. Valid values are `intact|impaired|nonverbal|requires_interpreter|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this functional status assessment record was first created in the source EHR system. Supports audit trail requirements under HIPAA Security Rule and data lineage tracking in the lakehouse.',
    `discharge_disposition_recommended` STRING COMMENT 'Clinician-recommended post-discharge care setting based on functional status assessment findings. Drives discharge planning workflows, post-acute care referrals, and transitions of care coordination. Supports CMS Discharge Planning Rule compliance. [ENUM-REF-CANDIDATE: home|home_with_services|snf|inpatient_rehab|ltach|hospice|assisted_living — 7 candidates stripped; promote to reference product]',
    `fall_risk_level` STRING COMMENT 'Clinician-assigned fall risk stratification based on Morse Fall Scale, Hendrich II, or equivalent validated tool. Drives fall prevention care plan interventions and is a required safety metric under TJC National Patient Safety Goals (NPSG.09.02.01).. Valid values are `low|moderate|high`',
    `iadl_score` DECIMAL(18,2) COMMENT 'Sub-score measuring the patients ability to perform Instrumental Activities of Daily Living (IADL) such as managing medications, finances, transportation, meal preparation, and housekeeping. Assessed via Lawton IADL Scale. Critical for community discharge planning.',
    `is_baseline_assessment` BOOLEAN COMMENT 'Indicates whether this assessment represents the initial baseline functional status evaluation for the patient within the current episode of care. Baseline assessments anchor longitudinal functional trajectory analysis and rehabilitation goal-setting.',
    `mobility_score` DECIMAL(18,2) COMMENT 'Sub-score quantifying the patients mobility status including ambulation, transfers, stair climbing, and wheelchair use. Derived from FIM motor subscale, Barthel mobility items, or Berg Balance Scale. Informs physical therapy referrals and fall risk management.',
    `mobility_status` STRING COMMENT 'Categorical classification of the patients overall mobility level using CMS MDS-aligned coding. Supports post-acute care placement criteria, physical therapy orders, and fall prevention protocols.. Valid values are `independent|supervision|limited_assistance|extensive_assistance|total_dependence|activity_did_not_occur`',
    `mrn` STRING COMMENT 'The Medical Record Number assigned to the patient by the healthcare organization. Used as the primary patient identity anchor across clinical systems and for cross-system reconciliation via the Master Patient Index (MPI).',
    `nutritional_status` STRING COMMENT 'Clinician-assessed nutritional status of the patient as determined during functional assessment. Malnutrition directly impacts functional recovery, wound healing, and rehabilitation outcomes. Supports dietitian referrals and care plan development.. Valid values are `adequate|at_risk|malnourished|unknown`',
    `pain_level` STRING COMMENT 'Patient-reported pain intensity score on a standardized numeric rating scale (NRS 0–10) or equivalent validated tool (Wong-Baker FACES, FLACC). Functional pain assessment is integral to ADL performance and mobility evaluation. Required by TJC pain management standards.',
    `phq9_score` STRING COMMENT 'Total score from the Patient Health Questionnaire-9 (PHQ-9) depression screening tool, ranging from 0 to 27. Scores of 5, 10, 15, and 20 represent mild, moderate, moderately severe, and severe depression thresholds respectively. Required for HEDIS MDD measures and CMS quality reporting.',
    `pressure_injury_risk` STRING COMMENT 'Risk stratification for pressure injury (decubitus ulcer) development based on Braden Scale or Norton Scale score. Supports wound prevention care planning and is tracked as a Hospital-Acquired Condition (HAC) under CMS quality programs.. Valid values are `no_risk|at_risk|high_risk|very_high_risk`',
    `prior_level_of_function` STRING COMMENT 'Patients functional status prior to the current illness, injury, or hospitalization as reported by patient, family, or prior care records. Establishes rehabilitation goals and discharge planning targets. Standard component of physical and occupational therapy evaluations.. Valid values are `independent|modified_independent|supervised|assisted|dependent|unknown`',
    `rehabilitation_potential` STRING COMMENT 'Clinicians assessment of the patients potential to improve functional status through rehabilitation services. Influences therapy authorization, post-acute care placement, and Medicare skilled care eligibility determinations.. Valid values are `good|fair|poor|not_applicable`',
    `score_interpretation` STRING COMMENT 'Clinically validated categorical interpretation of the total assessment score based on the tools published scoring bands. Supports rapid clinical triage, care plan development, and post-acute care placement decisions.. Valid values are `normal|mild_impairment|moderate_impairment|severe_impairment|total_dependence`',
    `sdoh_domain_flags` STRING COMMENT 'Pipe-delimited list of specific SDOH domains where unmet needs were identified (e.g., food_insecurity|housing_instability|transportation). Supports targeted community resource referrals and population health stratification under CMS SDOH initiatives.',
    `sdoh_screening_result` STRING COMMENT 'Overall result of the Social Determinants of Health (SDOH) screening indicating whether unmet social needs (food insecurity, housing instability, transportation barriers, financial strain, social isolation) were identified. Supports population health management and care coordination referrals.. Valid values are `no_needs_identified|needs_identified|patient_declined|not_screened`',
    `source_system_record_code` STRING COMMENT 'Native record identifier from the originating operational system (e.g., Epic ClinDoc SmartForm instance ID, Cerner PowerChart assessment ID). Enables traceability from the Silver Layer back to the source EHR record for data quality investigations.',
    `total_score` DECIMAL(18,2) COMMENT 'Composite numeric score derived from the assessment tools scoring algorithm. Score range and interpretation vary by tool (e.g., Barthel Index 0–100; PHQ-9 0–27; FIM 18–126). Used for clinical decision-making, discharge planning, and population health stratification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this functional status assessment record, including amendments, corrections, or status changes. Required for change data capture (CDC) processing in the Silver Layer ETL pipeline.',
    CONSTRAINT pk_functional_status PRIMARY KEY(`functional_status_id`)
) COMMENT 'Patient functional status and disability assessments documenting activities of daily living (ADL), instrumental ADLs, mobility status, cognitive function, and social determinants of health (SDOH) screenings. Captures assessment tool used (Barthel Index, FIM, PHQ-9, CAGE-AID, SDOH screening), assessment date, score, interpretation, and assessing clinician. Supports discharge planning, post-acute care placement, and population health stratification. Sourced from Epic ClinDoc.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` (
    `advance_directive_id` BIGINT COMMENT 'Unique surrogate identifier for the advance directive record in the lakehouse silver layer. Primary key for this entity.',
    `accreditation_survey_id` BIGINT COMMENT 'Foreign key linking to quality.accreditation_survey. Business justification: Advance directive documentation is reviewed during accreditation surveys (TJC, CMS). Surveyors assess compliance with patient rights standards. Essential for accreditation survey preparation and respo',
    `claim_attachment_id` BIGINT COMMENT 'Foreign key linking to claim.claim_attachment. Business justification: Advance directives are required documentation for hospice and palliative care claims. Compliance teams must link directive to claim attachment for Medicare hospice election validation and end-of-life ',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, or outpatient center) where the advance directive was documented or verified. Supports multi-facility enterprise reporting and care transition workflows.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider who documented or verified the advance directive in the Electronic Health Record (EHR). Supports audit and accountability requirements.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Advance directive management is governed by organizational policies implementing state/federal regulations (Patient Self-Determination Act). Healthcare organizations must link advance directive record',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this advance directive was documented. Links to the patient master record.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Advance directives are a specialized form of consent for end-of-life care decisions. Linking to the general consent framework ensures comprehensive consent tracking, supports POLST/MOLST workflows, an',
    `superseded_by_directive_advance_directive_id` BIGINT COMMENT 'Reference to the newer advance directive record that supersedes this one. Null if this directive has not been superseded. Enables directive version chain tracking and ensures the most current directive is applied in care decisions.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the advance directive was documented or verified. May be null if documented outside an encounter context.',
    `artificially_administered_nutrition` STRING COMMENT 'Patients documented preference regarding artificially administered nutrition and hydration (e.g., feeding tubes, IV fluids) as specified in the advance directive or POLST/MOLST. Critical for end-of-life care planning.. Valid values are `Accept|Decline|Trial Period|No Preference Stated`',
    `capacity_assessment_result` STRING COMMENT 'The result of the formal patient decision-making capacity assessment conducted at the time of advance directive documentation. Determines whether the patient could legally execute or modify the directive.. Valid values are `Has Capacity|Lacks Capacity|Capacity Uncertain`',
    `clinical_notes` STRING COMMENT 'Free-text clinical notes or additional instructions documented by the provider regarding the patients advance directive, including nuances, patient-expressed wishes, or contextual information not captured in structured fields.',
    `code_status` STRING COMMENT 'The patients current resuscitation code status as documented in the advance directive. Full Code = all resuscitative measures; DNR = Do Not Resuscitate; DNR/DNI = Do Not Resuscitate / Do Not Intubate; Comfort Care = palliative measures only; Limited Interventions = selective resuscitative measures as specified.. Valid values are `Full Code|DNR|DNR/DNI|Comfort Care|Limited Interventions`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this advance directive record was first created in the lakehouse data platform. Supports data lineage, audit trail, and regulatory compliance reporting.',
    `directive_status` STRING COMMENT 'Current lifecycle status of the advance directive document. Active = currently in force; Revoked = patient has withdrawn the directive; Superseded = replaced by a newer directive; Expired = past the expiration date; Pending Verification = documented but not yet clinically verified.. Valid values are `active|revoked|superseded|expired|pending_verification`',
    `directive_type` STRING COMMENT 'Classification of the advance directive document type. DNR = Do Not Resuscitate; POLST = Physician Orders for Life-Sustaining Treatment; MOLST = Medical Orders for Life-Sustaining Treatment; Living Will = written legal document; Healthcare Power of Attorney = proxy designation; Comfort Care Order = palliative/comfort-focused care order.. Valid values are `DNR|POLST|MOLST|Living Will|Healthcare Power of Attorney|Comfort Care Order`',
    `document_location` STRING COMMENT 'Indicates where the physical or electronic copy of the advance directive document is stored or held. Supports retrieval during care transitions and emergency situations.. Valid values are `EHR Scanned|Patient Holds Original|Family Holds Copy|Registry|Attorney on File`',
    `documented_timestamp` TIMESTAMP COMMENT 'The date and time when the advance directive was first entered or documented in the Electronic Health Record (EHR). Serves as the BUSINESS_EVENT_TIMESTAMP for this records creation in the clinical system.',
    `effective_date` DATE COMMENT 'The date on which the advance directive becomes legally and clinically effective. Used to determine whether the directive is currently binding for care decisions.',
    `ethics_consult_requested` BOOLEAN COMMENT 'Indicates whether an ethics committee consultation was requested in connection with this advance directive. Supports quality reporting, compliance tracking, and clinical ethics workflows.',
    `expiration_date` DATE COMMENT 'The date on which the advance directive expires and is no longer legally or clinically binding. Null if the directive has no defined expiration (open-ended). Supports automated status transitions to expired.',
    `fhir_consent_reference` STRING COMMENT 'The FHIR Consent resource identifier corresponding to this advance directive, enabling interoperability with Health Information Exchange (HIE) platforms and FHIR-compliant systems.',
    `hospice_enrolled` BOOLEAN COMMENT 'Indicates whether the patient is currently enrolled in a hospice program at the time of advance directive documentation. Relevant for care plan alignment and CMS hospice benefit compliance.',
    `hospitalization_preference` STRING COMMENT 'Patients documented preference regarding hospitalization and transfer to acute care settings as specified in the POLST/MOLST. Guides care transitions and Emergency Department (ED) triage decisions.. Valid values are `Accept Hospitalization|Avoid Hospitalization|Comfort Care Only|No Preference Stated`',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether a language interpreter was used during the advance directive discussion and documentation process. Supports compliance with Title VI of the Civil Rights Act and CMS language access requirements.',
    `life_sustaining_treatment_preference` STRING COMMENT 'Patients documented preference regarding life-sustaining treatment as captured in the POLST/MOLST or living will. Full Treatment = all medically appropriate interventions; Selective Treatment = specific interventions as detailed; Comfort Measures Only = palliative and comfort-focused care only. Core clinical decision support field.. Valid values are `Full Treatment|Selective Treatment|Comfort Measures Only`',
    `mechanical_ventilation_preference` STRING COMMENT 'Patients documented preference regarding mechanical ventilation and intubation as specified in the advance directive or POLST/MOLST. Directly informs DNR/DNI code status decisions.. Valid values are `Accept|Decline|Trial Period|No Preference Stated`',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient in the source Electronic Health Record (EHR) system. Supports cross-system patient matching via the Master Patient Index (MPI).',
    `notarized` BOOLEAN COMMENT 'Indicates whether the advance directive document has been notarized. Some state jurisdictions require notarization for legal validity of living wills and healthcare power of attorney designations.',
    `organ_donation_status` STRING COMMENT 'Patients documented preference or registered status regarding organ and tissue donation as captured in the advance directive or linked registry. Supports organ procurement coordination and UNOS compliance.. Valid values are `Donor|Non-Donor|Donor with Restrictions|Unknown`',
    `palliative_care_referral` BOOLEAN COMMENT 'Indicates whether a palliative care referral was initiated in conjunction with the advance directive documentation. Supports care coordination, population health management, and quality measure reporting.',
    `patient_capacity_assessed` BOOLEAN COMMENT 'Indicates whether the patients decision-making capacity was formally assessed at the time the advance directive was documented or verified. Relevant for legal validity and ethical compliance.',
    `patient_education_provided` BOOLEAN COMMENT 'Indicates whether the patient received education about advance directives and their rights under the Patient Self-Determination Act (PSDA) prior to or at the time of directive documentation.',
    `preferred_language` STRING COMMENT 'The patients preferred language for advance directive discussions and documentation, expressed as an ISO 639-1 or BCP-47 language code (e.g., en, es, zh-CN). Supports language access compliance and care equity reporting.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `proxy_alternate_phone` STRING COMMENT 'Alternate or secondary contact phone number for the designated healthcare proxy. Used when the primary proxy phone number is unreachable during urgent care decisions.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `proxy_name` STRING COMMENT 'Full name of the designated healthcare proxy or healthcare power of attorney agent authorized to make medical decisions on behalf of the patient when the patient lacks decision-making capacity.',
    `proxy_phone` STRING COMMENT 'Primary contact phone number for the designated healthcare proxy or power of attorney agent. Used to contact the proxy when the patient is unable to make decisions.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `proxy_relationship` STRING COMMENT 'The relationship of the designated healthcare proxy to the patient (e.g., Spouse, Parent, Child, Sibling, Friend, Legal Guardian, Attorney). Used for care coordination and next-of-kin notification workflows. [ENUM-REF-CANDIDATE: Spouse|Parent|Child|Sibling|Friend|Legal Guardian|Attorney — 7 candidates stripped; promote to reference product]',
    `revocation_timestamp` TIMESTAMP COMMENT 'The date and time when the patient formally revoked the advance directive. Null if the directive has not been revoked. Triggers status transition to revoked and inactivates the directive for care decisions.',
    `scanned_document_url` STRING COMMENT 'Secure URL or document management system path to the scanned or electronic copy of the advance directive document stored in the document management system or EHR. Supports retrieval for clinical review and legal reference.',
    `source_system_directive_code` STRING COMMENT 'The native identifier of the advance directive record in the originating operational system (e.g., Epic advance care planning record ID). Supports bidirectional traceability between the lakehouse and the source Electronic Health Record (EHR).',
    `state_of_execution` STRING COMMENT 'The U.S. state (two-letter USPS abbreviation) in which the advance directive was legally executed. Determines which state-specific legal requirements and forms apply to the directives validity.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this advance directive record was last modified in the lakehouse data platform. Supports change tracking, audit trail, and data quality monitoring.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity and currency of the advance directive. Original Document = physical original reviewed; Scanned Copy = digitized copy on file; Verbal Confirmation = patient verbally confirmed; Electronic Record = verified via Health Information Exchange (HIE); Notarized Copy = legally notarized document reviewed.. Valid values are `Original Document|Scanned Copy|Verbal Confirmation|Electronic Record|Notarized Copy`',
    `verified_timestamp` TIMESTAMP COMMENT 'The date and time when the advance directive was clinically verified by a qualified provider. Verification confirms the document is current, authentic, and reflects the patients current wishes.',
    `witness_name` STRING COMMENT 'Full name of the witness who attested to the patients execution of the advance directive document. Required by many state laws to validate the legal standing of the directive.',
    CONSTRAINT pk_advance_directive PRIMARY KEY(`advance_directive_id`)
) COMMENT 'Patient advance directive and end-of-life care preference documentation including DNR (Do Not Resuscitate) orders, POLST/MOLST (Physician/Medical Orders for Life-Sustaining Treatment), living wills, healthcare power of attorney designations, and code status (Full Code, DNR, DNR/DNI, Comfort Care). Captures directive type, effective date, expiration date, document status (active, revoked, superseded), healthcare proxy name and contact information, verification method, and the provider who documented or verified the directive. Critical for end-of-life care decisions, EMTALA compliance, and patient rights under the Patient Self-Determination Act. Sourced from Epic advance care planning module.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` (
    `nursing_assessment_id` BIGINT COMMENT 'Unique surrogate identifier for each nursing assessment record in the lakehouse silver layer. Primary key for this data product.',
    `bed_id` BIGINT COMMENT 'Foreign key linking to facility.bed. Business justification: Nursing assessments are performed at specific bedsides. Linking enables bed-level acuity tracking for staffing ratios, fall risk heat maps by bed location, pressure injury prevention tied to bed assig',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Nursing assessments (admission assessments, shift assessments, discharge assessments) inform care plan development and updates. Linking nursing_assessment.care_plan_id → care_plan.care_plan_id establi',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, or outpatient center) where this nursing assessment was conducted.',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Nursing assessments identify acute changes requiring immediate imaging (respiratory distress→chest X-ray, neuro change→head CT). Essential for rapid response protocols and acute care pathways.',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to quality.improvement_initiative. Business justification: Nursing assessment compliance is a common quality initiative (fall risk assessment completion, pressure injury risk assessment). Direct linkage enables tracking initiative impact. Essential for nursin',
    `mar_record_id` BIGINT COMMENT 'Foreign key linking to pharmacy.mar_record. Business justification: Nursing assessments (pain, respiratory status, skin integrity) documented alongside medication administration for clinical correlation. Required for nursing documentation standards and medication admi',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of this nursing assessment. Links to the master patient record.',
    `patient_safety_event_id` BIGINT COMMENT 'Foreign key linking to quality.patient_safety_event. Business justification: Safety events (falls, pressure injuries) trigger review of nursing assessments to identify missed risk factors. Root cause analysis requires linking events to prior assessments. Essential for safety e',
    `clinician_id` BIGINT COMMENT 'Reference to the licensed nurse (RN or LPN) who completed and signed this nursing assessment. Used for accountability, staffing analytics, and Joint Commission compliance.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Nursing assessments include sensitive data (restraint use, mental status, fall risk) requiring documented consent for interventions. Joint Commission standards mandate consent for restraints; mental h',
    `diet_order_id` BIGINT COMMENT 'Foreign key linking to order.diet_order. Business justification: Nursing assessments drive diet orders. Real workflow: swallow assessment shows aspiration risk, triggers pureed diet order. Essential for nutrition care compliance, aspiration prevention protocols, sp',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Nursing assessments review recent lab results for care planning (potassium levels→cardiac monitoring). Role prefix reviewed_ indicates assessment input. Essential for nursing flowsheet integration a',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (inpatient admission, ED visit, or outpatient visit) during which this nursing assessment was performed.',
    `assessment_interval_hours` STRING COMMENT 'The required reassessment interval in hours as defined by the care setting protocol and assessment type (e.g., every 4 hours for ICU, every 8 hours for medical-surgical). Used to monitor reassessment compliance and timeliness.',
    `assessment_notes` STRING COMMENT 'Free-text narrative clinical notes entered by the assessing nurse to supplement structured assessment findings. May include abnormal findings, patient responses, and clinical reasoning. Contains Protected Health Information (PHI).',
    `assessment_status` STRING COMMENT 'Current workflow status of the nursing assessment record. Indicates whether the assessment is actively being documented, finalized, amended after completion, or voided. Supports Joint Commission compliance audits.. Valid values are `In Progress|Completed|Amended|Cosigned|Voided`',
    `assessment_timestamp` TIMESTAMP COMMENT 'The date and time at which the nursing assessment was clinically performed (real-world event time). Distinct from documentation or record creation timestamps. Critical for shift-based quality metrics and regulatory reporting.',
    `assessment_type` STRING COMMENT 'Classification of the nursing assessment by its clinical purpose and timing. Drives workflow routing, documentation requirements, and quality metric calculations. [ENUM-REF-CANDIDATE: Admission|Shift Change|Discharge|Head-to-Toe|Fall Risk|Skin Integrity|Restraint|Pressure Injury|Discharge Readiness|Pain — promote to reference product]',
    `braden_score` STRING COMMENT 'Numeric pressure injury risk score calculated using the Braden Scale (range 6–23). Lower scores indicate higher risk. Required for pressure injury prevention protocol activation and CMS HAC reporting.',
    `cardiovascular_status` STRING COMMENT 'Documented cardiovascular assessment findings including heart rate regularity and rhythm. Core component of the head-to-toe nursing assessment and cardiac monitoring documentation.. Valid values are `Regular Rate and Rhythm|Irregular|Tachycardic|Bradycardic|Absent`',
    `care_recommendations` STRING COMMENT 'Nursing care recommendations and planned interventions documented as part of the assessment (e.g., reposition every 2 hours, initiate fall prevention bundle, consult wound care). Feeds into the nursing care plan.',
    `care_setting` STRING COMMENT 'The clinical care setting in which the nursing assessment was performed (e.g., Inpatient, Intensive Care Unit (ICU), Emergency Department (ED), Outpatient). Drives assessment template selection and quality metric stratification.. Valid values are `Inpatient|ICU|ED|Outpatient|Surgical|Observation`',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time at which the nurse finalized and signed the nursing assessment in the EHR. Used to measure documentation timeliness and compliance with shift-completion requirements.',
    `continence_status` STRING COMMENT 'Patients urinary and bowel continence status as documented in the nursing assessment. Relevant to Catheter-Associated Urinary Tract Infection (CAUTI) prevention protocols and skin integrity management.. Valid values are `Continent|Incontinent|Catheter|Ostomy|Unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this nursing assessment record was first created in the source system. Supports audit trail and data lineage requirements.',
    `discharge_barriers` STRING COMMENT 'Free-text or structured documentation of identified barriers to patient discharge (e.g., awaiting placement, transportation, caregiver availability, Social Determinants of Health (SDOH) factors). Supports care coordination and discharge planning workflows.',
    `discharge_readiness_score` STRING COMMENT 'Numeric score from a validated discharge readiness assessment tool (e.g., Readiness for Hospital Discharge Scale) indicating the patients preparedness for discharge. Supports discharge planning, Length of Stay (LOS) management, and readmission reduction initiatives.',
    `fall_risk_category` STRING COMMENT 'Categorical fall risk classification derived from the fall risk score (Low, Moderate, High). Drives nursing care plan interventions, bed alarm activation, and fall prevention bundle compliance reporting.. Valid values are `Low|Moderate|High`',
    `fall_risk_score` STRING COMMENT 'Numeric fall risk score calculated from the validated fall risk assessment tool (e.g., Morse Fall Scale, Hendrich II). Drives fall prevention protocol activation and care plan interventions. Required for Joint Commission NPSG.09.02.01.',
    `fall_risk_tool` STRING COMMENT 'The validated fall risk assessment instrument used to calculate the fall risk score (e.g., Morse Fall Scale, Hendrich II Fall Risk Model). Ensures comparability of scores across units and facilities.. Valid values are `Morse Fall Scale|Hendrich II|STRATIFY|Johns Hopkins`',
    `iv_access_type` STRING COMMENT 'Type of intravenous access device present and assessed during the nursing assessment (Peripheral IV, Central Line, PICC, Port, or None). Critical for Central Line-Associated Bloodstream Infection (CLABSI) prevention bundle compliance and HAI reporting.. Valid values are `Peripheral IV|Central Line|PICC|Port|None`',
    `iv_site_condition` STRING COMMENT 'Condition of the intravenous access site as assessed by the nurse (Patent, Infiltrated, Phlebitis, Occluded, Removed). Drives IV site care interventions and CLABSI prevention bundle documentation.. Valid values are `Patent|Infiltrated|Phlebitis|Occluded|Removed`',
    `joint_commission_compliant` BOOLEAN COMMENT 'Indicates whether this nursing assessment meets all applicable Joint Commission documentation requirements for the assessment type (e.g., all required fields completed, completed within required timeframe). Used for quality reporting and survey readiness.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this nursing assessment record was most recently modified in the source system. Supports change detection, incremental ETL loads, and audit compliance.',
    `mobility_status` STRING COMMENT 'Patients functional mobility level as assessed by the nurse (Independent, Assisted, Dependent, Bedrest, Ambulating). Informs fall prevention, pressure injury prevention, and physical therapy referral decisions.. Valid values are `Independent|Assisted|Dependent|Bedrest|Ambulating`',
    `mrn` STRING COMMENT 'The Medical Record Number (MRN) assigned to the patient by the facilitys Master Patient Index (MPI). Provides a human-readable patient identifier for clinical staff and HIM workflows.',
    `neurological_status` STRING COMMENT 'Documented neurological status of the patient at the time of assessment, reflecting level of consciousness and orientation. Core component of head-to-toe nursing assessment and change-of-condition monitoring.. Valid values are `Alert and Oriented|Confused|Lethargic|Obtunded|Stuporous|Comatose`',
    `nursing_unit` STRING COMMENT 'The specific nursing unit or department (e.g., 4 North Medical-Surgical, MICU, PACU) where the patient was located at the time of the assessment. Used for unit-level quality benchmarking and staffing analysis.',
    `nutrition_status` STRING COMMENT 'Nursing assessment of the patients nutritional status and feeding method. Drives dietary consult referrals and nutrition care plan interventions. Supports malnutrition quality reporting.. Valid values are `Adequate|At Risk|Malnourished|NPO|Tube Feeding`',
    `orientation_level` STRING COMMENT 'Patient orientation level documented during neurological assessment: x1 (person), x2 (person and place), x3 (person, place, and time), x4 (person, place, time, and event). Standard clinical notation used in nursing documentation.. Valid values are `x1|x2|x3|x4`',
    `pain_scale_type` STRING COMMENT 'The validated pain assessment scale used to obtain the pain score (e.g., Numeric Rating Scale (NRS), FLACC for pediatric/non-verbal patients, Critical Care Pain Observation Tool (CPOT)). Required for clinical interpretation of pain scores.. Valid values are `NRS|FLACC|CPOT|Wong-Baker|VAS`',
    `pain_score` STRING COMMENT 'Numeric pain intensity score documented by the nurse using a validated pain scale (e.g., Numeric Rating Scale 0–10, FLACC, CPOT). Required by The Joint Commission for all patient assessments. Drives pain management interventions.',
    `patient_education_provided` BOOLEAN COMMENT 'Indicates whether patient and/or family education was provided during this nursing assessment encounter. Required documentation for Joint Commission and CMS patient education standards.',
    `pressure_injury_location` STRING COMMENT 'Anatomical body site location of the identified pressure injury (e.g., sacrum, coccyx, heel, occiput). Documented using standardized anatomical terminology. Required for wound care documentation and HAC reporting.',
    `pressure_injury_stage` STRING COMMENT 'National Pressure Injury Advisory Panel (NPIAP) staging classification for any identified pressure injury (Stage 1 through Stage 4, Unstageable, or Deep Tissue Pressure Injury). Required for CMS Hospital-Acquired Condition (HAC) reporting and quality metrics.. Valid values are `Stage 1|Stage 2|Stage 3|Stage 4|Unstageable|Deep Tissue`',
    `respiratory_status` STRING COMMENT 'Documented respiratory status of the patient including breathing pattern and effort. Part of the head-to-toe body system assessment. Triggers escalation protocols when abnormal.. Valid values are `Regular|Labored|Shallow|Absent|Assisted`',
    `restraint_indication` STRING COMMENT 'Clinical justification documented by the nurse for restraint application (e.g., risk of self-harm, removal of life-sustaining devices, violent behavior). Required by CMS and Joint Commission for every restraint episode.',
    `restraint_type` STRING COMMENT 'Type of restraint applied to the patient as documented in the restraint assessment (Physical, Chemical, Soft Limb, Vest, Mitts, or None). Required for CMS Conditions of Participation restraint documentation and Joint Commission compliance.. Valid values are `Physical|Chemical|Soft Limb|Vest|Mitts|None`',
    `safety_check_completed` BOOLEAN COMMENT 'Indicates whether the nursing safety check (e.g., bed in lowest position, call light within reach, side rails up, ID band verified) was completed and documented as part of this assessment. Supports Joint Commission National Patient Safety Goal compliance.',
    `skin_integrity_status` STRING COMMENT 'Overall skin integrity assessment finding indicating whether the patients skin is intact or compromised. Triggers wound care protocols and pressure injury prevention bundles. Required for HAI reporting.. Valid values are `Intact|Impaired|Wound Present|Pressure Injury`',
    `source_system_assessment_code` STRING COMMENT 'The native identifier of this nursing assessment record in the originating Electronic Health Record (EHR) system (e.g., Epic ClinDoc flowsheet row ID or Cerner PowerChart documentation ID). Supports data lineage and reconciliation.',
    CONSTRAINT pk_nursing_assessment PRIMARY KEY(`nursing_assessment_id`)
) COMMENT 'Structured nursing assessments completed at admission, shift change, and discharge including head-to-toe assessments, skin integrity assessments, fall risk assessments, pressure injury staging, restraint assessments, and discharge readiness evaluations. Captures assessment type, completion date/time, assessing nurse, assessment findings by body system, risk scores, and care recommendations. Sourced from Epic ClinDoc nursing flowsheets. Supports nursing quality metrics and Joint Commission compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` (
    `hai_event_id` BIGINT COMMENT 'Unique surrogate identifier for each Healthcare-Associated Infection (HAI) surveillance event record in the silver layer lakehouse. Primary key for this entity.',
    `bed_id` BIGINT COMMENT 'Foreign key linking to facility.bed. Business justification: Hospital-acquired infections (CLABSI, CAUTI, SSI) are attributed to specific bed locations for infection control surveillance, outbreak investigation, unit-level infection rate tracking, and NHSN repo',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, campus, or care site) where the HAI event occurred. Required for facility-level NHSN reporting and CMS Value-Based Purchasing (VBP) penalty calculations.',
    `clinician_id` BIGINT COMMENT 'Reference to the infection preventionist (IP) clinician responsible for reviewing, confirming, and submitting this HAI event to NHSN. Required for audit trail and regulatory accountability.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to quality.corrective_action. Business justification: HAI events trigger corrective actions (process improvements, staff education). Direct linkage enables tracking corrective action effectiveness. Essential for infection prevention quality improvement a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: HAI events trigger VBP penalties and increased treatment costs. Finance tracks HAI-related costs by department/cost center for penalty attribution, cost containment initiatives, and quality program RO',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Healthcare-Associated Infection (HAI) surveillance events result in infection diagnoses being documented in the patient record. Linking hai_event.diagnosis_id → diagnosis.diagnosis_id connects the inf',
    `hipaa_privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.hipaa_privacy_incident. Business justification: HAI outbreak investigations may trigger HIPAA privacy incidents if patient information is improperly disclosed during contact tracing or public health reporting. Infection control breaches that expose',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Healthcare-associated infections require imaging to assess extent/complications (CLABSI with endocarditis, VAP with infiltrate). Required for infection control investigations and HAC penalty avoidance',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to quality.improvement_initiative. Business justification: HAI reduction is a primary quality improvement focus. Initiatives link to specific HAI events for root cause analysis and intervention tracking. Essential for infection prevention quality improvement ',
    `public_health_report_id` BIGINT COMMENT 'add column interoperability_public_health_report_id (BIGINT) with FK to interoperability.public_health_report.public_health_report_id - HAI events must be reported to public health authorities (NHSN) but lack a direct link to the reporting ',
    `procedure_event_id` BIGINT COMMENT 'Reference to the surgical or invasive procedure associated with this HAI event. Mandatory for Surgical Site Infection (SSI) events per NHSN SSI protocol; nullable for device-associated infections (CLABSI, CAUTI, VAP).',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: HAIs linked to specific devices/supplies for root cause analysis, NHSN reporting, and regulatory compliance. Enables infection control supply tracking, device-associated infection surveillance, and qu',
    `microbiology_culture_id` BIGINT COMMENT 'Foreign key linking to laboratory.microbiology_culture. Business justification: HAI events identified/confirmed by positive cultures - infection control core process. Role prefix diagnostic_ indicates event confirmation. Required for NHSN reporting and outbreak investigation. R',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who experienced the Healthcare-Associated Infection (HAI) event. Links to the master patient record for demographic and clinical context.',
    `outbreak_id` BIGINT COMMENT 'Identifier linking this HAI event to a specific outbreak investigation record when outbreak_flag is True. Enables grouping of related HAI events for epidemiological analysis and root cause investigation.',
    `patient_safety_event_id` BIGINT COMMENT 'Foreign key linking to quality.patient_safety_event. Business justification: HAI events are a subset of patient safety events. Many organizations track HAIs within their safety event system for unified reporting and root cause analysis. Essential for integrated safety reportin',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: HAI events trigger response orders. Real workflow: CLABSI identified, orders placed for line removal and antibiotics. Essential for infection control tracking, HAI response protocol compliance, NHSN r',
    `susceptibility_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.susceptibility_result. Business justification: Antibiotic selection for HAI treatment based on susceptibility results. Essential for antibiotic stewardship and MDRO tracking. Removes denormalized resistance profile data in favor of proper FK relat',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Healthcare-acquired infections treated with specific antimicrobials. Antibiotic stewardship programs track drug-bug relationships, resistance patterns, and treatment outcomes. Required for NHSN report',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient encounter during which the HAI event was identified. Used to correlate infection events with admission, discharge, and clinical documentation.',
    `attributed_los_days` STRING COMMENT 'Number of additional inpatient days clinically attributed to this HAI event beyond the expected Length of Stay (LOS). Used for cost-of-infection analysis, quality improvement, and VBP impact assessments. Distinct from total encounter LOS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HAI event record was first created in the system of record or ingested into the lakehouse silver layer. Supports audit trail, data lineage, and NHSN submission timeliness tracking.',
    `device_days` STRING COMMENT 'Total number of device-days (central line days, catheter days, or ventilator days) for the patient during the relevant surveillance period. Used as the denominator in NHSN device-associated infection rate calculations (infections per 1,000 device days).',
    `device_type` STRING COMMENT 'Type of invasive device associated with the HAI event. Applicable for device-associated infections: central line (CLABSI), urinary catheter (CAUTI), mechanical ventilator (VAP). Set to none for non-device-associated infections such as SSI, MRSA bacteremia, or CDI.. Valid values are `central_line|urinary_catheter|ventilator|none|other`',
    `event_date` DATE COMMENT 'The date on which the Healthcare-Associated Infection (HAI) event was identified or the infection onset date as defined by NHSN criteria. This is the principal real-world event date used for NHSN reporting, rate calculations, and CMS submission windows.',
    `event_status` STRING COMMENT 'Current workflow lifecycle status of the HAI event record. Tracks progression from initial identification through infection preventionist review, NHSN submission, and any subsequent amendments. Drives quality and compliance dashboards.. Valid values are `pending_review|confirmed|rejected|submitted|amended`',
    `hac_flag` BOOLEAN COMMENT 'Indicates whether this HAI event qualifies as a Hospital-Acquired Condition (HAC) under CMS payment policy, potentially triggering a payment reduction or penalty. True = qualifies as HAC; False = does not meet HAC criteria.',
    `infection_onset_setting` STRING COMMENT 'Clinical setting in which the infection is determined to have originated: inpatient (hospital-acquired), outpatient, community-acquired, long-term care facility (LTCF), or unknown. Supports NHSN attribution rules and population health analysis.. Valid values are `inpatient|outpatient|community|ltcf|unknown`',
    `infection_type` STRING COMMENT 'Classification of the HAI event per NHSN definitions: Central Line-Associated Bloodstream Infection (CLABSI), Catheter-Associated Urinary Tract Infection (CAUTI), Surgical Site Infection (SSI), Methicillin-Resistant Staphylococcus aureus (MRSA) bacteremia, Clostridioides difficile Infection (CDI), or Ventilator-Associated Pneumonia (VAP). Drives NHSN module routing and CMS VBP penalty calculations.. Valid values are `CLABSI|CAUTI|SSI|MRSA|CDI|VAP`',
    `ip_review_date` DATE COMMENT 'Date on which the infection preventionist completed their clinical review of this HAI event. Used for workflow tracking, timeliness metrics, and audit trail documentation.',
    `ip_review_notes` STRING COMMENT 'Free-text clinical notes entered by the infection preventionist during review of this HAI event. May include rationale for confirmation, rejection, or amendment of the event classification. Supports CDI and quality review workflows.',
    `ip_review_status` STRING COMMENT 'Status of the infection preventionists clinical review of this HAI event. Tracks whether the IP has reviewed, approved, or disputed the event classification prior to NHSN submission. Required for regulatory audit trails.. Valid values are `not_reviewed|in_review|reviewed|approved|disputed`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this HAI event record, including status changes, IP review updates, NHSN submission updates, or clinical amendments. Required for change data capture (CDC) and audit compliance.',
    `mrn` STRING COMMENT 'Medical Record Number (MRN) of the patient associated with this HAI event. Denormalized from the patient record to support infection surveillance workflows and NHSN submission without requiring a join.',
    `nhsn_definition_met` BOOLEAN COMMENT 'Indicates whether this event meets the CDC NHSN surveillance definition criteria for the specified infection type. True = confirmed HAI per NHSN criteria; False = under review or criteria not fully met. Determines reportability to CMS and state health departments.',
    `nhsn_event_number` STRING COMMENT 'Unique event number assigned by the CDC National Healthcare Safety Network (NHSN) upon submission of this HAI event. Used for regulatory tracking, CMS reporting reconciliation, and state mandatory reporting.',
    `nhsn_procedure_code` STRING COMMENT 'NHSN-specific procedure category code for the operative procedure linked to an SSI event (e.g., COLO for colon surgery, HPRO for hip prosthesis). Distinct from CPT codes; used specifically for NHSN SSI risk index calculation and benchmarking.',
    `nhsn_reporting_status` STRING COMMENT 'Indicates the submission and acceptance status of this HAI event with the CDC National Healthcare Safety Network (NHSN). Tracks whether the event has been reported, accepted, or rejected by NHSN. Critical for CMS HAI reporting compliance and VBP penalty avoidance.. Valid values are `not_reported|reported|accepted|rejected_by_nhsn`',
    `nhsn_submission_date` DATE COMMENT 'Date on which this HAI event was submitted to the CDC National Healthcare Safety Network (NHSN). Used to verify timely reporting compliance with CMS and state mandatory reporting deadlines.',
    `outbreak_flag` BOOLEAN COMMENT 'Indicates whether this HAI event has been associated with a declared infection outbreak investigation at the facility. True = linked to an active or closed outbreak; False = sporadic/isolated event. Supports epidemiological cluster analysis.',
    `patient_days` STRING COMMENT 'Total number of patient-days in the unit or facility during the surveillance period associated with this HAI event. Used as the denominator for non-device-associated infection rates (e.g., CDI, MRSA per 10,000 patient days) per NHSN methodology.',
    `patient_outcome` STRING COMMENT 'Clinical outcome of the patient attributed to or associated with this HAI event: recovered, transferred to higher level of care, expired, or unknown. Used for mortality analysis, quality reporting, and NHSN outcome tracking.. Valid values are `recovered|transferred|expired|unknown`',
    `present_on_admission` BOOLEAN COMMENT 'Indicates whether the infection was present at the time of hospital admission (True) or developed after admission (False). HAI events by definition should be False (post-admission onset). Used for HAC (Hospital-Acquired Condition) determination and CMS payment adjustments.',
    `secondary_infection_type` STRING COMMENT 'Secondary or co-occurring HAI type when a patient experiences more than one concurrent infection event (e.g., a patient with both CLABSI and CAUTI). Nullable; populated only when a secondary infection is clinically documented and meets NHSN criteria.',
    `source_system_event_code` STRING COMMENT 'Native identifier of this HAI event in the originating source system (e.g., Epic infection control record ID, Theradoc case number). Enables bidirectional traceability between the lakehouse and the system of record.',
    `ssi_depth` STRING COMMENT 'NHSN classification of the depth/anatomical level of the Surgical Site Infection (SSI): Superficial Incisional, Deep Incisional, or Organ/Space. Applicable only when infection_type = SSI. Determines NHSN SSI category and CMS reporting classification.. Valid values are `superficial_incisional|deep_incisional|organ_space`',
    `ssi_wound_class` STRING COMMENT 'NHSN wound classification for Surgical Site Infection (SSI) events: Clean, Clean-Contaminated, Contaminated, or Dirty/Infected. Applicable only when infection_type = SSI. Used for SSI risk stratification and NHSN SSI rate calculations.. Valid values are `clean|clean_contaminated|contaminated|dirty_infected`',
    `state_report_date` DATE COMMENT 'Date on which this HAI event was reported to the state health department, when state_reportable_flag is True. Used to verify compliance with state mandatory reporting timelines.',
    `state_reportable_flag` BOOLEAN COMMENT 'Indicates whether this HAI event is subject to mandatory reporting to the state health department under applicable state law. True = state reporting required; False = not subject to state mandatory reporting. Varies by infection type and state jurisdiction.',
    `unit_location_code` STRING COMMENT 'NHSN-mapped location code identifying the patient care unit or ward where the HAI event occurred (e.g., ICU, medical-surgical, step-down). Used for unit-level infection rate calculations, benchmarking, and targeted prevention interventions.',
    `unit_location_description` STRING COMMENT 'Human-readable description of the patient care unit or ward where the HAI event occurred (e.g., Medical ICU, Surgical Step-Down Unit). Complements the NHSN location code for reporting and operational dashboards.',
    `vbp_penalty_flag` BOOLEAN COMMENT 'Indicates whether this HAI event contributes to a CMS Value-Based Purchasing (VBP) HAI domain penalty calculation for the facility. True = event is included in VBP HAI scoring; False = excluded from VBP calculation.',
    CONSTRAINT pk_hai_event PRIMARY KEY(`hai_event_id`)
) COMMENT 'Healthcare-Associated Infection (HAI) surveillance event records tracking CLABSI, CAUTI, SSI, MRSA, C. difficile, and VAP events per NHSN (National Healthcare Safety Network) definitions. Captures infection type, NHSN definition criteria met, event date, device days, patient days, unit/location, causative organism, antibiotic susceptibility, linked procedure (for SSI), infection preventionist review status, and reporting status. Sourced from Epic infection control modules and dedicated surveillance systems (e.g., Theradoc, ICNet). Required for CMS HAI reporting, VBP penalty calculations, and state mandatory reporting. Domain ownership note: clinical domain owns the HAI event as a clinical occurrence; quality domain owns the aggregate surveillance metrics and benchmarking — global architect should confirm this boundary.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` (
    `clinical_finding_id` BIGINT COMMENT 'Unique surrogate identifier for the clinical finding record in the lakehouse silver layer.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care location where this clinical finding was documented.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who documented or recorded this clinical finding.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this clinical finding was documented.',
    `observation_id` BIGINT COMMENT 'FHIR Observation resource identifier assigned during FHIR-based clinical data exchange, enabling semantic interoperability with external Health Information Exchange (HIE) partners and APIs.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Finding observation type classification for result interpretation, reference range application, and interoperable data exchange. Clinical systems use LOINC codes to standardize finding observations fo',
    `note_id` BIGINT COMMENT 'Reference to the clinical note from which this structured finding was extracted or with which it is associated, enabling traceability back to the source narrative documentation.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Clinical findings (elevated BP, abnormal labs, symptoms) trigger prescription orders. Fundamental to clinical workflow where findings drive therapeutic interventions. Required for clinical decision su',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Clinical findings (depression diagnosis via PHQ-9, SDOH screening results) support quality measure numerator determination. Essential for automated quality measure calculation and clinical decision su',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Clinical findings (genetic, behavioral health, SDOH) may require consent for documentation or disclosure. Sensitive findings trigger consent verification workflows to ensure appropriate information sh',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical finding standardization for structured documentation, clinical decision support, and quality measure calculation. SNOMED CT findings enable semantic reasoning for care pathways, risk stratifi',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Clinical findings often derived from/supported by lab results (finding=hyperkalemia sourced from test_result). Role prefix source_ indicates data origin. Removes denormalized lab value fields in f',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this finding was documented.',
    `body_site_code` STRING COMMENT 'SNOMED CT concept code identifying the anatomical body site to which this clinical finding applies (e.g., 368209003 for right arm). Enables structured anatomical documentation.. Valid values are `^[0-9]{6,18}$`',
    `body_site_description` STRING COMMENT 'Human-readable description of the anatomical body site corresponding to the body_site_code (e.g., Right arm, Left lower lobe of lung).',
    `care_setting` STRING COMMENT 'Specific care setting or unit where the finding was documented (e.g., Emergency Department (ED), Intensive Care Unit (ICU), Operating Room (OR), outpatient clinic). Supports operational and quality reporting segmentation. [ENUM-REF-CANDIDATE: ED|ICU|OR|inpatient-ward|outpatient-clinic|telehealth|SNF|PACU|step-down — promote to reference product]',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates whether this clinical finding has triggered a Clinical Documentation Improvement (CDI) query to the provider for clarification or additional specificity, supporting accurate coding and reimbursement.',
    `chronic_finding_flag` BOOLEAN COMMENT 'Indicates whether this clinical finding represents a chronic or persistent condition rather than an acute or transient observation. Supports population health management and chronic disease registries.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification of this clinical finding per HIPAA and organizational policy. Restricted findings (e.g., behavioral health, substance use, HIV) require additional access controls beyond standard Protected Health Information (PHI) protections.. Valid values are `normal|restricted|very-restricted`',
    `documentation_date` DATE COMMENT 'Calendar date on which the clinical finding was documented by the provider in the Electronic Health Record (EHR). Used for longitudinal clinical tracking and quality measure date attribution.',
    `encounter_type` STRING COMMENT 'Type of clinical encounter during which this finding was documented (e.g., inpatient, outpatient, emergency department). Supports care setting stratification in analytics.. Valid values are `inpatient|outpatient|emergency|observation|telehealth`',
    `finding_category` STRING COMMENT 'High-level category classifying the type of clinical finding. [ENUM-REF-CANDIDATE: exam|symptom|history|functional|laboratory|imaging|social|vital-sign|assessment — promote to reference product]',
    `finding_comment` STRING COMMENT 'Free-text narrative comment or clinical note addendum provided by the documenting provider to further qualify or contextualize the finding beyond structured coded fields.',
    `finding_status` STRING COMMENT 'Clinical assertion status indicating whether the finding is present, absent, unknown, indeterminate, or not assessed for this patient at this encounter. Core semantic qualifier per SNOMED CT post-coordination.. Valid values are `present|absent|unknown|indeterminate|not-assessed`',
    `interpretation_code` STRING COMMENT 'Standardized interpretation flag for the finding value relative to reference ranges (e.g., N=Normal, H=High, L=Low, HH=Critical High, LL=Critical Low, POS=Positive, NEG=Negative, IND=Indeterminate). Aligns with HL7 v2 OBX-8. [ENUM-REF-CANDIDATE: N|A|H|L|HH|LL|POS|NEG|IND — 9 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the clinical finding record was most recently modified or updated in the source system.',
    `laterality` STRING COMMENT 'Laterality qualifier indicating which side of the body the finding applies to (left, right, bilateral, or unspecified). Used in conjunction with body site for precise anatomical documentation.. Valid values are `left|right|bilateral|unspecified`',
    `mrn` STRING COMMENT 'Medical Record Number (MRN) of the patient associated with this finding, as assigned by the facility Master Patient Index (MPI). Retained for operational cross-referencing.',
    `onset_date` DATE COMMENT 'Date on which the clinical finding first appeared or was first observed, as reported by the patient or clinician. Distinct from documentation date; supports longitudinal clinical analysis.',
    `present_on_admission` STRING COMMENT 'Present on Admission (POA) indicator for inpatient findings, per CMS reporting requirements. Y=Yes (present at admission), N=No (developed after admission), U=Unknown, W=Clinically undetermined. Impacts Hospital-Acquired Condition (HAC) reporting.. Valid values are `Y|N|U|W`',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this clinical finding is relevant to one or more clinical quality measures (e.g., HEDIS, CMS MIPS, Joint Commission Core Measures). Supports quality reporting workflows.',
    `recorded_timestamp` TIMESTAMP COMMENT 'Date and time when the clinical finding was first entered into the Electronic Health Record (EHR) system. Represents the business event timestamp of initial documentation.',
    `resolution_date` DATE COMMENT 'Date on which the clinical finding resolved or was no longer present, as documented by the provider. Null if the finding is ongoing or chronic.',
    `sdoh_flag` BOOLEAN COMMENT 'Indicates whether this clinical finding is related to Social Determinants of Health (SDOH), such as food insecurity, housing instability, or transportation barriers. Supports population health and care management programs.',
    `sensitive_finding_type` STRING COMMENT 'Classifies the finding as belonging to a sensitive clinical category subject to heightened privacy protections beyond standard HIPAA PHI rules (e.g., behavioral health, substance use disorder per 42 CFR Part 2, HIV status, sexual health, genetic information). none indicates no special sensitivity.. Valid values are `behavioral-health|substance-use|HIV|sexual-health|genetic|none`',
    `severity` STRING COMMENT 'Clinical severity grade of the finding as documented by the provider (e.g., mild, moderate, severe, life-threatening). Supports clinical decision support and quality reporting.. Valid values are `mild|moderate|severe|life-threatening`',
    `source_system_finding_code` STRING COMMENT 'Native identifier of this clinical finding in the originating operational system (Epic or Cerner internal ID), used for lineage and reconciliation.',
    `specialty` STRING COMMENT 'Clinical specialty of the provider who documented the finding (e.g., Cardiology, Internal Medicine, Emergency Medicine). Supports specialty-specific analytics and quality reporting.',
    `title` STRING COMMENT 'Short, human-readable title or label for the clinical finding as displayed in the Electronic Health Record (EHR) interface (e.g., Peripheral edema, Breath sounds diminished).',
    `value_code` STRING COMMENT 'Coded value for the finding when the result is expressed as a coded concept rather than a numeric quantity (e.g., a SNOMED CT code for positive, negative, or a specific coded finding result).',
    `value_string` STRING COMMENT 'Free-text string value for the finding when the result cannot be expressed as a numeric quantity or coded concept (e.g., Grade II/VI systolic murmur, Coarse breath sounds bilaterally).',
    `verification_status` STRING COMMENT 'Clinical verification status indicating the degree of certainty or confirmation of the finding by the documenting provider.. Valid values are `confirmed|provisional|refuted|entered-in-error`',
    CONSTRAINT pk_clinical_finding PRIMARY KEY(`clinical_finding_id`)
) COMMENT 'SNOMED CT-coded clinical findings and observations documented by providers representing discrete clinical concepts beyond diagnoses and procedures. Includes physical examination findings, symptom documentation, clinical impressions, and structured clinical data elements. Captures SNOMED CT concept code, finding category, finding status (present, absent, unknown), body site, laterality, severity, and documentation date. Enables semantic interoperability and FHIR-based clinical data exchange. Sourced from Epic and Cerner structured documentation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` (
    `procedure_equipment_usage_id` BIGINT COMMENT 'Unique surrogate identifier for each procedure-equipment usage record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician (surgeon, nurse, surgical tech) who documented this equipment usage in the clinical system. Supports audit trail and accountability.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to the specific equipment asset that was deployed and used',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to the clinical procedure event during which the equipment was used',
    `charge_captured_flag` BOOLEAN COMMENT 'Indicates whether a revenue cycle charge was generated for this equipment usage. Links equipment utilization to charge capture and revenue integrity.',
    `documentation_timestamp` TIMESTAMP COMMENT 'Date and time when this equipment usage record was documented in the source system. Supports audit trail and data quality assessment.',
    `equipment_malfunction_flag` BOOLEAN COMMENT 'Indicates whether the equipment experienced a malfunction, failure, or performance issue during this procedure. Triggers biomedical engineering investigation and potential FDA Medical Device Reporting (MDR).',
    `implant_used` BOOLEAN COMMENT 'Indicates whether a medical implant or device was used during the procedure. Triggers implant log documentation requirements, FDA device tracking obligations, and supply chain charge capture. [Moved from procedure_event: The implant_used flag in procedure_event is a procedure-level aggregate indicator, but the actual implant usage is equipment-specific. A procedure may use multiple equipment assets, only some of which are implants. The implant_used_flag and udi belong in the association to track which specific equipment assets were implanted, enabling FDA traceability at the device level rather than just the procedure level.]',
    `implant_used_flag` BOOLEAN COMMENT 'Indicates whether this specific equipment asset was used as an implantable device during the procedure. Critical for FDA traceability requirements and patient implant registries.',
    `malfunction_description` STRING COMMENT 'Free-text description of the equipment malfunction or performance issue if equipment_malfunction_flag is true. Used for root cause analysis and FDA reporting.',
    `sterilization_lot_number` STRING COMMENT 'Lot or batch number from the sterilization cycle that processed this equipment prior to use in this procedure. Critical for infection control tracking and sterile processing quality assurance.',
    `udi` STRING COMMENT 'FDA-mandated Unique Device Identifier captured at the point of use during the procedure. Required for implant traceability and device event reporting. May duplicate equipment_asset.udi but captured here for point-of-use verification.',
    `usage_duration_minutes` STRING COMMENT 'Total elapsed time in minutes that the equipment was actively used during the procedure. Derived from usage_start_timestamp and usage_end_timestamp. Supports utilization rate calculations and capacity planning.',
    `usage_end_timestamp` TIMESTAMP COMMENT 'Date and time when the equipment usage concluded and the asset was released from the procedure. Used to calculate actual usage duration and equipment turnover time.',
    `usage_role` STRING COMMENT 'Role or function of the equipment during the procedure (primary, backup, standby, ancillary). Distinguishes between primary surgical equipment and supporting devices.',
    `usage_start_timestamp` TIMESTAMP COMMENT 'Date and time when the equipment was deployed and began being used during the procedure. Critical for utilization tracking and equipment availability management.',
    CONSTRAINT pk_procedure_equipment_usage PRIMARY KEY(`procedure_equipment_usage_id`)
) COMMENT 'This association product represents the operational usage event between a clinical procedure and a specific equipment asset. It captures the actual deployment and utilization of biomedical equipment during surgical and interventional procedures. Each record links one procedure_event to one equipment_asset with timestamps, sterilization tracking, implant traceability, and malfunction reporting that exist only in the context of this specific usage instance. Supports OR utilization analytics, biomedical engineering maintenance correlation, FDA device event reporting (MDR), and TJC equipment management compliance.. Existence Justification: In healthcare operations, surgical and interventional procedures routinely deploy multiple equipment assets simultaneously (surgical table, anesthesia machine, robotic system, imaging equipment, infusion pumps, patient monitors), and each capital equipment asset is used across hundreds of procedures over its lifecycle. Clinical staff actively document equipment usage during procedure execution for charge capture, sterilization tracking, implant traceability, and malfunction reporting. This is an operational M:N relationship managed as part of the clinical workflow.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` (
    `plan_care_coordination_id` BIGINT COMMENT 'Unique surrogate identifier for this care plan-health plan coordination record',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to the patient care plan being coordinated with payer requirements',
    `clinician_id` BIGINT COMMENT 'Reference to the health plans case manager or care coordinator assigned to this care plan. May be different from the provider organizations care coordinator.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to the health insurance plan that has specific care management requirements for this care plan',
    `authorization_date` DATE COMMENT 'Date when the health plan approved authorization for this care plan. Null if authorization is pending or denied.',
    `authorization_expiration_date` DATE COMMENT 'Date when the health plan authorization for this care plan expires. Triggers reauthorization workflows.',
    `authorization_number` STRING COMMENT 'The authorization or reference number issued by the health plan for this care plan. Required for claims submission and payer coordination.',
    `authorization_status` STRING COMMENT 'Current authorization status from the health plan for this care plan. Values: pending, approved, denied, expired, revoked. Drives billing and service delivery authorization.',
    `care_management_tier` STRING COMMENT 'The level of care management intensity required by the health plan for this care plan. Values: basic, enhanced, intensive, complex. Drives care coordinator assignment and contact frequency requirements.',
    `coordination_end_date` DATE COMMENT 'Date when coordination between this care plan and health plan ended. Null if coordination is ongoing.',
    `coordination_start_date` DATE COMMENT 'Date when coordination between this care plan and health plan began. May differ from enrollment_date if coordination started before formal program enrollment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this care plan-health plan coordination record was first created in the system.',
    `enrollment_date` DATE COMMENT 'Date when this care plan was enrolled in the health plans care management program. Tracks when payer-specific care coordination began.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this coordination record. Tracks changes to authorization status, program enrollment, or other coordination attributes.',
    `last_payer_review_date` DATE COMMENT 'Date of the most recent review or audit of this care plan by the health plan. Used for tracking payer engagement and compliance reviews.',
    `next_payer_review_date` DATE COMMENT 'Scheduled date for the next review of this care plan by the health plan. Drives care coordination workflow reminders.',
    `plan_specific_goal_count` STRING COMMENT 'Number of care plan goals that are specifically required by this health plans care management program. Subset of total care plan goals.',
    `primary_coverage_flag` BOOLEAN COMMENT 'Indicates whether this health plan is the primary payer for this care plan. True for primary coverage, false for secondary/tertiary. Drives coordination of benefits and billing priority.',
    `program_enrollment_status` STRING COMMENT 'Current enrollment status in the health plans care management program for this care plan. Values: enrolled, active, suspended, completed, disenrolled. Tracks program participation lifecycle.',
    `program_name` STRING COMMENT 'Name of the specific care management program within the health plan that this care plan is enrolled in (e.g., Diabetes Management, CHF Care Coordination, Transitional Care).',
    `quality_measure_set` STRING COMMENT 'The quality measure set or HEDIS measures that this health plan requires for this care plan (e.g., HEDIS Diabetes Composite, CMS Stars Measures). Drives quality reporting requirements.',
    CONSTRAINT pk_plan_care_coordination PRIMARY KEY(`plan_care_coordination_id`)
) COMMENT 'This association product represents the enrollment and coordination relationship between a patients care plan and the health insurance plan(s) covering that care. It captures payer-specific care management requirements, authorization status, and program participation for each care plan-health plan combination. Each record links one care plan to one health plan with attributes that exist only in the context of this payer-specific care coordination relationship.. Existence Justification: In healthcare operations, a single care plan frequently requires coordination with multiple health insurance plans when patients have dual coverage (Medicare + Medicaid, primary + secondary insurance, or Medicare Advantage + supplemental). Each health plan imposes distinct care management requirements, authorization processes, quality measures, and program enrollment criteria for the same underlying care plan. Conversely, a health plans care management program tracks multiple care plans across its member population. Care coordinators actively manage these plan-specific coordination records, updating authorization status, program enrollment, and payer-specific goals as part of operational care delivery workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`note_template` (
    `note_template_id` BIGINT COMMENT 'Primary key for note_template',
    `employee_id` BIGINT COMMENT 'Identifier of the authorized user who approved this template for clinical use.',
    `note_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who originally created this template.',
    `org_provider_id` BIGINT COMMENT 'Identifier of the healthcare organization or facility that owns and maintains this template.',
    `parent_note_template_id` BIGINT COMMENT 'Self-referencing FK on note_template (parent_note_template_id)',
    `parent_template_id` BIGINT COMMENT 'The parent template id for the note template record.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED CT concept identifier for the clinical documentation type represented by this template.',
    `access_level` STRING COMMENT 'Access control level determining which users and roles can view and use this template.',
    `approval_date` DATE COMMENT 'Date when this template version was formally approved for clinical use by authorized personnel.',
    `auto_populate_fields` STRING COMMENT 'Comma-separated list of field names that are automatically populated from patient record data when the template is opened.',
    `cdi_enabled` BOOLEAN COMMENT 'Indicates whether this template includes Clinical Documentation Improvement prompts and quality checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this template record was first created in the system.',
    `note_template_description` STRING COMMENT 'Detailed description of the templates purpose, intended use cases, and any special instructions for clinicians.',
    `effective_end_date` DATE COMMENT 'Date when this template version is retired and no longer available for new documentation. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this template version becomes available for use in clinical documentation.',
    `encounter_type` STRING COMMENT 'Type of clinical encounter for which this template is intended (e.g., inpatient, outpatient, emergency, telehealth). [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|observation|telehealth|home_health|ambulatory_surgery — promote to reference product]',
    `estimated_completion_minutes` STRING COMMENT 'Average time in minutes required for a clinician to complete documentation using this template.',
    `format_type` STRING COMMENT 'Technical format in which the template body content is stored and rendered.',
    `is_default_for_specialty` BOOLEAN COMMENT 'Indicates whether this template is the default selection for its assigned clinical specialty.',
    `is_shared_across_facilities` BOOLEAN COMMENT 'Indicates whether this template is available for use across multiple facilities within the healthcare organization.',
    `is_structured` BOOLEAN COMMENT 'Indicates whether the template uses structured data entry fields with discrete data elements versus free-text narrative.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags to facilitate template search and discovery by clinicians.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the template content.',
    `last_reviewed_date` DATE COMMENT 'Date when this template was last reviewed for clinical accuracy and regulatory compliance.',
    `loinc_code` STRING COMMENT 'Standard LOINC code identifying the type of clinical document represented by this template for interoperability.',
    `macros_enabled` BOOLEAN COMMENT 'Indicates whether this template supports text expansion macros and shortcuts for efficient documentation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this template record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this template to ensure continued clinical relevance and compliance.',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory or compliance requirement that this template is designed to satisfy (e.g., CMS documentation requirements, Joint Commission standards).',
    `required_sections` STRING COMMENT 'Comma-separated list of mandatory sections that must be completed before the note can be signed and finalized.',
    `requires_attestation` BOOLEAN COMMENT 'Indicates whether notes created from this template require formal clinician attestation and signature.',
    `retirement_date` DATE COMMENT 'Date when this template was officially retired and removed from active use.',
    `specialty` STRING COMMENT 'Medical specialty or clinical department for which this template is designed (e.g., Cardiology, Emergency Medicine, Pediatrics).',
    `note_template_status` STRING COMMENT 'Current lifecycle status of the note template indicating its availability for clinical use.',
    `supports_voice_dictation` BOOLEAN COMMENT 'Indicates whether this template is optimized for voice dictation and speech recognition input.',
    `template_body` STRING COMMENT 'The structured content and layout of the clinical note template including sections, prompts, and data entry fields.',
    `template_code` STRING COMMENT 'Unique business identifier code for the note template used across the organization for reference and integration.',
    `template_name` STRING COMMENT 'Human-readable name of the clinical note template displayed to clinicians and staff.',
    `template_type` STRING COMMENT 'Classification of the clinical note template by its primary clinical purpose and documentation type.',
    `usage_count` BIGINT COMMENT 'Total number of clinical notes that have been created using this template since activation.',
    `version_number` STRING COMMENT 'Version identifier for the template following semantic versioning to track template revisions and updates.',
    CONSTRAINT pk_note_template PRIMARY KEY(`note_template_id`)
) COMMENT 'Master reference table for note_template. Referenced by template_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` (
    `outbreak_id` BIGINT COMMENT 'Primary key for outbreak',
    `care_site_id` BIGINT COMMENT 'Reference to the primary healthcare facility or location where the outbreak occurred.',
    `care_team_id` BIGINT COMMENT 'Reference to the infection prevention and control team responsible for outbreak response.',
    `public_health_report_id` BIGINT COMMENT 'add column interoperability_public_health_report_id (BIGINT) with FK to interoperability.public_health_report.public_health_report_id - outbreaks require mandatory public health reporting but lack this FK',
    `employee_id` BIGINT COMMENT 'Reference to the user who created the outbreak record.',
    `outbreak_reported_by_user_employee_id` BIGINT COMMENT 'Reference to the healthcare professional or epidemiologist leading the outbreak investigation.',
    `outbreak_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last updated the outbreak record.',
    `parent_outbreak_id` BIGINT COMMENT 'Self-referencing FK on outbreak (parent_outbreak_id)',
    `mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - outbreaks involve index patients but outbreak lacks a patient FK',
    `case_fatality_rate` DECIMAL(18,2) COMMENT 'Percentage of cases that resulted in death, calculated as (death_count / total_case_count) * 100.',
    `outbreak_code` STRING COMMENT 'Externally-known unique business identifier for the outbreak, typically assigned by public health authorities or internal epidemiology teams.',
    `confirmed_case_count` STRING COMMENT 'Number of laboratory-confirmed cases associated with this outbreak.',
    `containment_date` DATE COMMENT 'Date when the outbreak was successfully contained (no new cases for defined period).',
    `control_measures` STRING COMMENT 'Description of infection control and public health measures implemented to contain and resolve the outbreak.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the outbreak record was first created in the system.',
    `death_count` STRING COMMENT 'Number of deaths attributed to the outbreak.',
    `declaration_date` DATE COMMENT 'Date when the outbreak was formally declared by the responsible health authority.',
    `detection_date` DATE COMMENT 'Date when the outbreak was officially detected and recognized by public health or infection control authorities.',
    `disease_code` STRING COMMENT 'ICD-10 code representing the disease or condition associated with the outbreak.',
    `disease_name` STRING COMMENT 'Full clinical name of the disease or condition causing the outbreak (e.g., Salmonella Enteritidis Infection, COVID-19).',
    `genetic_sequencing_performed_flag` BOOLEAN COMMENT 'Indicates whether genetic sequencing (e.g., whole genome sequencing) was performed to characterize the outbreak strain.',
    `geographic_scope` STRING COMMENT 'Geographic extent of the outbreak spread.',
    `hospitalization_count` STRING COMMENT 'Number of cases requiring hospital admission due to the outbreak-related illness.',
    `index_case_date` DATE COMMENT 'Date when the first case (index case) of the outbreak was identified or symptom onset occurred.',
    `investigation_status` STRING COMMENT 'Current status of the epidemiological investigation into the outbreak.',
    `laboratory_confirmation_method` STRING COMMENT 'Description of the laboratory testing method(s) used to confirm the outbreak pathogen (e.g., PCR, culture, serology, whole genome sequencing).',
    `media_notification_flag` BOOLEAN COMMENT 'Indicates whether the outbreak was communicated to media or made public.',
    `outbreak_name` STRING COMMENT 'Human-readable descriptive name or title of the outbreak event (e.g., Salmonella Outbreak - Regional Hospital Q2 2024).',
    `notes` STRING COMMENT 'Free-text clinical and epidemiological notes documenting key findings, timeline, and observations related to the outbreak investigation.',
    `notification_date` DATE COMMENT 'Date when the outbreak was reported to public health authorities.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether mandatory public health notifications were sent to relevant authorities and stakeholders.',
    `pathogen_type` STRING COMMENT 'Classification of the causative agent responsible for the outbreak.',
    `primary_location_type` STRING COMMENT 'Type of setting where the outbreak primarily occurred or originated.',
    `probable_case_count` STRING COMMENT 'Number of probable cases (meeting clinical criteria without laboratory confirmation) associated with this outbreak.',
    `public_health_alert_issued_flag` BOOLEAN COMMENT 'Indicates whether a public health alert or advisory was issued to the community or healthcare providers.',
    `reporting_jurisdiction` STRING COMMENT 'State, territory, or country code of the jurisdiction responsible for outbreak reporting (ISO 3166-1 alpha-2 or alpha-3).',
    `resolution_date` DATE COMMENT 'Date when the outbreak was officially declared resolved and closed.',
    `severity_level` STRING COMMENT 'Classification of the outbreak severity based on case count, mortality, transmission rate, and public health impact.',
    `source_description` STRING COMMENT 'Detailed description of the identified or suspected source of the outbreak (e.g., contaminated food item, infected healthcare worker, environmental reservoir).',
    `source_identified_flag` BOOLEAN COMMENT 'Indicates whether the source or origin of the outbreak has been definitively identified.',
    `outbreak_status` STRING COMMENT 'Current lifecycle status of the outbreak investigation and response.',
    `total_case_count` STRING COMMENT 'Total number of confirmed and probable cases associated with this outbreak.',
    `transmission_mode` STRING COMMENT 'Primary mode of disease transmission identified for this outbreak.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the outbreak record was last modified.',
    CONSTRAINT pk_outbreak PRIMARY KEY(`outbreak_id`)
) COMMENT 'Master reference table for outbreak. Referenced by outbreak_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` (
    `flowsheet_row_id` BIGINT COMMENT 'Primary key for flowsheet_row',
    `flowsheet_template_id` BIGINT COMMENT 'Reference to the parent flowsheet template that contains this row. Links to the flowsheet template master table.',
    `parent_flowsheet_row_id` BIGINT COMMENT 'Self-referencing FK on flowsheet_row (parent_flowsheet_row_id)',
    `loinc_code_id` BIGINT COMMENT 'add column reference_loinc_code_id (BIGINT) with FK to reference.loinc_code.loinc_code_id - flowsheet rows capture clinical observations that should be LOINC-coded but lack this reference',
    `specialty_id` BIGINT COMMENT 'Reference to the medical specialty or clinical department that primarily uses this flowsheet row (e.g., Cardiology, Critical Care, Pediatrics).',
    `alert_enabled` BOOLEAN COMMENT 'Indicates whether automated clinical alerts are enabled when values fall outside defined thresholds for this flowsheet row.',
    `alert_severity` STRING COMMENT 'Severity classification for clinical alerts generated by abnormal values in this flowsheet row.',
    `calculation_formula` STRING COMMENT 'Mathematical or logical formula used to automatically calculate values for this flowsheet row from other clinical data elements.',
    `clinical_notes` STRING COMMENT 'Additional clinical guidance, interpretation notes, or special instructions for clinicians documenting this flowsheet row.',
    `consent_required` BOOLEAN COMMENT 'Indicates whether specific patient consent is required before documenting or sharing data from this flowsheet row.',
    `cpt_code` STRING COMMENT 'CPT code associated with the clinical service or procedure represented by this flowsheet row for billing and reimbursement purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this flowsheet row record was first created in the system.',
    `critical_high_threshold` DECIMAL(18,2) COMMENT 'Critical high threshold value that triggers immediate clinical alerts when measurements exceed this level.',
    `critical_low_threshold` DECIMAL(18,2) COMMENT 'Critical low threshold value that triggers immediate clinical alerts when measurements fall below this level.',
    `data_type` STRING COMMENT 'The data type expected for values recorded in this flowsheet row (numeric, text, date, selection list, etc.).',
    `flowsheet_row_description` STRING COMMENT 'Detailed description of the clinical measurement or observation captured by this flowsheet row, including clinical context and usage guidance.',
    `device_type` STRING COMMENT 'Type of medical device or monitoring equipment typically used to capture measurements for this flowsheet row (e.g., bedside monitor, infusion pump, ventilator).',
    `display_format` STRING COMMENT 'Format specification for displaying values in clinical user interfaces (e.g., decimal precision, date format, text length).',
    `display_sequence` STRING COMMENT 'Numeric sequence controlling the display order of flowsheet rows in clinical documentation interfaces.',
    `documentation_frequency` STRING COMMENT 'Expected or required frequency for documenting this measurement in clinical workflows (e.g., hourly for critical care vital signs).',
    `effective_end_date` DATE COMMENT 'Date when this flowsheet row was retired or deprecated and is no longer available for new clinical documentation. Null for currently active rows.',
    `effective_start_date` DATE COMMENT 'Date when this flowsheet row became active and available for clinical documentation.',
    `interface_code` STRING COMMENT 'External system interface code used for mapping this flowsheet row to medical devices, laboratory systems, or other clinical data sources.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether documentation of this flowsheet row contributes to billable clinical services or procedures.',
    `is_calculated` BOOLEAN COMMENT 'Indicates whether the value for this flowsheet row is automatically calculated from other measurements rather than manually entered.',
    `is_required` BOOLEAN COMMENT 'Indicates whether documentation of this flowsheet row is mandatory for specific clinical workflows or regulatory compliance.',
    `loinc_code` STRING COMMENT 'Standard LOINC code for the clinical observation or measurement. Enables interoperability and standardized clinical data exchange.',
    `modified_by` STRING COMMENT 'Identifier of the system user or administrator who last modified this flowsheet row configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this flowsheet row record was last modified.',
    `normal_range_high` DECIMAL(18,2) COMMENT 'Upper bound of the normal reference range for this measurement. Used for clinical decision support and alerting.',
    `normal_range_low` DECIMAL(18,2) COMMENT 'Lower bound of the normal reference range for this measurement. Used for clinical decision support and alerting.',
    `privacy_level` STRING COMMENT 'Privacy classification level for data in this flowsheet row, determining access controls and disclosure restrictions under HIPAA and organizational policies.',
    `quality_measure_indicator` BOOLEAN COMMENT 'Indicates whether this flowsheet row is used in clinical quality measure reporting (e.g., CMS quality programs, Joint Commission measures).',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory or accreditation requirement that mandates documentation of this flowsheet row (e.g., Joint Commission, CMS Conditions of Participation).',
    `row_code` STRING COMMENT 'Unique code identifying the flowsheet row within the Electronic Health Record (EHR) system. Used for system-level identification and mapping.',
    `row_name` STRING COMMENT 'Human-readable name of the flowsheet row measurement or observation type (e.g., Heart Rate, Blood Pressure Systolic, Temperature).',
    `row_type` STRING COMMENT 'Classification of the flowsheet row indicating the category of clinical data being captured (e.g., vital sign, laboratory result, intake/output measurement).',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT concept identifier for the clinical finding or observable entity represented by this flowsheet row.',
    `flowsheet_row_status` STRING COMMENT 'Current lifecycle status of this flowsheet row in the master reference table. Inactive or deprecated rows are no longer available for new documentation.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measurement for numeric values in this flowsheet row (e.g., bpm, mmHg, degrees Celsius, mL, mg/dL). Uses Unified Code for Units of Measure (UCUM) standard.',
    `validation_rule` STRING COMMENT 'Business rules and constraints applied to validate data entry for this flowsheet row (e.g., range checks, format validation, conditional logic).',
    `version_number` STRING COMMENT 'Version identifier for this flowsheet row configuration, supporting change tracking and configuration management.',
    `created_by` STRING COMMENT 'Identifier of the system user or administrator who created this flowsheet row configuration.',
    CONSTRAINT pk_flowsheet_row PRIMARY KEY(`flowsheet_row_id`)
) COMMENT 'Master reference table for flowsheet_row. Referenced by flowsheet_row_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` (
    `flowsheet_template_id` BIGINT COMMENT 'Primary key for flowsheet_template',
    `employee_id` BIGINT COMMENT 'Identifier of the authorized user who approved this flowsheet template for clinical use.',
    `care_site_id` BIGINT COMMENT 'add column facility_care_site_id (BIGINT) with FK to facility.care_site.care_site_id - flowsheet templates are site-specific but only have a self-ref',
    `flowsheet_created_by_user_id` BIGINT COMMENT 'Identifier of the user who originally created this flowsheet template in the system.',
    `flowsheet_last_modified_by_user_id` BIGINT COMMENT 'Identifier of the user who most recently modified this flowsheet template.',
    `flowsheet_workforce_employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - flowsheet templates need an author/owner but lack any employee FK',
    `org_unit_id` BIGINT COMMENT 'Identifier of the clinical department or service line responsible for maintaining and governing this flowsheet template.',
    `parent_flowsheet_template_id` BIGINT COMMENT 'Self-referencing FK on flowsheet_template (parent_flowsheet_template_id)',
    `age_range_max` STRING COMMENT 'Maximum patient age in years for which this flowsheet template is clinically appropriate. Null indicates no maximum age restriction.',
    `age_range_min` STRING COMMENT 'Minimum patient age in years for which this flowsheet template is clinically appropriate. Null indicates no minimum age restriction.',
    `allows_custom_fields` BOOLEAN COMMENT 'Indicates whether clinicians can add ad-hoc custom fields when using this flowsheet template for documentation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this flowsheet template was officially approved for clinical deployment.',
    `care_setting` STRING COMMENT 'Type of care environment where this flowsheet template is intended to be used.',
    `flowsheet_template_category` STRING COMMENT 'High-level grouping or category for organizing flowsheet templates (e.g., assessments, monitoring, interventions).',
    `copyright_notice` STRING COMMENT 'Copyright and intellectual property notice associated with this flowsheet template if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this flowsheet template record was first created in the system.',
    `flowsheet_template_description` STRING COMMENT 'Detailed description of the flowsheet template purpose, clinical use case, and documentation guidelines.',
    `display_order` STRING COMMENT 'Numeric sequence for ordering flowsheet templates in user interface selection lists and menus.',
    `documentation_interval_minutes` STRING COMMENT 'Standard time interval in minutes between flowsheet documentation entries when used for continuous monitoring.',
    `effective_end_date` DATE COMMENT 'Date when this flowsheet template version is retired or superseded. Null indicates currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this flowsheet template version becomes active and available for clinical use.',
    `frequency_default` STRING COMMENT 'Recommended or default frequency for completing this flowsheet (e.g., every 4 hours, once per shift, continuous).',
    `is_archived` BOOLEAN COMMENT 'Indicates whether this flowsheet template has been archived for historical reference but is no longer available for new documentation.',
    `is_electronic_signature_required` BOOLEAN COMMENT 'Indicates whether an electronic signature is required when completing this flowsheet for regulatory or policy compliance.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether completion of this flowsheet is required for specific care protocols or regulatory compliance.',
    `is_system_default` BOOLEAN COMMENT 'Indicates whether this flowsheet template is a system-provided default template versus a custom user-created template.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this flowsheet template record was most recently updated.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time when this flowsheet template was most recently used to create a flowsheet instance.',
    `loinc_code` STRING COMMENT 'Standard LOINC code associated with this flowsheet template for interoperability and clinical data exchange.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review and validation of this flowsheet template.',
    `patient_population` STRING COMMENT 'Target patient population for which this flowsheet template is designed and validated.',
    `print_layout_template` STRING COMMENT 'Reference to the print layout or report template used when generating printed versions of flowsheet data.',
    `publisher` STRING COMMENT 'Organization or entity responsible for publishing and maintaining this flowsheet template.',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory mandate or accreditation standard that requires this flowsheet documentation (e.g., Joint Commission, CMS Conditions of Participation).',
    `requires_cosignature` BOOLEAN COMMENT 'Indicates whether entries using this template require verification or cosignature by a supervising clinician.',
    `retired_timestamp` TIMESTAMP COMMENT 'Date and time when this flowsheet template was retired from active clinical use. Null indicates template is still active.',
    `review_frequency_days` STRING COMMENT 'Number of days between required periodic reviews of this flowsheet template for clinical accuracy and relevance.',
    `snomed_code` STRING COMMENT 'SNOMED CT concept code representing the clinical finding or procedure documented by this flowsheet template.',
    `specialty` STRING COMMENT 'Medical specialty or clinical department for which this flowsheet template is designed (e.g., cardiology, intensive care, emergency medicine).',
    `flowsheet_template_status` STRING COMMENT 'Current lifecycle status of the flowsheet template indicating whether it is available for clinical use.',
    `template_code` STRING COMMENT 'Unique business identifier or code for the flowsheet template, used for external references and system integration.',
    `template_name` STRING COMMENT 'Human-readable name of the flowsheet template used for identification and selection in clinical workflows.',
    `template_type` STRING COMMENT 'Classification of the flowsheet template by clinical purpose or specialty area.',
    `usage_count` BIGINT COMMENT 'Total number of times this flowsheet template has been used to create flowsheet instances in clinical documentation.',
    `version_number` STRING COMMENT 'Version identifier for the flowsheet template to track revisions and updates over time.',
    CONSTRAINT pk_flowsheet_template PRIMARY KEY(`flowsheet_template_id`)
) COMMENT 'Master reference table for flowsheet_template. Referenced by flowsheet_template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_note_template_id` FOREIGN KEY (`note_template_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note_template`(`note_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_parent_note_id` FOREIGN KEY (`parent_note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_previous_vital_sign_id` FOREIGN KEY (`previous_vital_sign_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`vital_sign`(`vital_sign_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_flowsheet_row_id` FOREIGN KEY (`flowsheet_row_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`flowsheet_row`(`flowsheet_row_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_cdi_worksheet_id` FOREIGN KEY (`cdi_worksheet_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`cdi_worksheet`(`cdi_worksheet_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_superseded_by_directive_advance_directive_id` FOREIGN KEY (`superseded_by_directive_advance_directive_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`advance_directive`(`advance_directive_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_outbreak_id` FOREIGN KEY (`outbreak_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`outbreak`(`outbreak_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_parent_note_template_id` FOREIGN KEY (`parent_note_template_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note_template`(`note_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_parent_template_id` FOREIGN KEY (`parent_template_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note_template`(`note_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_parent_outbreak_id` FOREIGN KEY (`parent_outbreak_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`outbreak`(`outbreak_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_flowsheet_template_id` FOREIGN KEY (`flowsheet_template_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`flowsheet_template`(`flowsheet_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_parent_flowsheet_row_id` FOREIGN KEY (`parent_flowsheet_row_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`flowsheet_row`(`flowsheet_row_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_parent_flowsheet_template_id` FOREIGN KEY (`parent_flowsheet_template_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`flowsheet_template`(`flowsheet_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`clinical` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`clinical` SET TAGS ('dbx_domain' = 'clinical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coded By User ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Admitting Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `admit_diagnosis_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_value_regex' = 'pending|agreed|disagreed|no_response|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `clinical_status` SET TAGS ('dbx_value_regex' = 'active|resolved|inactive|recurrence|remission|unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_date` SET TAGS ('dbx_business_glossary_term' = 'Coding Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `coding_status` SET TAGS ('dbx_value_regex' = 'unreviewed|coded|queried|finalized|amended');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `complication_comorbidity_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication or Comorbidity (CC/MCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Recorded Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Discharge Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `discharge_diagnosis_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `drg_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Relevant Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Entry Source');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_value_regex' = 'physician|cdi_specialist|coder|nurse|imported');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_diagnosis_source` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `encounter_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_business_glossary_term' = 'External Cause of Injury (ICD-10-CM) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `external_cause_code` SET TAGS ('dbx_value_regex' = '^[VWX][0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$|^Y[0-9A-Z]{2,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `hac_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospital-Acquired Condition (HAC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_business_glossary_term' = 'ICD-10-CM Fiscal Year Version');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `icd10_version` SET TAGS ('dbx_value_regex' = '^FY[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mcc_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Complication or Comorbidity (MCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `note_text` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `note_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `present_on_admission` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `present_on_admission` SET TAGS ('dbx_value_regex' = 'Y|N|U|W|1');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `principal_diagnosis_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `problem_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Problem List Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Rank');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `rank` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Recorded Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|critical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Diagnosis ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `source_system_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_value_regex' = 'principal|secondary|admitting|discharge|working|chronic_problem_list');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'confirmed|provisional|differential|refuted|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Room ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Preop Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `tertiary_procedure_anesthesia_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_value_regex' = 'general|regional|local|monitored_anesthesia_care|none');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `approach` SET TAGS ('dbx_business_glossary_term' = 'Surgical Approach');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `approach` SET TAGS ('dbx_value_regex' = 'open|laparoscopic|robotic|endoscopic|percutaneous|transcatheter');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `asa_classification` SET TAGS ('dbx_business_glossary_term' = 'American Society of Anesthesiologists (ASA) Physical Status Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `asa_classification` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|VI');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Procedure Body Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cdm_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Description Master (CDM) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Procedure Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_business_glossary_term' = 'CPT Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `cpt_modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `estimated_blood_loss_ml` SET TAGS ('dbx_business_glossary_term' = 'Estimated Blood Loss (EBL) in Milliliters');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision Procedure Coding System (ICD-10-PCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `icd10_pcs_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Procedure Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis ICD-10 Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Procedure Priority');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|stat');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_business_glossary_term' = 'Procedure Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_category` SET TAGS ('dbx_value_regex' = 'surgical|diagnostic|therapeutic|preventive|rehabilitative|palliative');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Procedure Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Procedure End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_number` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Procedure Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_status` SET TAGS ('dbx_value_regex' = 'performed|in-progress|cancelled|not-done|on-hold|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `procedure_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) — Work Component');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Procedure Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Clinical Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `snomed_ct_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `snomed_ct_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `specimen_collected` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collected Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `timeout_performed` SET TAGS ('dbx_business_glossary_term' = 'Surgical Time-Out Performed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `wound_classification` SET TAGS ('dbx_business_glossary_term' = 'Surgical Wound Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ALTER COLUMN `wound_classification` SET TAGS ('dbx_value_regex' = 'clean|clean_contaminated|contaminated|dirty_infected');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `accreditation_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Survey Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Document Type Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Author Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_cosigner_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Co-signer Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_template_id` SET TAGS ('dbx_business_glossary_term' = 'Note Template ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `parent_note_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Note ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `amended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Amended Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `author_role` SET TAGS ('dbx_business_glossary_term' = 'Note Author Role');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `authored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Authored Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|ambulatory_surgery|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_value_regex' = 'pending|answered|withdrawn|no_query');
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
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis International Classification of Diseases 10th Revision (ICD-10) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `sensitive_note_type` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Note Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `sensitive_note_type` SET TAGS ('dbx_value_regex' = 'behavioral_health|substance_abuse|hiv_aids|sexual_health|domestic_violence|none');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `signed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Note Signed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `source_system_note_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Note ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specialty');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_value_regex' = 'draft|signed|amended|addended|retracted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Text (Protected Health Information)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_value_regex' = 'History and Physical|Progress Note|Discharge Summary|Operative Note|Consult Note|Nursing Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Note Version Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Note Word Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Added By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_last_updated_by_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Ct Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `body_site_code` SET TAGS ('dbx_business_glossary_term' = 'Body Site Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `body_site_description` SET TAGS ('dbx_business_glossary_term' = 'Body Site Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|ambulatory|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `cdi_query_status` SET TAGS ('dbx_value_regex' = 'pending|answered|withdrawn|no-query');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Problem Comment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `comment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `comment` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Problem Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `fhir_condition_reference` SET TAGS ('dbx_business_glossary_term' = 'HL7 FHIR Condition Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `hcc_category_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Is Encounter Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `is_encounter_diagnosis` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `list_display_order` SET TAGS ('dbx_business_glossary_term' = 'Problem List Display Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `noted_date` SET TAGS ('dbx_business_glossary_term' = 'Problem Noted Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_age_years` SET TAGS ('dbx_business_glossary_term' = 'Onset Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_age_years` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_age_years` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Problem Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `onset_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `principal_problem_flag` SET TAGS ('dbx_business_glossary_term' = 'Principal Problem Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Problem Priority');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low|routine');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Problem Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `resolution_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `resolution_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Problem Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `source_system_problem_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Problem ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_code` SET TAGS ('dbx_business_glossary_term' = 'Problem Stage Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Stage Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `stage_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_business_glossary_term' = 'Problem Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_status` SET TAGS ('dbx_value_regex' = 'active|inactive|resolved|deleted|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Problem Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `title` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `title` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_business_glossary_term' = 'Problem Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `problem_type` SET TAGS ('dbx_value_regex' = 'chronic|acute|historical|social|surgical|psychiatric');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'confirmed|unconfirmed|provisional|differential|refuted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` SET TAGS ('dbx_subdomain' = 'patient_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_id` SET TAGS ('dbx_business_glossary_term' = 'Allergy Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `cpoe_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Triggering Cpoe Alert Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Documenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_override_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Override Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `claim_attachment_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Attachment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmatory Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Snomed Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `alert_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Allergy Alert Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_business_glossary_term' = 'Allergen Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_name` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|ambulatory|telehealth|other');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_business_glossary_term' = 'Allergy Category Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `allergy_category` SET TAGS ('dbx_value_regex' = 'allergy|intolerance|side_effect');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_business_glossary_term' = 'Allergy Clinical Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `clinical_status` SET TAGS ('dbx_value_regex' = 'active|inactive|resolved');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Allergy Criticality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `criticality` SET TAGS ('dbx_value_regex' = 'low|high|unable_to_assess');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Deletion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'HL7 FHIR Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `information_source` SET TAGS ('dbx_business_glossary_term' = 'Allergy Information Source');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `information_source` SET TAGS ('dbx_value_regex' = 'patient|caregiver|provider|medical_record|pharmacy|other');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_allergy` SET TAGS ('dbx_business_glossary_term' = 'No Known Allergy (NKA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `is_no_known_drug_allergy` SET TAGS ('dbx_business_glossary_term' = 'No Known Drug Allergy (NKDA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allergy Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `ndf_rt_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug File Reference Terminology (NDF-RT) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Allergy Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `note` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Allergy Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `onset_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `onset_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Override Timestamp');
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
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `source_system_allergy_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Allergy ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Allergy Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'confirmed|unconfirmed|refuted|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` SET TAGS ('dbx_subdomain' = 'patient_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_id` SET TAGS ('dbx_business_glossary_term' = 'Immunization ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Immunization Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Hedis Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `immunization_ordering_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `primary_care_physician_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_route_code` SET TAGS ('dbx_business_glossary_term' = 'Administration Route Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_route_code` SET TAGS ('dbx_value_regex' = 'IM|SC|ID|PO|IN|IV');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_site_code` SET TAGS ('dbx_business_glossary_term' = 'Administration Site Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_status` SET TAGS ('dbx_business_glossary_term' = 'Immunization Administration Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_status` SET TAGS ('dbx_value_regex' = 'completed|entered-in-error|not-done');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `administration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Immunization Administration Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `clinical_note` SET TAGS ('dbx_business_glossary_term' = 'Immunization Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Immunization Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_number_in_series` SET TAGS ('dbx_business_glossary_term' = 'Dose Number in Series');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_quantity` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Dose Quantity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Dose Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `dose_unit` SET TAGS ('dbx_value_regex' = 'mL|mg|mcg|units');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Funding Source Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_value_regex' = 'VFC|317|STATE|PRIVATE|OTHER');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `iis_reported` SET TAGS ('dbx_business_glossary_term' = 'Immunization Information System (IIS) Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `iis_reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Immunization Information System (IIS) Reported Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `not_given_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Immunization Not Given Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `reaction_detail` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Detail');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `reaction_observed` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Observed Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Immunization Series Completion Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_completion_status` SET TAGS ('dbx_value_regex' = 'complete|in-progress|not-started|overdue');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_doses_required` SET TAGS ('dbx_business_glossary_term' = 'Series Total Doses Required');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `series_name` SET TAGS ('dbx_business_glossary_term' = 'Immunization Series Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vaers_reported` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Adverse Event Reporting System (VAERS) Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vfc_eligibility_code` SET TAGS ('dbx_business_glossary_term' = 'Vaccines for Children (VFC) Eligibility Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vfc_eligibility_code` SET TAGS ('dbx_value_regex' = 'V01|V02|V03|V04|V05|V06');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vis_document_type` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Information Statement (VIS) Document Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vis_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Information Statement (VIS) Presentation Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ALTER COLUMN `vis_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Information Statement (VIS) Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` SET TAGS ('dbx_subdomain' = 'patient_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mar Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `previous_vital_sign_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Vital Sign Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `abnormal_flag` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Abnormal Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `amended_reason` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Body Site');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `care_unit` SET TAGS ('dbx_business_glossary_term' = 'Care Unit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_health' = 'true');
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
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `numeric_value` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Numeric Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `numeric_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `numeric_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Observation Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `observation_type` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Observation Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `oxygen_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `oxygen_delivery_method` SET TAGS ('dbx_value_regex' = 'room_air|nasal_cannula|simple_mask|non_rebreather|high_flow_nasal|mechanical_ventilator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Pain Assessment Scale Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_value_regex' = 'numeric_rating|visual_analog|faces|flacc|cpot|behavioral');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `patient_position` SET TAGS ('dbx_business_glossary_term' = 'Patient Position During Measurement');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `reference_range_high` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Reference Range High');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `reference_range_low` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Reference Range Low');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `snomed_finding_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Finding Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `snomed_finding_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `supplemental_oxygen_flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Oxygen Flow Rate (L/min)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `text_value` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Text Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `text_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `text_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Observation ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Observation Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `flowsheet_row_id` SET TAGS ('dbx_business_glossary_term' = 'EHR Flowsheet Row ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `assessment_component` SET TAGS ('dbx_business_glossary_term' = 'Assessment Component Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `assessment_tool` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assessment Tool');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `body_site_code` SET TAGS ('dbx_business_glossary_term' = 'Body Site SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `body_system` SET TAGS ('dbx_business_glossary_term' = 'Body System');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_business_glossary_term' = 'Observation Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `critical_value_notified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `data_absent_reason` SET TAGS ('dbx_business_glossary_term' = 'Data Absent Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Observation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Observation Device Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `external_observation_code` SET TAGS ('dbx_business_glossary_term' = 'External Observation ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `interpretation_flag` SET TAGS ('dbx_business_glossary_term' = 'Observation Interpretation Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Observation Amended Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `is_critical_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `issued_datetime` SET TAGS ('dbx_business_glossary_term' = 'Observation Issued Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|midline|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `local_code` SET TAGS ('dbx_business_glossary_term' = 'Local Observation Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `method_code` SET TAGS ('dbx_business_glossary_term' = 'Observation Method SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `presence_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Finding Presence Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `presence_status` SET TAGS ('dbx_value_regex' = 'present|absent|unknown|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `reference_range_high` SET TAGS ('dbx_business_glossary_term' = 'Reference Range High Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `reference_range_low` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Low Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `sdoh_domain` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Domain');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Clinical Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life-threatening|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
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
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `accreditation_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Survey Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `order_set_id` SET TAGS ('dbx_business_glossary_term' = 'Activated Order Set Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Category Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `tertiary_care_pcp_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `aco_attributed` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Attributed Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `advance_directive_on_file` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive on File Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `authored_date` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Authored Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Health Care Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `behavioral_health_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `cdi_review_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Review Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `cdi_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed|not_required');
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
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Care Plan Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `patient_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|on-hold|completed|revoked|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_business_glossary_term' = 'Population Health Program Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `population_health_program` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_icd10_code` SET TAGS ('dbx_business_glossary_term' = 'Primary ICD-10 Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `primary_icd10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9A-Z]{1,6}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `readmission_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Readmission Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `readmission_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Review Frequency');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `transitions_of_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Transitions of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Version Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `care_plan_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Goal ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Related Condition Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Target Measure Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Target Observation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Target Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `achieved_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Achieved Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `achievement_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `achievement_status` SET TAGS ('dbx_value_regex' = 'in-progress|improving|worsening|no-change|achieved|not-achieved');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `barrier_notes` SET TAGS ('dbx_business_glossary_term' = 'Goal Barrier Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Goal Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Cancelled Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `care_gap_related` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `care_team_role` SET TAGS ('dbx_business_glossary_term' = 'Care Team Role Responsible');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goal Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `current_value` SET TAGS ('dbx_business_glossary_term' = 'Goal Current Measured Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `current_value_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Current Value Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `expressed_by_type` SET TAGS ('dbx_business_glossary_term' = 'Goal Expressed By Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `expressed_by_type` SET TAGS ('dbx_value_regex' = 'patient|practitioner|related-person|caregiver');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `fhir_goal_reference` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Goal Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `fhir_goal_reference` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9-.]{1,64}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `goal_category_display` SET TAGS ('dbx_business_glossary_term' = 'Goal Category Display Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `goal_category_snomed_code` SET TAGS ('dbx_business_glossary_term' = 'Goal Category SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `goal_category_snomed_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `goal_description` SET TAGS ('dbx_business_glossary_term' = 'Goal Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `goal_external_code` SET TAGS ('dbx_business_glossary_term' = 'Goal External Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_value_regex' = 'proposed|accepted|in-progress|achieved|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `goal_title` SET TAGS ('dbx_business_glossary_term' = 'Goal Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Goal Clinical Note');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `patient_agreement` SET TAGS ('dbx_business_glossary_term' = 'Patient Goal Agreement Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Goal Priority');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high-priority|medium-priority|low-priority');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Goal Review Frequency');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|as-needed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `sdoh_related` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `status_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goal Status Changed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Target Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Goal Target Value');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `target_value_comparator` SET TAGS ('dbx_business_glossary_term' = 'Goal Target Value Comparator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `target_value_comparator` SET TAGS ('dbx_value_regex' = '<|<=|>=|>');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `target_value_unit` SET TAGS ('dbx_business_glossary_term' = 'Goal Target Value Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goal Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Goal Version Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `primary_contact_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `tertiary_care_member_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Member Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `aco_attributed` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Attribution Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_coordination_level` SET TAGS ('dbx_business_glossary_term' = 'Care Coordination Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_coordination_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|complex|intensive');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `cdi_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `coverage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `coverage_end_timestamp` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `coverage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `coverage_start_timestamp` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `ehr_care_team_csn` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Care Team Contact Serial Number (CSN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `hie_shared` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Shared Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_multidisciplinary` SET TAGS ('dbx_business_glossary_term' = 'Multidisciplinary Team Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_on_call` SET TAGS ('dbx_business_glossary_term' = 'On-Call Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `is_primary_team` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Team Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Participation End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_code` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Role Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_role_name` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Role Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Participation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_status` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|removed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Care Team Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Care Team Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `source_system_team_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specialty Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Care Team Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Care Team Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|proposed|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `team_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|primary|specialty|multidisciplinary|transitional');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `transitions_of_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Transitions of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ALTER COLUMN `vbp_program_code` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Purchasing (VBP) Program Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Added By User ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Assignment End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Assignment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|consulting|covering|co-managing|observing');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_category` SET TAGS ('dbx_business_glossary_term' = 'Care Team Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `care_team_category` SET TAGS ('dbx_value_regex' = 'longitudinal|episode|event|condition');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `clinical_focus` SET TAGS ('dbx_business_glossary_term' = 'Clinical Focus');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'scheduled|cross_coverage|locum|temporary|permanent');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `coverage_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `handoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Care Handoff Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_attending` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_on_call` SET TAGS ('dbx_business_glossary_term' = 'On-Call Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_pcp` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_status` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|removed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'secure_message|pager|phone|email|in_basket');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `relationship_to_patient` SET TAGS ('dbx_business_glossary_term' = 'Provider Relationship to Patient');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Removal Reason');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Care Team Role Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Care Team Role Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Care Team Member Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `snomed_role_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Role Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Care Team Member ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `cdi_query_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Icd10 Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `cdi_worksheet_id` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Worksheet ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Queried Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Working Drg Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Specialist ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Queried Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Radiology Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `actual_reimbursement_impact` SET TAGS ('dbx_business_glossary_term' = 'Actual Reimbursement Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `actual_reimbursement_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `appeal_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Support Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `cc_mcc_status` SET TAGS ('dbx_business_glossary_term' = 'Complication or Comorbidity / Major Complication or Comorbidity (CC/MCC) Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `cc_mcc_status` SET TAGS ('dbx_value_regex' = 'CC|MCC|none|undetermined');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `coding_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Coding Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `concurrent_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `documentation_gap_description` SET TAGS ('dbx_business_glossary_term' = 'Documentation Gap Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `drg_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `drg_type` SET TAGS ('dbx_value_regex' = 'MS-DRG|APR-DRG|AP-DRG');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `encounter_type` SET TAGS ('dbx_value_regex' = 'inpatient|observation|outpatient|ED|surgical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `expected_drg_code` SET TAGS ('dbx_business_glossary_term' = 'Expected Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `expected_drg_description` SET TAGS ('dbx_business_glossary_term' = 'Expected Diagnosis-Related Group (DRG) Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `expected_reimbursement_impact` SET TAGS ('dbx_business_glossary_term' = 'Expected Reimbursement Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `expected_reimbursement_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `final_drg_code` SET TAGS ('dbx_business_glossary_term' = 'Final Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `physician_query_method` SET TAGS ('dbx_business_glossary_term' = 'Physician Query Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `physician_query_method` SET TAGS ('dbx_value_regex' = 'electronic|verbal|written|secure_message');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_value_regex' = 'Y|N|U|W|1');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `provider_response_text` SET TAGS ('dbx_business_glossary_term' = 'Provider Response Text');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `provider_response_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_category` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_issue_date` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Issue Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_number` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_opportunity_flag` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Opportunity Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_outcome` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Outcome');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_outcome` SET TAGS ('dbx_value_regex' = 'agreed|disagreed|no_impact|unable_to_determine|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_response_date` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Response Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_status` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_status` SET TAGS ('dbx_value_regex' = 'open|answered|expired|withdrawn|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_text` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Text');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_type` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `query_type` SET TAGS ('dbx_value_regex' = 'compliant|leading|multiple_choice|yes_no|open_ended');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `response_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Query Response Turnaround Hours');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `retrospective_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Retrospective Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `risk_of_mortality_level` SET TAGS ('dbx_business_glossary_term' = 'Risk of Mortality (ROM) Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `risk_of_mortality_level` SET TAGS ('dbx_value_regex' = '1|2|3|4');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `severity_of_illness_level` SET TAGS ('dbx_business_glossary_term' = 'Severity of Illness (SOI) Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `severity_of_illness_level` SET TAGS ('dbx_value_regex' = '1|2|3|4');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `source_system_query_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Query ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `cdi_worksheet_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Worksheet ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'CDI Program ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Working Drg Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Specialist ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `admit_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `cc_mcc_captured` SET TAGS ('dbx_business_glossary_term' = 'CC/MCC Captured Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `cc_mcc_status` SET TAGS ('dbx_business_glossary_term' = 'Complication or Comorbidity / Major Complication or Comorbidity (CC/MCC) Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `cc_mcc_status` SET TAGS ('dbx_value_regex' = 'none|CC|MCC');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `documentation_gap_count` SET TAGS ('dbx_business_glossary_term' = 'Documentation Gap Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `documentation_gap_notes` SET TAGS ('dbx_business_glossary_term' = 'Documentation Gap Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `documentation_gap_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `drg_grouper_version` SET TAGS ('dbx_business_glossary_term' = 'DRG Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `drg_weight_change` SET TAGS ('dbx_business_glossary_term' = 'DRG Relative Weight Change');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `encounter_type` SET TAGS ('dbx_value_regex' = 'inpatient|observation|outpatient|ED|surgical');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `expected_reimbursement_impact` SET TAGS ('dbx_business_glossary_term' = 'Expected Reimbursement Impact (USD)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `expected_reimbursement_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `final_drg_code` SET TAGS ('dbx_business_glossary_term' = 'Final Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `final_drg_description` SET TAGS ('dbx_business_glossary_term' = 'Final Diagnosis-Related Group (DRG) Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `final_drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Final Diagnosis-Related Group (DRG) Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `hac_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospital-Acquired Condition (HAC) Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `los_at_review` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) at Review (Days)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mdc_code` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category (MDC) Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `payer_type` SET TAGS ('dbx_value_regex' = 'Medicare|Medicaid|commercial|self_pay|other');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `poa_status` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `poa_status` SET TAGS ('dbx_value_regex' = 'Y|N|U|W|1');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `query_count` SET TAGS ('dbx_business_glossary_term' = 'Physician Query Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `query_opportunity_flag` SET TAGS ('dbx_business_glossary_term' = 'Physician Query Opportunity Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `query_response_status` SET TAGS ('dbx_business_glossary_term' = 'Physician Query Response Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `query_response_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|agreed|disagreed|unable_to_determine');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Outcome');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'no_change|drg_upgrade|drg_downgrade|cc_mcc_added|principal_dx_changed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_query|completed|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'CDI Review Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'initial|concurrent|follow_up|final|post_discharge');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Clinical Service Line');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `source_system_worksheet_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Worksheet ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ALTER COLUMN `worksheet_number` SET TAGS ('dbx_business_glossary_term' = 'CDI Worksheet Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` SET TAGS ('dbx_subdomain' = 'patient_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `functional_status_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Status Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Assessing Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `therapy_order_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Therapy Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `adl_score` SET TAGS ('dbx_business_glossary_term' = 'Activities of Daily Living (ADL) Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `advance_directive_on_file` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive on File');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessing_discipline` SET TAGS ('dbx_business_glossary_term' = 'Assessing Clinical Discipline');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_location` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled|amended|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_tool` SET TAGS ('dbx_business_glossary_term' = 'Functional Assessment Tool');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'admission|discharge|interim|annual|follow_up|referral');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `cage_aid_score` SET TAGS ('dbx_business_glossary_term' = 'CAGE-AID Substance Use Screening Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `cage_aid_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `cage_aid_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `caregiver_support_available` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Support Available');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assessment Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `cognitive_score` SET TAGS ('dbx_business_glossary_term' = 'Cognitive Function Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `communication_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `communication_status` SET TAGS ('dbx_value_regex' = 'intact|impaired|nonverbal|requires_interpreter|unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `discharge_disposition_recommended` SET TAGS ('dbx_business_glossary_term' = 'Recommended Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `fall_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Fall Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `fall_risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `iadl_score` SET TAGS ('dbx_business_glossary_term' = 'Instrumental Activities of Daily Living (IADL) Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `is_baseline_assessment` SET TAGS ('dbx_business_glossary_term' = 'Baseline Assessment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `mobility_score` SET TAGS ('dbx_business_glossary_term' = 'Mobility Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `mobility_status` SET TAGS ('dbx_business_glossary_term' = 'Mobility Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `mobility_status` SET TAGS ('dbx_value_regex' = 'independent|supervision|limited_assistance|extensive_assistance|total_dependence|activity_did_not_occur');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_value_regex' = 'adequate|at_risk|malnourished|unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `pain_level` SET TAGS ('dbx_business_glossary_term' = 'Pain Level Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `phq9_score` SET TAGS ('dbx_business_glossary_term' = 'Patient Health Questionnaire-9 (PHQ-9) Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `phq9_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `phq9_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `pressure_injury_risk` SET TAGS ('dbx_business_glossary_term' = 'Pressure Injury Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `pressure_injury_risk` SET TAGS ('dbx_value_regex' = 'no_risk|at_risk|high_risk|very_high_risk');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `prior_level_of_function` SET TAGS ('dbx_business_glossary_term' = 'Prior Level of Function (PLOF)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `prior_level_of_function` SET TAGS ('dbx_value_regex' = 'independent|modified_independent|supervised|assisted|dependent|unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `rehabilitation_potential` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Potential');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `rehabilitation_potential` SET TAGS ('dbx_value_regex' = 'good|fair|poor|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `score_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Score Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `score_interpretation` SET TAGS ('dbx_value_regex' = 'normal|mild_impairment|moderate_impairment|severe_impairment|total_dependence');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `sdoh_domain_flags` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Domain Flags');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `sdoh_domain_flags` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `sdoh_domain_flags` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `sdoh_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Screening Result');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `sdoh_screening_result` SET TAGS ('dbx_value_regex' = 'no_needs_identified|needs_identified|patient_declined|not_screened');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `sdoh_screening_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `sdoh_screening_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `total_score` SET TAGS ('dbx_business_glossary_term' = 'Total Assessment Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `advance_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `accreditation_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Survey Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `claim_attachment_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Attachment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Documenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `superseded_by_directive_advance_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Directive ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `artificially_administered_nutrition` SET TAGS ('dbx_business_glossary_term' = 'Artificially Administered Nutrition Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `artificially_administered_nutrition` SET TAGS ('dbx_value_regex' = 'Accept|Decline|Trial Period|No Preference Stated');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Patient Decision-Making Capacity Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_value_regex' = 'Has Capacity|Lacks Capacity|Capacity Uncertain');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_business_glossary_term' = 'Advance Directive Clinical Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `code_status` SET TAGS ('dbx_business_glossary_term' = 'Code Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `code_status` SET TAGS ('dbx_value_regex' = 'Full Code|DNR|DNR/DNI|Comfort Care|Limited Interventions');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
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
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `hospice_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Hospice Enrollment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `hospitalization_preference` SET TAGS ('dbx_business_glossary_term' = 'Hospitalization Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `hospitalization_preference` SET TAGS ('dbx_value_regex' = 'Accept Hospitalization|Avoid Hospitalization|Comfort Care Only|No Preference Stated');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_business_glossary_term' = 'Life-Sustaining Treatment Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_value_regex' = 'Full Treatment|Selective Treatment|Comfort Measures Only');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `life_sustaining_treatment_preference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mechanical_ventilation_preference` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Ventilation Preference');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mechanical_ventilation_preference` SET TAGS ('dbx_value_regex' = 'Accept|Decline|Trial Period|No Preference Stated');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `notarized` SET TAGS ('dbx_business_glossary_term' = 'Directive Notarized Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `organ_donation_status` SET TAGS ('dbx_business_glossary_term' = 'Organ Donation Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `organ_donation_status` SET TAGS ('dbx_value_regex' = 'Donor|Non-Donor|Donor with Restrictions|Unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `palliative_care_referral` SET TAGS ('dbx_business_glossary_term' = 'Palliative Care Referral Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_business_glossary_term' = 'Patient Decision-Making Capacity Assessed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_capacity_assessed` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `patient_education_provided` SET TAGS ('dbx_business_glossary_term' = 'Patient Education Provided Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Patient Preferred Language');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `preferred_language` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_alternate_phone` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Proxy Alternate Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_alternate_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_alternate_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_alternate_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_name` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Proxy Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_phone` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Proxy Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Proxy Relationship');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Directive Revocation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `scanned_document_url` SET TAGS ('dbx_business_glossary_term' = 'Scanned Directive Document URL');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `scanned_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `source_system_directive_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Directive ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_business_glossary_term' = 'State of Directive Execution');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `state_of_execution` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Directive Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'Original Document|Scanned Copy|Verbal Confirmation|Electronic Record|Notarized Copy');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Directive Verified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Directive Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` SET TAGS ('dbx_subdomain' = 'patient_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `nursing_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Nursing Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mar Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Assessing Nurse Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `diet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Diet Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `assessment_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Assessment Interval Hours');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Clinical Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Nursing Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'In Progress|Completed|Amended|Cosigned|Voided');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Nursing Assessment Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `braden_score` SET TAGS ('dbx_business_glossary_term' = 'Braden Scale Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `braden_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `braden_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `cardiovascular_status` SET TAGS ('dbx_business_glossary_term' = 'Cardiovascular Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `cardiovascular_status` SET TAGS ('dbx_value_regex' = 'Regular Rate and Rhythm|Irregular|Tachycardic|Bradycardic|Absent');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `cardiovascular_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `cardiovascular_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `care_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Care Recommendations');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `care_recommendations` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `care_recommendations` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'Inpatient|ICU|ED|Outpatient|Surgical|Observation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `continence_status` SET TAGS ('dbx_business_glossary_term' = 'Continence Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `continence_status` SET TAGS ('dbx_value_regex' = 'Continent|Incontinent|Catheter|Ostomy|Unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `continence_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `continence_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `discharge_barriers` SET TAGS ('dbx_business_glossary_term' = 'Discharge Barriers');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `discharge_barriers` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `discharge_barriers` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `discharge_readiness_score` SET TAGS ('dbx_business_glossary_term' = 'Discharge Readiness Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `discharge_readiness_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `discharge_readiness_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Fall Risk Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_category` SET TAGS ('dbx_value_regex' = 'Low|Moderate|High');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fall Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_tool` SET TAGS ('dbx_business_glossary_term' = 'Fall Risk Assessment Tool');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `fall_risk_tool` SET TAGS ('dbx_value_regex' = 'Morse Fall Scale|Hendrich II|STRATIFY|Johns Hopkins');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `iv_access_type` SET TAGS ('dbx_business_glossary_term' = 'Intravenous (IV) Access Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `iv_access_type` SET TAGS ('dbx_value_regex' = 'Peripheral IV|Central Line|PICC|Port|None');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `iv_access_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `iv_access_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `iv_site_condition` SET TAGS ('dbx_business_glossary_term' = 'Intravenous (IV) Site Condition');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `iv_site_condition` SET TAGS ('dbx_value_regex' = 'Patent|Infiltrated|Phlebitis|Occluded|Removed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `iv_site_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `iv_site_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `joint_commission_compliant` SET TAGS ('dbx_business_glossary_term' = 'Joint Commission Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mobility_status` SET TAGS ('dbx_business_glossary_term' = 'Mobility Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mobility_status` SET TAGS ('dbx_value_regex' = 'Independent|Assisted|Dependent|Bedrest|Ambulating');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mobility_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mobility_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `neurological_status` SET TAGS ('dbx_business_glossary_term' = 'Neurological Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `neurological_status` SET TAGS ('dbx_value_regex' = 'Alert and Oriented|Confused|Lethargic|Obtunded|Stuporous|Comatose');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `neurological_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `neurological_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `nursing_unit` SET TAGS ('dbx_business_glossary_term' = 'Nursing Unit');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_value_regex' = 'Adequate|At Risk|Malnourished|NPO|Tube Feeding');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `orientation_level` SET TAGS ('dbx_business_glossary_term' = 'Orientation Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `orientation_level` SET TAGS ('dbx_value_regex' = 'x1|x2|x3|x4');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `orientation_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `orientation_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Pain Scale Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pain_scale_type` SET TAGS ('dbx_value_regex' = 'NRS|FLACC|CPOT|Wong-Baker|VAS');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pain_score` SET TAGS ('dbx_business_glossary_term' = 'Pain Score');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pain_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pain_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `patient_education_provided` SET TAGS ('dbx_business_glossary_term' = 'Patient Education Provided Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pressure_injury_location` SET TAGS ('dbx_business_glossary_term' = 'Pressure Injury Location');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pressure_injury_location` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pressure_injury_location` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pressure_injury_stage` SET TAGS ('dbx_business_glossary_term' = 'Pressure Injury Stage');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pressure_injury_stage` SET TAGS ('dbx_value_regex' = 'Stage 1|Stage 2|Stage 3|Stage 4|Unstageable|Deep Tissue');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pressure_injury_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `pressure_injury_stage` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `respiratory_status` SET TAGS ('dbx_business_glossary_term' = 'Respiratory Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `respiratory_status` SET TAGS ('dbx_value_regex' = 'Regular|Labored|Shallow|Absent|Assisted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `respiratory_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `respiratory_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `restraint_indication` SET TAGS ('dbx_business_glossary_term' = 'Restraint Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `restraint_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `restraint_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `restraint_type` SET TAGS ('dbx_business_glossary_term' = 'Restraint Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `restraint_type` SET TAGS ('dbx_value_regex' = 'Physical|Chemical|Soft Limb|Vest|Mitts|None');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `restraint_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `restraint_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `safety_check_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Check Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `skin_integrity_status` SET TAGS ('dbx_business_glossary_term' = 'Skin Integrity Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `skin_integrity_status` SET TAGS ('dbx_value_regex' = 'Intact|Impaired|Wound Present|Pressure Injury');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `skin_integrity_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `skin_integrity_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ALTER COLUMN `source_system_assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` SET TAGS ('dbx_subdomain' = 'infection_surveillance');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `hai_event_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Event ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Infection Preventionist ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `hipaa_privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Procedure ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `microbiology_culture_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Culture Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `outbreak_id` SET TAGS ('dbx_business_glossary_term' = 'Outbreak Investigation ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Response Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `susceptibility_result_id` SET TAGS ('dbx_business_glossary_term' = 'Susceptibility Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `attributed_los_days` SET TAGS ('dbx_business_glossary_term' = 'Attributed Length of Stay (LOS) Days');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `device_days` SET TAGS ('dbx_business_glossary_term' = 'Device Days');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Invasive Device Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'central_line|urinary_catheter|ventilator|none|other');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'HAI Event Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'HAI Event Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending_review|confirmed|rejected|submitted|amended');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `hac_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospital-Acquired Condition (HAC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `infection_onset_setting` SET TAGS ('dbx_business_glossary_term' = 'Infection Onset Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `infection_onset_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|community|ltcf|unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `infection_type` SET TAGS ('dbx_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `infection_type` SET TAGS ('dbx_value_regex' = 'CLABSI|CAUTI|SSI|MRSA|CDI|VAP');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `ip_review_date` SET TAGS ('dbx_business_glossary_term' = 'Infection Preventionist (IP) Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `ip_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Infection Preventionist (IP) Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `ip_review_status` SET TAGS ('dbx_business_glossary_term' = 'Infection Preventionist (IP) Review Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `ip_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|in_review|reviewed|approved|disputed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `nhsn_definition_met` SET TAGS ('dbx_business_glossary_term' = 'National Healthcare Safety Network (NHSN) Definition Criteria Met');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `nhsn_event_number` SET TAGS ('dbx_business_glossary_term' = 'National Healthcare Safety Network (NHSN) Event Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `nhsn_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'National Healthcare Safety Network (NHSN) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `nhsn_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'National Healthcare Safety Network (NHSN) Reporting Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `nhsn_reporting_status` SET TAGS ('dbx_value_regex' = 'not_reported|reported|accepted|rejected_by_nhsn');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `nhsn_submission_date` SET TAGS ('dbx_business_glossary_term' = 'National Healthcare Safety Network (NHSN) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `outbreak_flag` SET TAGS ('dbx_business_glossary_term' = 'Outbreak Association Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `patient_days` SET TAGS ('dbx_business_glossary_term' = 'Patient Days');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `patient_outcome` SET TAGS ('dbx_business_glossary_term' = 'Patient Outcome');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `patient_outcome` SET TAGS ('dbx_value_regex' = 'recovered|transferred|expired|unknown');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `present_on_admission` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `secondary_infection_type` SET TAGS ('dbx_business_glossary_term' = 'Secondary Healthcare-Associated Infection (HAI) Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `ssi_depth` SET TAGS ('dbx_business_glossary_term' = 'Surgical Site Infection (SSI) Depth');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `ssi_depth` SET TAGS ('dbx_value_regex' = 'superficial_incisional|deep_incisional|organ_space');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `ssi_wound_class` SET TAGS ('dbx_business_glossary_term' = 'Surgical Site Infection (SSI) Wound Classification');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `ssi_wound_class` SET TAGS ('dbx_value_regex' = 'clean|clean_contaminated|contaminated|dirty_infected');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `state_report_date` SET TAGS ('dbx_business_glossary_term' = 'State Report Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `state_report_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `state_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'State Mandatory Reporting Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `state_reportable_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `unit_location_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Location Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `unit_location_description` SET TAGS ('dbx_business_glossary_term' = 'Unit Location Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ALTER COLUMN `vbp_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Purchasing (VBP) Penalty Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Finding ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Documenting Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'FHIR (Fast Healthcare Interoperability Resources) Observation ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Ct Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Source Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `body_site_code` SET TAGS ('dbx_business_glossary_term' = 'Body Site SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `body_site_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,18}$');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `body_site_description` SET TAGS ('dbx_business_glossary_term' = 'Body Site Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `chronic_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'normal|restricted|very-restricted');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `documentation_date` SET TAGS ('dbx_business_glossary_term' = 'Documentation Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `encounter_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|observation|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Finding Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `finding_comment` SET TAGS ('dbx_business_glossary_term' = 'Clinical Finding Comment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `finding_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Finding Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'present|absent|unknown|indeterminate|not-assessed');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `interpretation_code` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `present_on_admission` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `present_on_admission` SET TAGS ('dbx_value_regex' = 'Y|N|U|W');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `sdoh_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Determinants of Health (SDOH) Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `sensitive_finding_type` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Finding Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `sensitive_finding_type` SET TAGS ('dbx_value_regex' = 'behavioral-health|substance-use|HIV|sexual-health|genetic|none');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `sensitive_finding_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `sensitive_finding_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life-threatening');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `source_system_finding_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Finding ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Documenting Provider Specialty');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Clinical Finding Title');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `value_code` SET TAGS ('dbx_business_glossary_term' = 'Finding Value Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `value_string` SET TAGS ('dbx_business_glossary_term' = 'Finding Value String');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'confirmed|provisional|refuted|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('dbx_subdomain' = 'infection_surveillance');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` SET TAGS ('dbx_association_edges' = 'clinical.procedure_event,facility.equipment_asset');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `procedure_equipment_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Equipment Usage ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `procedure_equipment_usage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Documented By Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Equipment Usage - Equipment Asset Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Equipment Usage - Procedure Event Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `charge_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Charge Captured Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `documentation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Documentation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `equipment_malfunction_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Malfunction Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `implant_used` SET TAGS ('dbx_business_glossary_term' = 'Implant Used Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `implant_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Implant Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `malfunction_description` SET TAGS ('dbx_business_glossary_term' = 'Malfunction Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `sterilization_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `usage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Usage Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `usage_duration_minutes` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `usage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `usage_end_timestamp` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `usage_role` SET TAGS ('dbx_business_glossary_term' = 'Usage Role');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `usage_role` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `usage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ALTER COLUMN `usage_start_timestamp` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('dbx_subdomain' = 'care_coordination');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` SET TAGS ('dbx_association_edges' = 'clinical.care_plan,insurance.health_plan');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `plan_care_coordination_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Care Coordination Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Care Coordination - Care Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Case Manager Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Care Coordination - Health Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `authorization_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `care_management_tier` SET TAGS ('dbx_business_glossary_term' = 'Care Management Tier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `care_management_tier` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `coordination_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `coordination_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Care Management Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `last_payer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payer Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `next_payer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payer Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `plan_specific_goal_count` SET TAGS ('dbx_business_glossary_term' = 'Plan-Specific Goal Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `primary_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `primary_coverage_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `program_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Care Management Program Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` SET TAGS ('dbx_subdomain' = 'clinical_documentation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `note_template_id` SET TAGS ('dbx_business_glossary_term' = 'Note Template Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `note_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `note_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `note_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `parent_note_template_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Note Template Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `parent_note_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `auto_populate_fields` SET TAGS ('dbx_business_glossary_term' = 'Auto Populate Fields');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `cdi_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cdi Enabled');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `note_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `estimated_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Minutes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Format Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `is_default_for_specialty` SET TAGS ('dbx_business_glossary_term' = 'Is Default For Specialty');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `is_shared_across_facilities` SET TAGS ('dbx_business_glossary_term' = 'Is Shared Across Facilities');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `is_structured` SET TAGS ('dbx_business_glossary_term' = 'Is Structured');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `loinc_code` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `macros_enabled` SET TAGS ('dbx_business_glossary_term' = 'Macros Enabled');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `required_sections` SET TAGS ('dbx_business_glossary_term' = 'Required Sections');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `requires_attestation` SET TAGS ('dbx_business_glossary_term' = 'Requires Attestation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `note_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `supports_voice_dictation` SET TAGS ('dbx_business_glossary_term' = 'Supports Voice Dictation');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `template_body` SET TAGS ('dbx_business_glossary_term' = 'Template Body');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` SET TAGS ('dbx_subdomain' = 'infection_surveillance');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_id` SET TAGS ('dbx_business_glossary_term' = 'Outbreak Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Team Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_reported_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_reported_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_reported_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `parent_outbreak_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Outbreak Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `parent_outbreak_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `case_fatality_rate` SET TAGS ('dbx_business_glossary_term' = 'Case Fatality Rate');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_code` SET TAGS ('dbx_business_glossary_term' = 'Outbreak Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `confirmed_case_count` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Case Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `containment_date` SET TAGS ('dbx_business_glossary_term' = 'Containment Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `death_count` SET TAGS ('dbx_business_glossary_term' = 'Death Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `disease_code` SET TAGS ('dbx_business_glossary_term' = 'Disease Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `disease_name` SET TAGS ('dbx_business_glossary_term' = 'Disease Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `genetic_sequencing_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetic Sequencing Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `hospitalization_count` SET TAGS ('dbx_business_glossary_term' = 'Hospitalization Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `index_case_date` SET TAGS ('dbx_business_glossary_term' = 'Index Case Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `laboratory_confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Confirmation Method');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `media_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Media Notification Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_name` SET TAGS ('dbx_business_glossary_term' = 'Outbreak Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Outbreak Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `pathogen_type` SET TAGS ('dbx_business_glossary_term' = 'Pathogen Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `primary_location_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Location Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `probable_case_count` SET TAGS ('dbx_business_glossary_term' = 'Probable Case Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_alert_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Health Alert Issued Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_alert_issued_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `public_health_alert_issued_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `source_description` SET TAGS ('dbx_business_glossary_term' = 'Source Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `source_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Source Identified Flag');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `outbreak_status` SET TAGS ('dbx_business_glossary_term' = 'Outbreak Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `total_case_count` SET TAGS ('dbx_business_glossary_term' = 'Total Case Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `transmission_mode` SET TAGS ('dbx_business_glossary_term' = 'Transmission Mode');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` SET TAGS ('dbx_subdomain' = 'patient_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `flowsheet_row_id` SET TAGS ('dbx_business_glossary_term' = 'Flowsheet Row Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `flowsheet_template_id` SET TAGS ('dbx_business_glossary_term' = 'Flowsheet Template Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `parent_flowsheet_row_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Flowsheet Row Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `parent_flowsheet_row_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `alert_enabled` SET TAGS ('dbx_business_glossary_term' = 'Alert Enabled');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `consent_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Required');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `critical_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical High Threshold');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `critical_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Threshold');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `flowsheet_row_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `display_format` SET TAGS ('dbx_business_glossary_term' = 'Display Format');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `documentation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Documentation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `interface_code` SET TAGS ('dbx_business_glossary_term' = 'Interface Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `is_calculated` SET TAGS ('dbx_business_glossary_term' = 'Is Calculated');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `loinc_code` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `normal_range_high` SET TAGS ('dbx_business_glossary_term' = 'Normal Range High');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `normal_range_low` SET TAGS ('dbx_business_glossary_term' = 'Normal Range Low');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `privacy_level` SET TAGS ('dbx_business_glossary_term' = 'Privacy Level');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `quality_measure_indicator` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Indicator');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `row_code` SET TAGS ('dbx_business_glossary_term' = 'Row Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `row_name` SET TAGS ('dbx_business_glossary_term' = 'Row Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `row_type` SET TAGS ('dbx_business_glossary_term' = 'Row Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `snomed_ct_code` SET TAGS ('dbx_business_glossary_term' = 'Snomed Ct Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `flowsheet_row_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `validation_rule` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` SET TAGS ('dbx_subdomain' = 'patient_assessment');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_template_id` SET TAGS ('dbx_business_glossary_term' = 'Flowsheet Template Identifier');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_created_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_created_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_last_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_last_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_last_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_workforce_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_workforce_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Department Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `parent_flowsheet_template_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Flowsheet Template Id');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `parent_flowsheet_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `age_range_max` SET TAGS ('dbx_business_glossary_term' = 'Age Range Max');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `age_range_max` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `age_range_min` SET TAGS ('dbx_business_glossary_term' = 'Age Range Min');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `age_range_min` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `allows_custom_fields` SET TAGS ('dbx_business_glossary_term' = 'Allows Custom Fields');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_template_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `copyright_notice` SET TAGS ('dbx_business_glossary_term' = 'Copyright Notice');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `documentation_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Documentation Interval Minutes');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `frequency_default` SET TAGS ('dbx_business_glossary_term' = 'Frequency Default');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `is_electronic_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Is Electronic Signature Required');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `is_system_default` SET TAGS ('dbx_business_glossary_term' = 'Is System Default');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `loinc_code` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `patient_population` SET TAGS ('dbx_business_glossary_term' = 'Patient Population');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `print_layout_template` SET TAGS ('dbx_business_glossary_term' = 'Print Layout Template');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `publisher` SET TAGS ('dbx_business_glossary_term' = 'Publisher');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `requires_cosignature` SET TAGS ('dbx_business_glossary_term' = 'Requires Cosignature');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `retired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Retired Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `snomed_code` SET TAGS ('dbx_business_glossary_term' = 'Snomed Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `flowsheet_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
