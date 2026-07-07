-- Schema for Domain: radiology | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`radiology` COMMENT 'Medical imaging and diagnostic radiology services. Owns imaging orders, modality scheduling (CT, MRI, X-ray, ultrasound, PET), PACS (Picture Archiving and Communication System) integration, radiology reports, DICOM image metadata, contrast administration, radiation dose tracking, radiologist interpretations, and CPT-coded procedures. Integrates with RIS (Radiology Information System) including Epic Radiant and Cerner RadNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` (
    `imaging_order_id` BIGINT COMMENT 'Unique identifier for the imaging order.',
    `audit_finding_id` BIGINT COMMENT 'Link to compliance audit finding if applicable.',
    `care_site_id` BIGINT COMMENT 'Facility where the imaging order was placed.',
    `clinical_order_id` BIGINT COMMENT 'Parent clinical order.',
    `drug_master_id` BIGINT COMMENT 'Contrast agent drug master record.',
    `material_master_id` BIGINT COMMENT 'Contrast material supply record.',
    `cost_center_id` BIGINT COMMENT 'Cost center for financial tracking.',
    `demographics_id` BIGINT COMMENT 'Patient demographic record.',
    `employee_id` BIGINT COMMENT 'Employee who placed or processed the order.',
    `icd_code_id` BIGINT COMMENT 'Primary ICD-10 diagnosis code.',
    `payer_id` BIGINT COMMENT 'Insurance payer.',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the imaging study.',
    `cpt_code_id` BIGINT COMMENT 'CPT code for the imaging procedure.',
    `research_study_id` BIGINT COMMENT 'Research study if applicable.',
    `visit_id` BIGINT COMMENT 'Encounter visit.',
    `accession_number` STRING COMMENT 'Unique accession number for the imaging order.',
    `body_part` STRING COMMENT 'Anatomical body part to be imaged.',
    `cancellation_reason` STRING COMMENT 'Reason for order cancellation.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time the order was cancelled.',
    `clinical_indication` STRING COMMENT 'Clinical reason for the imaging order.',
    `contrast_required` BOOLEAN COMMENT 'Flag indicating if contrast is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the order record was created.',
    `critical_finding_flag` BOOLEAN COMMENT 'Flag indicating if a critical finding was identified.',
    `exam_end_timestamp` TIMESTAMP COMMENT 'Date and time the exam ended.',
    `exam_start_timestamp` TIMESTAMP COMMENT 'Date and time the exam started.',
    `is_portable` BOOLEAN COMMENT 'Flag indicating if the imaging is portable (bedside).',
    `is_stat_override` BOOLEAN COMMENT 'Flag indicating if the order was marked as STAT.',
    `laterality` STRING COMMENT 'Left, right, or bilateral.',
    `modality_type` STRING COMMENT 'Imaging modality (e.g., CT, MRI, X-Ray).',
    `mrn` STRING COMMENT 'Patient medical record number.',
    `order_priority` STRING COMMENT 'Priority level (e.g., routine, urgent, STAT).',
    `order_source` STRING COMMENT 'Source system or method of order entry.',
    `order_status` STRING COMMENT 'Current status of the order.',
    `ordered_timestamp` TIMESTAMP COMMENT 'Date and time the order was placed.',
    `ordering_provider_npi` STRING COMMENT 'National Provider Identifier of the ordering provider.',
    `prior_auth_number` STRING COMMENT 'Prior authorization number from payer.',
    `prior_auth_status` STRING COMMENT 'Status of prior authorization.',
    `procedure_description` STRING COMMENT 'Description of the imaging procedure.',
    `protocol_name` STRING COMMENT 'Imaging protocol name.',
    `radiation_dose_ctdi` DECIMAL(18,2) COMMENT 'CT Dose Index (CTDI) in mGy.',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT 'Dose Length Product (DLP) in mGy·cm.',
    `referring_department` STRING COMMENT 'Department that referred the patient.',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'Date and time the report was finalized.',
    `report_status` STRING COMMENT 'Status of the radiology report.',
    `requisition_number` STRING COMMENT 'Requisition number for the order.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Date and time the exam is scheduled.',
    `source_system_order_code` STRING COMMENT 'Order code in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time the order record was last updated.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology imaging order record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the radiology imaging order record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_imaging_order PRIMARY KEY(`imaging_order_id`)
) COMMENT 'Radiology imaging order placed by a provider for diagnostic or therapeutic imaging procedures.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` (
    `dicom_series_id` BIGINT COMMENT 'Unique identifier for the DICOM series.',
    `protocol_id` BIGINT COMMENT 'Imaging protocol used for the series.',
    `modality_id` BIGINT COMMENT 'Foreign key linking to radiology.modality. Business justification: A DICOM series is acquired on a specific physical imaging equipment unit (modality). dicom_series currently only carries a free-text modality string plus denormalized equipment descriptors (manufactur',
    `employee_id` BIGINT COMMENT 'Technologist who performed the series.',
    `radiology_study_id` BIGINT COMMENT 'Parent radiology study.',
    `accession_number` STRING COMMENT 'Accession number for the series.',
    `body_part_examined` STRING COMMENT 'Anatomical body part examined.',
    `contrast_bolus_agent` STRING COMMENT 'Contrast agent used.',
    `contrast_bolus_route` STRING COMMENT 'Route of contrast administration.',
    `contrast_bolus_volume_ml` DECIMAL(18,2) COMMENT 'Volume of contrast administered in mL.',
    `cpt_code` STRING COMMENT 'CPT code for the series.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the series record was created.',
    `ctdi_vol_mgy` DECIMAL(18,2) COMMENT 'CT Dose Index Volume in mGy.',
    `dlp_mgy_cm` DECIMAL(18,2) COMMENT 'Dose Length Product in mGy·cm.',
    `exposure_ma` DECIMAL(18,2) COMMENT 'Exposure in milliamperes.',
    `exposure_time_ms` DECIMAL(18,2) COMMENT 'Exposure time in milliseconds.',
    `image_orientation_patient` STRING COMMENT 'DICOM Image Orientation (Patient).',
    `kvp` DECIMAL(18,2) COMMENT 'Peak kilovoltage.',
    `laterality` STRING COMMENT 'Left, right, or bilateral.',
    `modality` STRING COMMENT 'Imaging modality (e.g., CT, MRI, X-Ray).',
    `number_of_series_related_instances` STRING COMMENT 'Number of instances (images) in the series.',
    `pacs_archive_status` STRING COMMENT 'Status in PACS archive.',
    `pacs_storage_path` STRING COMMENT 'PACS storage path or location.',
    `patient_position` STRING COMMENT 'Patient position during imaging.',
    `performing_physician_name` STRING COMMENT 'Name of the performing physician.',
    `pixel_spacing_mm` STRING COMMENT 'Pixel spacing in millimeters.',
    `procedure_code_modifier` STRING COMMENT 'CPT code modifier.',
    `quality_control_comments` STRING COMMENT 'The quality control comments of the radiology dicom series record.',
    `quality_control_status` STRING COMMENT 'The quality control status value classifying the radiology dicom series record.',
    `radiation_dose_mgy` DECIMAL(18,2) COMMENT 'Radiation dose in mGy.',
    `referring_physician_npi` STRING COMMENT 'National Provider Identifier of the referring physician.',
    `requesting_physician_name` STRING COMMENT 'Name of the requesting physician.',
    `series_completeness_flag` BOOLEAN COMMENT 'Flag indicating if the series is complete.',
    `series_date` DATE COMMENT 'Date of the series.',
    `series_description` STRING COMMENT 'Description of the series.',
    `series_instance_uid` STRING COMMENT 'DICOM Series Instance UID.',
    `series_number` STRING COMMENT 'Series number within the study.',
    `series_status` STRING COMMENT 'Status of the series.',
    `series_time` TIMESTAMP COMMENT 'Time of the series.',
    `slice_thickness_mm` DECIMAL(18,2) COMMENT 'Slice thickness in millimeters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time the series record was last updated.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology dicom series record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the radiology dicom series record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_dicom_series PRIMARY KEY(`dicom_series_id`)
) COMMENT 'DICOM series within a radiology study, containing series-level metadata and image attributes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`report` (
    `report_id` BIGINT COMMENT 'Primary key for report',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, imaging center, outpatient clinic) where the imaging study was performed. Used for operational reporting, capacity management, and multi-site analytics.',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Finalized radiology reports trigger professional component billing. Compliance audits verify that billed interpretation services match documented reports. Essential for professional fee billing, charg',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Radiology reports document findings from ordered studies. Providers review results in context of original orders. Quality metrics track order-to-report turnaround times. Regulatory requirements for re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Radiology reports represent professional component work that must be allocated to radiologist cost centers for productivity-based costing, professional fee allocation, and departmental P&L. Critical f',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Reports reference CPT codes for billing reconciliation between RIS and revenue cycle systems, support professional fee coding, and enable radiologist productivity tracking by procedure complexity and ',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: Radiology reports are transmitted via Direct messaging for care coordination, specialist referrals, and patient-requested records. Links report to Direct message for delivery tracking, read receipts, ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Reports document ICD-10 codes for clinical documentation integrity, support diagnosis-based quality measures, and enable population health analytics linking imaging findings to disease prevalence.',
    `imaging_order_id` BIGINT COMMENT 'Reference to the parent imaging order that triggered this radiology report. Links the report back to the order management workflow in the radiology domain.',
    `message_log_id` BIGINT COMMENT 'Unique identifier of the HL7 ORU^R01 message used to transmit the finalized radiology report to downstream clinical systems (EHR, ordering provider). Enables message traceability, deduplication, and integration audit. Sourced from the HL7 interface engine.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of the imaging study and this report. Protected Health Information (PHI) under HIPAA. Links to the Master Patient Index (MPI).',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who authored the addendum or amendment. May differ from the original signing radiologist. Null for the original report.',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.study. Business justification: report currently has imaging_order_id FK but no imaging_study_id FK. Radiology reports interpret STUDIES (the actual acquired images), not orders. One order can result in multiple studies (e.g., repea',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Radiology reports for research subjects require linkage for endpoint adjudication, independent imaging review, safety monitoring, and regulatory submissions. Reports may be blinded for trial integrity',
    `tertiary_report_reading_radiologist_clinician_id` BIGINT COMMENT 'Reference to the radiologist who performed the primary interpretation of the imaging study. May differ from the signing radiologist in teaching or supervisory contexts (e.g., resident reads, attending signs). Used for productivity tracking and RVU attribution.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Radiology reports often dictated and transcribed by medical transcriptionists. Tracking needed for quality assurance, productivity monitoring, and error investigation when voice recognition not used.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit) during which the imaging study was ordered and performed. Enables linkage to the patient visit context for clinical and revenue cycle workflows.',
    `accession_number` STRING COMMENT 'Externally-known unique identifier assigned by the Radiology Information System (RIS) to the imaging order and its associated report. Used as the primary cross-system business key linking the report to the imaging order, PACS, and billing systems. Sourced from Epic Radiant and Cerner RadNet.',
    `addendum_sequence` STRING COMMENT 'Sequential number identifying the addendum within the reports amendment history. Null for the original report. Increments with each addendum or amendment added post-finalization. Used to order and display the full report amendment history.',
    `addendum_text` STRING COMMENT 'Full text content of the addendum or amendment added to the report post-finalization. Contains Protected Health Information (PHI). Null for the original report. Preserves the complete amendment history as versioned child records.',
    `addendum_timestamp` TIMESTAMP COMMENT 'Date and time when the addendum or amendment was authored and signed. Null for the original report. Used to track the timeline of post-final modifications.',
    `addendum_type` STRING COMMENT 'Classifies the type of post-final modification to the report. Addendum adds new information without changing the original; amendment modifies existing content; correction fixes a factual error; retraction withdraws the report. Null for the original report.. Valid values are `addendum|amendment|correction|retraction`',
    `attestation_timestamp` TIMESTAMP COMMENT 'Date and time when the signing radiologist attested and finalized the report, transitioning it to final status. This is the principal business event timestamp for the report lifecycle. Required for billing, legal, and compliance purposes.',
    `body_part` STRING COMMENT 'Anatomical region or body part that was the subject of the imaging study (e.g., CHEST, ABDOMEN, BRAIN, KNEE). Sourced from DICOM tag (0018,0015) and RIS order. Used for clinical classification and CPT code validation.',
    `contrast_administered_flag` BOOLEAN COMMENT 'Indicates whether contrast agent was administered during the imaging study. Relevant for CPT code selection, billing accuracy, radiation safety, and clinical documentation of contrast reactions.',
    `contrast_agent_name` STRING COMMENT 'Name of the contrast agent administered during the imaging study (e.g., Gadolinium, Iohexol, Gadobutrol). Null if no contrast was administered. Used for adverse event tracking, pharmacy reconciliation, and clinical documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the radiology report record was first created in the source system. Represents the audit creation timestamp for the report entity. Used for data lineage, audit trails, and compliance reporting.',
    `critical_finding_communicated_flag` BOOLEAN COMMENT 'Indicates whether the critical finding has been communicated to the ordering or responsible provider. Required for Joint Commission compliance. Only applicable when critical_finding_flag is True.',
    `critical_finding_communicated_timestamp` TIMESTAMP COMMENT 'Date and time when the critical finding was communicated to the ordering or responsible provider. Used to measure turnaround time compliance with Joint Commission and ACR critical results communication standards.',
    `critical_finding_flag` BOOLEAN COMMENT 'Indicates whether the report contains a critical or urgent finding that requires immediate communication to the ordering provider per ACR and Joint Commission guidelines. When True, triggers a critical results notification workflow. Supports patient safety and regulatory compliance.',
    `dicom_study_instance_uid` STRING COMMENT 'Globally unique DICOM Study Instance UID linking this report to the corresponding image set in the Picture Archiving and Communication System (PACS). Enables direct navigation from the report to the source images. Sourced from DICOM tag (0020,000D).',
    `dictation_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist began dictating the report. Used to measure report turnaround time (TAT) from study completion to dictation. Sourced from Epic Radiant or Cerner RadNet workflow timestamps.',
    `findings_text` STRING COMMENT 'Full narrative text of the radiologists findings section of the report, describing the imaging observations in detail. Contains Protected Health Information (PHI). This is the primary clinical content of the report and the source of truth for diagnostic observations. Sourced from Epic ClinDoc or Cerner PowerChart dictation/transcription.',
    `follow_up_recommendation` STRING COMMENT 'Structured follow-up recommendation from the radiologists impression, indicating the recommended next action (e.g., Follow-up CT in 3 months, Biopsy recommended, No follow-up needed). Used for care coordination, population health management, and closing the loop on incidental findings.',
    `impression_text` STRING COMMENT 'Radiologists summary impression or conclusion section of the report, providing the diagnostic interpretation and clinical recommendations. Contains Protected Health Information (PHI). This is the most clinically actionable section of the report and is used for clinical decision support, CDI, and quality measurement.',
    `laterality` STRING COMMENT 'Indicates the side of the body examined when applicable (left, right, bilateral, or unspecified). Critical for surgical safety, billing accuracy, and clinical documentation. Sourced from DICOM tag (0020,0060) and RIS.. Valid values are `left|right|bilateral|unspecified`',
    `modality_code` STRING COMMENT 'DICOM-standard code identifying the imaging modality used for the study (e.g., CT = Computed Tomography, MR = Magnetic Resonance Imaging, XR/DX/CR = X-Ray, US = Ultrasound, PT = Positron Emission Tomography, NM = Nuclear Medicine, MG = Mammography, FL = Fluoroscopy). Sourced from DICOM tag (0008,0060). [ENUM-REF-CANDIDATE: CT|MR|XR|US|PT|NM|MG|FL|DX|CR — 10 candidates stripped; promote to reference product]',
    `preliminary_timestamp` TIMESTAMP COMMENT 'Date and time when the report was first released in preliminary status, making it available to ordering providers before final attestation. Key lifecycle event for TAT measurement and clinical workflow.',
    `radiation_dose_ctdi` DECIMAL(18,2) COMMENT 'CT Dose Index Volume (CTDIvol) in mGy representing the average radiation dose per unit length for CT studies. Null for non-CT modalities. Used alongside DLP for comprehensive radiation dose monitoring and ACR Dose Index Registry reporting.',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT 'Dose Length Product (DLP) in mGy·cm representing the total radiation dose delivered during the CT or fluoroscopy study. Null for non-ionizing modalities (MRI, Ultrasound). Used for radiation dose monitoring, ACR Dose Index Registry reporting, and patient safety compliance.',
    `rads_category` STRING COMMENT 'Standardized ACR Reporting and Data System (RADS) assessment category assigned in the impression (e.g., BI-RADS 0-6 for mammography, LI-RADS 1-5 for liver, TI-RADS 1-5 for thyroid, Lung-RADS 1-4). Drives follow-up recommendations and quality measurement. [ENUM-REF-CANDIDATE: BI-RADS 0|BI-RADS 1|BI-RADS 2|BI-RADS 3|BI-RADS 4|BI-RADS 5|BI-RADS 6|LI-RADS 1|LI-RADS 2|LI-RADS 3|LI-RADS 4|LI-RADS 5|TI-RADS 1|TI-RADS 2|TI-RADS 3|TI-RADS 4|TI-RADS 5|Lung-RADS 1|Lung-RADS 2|Lung-RADS 3|Lung-RADS 4 — promote to reference product]',
    `report_status` STRING COMMENT 'Current workflow state of the radiology report. Drives clinical decision-making and downstream notification workflows. Preliminary indicates a draft interpretation; final indicates the signed, attested report; addendum and amended indicate post-final modifications. Aligns with HL7 FHIR DiagnosticReport.status.. Valid values are `preliminary|final|addendum|amended|corrected|cancelled`',
    `ris_report_code` STRING COMMENT 'Native report identifier from the source Radiology Information System (RIS), such as Epic Radiant or Cerner RadNet. Used for cross-system reconciliation, ETL lineage tracking, and source system audit.',
    `signing_radiologist_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the radiologist who signed and attested the final report. Required for CMS billing, claims submission, and provider credentialing validation. Sourced from the NPPES registry.. Valid values are `^[0-9]{10}$`',
    `stat_priority_flag` BOOLEAN COMMENT 'Indicates whether the imaging order and report were designated as STAT (immediate/urgent priority), requiring expedited turnaround time. Drives workflow prioritization in the RIS and radiologist worklist. Used for TAT compliance monitoring.',
    `study_datetime` TIMESTAMP COMMENT 'Date and time when the imaging study was performed (image acquisition). This is the principal real-world event time for the report. Sourced from DICOM tag (0008,0020)/(0008,0030) and RIS. Used as the primary temporal anchor for TAT calculations and clinical timelines.',
    `study_description` STRING COMMENT 'Human-readable description of the imaging study protocol or procedure performed (e.g., CT Chest with Contrast, MRI Brain without Contrast). Sourced from the RIS order and DICOM tag (0008,1030). Used for report titling and clinical context.',
    `template_code` BIGINT COMMENT 'Reference to the structured reporting template used to generate the report (e.g., ACR-standardized templates, site-specific templates). Supports structured reporting initiatives, quality measurement, and AI-assisted reporting workflows.',
    `transcription_timestamp` TIMESTAMP COMMENT 'Date and time when the report transcription was completed (if applicable). Relevant for facilities using human transcription services rather than voice recognition. Used in TAT measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the radiology report record was last modified in the source system. Used for incremental data loading, change data capture (CDC), and audit trail maintenance.',
    `version` STRING COMMENT 'Sequential version number of the report, starting at 1 for the initial report and incrementing with each amendment or addendum. Enables tracking of the full amendment history and identification of the current authoritative version.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology report record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_report PRIMARY KEY(`report_id`)
) COMMENT 'Authoritative clinical document containing the radiologists interpretation of an imaging study, including all addenda and amendments as versioned child records. Captures report accession number, report status (preliminary, final, addendum, amended), findings narrative, impression text, critical finding flag, dictation/transcription/attestation timestamps, signing radiologist NPI, addendum history (sequence, type, text, author, datetime), and HL7 ORU message ID. SSOT for radiologist interpretation, diagnostic conclusions, and report amendment history. Aligns with HL7 FHIR DiagnosticReport resource and IHE RAD-28 (Report Workflow). Integrates with Epic ClinDoc and Cerner PowerChart.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` (
    `report_addendum_id` BIGINT COMMENT 'Unique surrogate identifier for each radiology report addendum record in the Silver Layer lakehouse. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, imaging center, outpatient clinic) where the original imaging study was performed and the addendum was issued. Supports multi-facility enterprise reporting and regulatory submissions.',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Report addenda generate separate CDA document versions (replacement or addendum document types) for HIE transmission. Required for regulatory compliance and ensuring downstream systems receive correct',
    `cdi_query_id` BIGINT COMMENT 'Reference to the CDI (Clinical Documentation Improvement) query that prompted this addendum, if applicable. Links the addendum to the CDI workflow for documentation quality tracking and DRG (Diagnosis-Related Group) impact analysis.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Addenda may reference procedure codes when clarifying exam scope or correcting billing. Supports revenue integrity audits and ensures addendum changes are reflected in charge capture systems.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Addenda may update or clarify diagnosis codes for CDI queries, DRG impact analysis, and billing corrections. Links support amendment tracking and diagnosis code change auditing for compliance.',
    `message_log_id` BIGINT COMMENT 'Unique identifier of the HL7 (Health Level Seven) ORU or MDM message used to transmit this addendum between systems (e.g., from RIS to EHR via HL7 v2.x or FHIR). Supports interoperability audit and HIE (Health Information Exchange) traceability.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose imaging study and original report are being amended. Required for PHI (Protected Health Information) audit trails and HIM (Health Information Management) compliance.',
    `org_unit_id` BIGINT COMMENT 'Reference to the radiology department or imaging section within the facility where the addendum was issued. Supports departmental performance analytics and CDI program management.',
    `report_id` BIGINT COMMENT 'Reference to the finalized radiology report to which this addendum is appended. Links the addendum to its parent report for audit and CDI (Clinical Documentation Improvement) traceability.',
    `clinician_id` BIGINT COMMENT 'Internal provider identifier for the radiologist or clinician who authored this addendum. Complements author_npi for internal system linkage to the provider master.',
    `tertiary_report_ordering_provider_clinician_id` BIGINT COMMENT 'Internal provider identifier for the clinician who placed the original imaging order. Required to determine notification obligations when an addendum is issued, per ACR communication guidelines.',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter (visit) during which the original imaging study was ordered. Supports clinical context linkage for CDI and quality reporting.',
    `accession_number` STRING COMMENT 'RIS (Radiology Information System)-assigned accession number of the imaging order associated with the original report. Used to correlate the addendum back to the imaging study in Epic Radiant or Cerner RadNet.',
    `acknowledgment_datetime` TIMESTAMP COMMENT 'Date and time when the ordering provider acknowledged receipt of the addendum notification. Nullable until acknowledged. Critical for closed-loop communication compliance per ACR and TJC standards.',
    `addendum_datetime` TIMESTAMP COMMENT 'Date and time when the addendum was authored and entered into the RIS/EHR system. Represents the principal business event timestamp for this transaction. Stored in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `addendum_sequence_number` STRING COMMENT 'Sequential integer indicating the order of this addendum relative to other addenda on the same original report (e.g., 1 = first addendum, 2 = second addendum). Supports multi-addendum tracking and version ordering.',
    `addendum_status` STRING COMMENT 'Current workflow lifecycle state of the addendum. draft = authored but not yet signed; pending_review = awaiting co-signature or peer review; finalized = signed and locked; retracted = addendum itself has been withdrawn.. Valid values are `draft|pending_review|finalized|retracted`',
    `addendum_text` STRING COMMENT 'Full narrative text of the addendum as authored by the radiologist. Contains PHI (Protected Health Information) and clinical findings. Supports CDI (Clinical Documentation Improvement) workflows and HIM audit requirements.',
    `addendum_type` STRING COMMENT 'Categorical classification of the addendum indicating its clinical purpose. correction = factual error corrected; clarification = ambiguous language clarified; clinical_update = new clinical information incorporated; addendum = supplemental information added; retraction = prior finding retracted. [ENUM-REF-CANDIDATE: correction|clarification|clinical_update|addendum|retraction — promote to reference product if additional types emerge]. Valid values are `correction|clarification|clinical_update|addendum|retraction`',
    `addendum_word_count` STRING COMMENT 'Number of words in the addendum text. Used for documentation completeness analytics, CDI program metrics, and radiologist productivity reporting. Derived at ingestion time from addendum_text.',
    `amendment_reason` STRING COMMENT 'Free-text or structured explanation of why the original report required amendment. Documents the clinical or administrative rationale (e.g., Transcription error in laterality, New clinical history provided by ordering physician). Required for HIM audit and OIG (Office of Inspector General) compliance.',
    `amendment_reason_code` STRING COMMENT 'Standardized code categorizing the reason for amendment, enabling structured reporting and quality analytics. Complements the free-text amendment_reason field. [ENUM-REF-CANDIDATE: transcription_error|laterality_error|clinical_history_update|measurement_correction|impression_revision|additional_finding|provider_request|other — promote to reference product]',
    `author_npi` STRING COMMENT '10-digit NPI (National Provider Identifier) of the radiologist or clinician who authored this addendum. Required for provider attribution, credentialing validation, and CMS (Centers for Medicare and Medicaid Services) billing compliance.. Valid values are `^[0-9]{10}$`',
    `body_part` STRING COMMENT 'Anatomical body part or region examined in the original imaging study (e.g., CHEST, ABDOMEN, BRAIN, SPINE). Derived from DICOM tag (0018,0015) BodyPartExamined. Supports anatomical-level quality and utilization analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this addendum record was first created in the data platform. Used for audit trail and data lineage tracking per HIPAA and HIM requirements.',
    `critical_finding_flag` BOOLEAN COMMENT 'Indicates whether this addendum contains or introduces a critical or urgent finding requiring immediate clinical action. When True, triggers expedited notification workflows per ACR and TJC critical results communication standards.',
    `dicom_study_instance_uid` STRING COMMENT 'Globally unique DICOM (Digital Imaging and Communications in Medicine) Study Instance UID of the imaging study associated with the original report. Enables direct linkage to PACS (Picture Archiving and Communication System) for image retrieval and addendum context.. Valid values are `^[0-9]+(.[0-9]+)+$`',
    `drg_impact_flag` BOOLEAN COMMENT 'Indicates whether this addendum has the potential to change the DRG (Diagnosis-Related Group) assignment for the associated inpatient encounter, affecting reimbursement. True = DRG may be affected; False = no DRG impact anticipated. Supports RCM (Revenue Cycle Management) and CDI analytics.',
    `finalized_datetime` TIMESTAMP COMMENT 'Date and time when the addendum was electronically signed and finalized by the authoring radiologist. Distinct from addendum_datetime (authoring time) — captures the attestation event for HIM audit and legal record purposes.',
    `him_review_datetime` TIMESTAMP COMMENT 'Date and time when the HIM department completed its review of this addendum. Nullable until HIM review is performed. Supports HIM audit trail and CDI workflow tracking.',
    `him_review_flag` BOOLEAN COMMENT 'Indicates whether this addendum has been flagged for review by the HIM (Health Information Management) department for coding accuracy, documentation integrity, or compliance purposes.',
    `impression_changed_flag` BOOLEAN COMMENT 'Indicates whether the addendum materially changes the clinical impression or diagnosis of the original report. True = impression revised; False = addendum is supplemental or administrative only. Key metric for CDI quality analytics and RAC (Recovery Audit Contractor) review.',
    `laterality` STRING COMMENT 'Laterality of the anatomical region examined (left, right, bilateral, or not applicable). Frequently the subject of addenda when laterality errors are identified in the original report. Supports patient safety and HIM audit workflows.. Valid values are `left|right|bilateral|not_applicable`',
    `modality` STRING COMMENT 'Imaging modality of the original study being amended (e.g., CT = Computed Tomography, MRI = Magnetic Resonance Imaging, XR = X-Ray, US = Ultrasound, PET = Positron Emission Tomography). Supports modality-level quality analytics and ACR benchmarking. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|DX|other — promote to reference product]',
    `notification_datetime` TIMESTAMP COMMENT 'Date and time when the notification of this addendum was dispatched to the ordering provider. Nullable when notification_status is not_required. Supports ACR communication audit trail.',
    `notification_method` STRING COMMENT 'Channel or method used to notify the ordering provider of the addendum (e.g., Epic In Basket message, secure message, phone call, fax). Supports communication audit and ACR compliance documentation.. Valid values are `in_basket|secure_message|phone|fax|ehr_alert|email`',
    `notification_status` STRING COMMENT 'Status of notification sent to the ordering provider regarding this addendum. not_required = no notification needed per policy; pending = notification queued; sent = notification dispatched; acknowledged = provider confirmed receipt; failed = notification delivery failed. Supports ACR communication compliance.. Valid values are `not_required|pending|sent|acknowledged|failed`',
    `original_report_finalized_datetime` TIMESTAMP COMMENT 'Date and time when the original radiology report was finalized prior to this addendum. Used to calculate turnaround time between original finalization and addendum, supporting quality metrics and ACR (American College of Radiology) benchmarking.',
    `peer_review_flag` BOOLEAN COMMENT 'Indicates whether this addendum was generated as a result of a formal peer review process (e.g., ACR RADPEER, internal quality review). True = peer review initiated; False = standard clinical addendum. Supports quality program analytics.',
    `peer_review_score` STRING COMMENT 'ACR RADPEER concordance score assigned during peer review, if applicable. Scale: 1 = agree with interpretation; 2a/2b = minor discrepancy; 3a/3b = significant discrepancy; 4 = major discrepancy. Nullable when peer_review_flag is False.. Valid values are `1|2a|2b|3a|3b|4`',
    `source_system_addendum_code` STRING COMMENT 'Native identifier of this addendum record in the originating operational system (e.g., Epic Radiant internal addendum ID, Cerner RadNet addendum key). Enables reconciliation between the lakehouse Silver Layer and the source RIS/EHR.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this addendum record was last modified in the data platform. Supports change detection and incremental ETL (Extract Transform Load) processing.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology report addendum record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `voice_recognition_flag` BOOLEAN COMMENT 'Indicates whether this addendum was authored using voice recognition / speech-to-text dictation software (e.g., Nuance PowerScribe, Nuance DAX). True = voice recognition used; False = manually typed. Supports transcription error root cause analysis.',
    CONSTRAINT pk_report_addendum PRIMARY KEY(`report_addendum_id`)
) COMMENT 'Tracks amendments and addenda appended to a finalized radiology report. Records addendum sequence number, addendum type (correction, clarification, clinical update), addendum text, reason for amendment, addendum author NPI, addendum datetime, original report reference, and notification status to ordering provider. Supports HIM (Health Information Management) audit requirements and CDI (Clinical Documentation Improvement) workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`modality` (
    `modality_id` BIGINT COMMENT 'Unique surrogate identifier for the imaging modality unit within the enterprise data platform. Primary key for the modality master reference entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the enterprise facility (hospital, clinic, imaging center) where this modality unit is physically deployed. Supports multi-site utilization analytics, capacity planning, and regulatory reporting by location.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Imaging equipment (CT, MRI, X-ray) are capital assets requiring linkage for depreciation calculation, asset lifecycle tracking, maintenance cost capitalization, and capital planning. Modality operatio',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: DICOM modalities connect to PACS/RIS via specific interface channels for modality worklist (MWL), MPPS, and image transmission. Links modality to its configured channel for troubleshooting connectivit',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Radiology equipment has assigned primary operators/technologists for accountability, competency tracking, and maintenance coordination. Required for quality assurance programs and regulatory complianc',
    `acr_accreditation_expiration_date` DATE COMMENT 'Date on which the current American College of Radiology (ACR) accreditation for this modality unit expires. Null if not accredited or not applicable. Critical for maintaining Medicare billing eligibility for advanced imaging services.',
    `acr_accreditation_status` STRING COMMENT 'Current American College of Radiology (ACR) accreditation status for this imaging modality unit. ACR accreditation is required for Medicare reimbursement for advanced imaging services (CT, MRI, PET, nuclear medicine) under CMS policy. Drives billing eligibility and quality reporting.. Valid values are `accredited|provisional|denied|expired|not_applicable`',
    `ae_title` STRING COMMENT 'DICOM Application Entity (AE) title assigned to this modality unit, used for DICOM network communication, PACS routing, and worklist queries. Must be unique across the enterprise DICOM network. Configured in PACS and RIS for image routing and storage commitment.. Valid values are `^[A-Z0-9_-]{1,16}$`',
    `bore_diameter_cm` DECIMAL(18,2) COMMENT 'Inner diameter of the CT or MRI gantry bore in centimeters (e.g., 70 cm wide-bore MRI, 80 cm CT). Null for non-gantry equipment. Used for patient eligibility screening (claustrophobia, body habitus) and order routing to appropriate equipment.',
    `building_code` STRING COMMENT 'Facility building or wing code where the modality unit is located (e.g., MAIN, NORTH, MOB-A). Supports physical asset management, maintenance routing, and emergency response planning.',
    `contrast_capable` BOOLEAN COMMENT 'Indicates whether this modality unit is equipped and approved for contrast-enhanced imaging procedures. Drives protocol assignment, contrast administration workflow routing, and safety checklist requirements in the RIS and EHR order management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this modality unit record was first created in the enterprise data platform. Supports data lineage, audit trail requirements, and HIPAA Security Rule audit controls.',
    `decommission_date` DATE COMMENT 'Date the imaging modality unit was permanently retired from clinical service. Null for active equipment. Used for asset lifecycle management, capital planning, and historical utilization analysis.',
    `department_name` STRING COMMENT 'Name of the clinical department or imaging section within the facility where this modality unit is assigned (e.g., Radiology, Emergency Radiology, Cardiac Imaging, Breast Imaging Center). Used for departmental cost allocation and operational reporting.',
    `detector_type` STRING COMMENT 'Type of image detector technology used in the modality unit (e.g., Flat Panel, Curved Array, Photon Counting, CCD, Amorphous Silicon, Scintillator). Relevant for image quality benchmarking, protocol optimization, and ACR phantom testing requirements.',
    `dicom_modality_code` STRING COMMENT 'Standardized DICOM modality code as defined in DICOM PS3.3 (e.g., CT, MR, US, DX, PT, NM, MG, RF, XA). Used for PACS routing, DICOM worklist matching, and interoperability with imaging systems. Critical for HL7 and FHIR image exchange.. Valid values are `^[A-Z]{2,4}$`',
    `dose_tracking_enabled` BOOLEAN COMMENT 'Indicates whether automated radiation dose tracking and reporting is enabled for this modality unit, feeding the ACR Dose Index Registry (DIR) and enterprise dose management systems. Required for CMS quality reporting and MIPS measures related to radiation safety.',
    `equipment_type` STRING COMMENT 'Classification of the imaging modality by technology type, aligned with DICOM modality codes and ACR accreditation categories. Drives order routing rules, protocol assignment, and utilization reporting. [ENUM-REF-CANDIDATE: CT|MRI|X-ray|Ultrasound|PET-CT|PET|Fluoroscopy|Mammography|Nuclear Medicine|DEXA|Angiography — promote to reference product]',
    `fda_510k_number` STRING COMMENT 'FDA 510(k) premarket notification clearance number for this imaging device model, confirming substantial equivalence to a predicate device. Supports regulatory compliance documentation and procurement validation.. Valid values are `^K[0-9]{6}$`',
    `fda_registration_number` STRING COMMENT 'U.S. Food and Drug Administration (FDA) device establishment registration number assigned to this imaging equipment unit under 21 CFR Part 807. Required for regulatory compliance tracking and FDA inspection readiness.. Valid values are `^[0-9]{7}$`',
    `installation_date` DATE COMMENT 'Date the imaging modality unit was physically installed and commissioned at the facility. Used to calculate equipment age, depreciation schedules, warranty expiration, and capital replacement planning.',
    `is_mobile` BOOLEAN COMMENT 'Indicates whether this modality unit is a portable or mobile imaging device (True) that can be transported to patient care areas (e.g., portable X-ray, mobile ultrasound, mobile CT), versus a fixed-installation unit (False). Affects scheduling logic, location tracking, and utilization reporting.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration or quality control (QC) performance of the imaging modality unit. Required for ACR accreditation, state radiation control compliance, and Joint Commission equipment maintenance standards.',
    `last_preventive_maintenance_date` DATE COMMENT 'Date of the most recent scheduled preventive maintenance (PM) service performed on the modality unit by biomedical engineering or the manufacturers field service team. Supports Joint Commission equipment maintenance compliance and uptime tracking.',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the imaging modality unit (e.g., Siemens Healthineers, GE Healthcare, Philips Healthcare, Canon Medical, Hologic). Used for vendor management, service contract tracking, and FDA device registration.',
    `max_patient_weight_kg` DECIMAL(18,2) COMMENT 'Maximum patient weight in kilograms that the modality units table or gantry is rated to support. Critical for bariatric patient scheduling, safety screening, and order routing to appropriate equipment. Drives clinical decision support alerts in the RIS and EHR.',
    `model_name` STRING COMMENT 'Manufacturer-assigned model name or product line designation for the imaging equipment unit (e.g., SOMATOM Force, MAGNETOM Vida, Revolution CT, Ingenia Elition). Used for service contract management, software upgrade tracking, and ACR accreditation documentation.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date by which the next calibration or quality control test must be completed to maintain regulatory compliance and accreditation status. Drives preventive maintenance scheduling and compliance alerts.',
    `next_preventive_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service on the modality unit. Used by biomedical engineering and facilities management for maintenance scheduling and Joint Commission compliance.',
    `operational_status` STRING COMMENT 'Current operational lifecycle status of the imaging modality unit. Drives scheduling availability, order routing eligibility, and equipment utilization reporting. active = available for clinical use; under_maintenance = temporarily unavailable; decommissioned = permanently retired from service.. Valid values are `active|inactive|under_maintenance|decommissioned|pending_installation`',
    `pacs_node_name` STRING COMMENT 'Name of the PACS (Picture Archiving and Communication System) storage node or archive destination configured for this modality unit. Defines the image routing path from the modality to the enterprise PACS for storage, retrieval, and radiologist interpretation.',
    `radiation_emitting` BOOLEAN COMMENT 'Indicates whether this imaging modality unit emits ionizing radiation (True = ionizing radiation, e.g., CT, X-ray, PET, fluoroscopy; False = non-ionizing, e.g., MRI, ultrasound). Drives radiation dose tracking requirements, state radiation control reporting, and ALARA compliance workflows.',
    `ris_resource_code` STRING COMMENT 'Identifier for this modality unit as configured in the source Radiology Information System (RIS) — Epic Radiant or Cerner RadNet. Used for system-of-record traceability, ETL reconciliation, and cross-system integration with scheduling and order management.',
    `room_identifier` STRING COMMENT 'Physical room or suite identifier within the facility where the modality unit is installed (e.g., Room 3, Suite B-102, MRI Suite 1). Used for scheduling, patient wayfinding, and facility management.',
    `scheduled_hours_per_day` DECIMAL(18,2) COMMENT 'Standard number of hours per day this modality unit is scheduled for clinical operations. Used as the denominator for equipment utilization rate calculations, capacity planning, and staffing models in radiology operations analytics.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the physical imaging equipment unit. Required for FDA device registration, warranty tracking, service contract management, and ACR accreditation. Stored as confidential due to its role in device security and regulatory compliance.',
    `service_contract_expiration_date` DATE COMMENT 'Date on which the current service and maintenance contract for this modality unit expires. Drives contract renewal alerts and procurement planning to ensure continuous coverage and Joint Commission compliance.',
    `service_contract_number` STRING COMMENT 'Identifier for the active service and maintenance contract covering this imaging modality unit. Links to the vendor service agreement in the procurement system. Used for service dispatch, cost tracking, and contract renewal management.',
    `shared_service_indicator` BOOLEAN COMMENT 'Indicates whether this modality unit is shared across multiple departments, facilities, or service lines (True) versus dedicated to a single department (False). Relevant for cost allocation, scheduling priority rules, and utilization analytics in multi-entity health systems.',
    `slice_count` STRING COMMENT 'Number of detector rows or slices for CT modality units (e.g., 16, 64, 128, 256, 320). Null for non-CT equipment. Determines CT protocol capabilities, scan speed, and clinical application eligibility (e.g., cardiac CT requires ≥64 slices). Used in equipment utilization and capability reporting.',
    `software_version` STRING COMMENT 'Current installed software or firmware version on the imaging modality unit. Critical for cybersecurity patch management, FDA software as a medical device (SaMD) compliance, and protocol compatibility with PACS and RIS systems.',
    `tesla_field_strength` DECIMAL(18,2) COMMENT 'Magnetic field strength in Tesla (T) for MRI modality units (e.g., 1.5, 3.0, 7.0). Null for non-MRI equipment. Determines MRI safety zone classifications, implant screening requirements, and protocol capabilities. Required for ACR MRI accreditation documentation.',
    `unit_code` STRING COMMENT 'Facility-assigned alphanumeric code uniquely identifying this imaging equipment unit within the enterprise. Used as the operational business identifier in RIS scheduling, order routing, and PACS integration (e.g., CT01, MRI-3T-02). Corresponds to the equipment code in Epic Radiant and Cerner RadNet.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `unit_name` STRING COMMENT 'Human-readable display name for the imaging modality unit as it appears in scheduling systems, worklists, and operational dashboards (e.g., Main Campus CT Scanner 1, North Wing 3T MRI). Used by technologists and schedulers to identify equipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this modality unit record in the enterprise data platform. Supports change data capture (CDC), ETL incremental load processing, and audit trail requirements under HIPAA Security Rule.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology modality record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_modality PRIMARY KEY(`modality_id`)
) COMMENT 'Master reference entity for physical imaging equipment units deployed across enterprise facilities. Captures modality unit identifier, equipment type (CT, MRI, PET-CT, X-ray, ultrasound, fluoroscopy, mammography, nuclear medicine), manufacturer, model, serial number, DICOM AE title, facility location, room assignment, installation date, last calibration date, FDA device registration, ACR accreditation status, and operational status. SSOT for imaging equipment identity within the radiology domain. Supports equipment utilization analytics, maintenance scheduling, and regulatory compliance tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`protocol` (
    `protocol_id` BIGINT COMMENT 'Primary key for protocol',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Imaging protocols operationalize compliance policies for radiation safety, contrast administration, and clinical appropriateness. Policies mandate protocol standards; protocols reference governing pol',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Imaging protocols define standard contrast agents for specific exam types. FK to drug_master ensures protocol-formulary alignment, supports automated order validation, and enables protocol updates whe',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Imaging protocols are mapped to CPT codes to standardize procedure ordering, support charge capture automation, and enable protocol-to-billing reconciliation. Essential for revenue cycle optimization ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Imaging protocols authored by radiologists or medical physicists require creator tracking for audit trail, version control, and regulatory compliance. Distinct from approving_clinician_id which captur',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Protocols reference LOINC codes for interoperable procedure identification in HL7 messages, support standardized order entry, and enable cross-facility protocol comparison for quality benchmarking.',
    `parent_protocol_id` BIGINT COMMENT 'Reference to the imaging_protocol_id of the parent protocol from which this protocol was derived or branched (e.g., a pediatric variant derived from an adult protocol). Supports protocol hierarchy and variant management within the Radiant protocol library.',
    `primary_superseded_by_protocol_id` BIGINT COMMENT 'Reference to the imaging_protocol_id of the newer protocol version that replaced this one upon retirement. Enables forward navigation through protocol version history and ensures continuity of care documentation.',
    `acr_appropriateness_rating` STRING COMMENT 'American College of Radiology (ACR) Appropriateness Criteria rating for this protocol-indication combination. Used for clinical decision support, prior authorization, and CMS Appropriate Use Criteria (AUC) compliance reporting under PAMA.. Valid values are `usually_appropriate|may_be_appropriate|usually_not_appropriate`',
    `approval_date` DATE COMMENT 'Date on which the approving radiologist formally approved this protocol version for clinical use. Marks the transition from draft to active status and is used for audit trails and regulatory compliance documentation.',
    `approving_radiologist_npi` STRING COMMENT 'National Provider Identifier (NPI) of the radiologist who reviewed and approved this protocol version. Ensures accountability for clinical protocol governance and supports credentialing verification. Links to provider registry.. Valid values are `^d{10}$`',
    `body_part` STRING COMMENT 'Anatomical region or body part targeted by this imaging protocol (e.g., Brain, Chest, Abdomen and Pelvis, Lumbar Spine). Corresponds to the DICOM Body Part Examined attribute and SNOMED CT anatomical site codes. Used for protocol selection and PACS routing.',
    `protocol_category` STRING COMMENT 'Clinical category classifying the purpose of this imaging protocol. diagnostic for standard clinical workup, screening for population health programs (e.g., lung cancer screening), interventional for image-guided procedures, research for IRB-approved studies, emergency for ED/trauma protocols, pediatric for age-specific protocols.. Valid values are `diagnostic|screening|interventional|research|emergency|pediatric`',
    `clinical_indication` STRING COMMENT 'The clinical reason or diagnostic question driving the imaging order for which this protocol is designed (e.g., Pulmonary Embolism Rule-Out, Abdominal Pain, Stroke Workup). Maps to ICD-10 diagnosis categories and supports appropriateness criteria evaluation.',
    `protocol_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the protocol within the Radiology Information System (RIS), such as Epic Radiant or Cerner RadNet. Used for order mapping, PACS integration, and cross-system reference.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `contrast_dose_ml` DECIMAL(18,2) COMMENT 'Standard contrast agent dose in milliliters specified for this protocol. May be weight-based (documented separately in patient preparation instructions) or fixed volume. Used for pharmacy preparation and contrast utilization tracking.',
    `contrast_flow_rate_ml_per_sec` DECIMAL(18,2) COMMENT 'Injection flow rate for intravenous contrast in milliliters per second as specified in the protocol. Critical for CT angiography and dynamic phase imaging to achieve optimal vascular enhancement. Null for non-IV contrast protocols.',
    `contrast_required` BOOLEAN COMMENT 'Indicates whether intravenous or oral contrast administration is required for this protocol. True = contrast is required; False = non-contrast study. Drives pre-procedure screening for contrast allergies, renal function checks, and pharmacy preparation.',
    `contrast_route` STRING COMMENT 'Route of administration for the contrast agent specified in this protocol (e.g., intravenous for CT angiography, oral for GI studies, intrathecal for myelography). Drives nursing preparation and patient consent requirements.. Valid values are `intravenous|oral|rectal|intrathecal|intra_articular|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protocol record was first created in the radiology data platform. Used for audit trail, data lineage, and compliance with HIPAA record retention requirements.',
    `dose_optimization_program` STRING COMMENT 'Radiation dose optimization program under which this protocol was designed or benchmarked. image_gently for pediatric dose reduction, image_wisely for adult dose reduction, acr_dir for ACR Dose Index Registry benchmarking. Supports regulatory reporting and quality improvement programs.. Valid values are `image_gently|image_wisely|acr_dir|none`',
    `effective_date` DATE COMMENT 'Date from which this protocol version becomes effective and available for clinical use in the RIS. May differ from approval_date if a future activation date is set. Used for version control and ensuring technologists use the current protocol.',
    `fasting_duration_hours` STRING COMMENT 'Required fasting duration in hours prior to the examination when fasting_required is True (e.g., 4 hours for contrast CT, 6 hours for PET-CT). Null when fasting is not required.',
    `fasting_required` BOOLEAN COMMENT 'Indicates whether the patient must fast (NPO) prior to this imaging examination. True = fasting required; False = no fasting required. Drives pre-procedure patient instructions and scheduling communication.',
    `field_of_view_mm` DECIMAL(18,2) COMMENT 'Field of view in millimeters defining the anatomical coverage area for image reconstruction. Determines spatial resolution and the extent of anatomy captured in the image matrix. Applicable to CT and MRI protocols.',
    `implant_screening_required` BOOLEAN COMMENT 'Indicates whether MRI implant safety screening is required before performing this protocol. True = screening required (applicable to all MRI protocols); False = not required. Drives pre-procedure safety questionnaire workflows to identify contraindicated implants, pacemakers, or metallic foreign bodies.',
    `kvp` STRING COMMENT 'Peak kilovoltage (kVp) setting for the X-ray tube as specified in this protocol. Determines X-ray beam energy and affects image contrast and patient radiation dose. Applicable to CT, X-ray, and fluoroscopy modalities. Null for MRI and ultrasound.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this protocol record was most recently modified in the radiology data platform. Used for change tracking, audit trails, and incremental data pipeline processing in the Databricks Silver layer.',
    `magnetic_field_strength_tesla` DECIMAL(18,2) COMMENT 'Magnetic field strength in Tesla for MRI protocols (e.g., 1.5T, 3.0T, 7.0T). Determines scanner compatibility, image quality characteristics, and specific absorption rate (SAR) limits. Null for non-MRI modalities.',
    `mas` DECIMAL(18,2) COMMENT 'Milliampere-seconds (mAs) setting specifying the X-ray tube current-time product for this protocol. Directly influences image noise and patient radiation dose. Used in CT and radiography protocols. Null for MRI and ultrasound.',
    `modality_type` STRING COMMENT 'DICOM-standard imaging modality code for which this protocol is defined (e.g., CT = Computed Tomography, MRI = Magnetic Resonance Imaging, XR = X-Ray, US = Ultrasound, PET = Positron Emission Tomography, NM = Nuclear Medicine, MG = Mammography). Drives scheduling to the correct equipment and technologist skill set. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|DX|PT — 10 candidates stripped; promote to reference product]',
    `protocol_name` STRING COMMENT 'Human-readable name of the imaging acquisition protocol as displayed in the RIS and PACS worklist (e.g., CT Abdomen Pelvis with Contrast, MRI Brain without Contrast). Used by technologists and radiologists to identify the correct acquisition procedure.',
    `pacs_routing_code` STRING COMMENT 'Code used to route completed images to the correct reading worklist, hanging protocol, and storage location within the Picture Archiving and Communication System (PACS). Ensures images are delivered to the appropriate radiologist subspecialty queue for interpretation.',
    `patient_population` STRING COMMENT 'Target patient population for which this protocol is designed. Drives protocol selection logic in the RIS based on patient age and clinical context. Pediatric and neonatal protocols use weight-based dosing and modified acquisition parameters.. Valid values are `adult|pediatric|neonatal|geriatric|obstetric|all`',
    `patient_prep_instructions` STRING COMMENT 'Standardized patient preparation instructions for this protocol, including fasting requirements (e.g., NPO 4 hours), hydration instructions, medication holds (e.g., hold Metformin for contrast studies), bowel preparation, and breath-hold coaching. Displayed to scheduling staff and communicated to patients prior to the exam.',
    `pitch_factor` DECIMAL(18,2) COMMENT 'Helical pitch factor for CT protocols, defined as table feed per rotation divided by total collimation. Values less than 1.0 indicate overlapping acquisitions (higher dose, better quality); values greater than 1.0 indicate faster coverage with lower dose. Null for non-helical CT and other modalities.',
    `protocol_status` STRING COMMENT 'Current lifecycle status of the imaging protocol. active indicates the protocol is approved and available for use; draft indicates pending approval; retired indicates superseded by a newer version; under_review indicates undergoing clinical review.. Valid values are `active|inactive|draft|retired|under_review`',
    `pulse_sequence_type` STRING COMMENT 'MRI pulse sequence type used in this protocol (e.g., T1 SE, T2 FSE, FLAIR, DWI, GRE, SSFP, EPI). Defines the fundamental MRI acquisition technique and determines tissue contrast characteristics. Null for non-MRI modalities.',
    `radiation_dose_ctdi_vol_mgy` DECIMAL(18,2) COMMENT 'Reference CT Dose Index Volume (CTDIvol) in milligray representing the average radiation dose within the scan volume for this CT protocol. Standardized metric for comparing dose across CT scanners and protocols. Reported to ACR Dose Index Registry and used for DRL benchmarking.',
    `radiation_dose_dlp_mgy_cm` DECIMAL(18,2) COMMENT 'Reference Dose Length Product (DLP) in milligray-centimeters representing the expected radiation dose for this CT protocol under standard conditions. Used for radiation dose optimization programs, comparison against Diagnostic Reference Levels (DRLs), and regulatory reporting to CMS and ACR Dose Index Registry.',
    `radlex_code` STRING COMMENT 'RSNA RadLex ontology code for the imaging procedure or anatomy associated with this protocol (e.g., RID10321 for CT of abdomen). Supports standardized terminology in radiology reporting, PACS integration, and research data aggregation.. Valid values are `^RIDd+$`',
    `reconstruction_algorithm` STRING COMMENT 'Image reconstruction algorithm specified for this protocol (e.g., Filtered Back Projection, Iterative Reconstruction, Deep Learning Reconstruction, ASIR-V 40%). Affects image quality, noise characteristics, and radiation dose efficiency. Vendor-specific algorithm names are stored as-is.',
    `renal_function_check_required` BOOLEAN COMMENT 'Indicates whether pre-procedure renal function assessment (eGFR/creatinine) is required before administering contrast for this protocol. True = renal check required (standard for iodinated and gadolinium contrast protocols); False = not required. Drives lab order triggers in Epic Radiant.',
    `retirement_date` DATE COMMENT 'Date on which this protocol version was retired or superseded by a newer version. Null for currently active protocols. Used for version lifecycle management and historical audit trails.',
    `ris_procedure_code` STRING COMMENT 'Internal procedure code assigned to this protocol within the Radiology Information System (RIS), such as Epic Radiant or Cerner RadNet. Used for order entry mapping, scheduling, and charge capture integration with the CDM.',
    `scan_duration_estimate_sec` STRING COMMENT 'Estimated acquisition time in seconds for this protocol under standard conditions. Used for scheduling slot allocation in the RIS, patient throughput planning, and breath-hold instruction timing for chest and abdominal studies.',
    `sedation_required` BOOLEAN COMMENT 'Indicates whether procedural sedation or anesthesia is required or commonly needed for this protocol (e.g., pediatric MRI, claustrophobic patients). True = sedation required; False = no sedation required. Triggers anesthesia scheduling and pre-sedation assessment workflows.',
    `slice_thickness_mm` DECIMAL(18,2) COMMENT 'Nominal slice thickness in millimeters for cross-sectional imaging protocols (CT, MRI). Thinner slices provide higher spatial resolution for small structure evaluation; thicker slices reduce noise and radiation dose. Null for planar modalities.',
    `total_exam_duration_min` STRING COMMENT 'Total estimated examination time in minutes including patient preparation, positioning, scanning, and post-processing. Used for scheduling block allocation in the RIS and patient appointment communication. Distinct from scan_duration_estimate_sec which covers acquisition only.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the radiology protocol record.',
    `version` STRING COMMENT 'Version number of the protocol definition following semantic versioning (e.g., 1.0, 2.3, 3.1.2). Enables tracking of protocol revisions over time and ensures technologists are using the current approved version.. Valid values are `^d+.d+(.d+)?$`',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology protocol record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_protocol PRIMARY KEY(`protocol_id`)
) COMMENT 'Defines standardized acquisition protocols for each modality and clinical indication combination. Stores protocol name, modality type, clinical indication, body part, contrast requirement flag, contrast agent type, slice thickness, kVp, mAs, field of view, reconstruction algorithm, scan duration estimate, patient preparation instructions, protocol version, effective date, and approving radiologist. Enables consistent image quality and supports radiation dose optimization programs. Managed within Epic Radiant protocol library.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` (
    `contrast_admin_id` BIGINT COMMENT 'Primary key for contrast_admin',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician (nurse, radiologic technologist, or radiologist) who administered the contrast agent. Used for accountability and adverse event tracking.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Contrast administration must link to clinical orders for medication reconciliation workflows. Clinical decision support for contrast allergy screening requires full order context including patient all',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Contrast administration records must link to material master for non-pharmacy contrast agents, enabling lot tracking, expiration management, and FDA recall response. Critical for patient safety when c',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who received the contrast agent. Links to the Master Patient Index (MPI) record. Protected Health Information (PHI) under HIPAA.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Contrast agents are medications managed in pharmacy formulary. Currently has agent_name and ndc_code as text. FK to drug_master normalizes contrast agent data, enables allergy checking, formulary mana',
    `equipment_asset_id` BIGINT COMMENT 'The asset or serial identifier of the power injector device used for contrast administration. Supports medical device tracking, maintenance scheduling, and adverse event investigation.',
    `imaging_order_id` BIGINT COMMENT 'Reference to the parent imaging order that triggered this contrast administration event. Links to the radiology order in Epic Radiant or Cerner RadNet.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Contrast agents are pharmaceutical products identified by NDC for medication administration records, adverse event tracking, inventory management, and pharmacy billing. Essential for drug safety surve',
    `radiology_study_id` BIGINT COMMENT 'Reference to the imaging study (DICOM study) with which this contrast administration is associated. Supports PACS integration and study-level traceability.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Contrast administration to research subjects requires tracking for adverse event monitoring, safety reporting, and protocol compliance. Contrast reactions are reportable adverse events. Linkage enable',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Contrast agent administration requires specific informed consent due to allergy/anaphylaxis risks, renal function considerations, and potential adverse reactions. Standard of care requirement. Links c',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit) during which the contrast was administered. Supports revenue cycle and clinical documentation linkage.',
    `accession_number` STRING COMMENT 'The Radiology Information System (RIS) accession number assigned to the imaging order. Serves as the primary business identifier linking the contrast event to the RIS workflow in Epic Radiant and Cerner RadNet.',
    `administered_timestamp` TIMESTAMP COMMENT 'The administered timestamp of the radiology contrast admin record.',
    `administering_clinician_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the clinician who administered the contrast agent. Required for regulatory reporting, billing, and provider accountability tracking.. Valid values are `^d{10}$`',
    `administration_datetime` TIMESTAMP COMMENT 'The precise date and time at which the contrast agent was administered to the patient. This is the principal real-world event timestamp for this transaction, distinct from record audit timestamps.',
    `administration_status` STRING COMMENT 'Current lifecycle status of the contrast administration event, aligned with HL7 FHIR MedicationAdministration status codes. not-done indicates contrast was withheld after screening.. Valid values are `completed|in-progress|not-done|on-hold|stopped|entered-in-error`',
    `adverse_reaction_datetime` TIMESTAMP COMMENT 'The date and time at which the adverse reaction was first observed following contrast administration. Used to calculate time-to-reaction interval for safety analytics.',
    `adverse_reaction_description` STRING COMMENT 'Detailed clinical description of the adverse reaction signs and symptoms observed following contrast administration (e.g., urticaria on trunk and arms, resolved with diphenhydramine). Required for FDA MedWatch and internal safety reporting.',
    `adverse_reaction_occurred` BOOLEAN COMMENT 'Indicates whether the patient experienced an adverse reaction following contrast administration (True = reaction occurred, False = no reaction). Triggers mandatory documentation and reporting workflows.',
    `adverse_reaction_severity` STRING COMMENT 'Severity classification of the adverse reaction experienced by the patient following contrast administration, per ACR grading criteria. Drives escalation protocols and mandatory reporting thresholds.. Valid values are `mild|moderate|severe|life-threatening`',
    `adverse_reaction_treatment` STRING COMMENT 'Description of the clinical interventions performed to treat the adverse contrast reaction (e.g., epinephrine 0.3mg IM, oxygen 4L/min via nasal cannula, IV fluid bolus). Supports quality review and safety reporting.',
    `agent_class` STRING COMMENT 'Classification of the contrast agent by chemical class. Drives safety screening protocols (e.g., gadolinium retention monitoring, iodine allergy screening) and ACR guideline compliance.. Valid values are `iodinated|gadolinium-based|barium|microbubble|manganese-based|iron-based`',
    `agent_osmolality_type` STRING COMMENT 'Osmolality classification of the iodinated contrast agent (low, iso, or high osmolality). Relevant for patient safety risk stratification, particularly in patients with renal impairment.. Valid values are `low-osmolality|iso-osmolality|high-osmolality`',
    `body_region` STRING COMMENT 'The anatomical body region being imaged (e.g., abdomen/pelvis, brain, chest, spine). Used for contrast protocol selection and population health analytics.',
    `catheter_gauge` STRING COMMENT 'The gauge size of the intravenous catheter used for contrast injection (e.g., 18G, 20G, 22G). Relevant for power injector safety limits and extravasation risk assessment.',
    `concentration_mg_per_ml` DECIMAL(18,2) COMMENT 'The concentration of the contrast agent in the administered preparation, expressed in milligrams per milliliter (mg/mL). Used to verify dose calculations and product selection.',
    `contrast_agent_name` STRING COMMENT 'The contrast agent name of the radiology contrast admin record.',
    `contrast_allergy_screening_result` STRING COMMENT 'The result of the pre-administration contrast allergy screening assessment. Captures whether the patient has a documented prior contrast reaction, confirmed allergy, or no known allergy. Drives pre-medication decision.. Valid values are `no-allergy|prior-reaction|allergy-confirmed|screening-not-done|contraindicated`',
    `contrast_protocol_name` STRING COMMENT 'The name of the institutional contrast administration protocol followed (e.g., CT Abdomen Pelvis with IV Contrast — Standard Adult). Supports protocol compliance auditing and quality improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the radiology contrast admin record.',
    `dose_amount_mg` DECIMAL(18,2) COMMENT 'The total mass of contrast agent administered, measured in milligrams (mg). Supports weight-based dosing verification and cumulative gadolinium/iodine exposure tracking.',
    `dose_ml` DECIMAL(18,2) COMMENT 'The dose ml of the radiology contrast admin record.',
    `dose_volume_ml` DECIMAL(18,2) COMMENT 'The total volume of contrast agent administered, measured in milliliters (mL). Used for dose tracking, pharmacy reconciliation, and radiation/contrast safety monitoring.',
    `extravasation_occurred` BOOLEAN COMMENT 'Indicates whether contrast agent extravasation (leakage into surrounding tissue) occurred during injection (True = extravasation, False = no extravasation). Triggers wound care and incident reporting protocols.',
    `extravasation_volume_ml` DECIMAL(18,2) COMMENT 'Estimated volume of contrast agent that extravasated into surrounding tissue, in milliliters (mL). Used to guide clinical management and severity classification of the extravasation event.',
    `informed_consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the patient prior to contrast administration (True = consent obtained, False = consent not obtained or waived). Required for regulatory compliance and risk management.',
    `injection_rate_ml_per_sec` DECIMAL(18,2) COMMENT 'The rate at which the contrast agent was injected, expressed in milliliters per second (mL/sec). Relevant for CT bolus timing, power injector programming, and adverse event analysis.',
    `injection_site` STRING COMMENT 'The anatomical site of contrast injection (e.g., right antecubital vein, left hand dorsal vein, lumbar intrathecal space). Supports extravasation tracking and adverse event documentation.',
    `metformin_held` BOOLEAN COMMENT 'Indicates whether metformin was held prior to or following contrast administration per ACR guidelines for patients with renal impairment (True = metformin held, False = not held or not applicable).',
    `modality` STRING COMMENT 'The imaging modality for which the contrast was administered (e.g., CT, MRI, Ultrasound, PET). Determines applicable ACR contrast guidelines and safety protocols. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|FLUORO|ANGIO — 8 candidates stripped; promote to reference product]',
    `patient_weight_kg` DECIMAL(18,2) COMMENT 'The patients body weight in kilograms (kg) recorded at the time of contrast administration. Used for weight-based dose calculation verification and contrast safety risk stratification.',
    `power_injector_used` BOOLEAN COMMENT 'Indicates whether a power injector device was used to administer the contrast agent (True) or manual hand injection was performed (False). Relevant for injection rate documentation and device safety tracking.',
    `pregnancy_status` STRING COMMENT 'The patients pregnancy status at the time of contrast administration screening. Required for contrast safety risk assessment and informed consent documentation per ACR guidelines.. Valid values are `not-pregnant|pregnant|unknown|not-applicable`',
    `premedication_details` STRING COMMENT 'Free-text or structured description of the pre-medication regimen administered (e.g., Prednisone 50mg PO x3 doses + Diphenhydramine 50mg IV). Supports clinical documentation and pharmacy reconciliation.',
    `premedication_given` BOOLEAN COMMENT 'Indicates whether pre-medication (e.g., corticosteroid prophylaxis) was administered prior to contrast injection to reduce the risk of allergic reaction (True = pre-medicated, False = not pre-medicated).',
    `prior_contrast_reaction_type` STRING COMMENT 'Description of the type of prior contrast reaction documented in the patients allergy history (e.g., urticaria, bronchospasm, anaphylaxis). Informs pre-medication protocol selection.',
    `reaction_flag` BOOLEAN COMMENT 'The reaction flag of the radiology contrast admin record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this contrast administration record was first created in the source system or ingested into the lakehouse Silver layer. Supports audit trail and data lineage requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this contrast administration record was last modified in the source system or updated in the lakehouse Silver layer. Supports change tracking and audit compliance.',
    `route` STRING COMMENT 'The route of the radiology contrast admin record.',
    `route_of_administration` STRING COMMENT 'The anatomical route by which the contrast agent was delivered to the patient (e.g., intravenous, oral, intrathecal). Critical for adverse reaction risk assessment and clinical documentation.. Valid values are `intravenous|oral|intrathecal|intra-arterial|intraperitoneal|rectal`',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating operational system (e.g., Epic Radiant administration event ID, Cerner RadNet medication administration ID). Supports ETL traceability and cross-system reconciliation.',
    `thyroid_disease_flag` BOOLEAN COMMENT 'Indicates whether the patient has a documented thyroid condition (e.g., hyperthyroidism, thyroid cancer) that may be relevant to iodinated contrast administration safety screening.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the radiology contrast admin record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology contrast admin record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_contrast_admin PRIMARY KEY(`contrast_admin_id`)
) COMMENT 'Transactional record of contrast agent administration events associated with an imaging study. Captures contrast agent name, NDC (National Drug Code), route of administration (IV, oral, intrathecal), dose administered (mL and mg), injection rate, injection site, pre-medication given flag, pre-medication details, adverse reaction flag, adverse reaction description, eGFR value at time of administration, contrast allergy screening result, administering clinician NPI, and administration datetime. Supports patient safety monitoring, contrast reaction tracking, and pharmacy reconciliation. Aligns with ACR Manual on Contrast Media guidelines and HL7 FHIR MedicationAdministration resource.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` (
    `dose_record_id` BIGINT COMMENT 'Primary key for dose_record',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or imaging center where the study was performed. Supports facility-level dose benchmarking, ACR DIR site-level reporting, and Joint Commission accreditation tracking.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Radiation dose records must be traceable to clinical orders for dose optimization programs and regulatory reporting to dose index registries. Quality assurance workflows validate appropriate imaging u',
    `imaging_order_id` BIGINT COMMENT 'Reference to the radiology order (CPOE) that initiated the imaging study. Links dose data to the clinical order for appropriateness review and order management workflows in Epic Radiant or Cerner RadNet.',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: dose_record currently has imaging_protocol_name: STRING (free-text field). Radiation dose records are tied to the acquisition protocol used, which determines expected dose ranges and DRL comparisons. ',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Radiation dose structured reports (RDSR) are transmitted via HL7 ORU or DICOM to dose registries (ACR DIR, state registries) for regulatory reporting and dose optimization programs. Message_log tracks',
    `modality_id` BIGINT COMMENT 'Unique identifier for the modality within the radiology dose record record.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received the radiation exposure. Links to the Master Patient Index (MPI) record for cumulative dose tracking and patient-level radiation safety monitoring per ALARA principle.',
    `osha_safety_program_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_safety_program. Business justification: Dose records support OSHA radiation safety programs by documenting employee and patient exposure levels. Safety programs monitor cumulative dose data to ensure compliance with occupational exposure li',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who ordered the imaging study. Used for utilization management, appropriateness criteria reporting, and CMS quality program compliance.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Radiation dose records link to CPT codes for dose-by-procedure benchmarking, ACR Dose Index Registry submissions, and radiation safety quality measures. Supports dose optimization program reporting.',
    `public_health_report_id` BIGINT COMMENT 'Foreign key linking to interoperability.public_health_report. Business justification: Radiation dose records are submitted to state dose registries and ACR Dose Index Registry for public health surveillance and dose optimization programs. Links dose record to its public health submissi',
    `radiology_study_id` BIGINT COMMENT 'Unique identifier for the radiology study within the radiology dose record record.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Radiation dose tracking for research subjects is IRB-mandated for protocols involving imaging. Cumulative dose monitoring, safety reporting to IRBs and sponsors, and protocol-specified dose limits req',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Radiation dose records require medical physicist review for quality assurance and regulatory compliance (ACR, state regulations). Physicists may not have clinician_id if non-provider staff.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit) during which the imaging study and radiation exposure occurred. Supports revenue cycle linkage and clinical context for dose reporting.',
    `accession_number` STRING COMMENT 'Radiology Information System (RIS) accession number uniquely identifying the imaging order/study to which this dose record belongs. Primary business identifier linking dose data to the imaging study in Epic Radiant or Cerner RadNet.',
    `body_part_examined` STRING COMMENT 'DICOM-coded body part or anatomical region examined during the imaging study (e.g., CHEST, ABDOMEN, HEAD, PELVIS). Used for dose benchmarking by anatomy and ACR DIR stratification.',
    `contrast_administered` BOOLEAN COMMENT 'Indicates whether iodinated or gadolinium-based contrast agent was administered during the imaging study. True = contrast used; False = non-contrast study. Relevant for dose context, adverse event tracking, and clinical protocol classification.',
    `contrast_agent_type` STRING COMMENT 'Type of contrast agent administered during the imaging study. iodinated=CT/X-ray contrast; gadolinium=MRI contrast (tracked for nephrogenic systemic fibrosis risk); barium=GI fluoroscopy; none=no contrast. Used for clinical safety monitoring and protocol classification.. Valid values are `iodinated|gadolinium|barium|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dose record was first created in the source system or ingested into the lakehouse Silver layer. Supports audit trail, data lineage, and regulatory record retention requirements.',
    `ctdi_vol_mgy` DECIMAL(18,2) COMMENT 'The ctdi vol mgy of the radiology dose record record.',
    `ctdivol_mgy` DECIMAL(18,2) COMMENT 'Volume CT Dose Index (CTDIvol) in milligray (mGy) for CT studies. Represents the average radiation dose delivered within the scan volume for a single series or the entire study. Primary CT dose metric for ACR DIR benchmarking and dose alert thresholds per NCRP and FDA guidance.',
    `cumulative_dose_msv` DECIMAL(18,2) COMMENT 'Running cumulative effective dose in millisieverts (mSv) for this patient across all prior ionizing radiation imaging studies recorded in the system, including the current study. Supports ALARA principle compliance, radiation safety counseling, and identification of high-dose patients for clinical review.',
    `dap_gy_cm2` DECIMAL(18,2) COMMENT 'Dose Area Product (DAP) in Gy·cm² for fluoroscopy, X-ray angiography, and interventional radiology procedures. Measures total radiation energy delivered to the patient. Primary dose metric for fluoroscopic procedures per IEC 60601-2-43.',
    `dlp_mgy_cm` DECIMAL(18,2) COMMENT 'Dose Length Product (DLP) in mGy·cm for CT studies. Represents the total radiation energy imparted along the scan length. Used with conversion coefficients to estimate effective dose and is the primary metric for ACR DIR CT dose reporting.',
    `dose_alert_flag` BOOLEAN COMMENT 'Indicates whether this study triggered a radiation dose alert based on institutional or regulatory thresholds (e.g., CTDIvol > alert level, fluoroscopy time > 30 min, RAK > 3 Gy). True = alert triggered; False = within normal limits. Supports Joint Commission radiation safety event reporting.',
    `dose_alert_threshold_type` STRING COMMENT 'The specific dose metric that triggered the dose alert, if applicable. Identifies which threshold was exceeded to support targeted clinical review and root cause analysis. not_triggered when dose_alert_flag is False. [ENUM-REF-CANDIDATE: ctdivol|dlp|dap|fluoroscopy_time|rak|effective_dose|not_triggered — 7 candidates stripped; promote to reference product]',
    `dose_alert_value` DECIMAL(18,2) COMMENT 'The numeric threshold value that was exceeded to trigger the dose alert, expressed in the unit of the triggering metric (mGy, mGy·cm, Gy·cm², seconds, or mSv). Supports audit trail for dose safety events.',
    `dose_record_status` STRING COMMENT 'Current lifecycle status of the radiation dose record. preliminary = dose data received but not yet reviewed; final = reviewed and confirmed; amended = corrected after finalization; corrected = technical correction applied; cancelled = study voided.. Valid values are `preliminary|final|amended|corrected|cancelled`',
    `dose_registry_submission_status` STRING COMMENT 'Status of submission of this dose record to the ACR Dose Index Registry (DIR). pending=queued for submission; submitted=transmitted to ACR DIR; accepted=confirmed by ACR DIR; rejected=rejected by ACR DIR (requires correction); not_required=procedure not in DIR scope.. Valid values are `pending|submitted|accepted|rejected|not_required`',
    `dose_registry_submission_timestamp` TIMESTAMP COMMENT 'Date and time when this dose record was submitted to the ACR Dose Index Registry (DIR) or other regulatory dose registry. Supports audit trail for regulatory compliance and CMS quality program reporting.',
    `drl_comparison_result` STRING COMMENT 'Result of comparing the study dose against the applicable national or institutional Diagnostic Reference Level (DRL). below_drl=dose is below the reference level (optimal); at_drl=dose equals reference level; above_drl=dose exceeds reference level (requires review); not_applicable=no DRL defined for this procedure.. Valid values are `below_drl|at_drl|above_drl|not_applicable`',
    `effective_dose_msv` DECIMAL(18,2) COMMENT 'Estimated effective dose in millisieverts (mSv) representing the stochastic risk-weighted whole-body equivalent dose. Derived from DLP × conversion coefficient (k-factor) for CT, or from DAP for fluoroscopy. Used for patient communication, cumulative dose tracking, and ALARA compliance.',
    `entrance_skin_dose_mgy` DECIMAL(18,2) COMMENT 'Entrance skin dose (ESD) in milligray (mGy) for radiographic and fluoroscopic procedures. Represents the absorbed dose at the skin entry point. Critical for radiation injury risk assessment and Joint Commission threshold monitoring.',
    `exceeds_reference_level_flag` BOOLEAN COMMENT 'The exceeds reference level flag of the radiology dose record record.',
    `fluoroscopy_time_sec` DECIMAL(18,2) COMMENT 'Total fluoroscopy beam-on time in seconds for fluoroscopic and interventional procedures. Regulatory threshold monitoring metric; Joint Commission requires tracking and alerting when fluoroscopy time exceeds defined thresholds (e.g., 30 minutes cumulative).',
    `kvp` DECIMAL(18,2) COMMENT 'Peak kilovoltage (kVp) applied to the X-ray tube during the study. Represents the energy of the X-ray beam. Used for dose optimization, protocol review, and physics quality assurance.',
    `modality_type` STRING COMMENT 'DICOM modality code indicating the type of imaging equipment used. CT=Computed Tomography, FL=Fluoroscopy, NM=Nuclear Medicine, DX=Digital Radiography (X-ray), MG=Mammography, XA=X-Ray Angiography, RF=Radiofluoroscopy. Determines applicable dose metrics (CTDIvol/DLP for CT, DAP/fluoroscopy time for fluoroscopy). [ENUM-REF-CANDIDATE: CT|FL|NM|DX|MG|XA|RF|PT|SPECT — promote to reference product]',
    `number_of_exposures` STRING COMMENT 'Total count of individual X-ray exposures (radiographic frames or pulses) delivered during the study. Used for dose optimization analysis and comparison against diagnostic reference levels (DRLs).',
    `patient_age_at_study` STRING COMMENT 'Patient age in whole years at the time of the imaging study. Used for pediatric dose benchmarking (pediatric patients require lower dose protocols), age-stratified DRL comparisons, and ACR DIR age-group reporting. Derived at time of study to avoid recalculation.',
    `patient_size_cm` DECIMAL(18,2) COMMENT 'Patient effective diameter or water-equivalent diameter in centimeters, used for Size-Specific Dose Estimate (SSDE) calculation in CT. Derived from scout/localizer images or patient measurements. Required for AAPM TG-204 SSDE methodology.',
    `patient_weight_kg` DECIMAL(18,2) COMMENT 'Patient body weight in kilograms at the time of the imaging study. Used for size-specific dose estimate (SSDE) calculations for CT, weight-based protocol selection, and dose normalization for benchmarking.',
    `physicist_review_flag` BOOLEAN COMMENT 'Indicates whether this dose record has been flagged for or completed a review by a qualified medical physicist. True = physicist review required or completed; False = no physicist review needed. Triggered by dose alerts, unusual protocol deviations, or regulatory requirements.',
    `physicist_review_timestamp` TIMESTAMP COMMENT 'Date and time when the medical physicist completed the review of this dose record. Null if physicist_review_flag is False or review is pending. Supports compliance audit trail for Joint Commission radiation safety requirements.',
    `procedure_description` STRING COMMENT 'Human-readable description of the imaging procedure performed (e.g., CT Chest with Contrast, Fluoroscopic Guidance for Biopsy). Sourced from the Charge Description Master (CDM) or RIS procedure catalog.',
    `rdsr_uid` STRING COMMENT 'DICOM Radiation Dose Structured Report (RDSR) SOP Instance UID per IEC 61910 standard. Globally unique identifier for the structured dose report generated by the imaging modality. Used for PACS integration and ACR Dose Index Registry (DIR) submission.',
    `recorded_timestamp` TIMESTAMP COMMENT 'The recorded timestamp of the radiology dose record record.',
    `reference_air_kerma_mgy` DECIMAL(18,2) COMMENT 'Reference Air Kerma (RAK) in mGy for interventional fluoroscopy procedures. Measured at the interventional reference point (IRP) per IEC 60601-2-43. Used for radiation injury risk assessment and regulatory threshold compliance.',
    `scanner_manufacturer` STRING COMMENT 'Manufacturer of the imaging equipment used for the study (e.g., Siemens, GE Healthcare, Philips, Canon). Used for equipment-level dose benchmarking, physics QA, and ACR DIR equipment stratification.',
    `scanner_model` STRING COMMENT 'Model name of the imaging equipment used (e.g., SOMATOM Force, Revolution CT, Ingenuity Elite). Used for equipment-specific dose performance tracking and physics quality assurance.',
    `scanner_station_name` STRING COMMENT 'DICOM station name or AE title of the imaging modality that generated the dose data. Used for equipment-level dose tracking, PACS routing, and physics QA within a multi-scanner facility.',
    `ssde_mgy` DECIMAL(18,2) COMMENT 'Size-Specific Dose Estimate (SSDE) in mGy for CT studies, calculated per AAPM TG-204 methodology by applying a size-based conversion factor to CTDIvol. Provides a more accurate patient-specific dose estimate than CTDIvol alone. Used for pediatric dose optimization and ACR DIR advanced reporting.',
    `study_date` DATE COMMENT 'Calendar date on which the imaging study was performed. Principal business event date for dose record. Used for trending, regulatory reporting, and cumulative dose period calculations.',
    `study_instance_uid` STRING COMMENT 'DICOM Study Instance UID uniquely identifying the imaging study in the PACS (Picture Archiving and Communication System). Enables direct linkage between dose records and DICOM image metadata for audit and regulatory reporting.',
    `study_timestamp` TIMESTAMP COMMENT 'Precise date and time the imaging study was performed, including timezone offset. Used for intraday workflow analysis, dose alert timing, and RDSR correlation.',
    `tube_current_mas` DECIMAL(18,2) COMMENT 'X-ray tube current-time product in milliampere-seconds (mAs) for the study. Directly influences radiation dose output. Used for protocol optimization and dose benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this dose record was last modified in the source system or Silver layer. Used for incremental ETL processing, change data capture, and audit trail maintenance.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology dose record record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_dose_record PRIMARY KEY(`dose_record_id`)
) COMMENT 'Captures radiation dose metrics for each imaging study involving ionizing radiation (CT, fluoroscopy, nuclear medicine, X-ray). Stores CTDIvol, DLP (Dose Length Product), effective dose estimate (mSv), DAP for fluoroscopy, fluoroscopy time, number of exposures, dose reference level comparison, dose alert flags, RDSR (Radiation Dose Structured Report) UID per IEC 61910 standard, and cumulative patient dose tracking. SSOT for radiation exposure documentation. Supports ACR Dose Index Registry (DIR) reporting, Joint Commission radiation safety requirements, CMS quality programs, and ALARA principle compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` (
    `radiology_appointment_id` BIGINT COMMENT 'Primary key for appointment',
    `material_master_id` BIGINT COMMENT 'Link to material/supply administered during appointment',
    `appointment_type_id` BIGINT COMMENT 'Type of appointment (office visit, procedure, etc)',
    `care_plan_id` BIGINT COMMENT 'Associated care plan if appointment is part of care coordination',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, outpatient imaging center, clinic) where the imaging appointment is scheduled to take place.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Imaging appointments fulfill clinical orders. Scheduling workflows require linking appointments to orders for prep instruction delivery, authorization verification, and patient communication. Operatio',
    `demographics_id` BIGINT COMMENT 'Patient demographic information',
    `diagnosis_id` BIGINT COMMENT 'Primary diagnosis for appointment',
    `eligibility_id` BIGINT COMMENT 'Insurance eligibility verification',
    `employee_id` BIGINT COMMENT 'Reference to the radiology technologist (RT) assigned to perform the imaging study for this appointment. Used for staffing, productivity tracking, and quality assurance.',
    `encounter_authorization_id` BIGINT COMMENT 'Authorization for the encounter',
    `member_enrollment_id` BIGINT COMMENT 'Member enrollment record',
    `modality_id` BIGINT COMMENT 'Unique identifier for the modality within the radiology radiology appointment record.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient receiving the imaging service. Serves as the PARTY_REFERENCE for this transaction, linking to the patient master record.',
    `payer_id` BIGINT COMMENT 'Insurance payer',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who placed the imaging order that generated this appointment. Used for referral tracking, utilization management, and RVU attribution.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Appointments are scheduled for specific CPT-coded procedures to enable resource allocation, exam duration estimation, and scheduling template management. Links support capacity planning and utilizatio',
    `radiology_clinician_id` BIGINT COMMENT 'Primary clinician for the appointment',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Appointments carry diagnosis codes for prior authorization verification at scheduling time, support medical necessity screening, and enable diagnosis-based appointment prioritization for urgent condit',
    `room_id` BIGINT COMMENT 'Reference to the specific imaging room or scanner unit assigned for this appointment. Enables room-level utilization tracking, maintenance scheduling, and capacity management.',
    `radiology_room_id` BIGINT COMMENT 'Room assigned for appointment',
    `radiology_visit_reason_icd_code_id` BIGINT COMMENT 'ICD code for visit reason',
    `referral_order_id` BIGINT COMMENT 'Referral order if appointment is from referral',
    `research_study_id` BIGINT COMMENT 'Research study if appointment is study-related',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Research imaging appointments are scheduled per protocol visit schedules. Direct linkage to subject enrollment enables protocol compliance tracking, visit window adherence monitoring, and research bil',
    `tertiary_radiology_referring_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who referred the patient for this imaging study, which may differ from the ordering provider. Used for referral analytics, network management, and payer reporting.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit associated with this imaging appointment. Connects the radiology scheduling event to the broader patient visit context.',
    `org_unit_id` BIGINT COMMENT 'Organizational unit responsible for appointment',
    `enterprise_appointment_id` BIGINT COMMENT 'Reference to the parent enterprise scheduling appointment record. Links this radiology-specific scheduling record to the general enterprise scheduling infrastructure.',
    `scheduling_appointment_id` BIGINT COMMENT 'Unique identifier for the appointment record',
    `accession_number` STRING COMMENT 'Unique identifier assigned by the Radiology Information System (RIS) to this imaging study appointment. Used as the primary cross-system identifier linking the RIS, PACS, and EHR for this imaging event. Conforms to DICOM accession number format.',
    `actual_end_datetime` TIMESTAMP COMMENT 'The actual date and time the imaging procedure concluded. Combined with actual_start_datetime to compute actual procedure duration for throughput and capacity analytics.',
    `actual_start_datetime` TIMESTAMP COMMENT 'The actual date and time the imaging procedure began (patient on table / scan initiated). Used to measure schedule adherence, wait times, and operational efficiency.',
    `appointment_comment` STRING COMMENT 'Free-text clinical or operational notes associated with the imaging appointment (e.g., special patient needs, equipment requirements, interpreter needed, claustrophobia notes for MRI). Not intended for clinical documentation.',
    `appointment_domain` STRING COMMENT 'Domain discriminator: RADIOLOGY or SCHEDULING',
    `appointment_number` STRING COMMENT 'Human-readable appointment identifier',
    `appointment_scope` STRING COMMENT 'The appointment scope of the radiology radiology appointment record.',
    `appointment_status` STRING COMMENT 'Current workflow state of the radiology imaging appointment. Tracks the full lifecycle from initial scheduling through completion or cancellation. Aligns with IHE SWF appointment status codes.. Valid values are `scheduled|arrived|in_progress|completed|cancelled|no_show`',
    `appointment_type` STRING COMMENT 'Clinical classification of the imaging appointment indicating the urgency and purpose of the study. Drives scheduling priority, slot allocation, and workflow routing. [ENUM-REF-CANDIDATE: routine|urgent|stat|screening|follow_up|pre_op|research — promote to reference product if additional types are needed]',
    `arrival_timestamp` TIMESTAMP COMMENT 'Timestamp when patient arrived',
    `auth_status` STRING COMMENT 'Current status of the insurance pre-authorization for this imaging appointment. Drives scheduling holds, revenue cycle workflows, and denial management processes.. Valid values are `approved|pending|denied|not_required|expired`',
    `billing_eligibility_flag` BOOLEAN COMMENT 'Whether appointment is billable',
    `body_part` STRING COMMENT 'The anatomical region or body part targeted by the imaging study (e.g., CHEST, ABDOMEN, BRAIN, KNEE). Aligns with DICOM Body Part Examined attribute and SNOMED CT anatomical terminology.',
    `booking_channel` STRING COMMENT 'Channel used to book (phone, portal, walk-in)',
    `booking_timestamp` TIMESTAMP COMMENT 'When appointment was booked',
    `cancellation_reason` STRING COMMENT 'The documented reason for appointment cancellation when appointment_status is cancelled. Used for operational analytics, capacity recovery, and patient access improvement initiatives.',
    `cancellation_reason_code` STRING COMMENT 'Coded cancellation reason',
    `cancellation_timestamp` TIMESTAMP COMMENT 'When appointment was cancelled',
    `cancelled_by` STRING COMMENT 'User who cancelled appointment',
    `care_setting` STRING COMMENT 'Care setting (ambulatory, inpatient, ED)',
    `check_in_timestamp` TIMESTAMP COMMENT 'When patient checked in',
    `clinical_indication` STRING COMMENT 'The clinical reason or indication for the imaging study as documented by the ordering provider. Contains PHI and is used for clinical decision support, ACR appropriateness criteria evaluation, and CDI.',
    `confirmation_status` STRING COMMENT 'The confirmation status value classifying the radiology radiology appointment record.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'When appointment was confirmed',
    `contrast_required` BOOLEAN COMMENT 'Indicates whether intravenous or oral contrast agent is required for this imaging study. Drives pre-appointment prep instructions, allergy screening, renal function checks, and contrast timing workflows.',
    `contrast_type` STRING COMMENT 'The route of contrast agent administration planned for this imaging study. Used for pre-procedure preparation, patient safety screening, and contrast administration documentation.. Valid values are `IV|oral|intrathecal|intra_articular|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this imaging appointment record was first created in the system. Serves as the audit creation timestamp for data lineage, compliance, and change tracking.',
    `duration_minutes` STRING COMMENT 'Appointment duration in minutes',
    `end_timestamp` TIMESTAMP COMMENT 'Appointment end time',
    `insurance_verification_status` STRING COMMENT 'The insurance verification status value classifying the radiology radiology appointment record.',
    `insurance_verification_timestamp` TIMESTAMP COMMENT 'When insurance was verified',
    `is_portable` BOOLEAN COMMENT 'Indicates whether the imaging study is to be performed at the patients bedside or location (portable) rather than in a dedicated imaging room. Affects equipment assignment and technologist dispatch.',
    `is_stat` BOOLEAN COMMENT 'Indicates whether this imaging appointment was ordered as STAT (immediate/urgent priority), requiring expedited scheduling and turnaround. Drives workflow prioritization in the RIS and PACS.',
    `laterality` STRING COMMENT 'Specifies the side of the body for the imaging study when applicable (left, right, bilateral). Critical for patient safety, correct-site imaging compliance, and DICOM metadata accuracy.. Valid values are `left|right|bilateral|not_applicable`',
    `modality_type` STRING COMMENT 'The type of imaging modality assigned for this appointment (e.g., CT, MRI, X-ray, Ultrasound, PET). Core radiology scheduling attribute that determines equipment, room, and technologist assignment. Uses DICOM modality codes. [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|DXA|DEXA — promote to reference product]',
    `no_show_flag` BOOLEAN COMMENT 'Whether patient was a no-show',
    `no_show_reason` STRING COMMENT 'The documented reason the patient did not appear for the scheduled imaging appointment when appointment_status is no_show. Used for patient outreach, access analytics, and population health management.',
    `pacs_study_uid` STRING COMMENT 'The globally unique DICOM Study Instance UID assigned by the PACS for the imaging study associated with this appointment. Enables direct linkage between the scheduling record and the DICOM image archive.. Valid values are `^[0-9]+(.[0-9]+)+$`',
    `patient_device_type` STRING COMMENT 'Device type for telehealth',
    `patient_location` STRING COMMENT 'The patients physical location at the time of the imaging appointment (e.g., inpatient unit/bed, ED bay, outpatient clinic, external). Used for transport coordination and portable imaging dispatch.',
    `prep_instructions` STRING COMMENT 'Specific pre-appointment preparation instructions communicated to the patient (e.g., NPO after midnight, bowel prep, hydration requirements, medication holds). Critical for imaging quality and patient safety.',
    `prior_auth_number` STRING COMMENT 'The pre-authorization or prior authorization reference number obtained from the patients insurance payer before the imaging study. Required for reimbursement and revenue cycle management. Null if authorization not required or not yet obtained.',
    `priority` STRING COMMENT 'Appointment priority',
    `procedure_description` STRING COMMENT 'Human-readable description of the imaging procedure to be performed, corresponding to the CPT code. Used for patient communication, scheduling displays, and clinical documentation.',
    `provider_attestation_flag` BOOLEAN COMMENT 'Provider attestation completed',
    `radiation_dose_flag` BOOLEAN COMMENT 'Indicates whether radiation dose tracking is required for this imaging appointment (applicable to CT, fluoroscopy, nuclear medicine, and other ionizing radiation modalities). Drives dose monitoring workflows per ACR and Joint Commission requirements.',
    `record_number` BIGINT COMMENT 'Consent record for appointment',
    `reschedule_count` STRING COMMENT 'The number of times this imaging appointment has been rescheduled. Used to identify access barriers, patient compliance issues, and scheduling inefficiencies.',
    `ris_appointment_code` STRING COMMENT 'The native appointment identifier from the source Radiology Information System (RIS) such as Epic Radiant or Cerner RadNet. Used for cross-system reconciliation and ETL lineage tracking.',
    `roomed_timestamp` TIMESTAMP COMMENT 'When patient was roomed',
    `scheduled_date` DATE COMMENT 'Timestamp capturing the scheduled date associated with the radiology radiology appointment record.',
    `scheduled_duration_minutes` STRING COMMENT 'The planned duration of the imaging appointment in minutes as defined at time of scheduling. Drives modality slot blocking, throughput analysis, and schedule optimization.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'The planned date and time the imaging appointment is expected to conclude. Used with scheduled_start_datetime to determine the reserved slot duration on the modality schedule.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Timestamp capturing the scheduled end time associated with the radiology radiology appointment record.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'The planned date and time the imaging appointment is scheduled to begin. Serves as the principal business event timestamp for scheduling analytics, capacity planning, and patient communication.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Timestamp capturing the scheduled start time associated with the radiology radiology appointment record.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'The scheduled timestamp of the radiology radiology appointment record.',
    `scheduling_source` STRING COMMENT 'The channel or source through which this imaging appointment was scheduled. Used for access analytics, referral management, and patient experience reporting.. Valid values are `provider_referral|patient_self|order_based|transfer|walk_in|portal`',
    `ssot_reference` STRING COMMENT 'The ssot reference of the radiology radiology appointment record.',
    `start_timestamp` TIMESTAMP COMMENT 'Actual start time',
    `telehealth_access_code` STRING COMMENT 'Access code for telehealth session',
    `telehealth_connection_status` STRING COMMENT 'The telehealth connection status value classifying the radiology radiology appointment record.',
    `telehealth_platform` STRING COMMENT 'Telehealth platform used',
    `telehealth_session_url` STRING COMMENT 'URL for telehealth session',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this imaging appointment record was most recently modified. Used for incremental ETL processing, audit trails, and change data capture in the lakehouse pipeline.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology radiology appointment record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `visit_modality` STRING COMMENT 'Visit modality (in-person, telehealth, phone)',
    `visit_reason` STRING COMMENT 'Reason for visit',
    `visit_reason_code` STRING COMMENT 'Coded visit reason',
    CONSTRAINT pk_radiology_appointment PRIMARY KEY(`radiology_appointment_id`)
) COMMENT 'SSOT resolved: defer to scheduling.scheduling_appointment as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` (
    `reader_assignment_id` BIGINT COMMENT 'Primary key for reader_assignment',
    `care_site_id` BIGINT COMMENT 'Reference to the facility (hospital, imaging center, outpatient clinic) where the imaging study was performed. Used for facility-level TAT reporting, worklist segmentation, and operational analytics.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Radiologist assignments track CPT codes for workload balancing by procedure complexity, RVU-based productivity measurement, and subspecialty matching. Essential for radiologist compensation and staffi',
    `clinician_id` BIGINT COMMENT 'Reference to the radiologist or reading provider assigned to interpret the imaging study. May reference an internal clinician or a teleradiology vendor reader.',
    `prior_assignment_reader_assignment_id` BIGINT COMMENT 'Reference to the previous reader_assignment record when this record represents a reassignment or second read. Enables chaining of assignment history for a single imaging study to support audit trails and TAT analysis.',
    `radiology_study_id` BIGINT COMMENT 'Reference to the imaging study (accession) to which this reader assignment applies. Links the assignment to the specific diagnostic imaging order and PACS study.',
    `report_id` BIGINT COMMENT 'Reference to the finalized radiology report generated as the output of this reader assignment. Links the assignment record to the report document in the RIS/PACS or clinical documentation system.',
    `stark_arrangement_id` BIGINT COMMENT 'Foreign key linking to compliance.stark_arrangement. Business justification: Radiologist reading assignments, especially teleradiology and overread arrangements, may involve Stark-regulated compensation. Compliance monitors whether assignment-based compensation meets fair mark',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter (visit) associated with the imaging study being assigned for interpretation. Supports linkage to ADT and clinical context.',
    `accession_number` STRING COMMENT 'The RIS-assigned accession number uniquely identifying the imaging study within the radiology information system. Used as the primary business identifier for the study in Epic Radiant, Cerner RadNet, and PACS/DICOM workflows.',
    `addendum_flag` BOOLEAN COMMENT 'Indicates whether an addendum was appended to the original radiology report after initial signing. True if an addendum exists; False otherwise. Supports HIM audit trails and clinical documentation integrity.',
    `addendum_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent addendum was added to the radiology report. Populated only when addendum_flag is True. Used for HIM documentation tracking and clinical audit.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist was formally assigned to the imaging study. Serves as the start of the turnaround time (TAT) clock for SLA measurement. Stored in ISO 8601 format with timezone offset.',
    `assignment_source` STRING COMMENT 'Mechanism by which the radiologist was assigned to the study. Values: worklist_auto (RIS auto-assignment algorithm), manual (dispatcher or radiologist self-assignment), teleradiology_vendor (routed to external vendor), ai_routing (AI-assisted worklist routing), escalation (escalated from prior assignment). [ENUM-REF-CANDIDATE: worklist_auto|manual|teleradiology_vendor|ai_routing|escalation|stat_escalation|protocol_override — promote to reference product if values expand]. Valid values are `worklist_auto|manual|teleradiology_vendor|ai_routing|escalation`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the reader assignment. Values: assigned (radiologist notified, not yet started), in_progress (read actively underway), completed (report finalized), cancelled (assignment voided), reassigned (transferred to another reader), pending (awaiting routing confirmation).. Valid values are `assigned|in_progress|completed|cancelled|reassigned|pending`',
    `assignment_type` STRING COMMENT 'Classification of the reader assignment indicating the role of the radiologist relative to the study. Values: primary_read (initial interpretation), second_read (confirmatory read), peer_review (quality/audit read), overread (supervisory review), teleradiology (remote vendor read).. Valid values are `primary_read|second_read|peer_review|overread|teleradiology`',
    `body_part` STRING COMMENT 'Anatomical body part or region examined in the imaging study, as coded in the RIS/PACS. Used for subspecialty routing, worklist filtering, and subspecialty match validation. Aligns with SNOMED CT anatomical site codes.',
    `completed_timestamp` TIMESTAMP COMMENT 'The completed timestamp of the radiology reader assignment record.',
    `contrast_used` BOOLEAN COMMENT 'Indicates whether contrast agent was administered during the imaging study. True if contrast was used; False for non-contrast studies. Relevant for CPT code selection, billing, and clinical interpretation context.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the reader assignment record was first created in the RIS or data platform. Serves as the audit trail creation timestamp per HIPAA and TJC record-keeping requirements.',
    `critical_finding_flag` BOOLEAN COMMENT 'Indicates whether the radiologist identified a critical or urgent finding during interpretation that requires immediate clinical communication per ACR and TJC standards. True if a critical finding was flagged; False otherwise. Drives critical result notification workflows.',
    `critical_finding_notified_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist or RIS system notified the ordering provider of a critical imaging finding. Required for TJC and ACR compliance documentation. Populated only when critical_finding_flag is True.',
    `dictation_method` STRING COMMENT 'Method used by the radiologist to generate the report for this assignment. Values: voice_recognition (real-time speech-to-text, e.g., Nuance PowerScribe), manual_transcription (transcriptionist-assisted), structured_reporting (form-based structured data entry), template (pre-built report template).. Valid values are `voice_recognition|manual_transcription|structured_reporting|template`',
    `image_count` STRING COMMENT 'Total number of DICOM image instances in the imaging study at the time of assignment. Used as a proxy for study complexity in radiologist workload and productivity analysis.',
    `is_teleradiology` BOOLEAN COMMENT 'Indicates whether this assignment was routed to an external teleradiology vendor rather than an internal radiologist. True for teleradiology assignments; False for internal reads. Drives vendor SLA tracking and billing differentiation.',
    `modality` STRING COMMENT 'The imaging modality of the study being assigned for interpretation. Standard DICOM modality codes: CT (Computed Tomography), MRI (Magnetic Resonance Imaging), XR/DX/CR (X-ray), US (Ultrasound), PET (Positron Emission Tomography), NM (Nuclear Medicine), MG (Mammography), FL (Fluoroscopy). [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|NM|MG|FL|DX|CR|DEXA|OT — promote to reference product]',
    `pacs_study_uid` STRING COMMENT 'The globally unique DICOM Study Instance UID used to identify and retrieve the imaging study in the PACS. Enables direct linkage between the RIS assignment record and the PACS image archive for worklist integration and image retrieval.. Valid values are `^[0-9]+(.[0-9]+)+$`',
    `peer_review_category` STRING COMMENT 'Categorical classification of the peer review outcome indicating the level of agreement or discrepancy between the primary read and the peer reviewers interpretation. Supports quality improvement programs and radiologist performance monitoring.. Valid values are `agree|minor_discrepancy|significant_discrepancy|major_discrepancy`',
    `peer_review_score` STRING COMMENT 'Radiologist peer review quality score assigned during a peer review or overread assignment. Typically uses the ACR RADPEER scoring scale (1=agree, 2=minor discrepancy, 3=significant discrepancy, 4=major discrepancy). Populated only for peer_review and overread assignment types.. Valid values are `1|2|3|4|5`',
    `priority` STRING COMMENT 'Clinical priority level assigned to the imaging study read, driving worklist ordering and SLA target selection. Values: stat (immediate, life-threatening), urgent (expedited, clinically time-sensitive), routine (standard queue), scheduled (pre-planned elective read).. Valid values are `stat|urgent|routine|scheduled`',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT 'Dose Length Product (DLP) in mGy·cm recorded for CT studies, representing the total radiation dose delivered during the imaging acquisition. Used for radiation dose tracking, ACR Dose Index Registry reporting, and patient safety compliance.',
    `read_complete_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist completed the interpretation and the report was finalized or signed. Used as the end point for TAT SLA calculation.',
    `read_start_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist opened and began actively interpreting the imaging study in PACS or the RIS worklist. Used to measure time-to-read and radiologist productivity.',
    `reading_site` STRING COMMENT 'Physical or virtual location from which the radiologist performed the interpretation (e.g., on-site reading room, remote home workstation, teleradiology hub). Distinct from the imaging facility; captures where the read occurred.',
    `reassignment_reason` STRING COMMENT 'Free-text or coded reason why the study was reassigned from the originally assigned radiologist to another reader. Examples include radiologist unavailability, subspecialty escalation, conflict of interest, or workload rebalancing. Populated only when assignment_status is reassigned.',
    `report_signed_timestamp` TIMESTAMP COMMENT 'Date and time when the radiologist electronically signed and authenticated the final radiology report. Distinct from read_complete_timestamp as signing may occur after dictation/transcription. Supports HIM and compliance audit requirements.',
    `rvu_value` DECIMAL(18,2) COMMENT 'The total Relative Value Unit (RVU) assigned to the CPT code for this interpretation, sourced from the CMS Physician Fee Schedule. Used for radiologist productivity measurement, compensation modeling, and departmental workload reporting.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the reader assignment was completed within the applicable SLA target turnaround time. True if tat_minutes is less than or equal to sla_target_minutes; False otherwise. Supports SLA compliance dashboards and vendor performance management.',
    `sla_target_minutes` STRING COMMENT 'The contractual or operational SLA target turnaround time in minutes applicable to this assignment, based on study priority, modality, and assignment type. Sourced from the applicable SLA contract or internal policy at time of assignment.',
    `subspecialty_match` BOOLEAN COMMENT 'Indicates whether the assigned radiologists subspecialty certification matches the subspecialty required for the imaging study. True if matched; False if assigned outside subspecialty (e.g., general radiologist reading a neuroradiology study). Supports quality and credentialing compliance reporting.',
    `subspecialty_required` STRING COMMENT 'The radiologist subspecialty required to interpret this imaging study (e.g., neuroradiology, musculoskeletal, breast imaging, interventional, nuclear medicine). Drives subspecialty-based worklist routing and teleradiology vendor selection.',
    `tat_minutes` STRING COMMENT 'Calculated turnaround time in minutes from study assignment to report completion. Stored as a pre-computed operational field (not a KPI aggregate) to support SLA compliance monitoring and worklist management without requiring real-time computation.',
    `teleradiology_routing_reason` STRING COMMENT 'Business reason why the study was routed to a teleradiology vendor rather than read internally. Values: after_hours (no internal radiologist available), subspecialty_gap (required subspecialty not available internally), volume_overflow (worklist capacity exceeded), coverage_gap (scheduled radiologist absent), stat_backup (emergency backup coverage).. Valid values are `after_hours|subspecialty_gap|volume_overflow|coverage_gap|stat_backup`',
    `teleradiology_vendor_name` STRING COMMENT 'Name of the external teleradiology vendor to whom the study was routed for interpretation. Populated only when is_teleradiology is True. Used for vendor performance management and contract SLA tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the reader assignment record was most recently modified. Supports change data capture (CDC) in the Databricks Silver Layer ETL pipeline and audit trail requirements.',
    `vendor_accession_number` STRING COMMENT 'The accession number assigned by the teleradiology vendors RIS to the study. Used for cross-referencing the internal RIS accession number with the vendors system for report reconciliation and image retrieval.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology reader assignment record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `worklist_code` STRING COMMENT 'Identifier of the RIS worklist queue from which this assignment was generated or pulled. Used to trace the assignment back to its originating worklist configuration for routing audit and performance analysis.',
    CONSTRAINT pk_reader_assignment PRIMARY KEY(`reader_assignment_id`)
) COMMENT 'Association record linking a radiologist (or teleradiology vendor) to an imaging study for interpretation. Captures assignment type (primary reader, second read, peer review, overread, teleradiology), assignment source (worklist auto-assign, manual, teleradiology vendor), vendor details when applicable (vendor name, contract ID, routing reason, vendor accession number), assignment/read start/completion datetimes, turnaround time, subspecialty match, SLA compliance, and assignment status. SSOT for radiologist-to-study assignment including teleradiology routing. Supports worklist management, TAT SLA tracking, teleradiology vendor SLA management, and radiologist productivity reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` (
    `critical_result_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to facility care site',
    `clinical_order_id` BIGINT COMMENT 'FK to clinical order',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the critical notifying clinician within the radiology critical result record.',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics',
    `employee_id` BIGINT COMMENT 'FK to workforce employee',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `message_log_id` BIGINT COMMENT 'FK to message log',
    `org_unit_id` BIGINT COMMENT 'FK to org unit',
    `primary_critical_clinician_id` BIGINT COMMENT 'FK to clinician who identified critical result',
    `radiology_study_id` BIGINT COMMENT 'Unique identifier for the radiology study within the radiology critical result record.',
    `report_id` BIGINT COMMENT 'FK to radiology report',
    `subject_enrollment_id` BIGINT COMMENT 'FK to research subject enrollment',
    `tertiary_critical_ordering_provider_clinician_id` BIGINT COMMENT 'FK to ordering provider',
    `visit_id` BIGINT COMMENT 'FK to encounter visit',
    `accession_number` STRING COMMENT 'Radiology accession number',
    `acknowledged_flag` BOOLEAN COMMENT 'The acknowledged flag of the radiology critical result record.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'The acknowledged timestamp of the radiology critical result record.',
    `acknowledgment_datetime` TIMESTAMP COMMENT 'When critical result was acknowledged',
    `acknowledgment_method` STRING COMMENT 'Method of acknowledgment',
    `acknowledgment_turnaround_minutes` STRING COMMENT 'Minutes from notification to acknowledgment',
    `body_part_examined` STRING COMMENT 'The body part examined of the radiology critical result record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `dicom_study_uid` STRING COMMENT 'The dicom study uid of the radiology critical result record.',
    `emtala_applicable` BOOLEAN COMMENT 'Whether EMTALA applies',
    `escalation_datetime` TIMESTAMP COMMENT 'When escalation occurred',
    `escalation_flag` BOOLEAN COMMENT 'Whether result was escalated',
    `escalation_reason` STRING COMMENT 'Reason for escalation',
    `finding_category` STRING COMMENT 'Category of critical finding',
    `finding_datetime` TIMESTAMP COMMENT 'When finding was identified',
    `finding_description` STRING COMMENT 'Description of critical finding',
    `finding_severity` STRING COMMENT 'Severity of finding',
    `modality` STRING COMMENT 'Imaging modality',
    `mrn` STRING COMMENT 'Medical record number',
    `notification_attempt_count` STRING COMMENT 'Number of notification attempts',
    `notification_datetime` TIMESTAMP COMMENT 'When notification was sent',
    `notification_method` STRING COMMENT 'Method of notification',
    `notification_status` STRING COMMENT 'Status of notification',
    `notification_turnaround_minutes` STRING COMMENT 'Minutes from finding to notification',
    `notified_provider_npi` STRING COMMENT 'NPI of notified provider',
    `notified_timestamp` TIMESTAMP COMMENT 'The notified timestamp of the radiology critical result record.',
    `pacs_system_name` STRING COMMENT 'The pacs system name of the radiology critical result record.',
    `patient_care_setting` STRING COMMENT 'The patient care setting of the radiology critical result record.',
    `patient_location_at_notification` STRING COMMENT 'Patient location when notified',
    `patient_safety_event_flag` BOOLEAN COMMENT 'Whether this is a patient safety event',
    `radiologist_npi` STRING COMMENT 'NPI of radiologist',
    `read_back_notes` STRING COMMENT 'The read back notes of the radiology critical result record.',
    `read_back_performed` BOOLEAN COMMENT 'Whether read-back was performed',
    `report_status_at_notification` STRING COMMENT 'Report status at time of notification',
    `tjc_compliance_status` STRING COMMENT 'The tjc compliance status value classifying the radiology critical result record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_critical_result PRIMARY KEY(`critical_result_id`)
) COMMENT 'Tracks the communication workflow for critical and significant radiology findings requiring immediate clinical action per Joint Commission NPSG.02.03.01. Records finding description, severity level (critical, significant, incidental), notification method (phone, secure message, EHR alert), notified provider NPI, notification datetime, acknowledgment datetime, acknowledgment method, escalation flag, escalation datetime, and Joint Commission compliance status. Supports EMTALA compliance, TJC accreditation requirements, and patient safety event tracking. Aligns with HL7 FHIR CommunicationRequest resource for critical result notification workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` (
    `teleradiology_case_id` BIGINT COMMENT 'Primary key',
    `business_associate_agreement_id` BIGINT COMMENT 'Unique identifier for the business associate agreement within the radiology teleradiology case record.',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `employee_id` BIGINT COMMENT 'FK to case coordinator',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `message_log_id` BIGINT COMMENT 'FK to message log',
    `payer_contract_id` BIGINT COMMENT 'FK to payer contract',
    `radiology_study_id` BIGINT COMMENT 'Unique identifier for the radiology study within the radiology teleradiology case record.',
    `stark_arrangement_id` BIGINT COMMENT 'FK to Stark arrangement',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `teleradiology_reading_clinician_id` BIGINT COMMENT 'Unique identifier for the teleradiology reading clinician within the radiology teleradiology case record.',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `accession_number` STRING COMMENT 'The accession number of the radiology teleradiology case record.',
    `actual_tat_minutes` STRING COMMENT 'Actual turnaround time in minutes',
    `billing_responsibility` STRING COMMENT 'The billing responsibility of the radiology teleradiology case record.',
    `body_part` STRING COMMENT 'The body part of the radiology teleradiology case record.',
    `case_status` STRING COMMENT 'The case status value classifying the radiology teleradiology case record.',
    `clinical_indication` STRING COMMENT 'The clinical indication of the radiology teleradiology case record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_finding_flag` BOOLEAN COMMENT 'Whether critical finding present',
    `critical_finding_notified_datetime` TIMESTAMP COMMENT 'When critical finding was notified',
    `dicom_study_uid` STRING COMMENT 'The dicom study uid of the radiology teleradiology case record.',
    `discrepancy_category` STRING COMMENT 'The discrepancy category of the radiology teleradiology case record.',
    `expected_tat_minutes` STRING COMMENT 'Expected turnaround time',
    `final_report_datetime` TIMESTAMP COMMENT 'Timestamp capturing the final report datetime associated with the radiology teleradiology case record.',
    `final_report_text` STRING COMMENT 'The final report text of the radiology teleradiology case record.',
    `interpretation_start_datetime` TIMESTAMP COMMENT 'When interpretation started',
    `interpreting_radiologist_name` STRING COMMENT 'The interpreting radiologist name of the radiology teleradiology case record.',
    `interpreting_radiologist_npi` STRING COMMENT 'The interpreting radiologist npi of the radiology teleradiology case record.',
    `modality_code` STRING COMMENT 'The modality code value classifying the radiology teleradiology case record.',
    `mrn` STRING COMMENT 'Medical record number',
    `number_of_images` STRING COMMENT 'The number of images of the radiology teleradiology case record.',
    `number_of_series` STRING COMMENT 'The number of series of the radiology teleradiology case record.',
    `preliminary_report_datetime` TIMESTAMP COMMENT 'Timestamp capturing the preliminary report datetime associated with the radiology teleradiology case record.',
    `preliminary_report_text` STRING COMMENT 'The preliminary report text of the radiology teleradiology case record.',
    `priority_level` STRING COMMENT 'The priority level of the radiology teleradiology case record.',
    `professional_component_billed` BOOLEAN COMMENT 'Whether professional component billed',
    `reconciliation_datetime` TIMESTAMP COMMENT 'Timestamp capturing the reconciliation datetime associated with the radiology teleradiology case record.',
    `reconciliation_discrepancy_flag` BOOLEAN COMMENT 'Whether reconciliation discrepancy exists',
    `report_reconciliation_status` STRING COMMENT 'The report reconciliation status value classifying the radiology teleradiology case record.',
    `retransmission_count` STRING COMMENT 'Number of retransmissions',
    `routing_reason` STRING COMMENT 'Reason for routing',
    `sent_timestamp` TIMESTAMP COMMENT 'The sent timestamp of the radiology teleradiology case record.',
    `sla_met` BOOLEAN COMMENT 'Whether SLA was met',
    `study_datetime` TIMESTAMP COMMENT 'Timestamp capturing the study datetime associated with the radiology teleradiology case record.',
    `subspecialty_required` STRING COMMENT 'Required subspecialty',
    `transmission_datetime` TIMESTAMP COMMENT 'Timestamp capturing the transmission datetime associated with the radiology teleradiology case record.',
    `transmission_method` STRING COMMENT 'The transmission method of the radiology teleradiology case record.',
    `transmission_success` BOOLEAN COMMENT 'Whether transmission succeeded',
    `turnaround_minutes` STRING COMMENT 'The turnaround minutes of the radiology teleradiology case record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vendor_accession_number` STRING COMMENT 'The vendor accession number of the radiology teleradiology case record.',
    `vendor_receipt_datetime` TIMESTAMP COMMENT 'Timestamp capturing the vendor receipt datetime associated with the radiology teleradiology case record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_teleradiology_case PRIMARY KEY(`teleradiology_case_id`)
) COMMENT 'Manages imaging studies routed to teleradiology vendors or remote radiologists for after-hours, subspecialty, or overflow interpretation. Captures vendor name, vendor contract ID, routing reason (after-hours, subspecialty, overflow), transmission datetime, vendor accession number, expected TAT (turnaround time), actual TAT, preliminary report received datetime, final report received datetime, report reconciliation status, and billing responsibility (professional component ownership). Supports teleradiology vendor SLA management and report reconciliation workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` (
    `follow_up_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to care coordinator',
    `clinical_order_id` BIGINT COMMENT 'FK to clinical order',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `report_id` BIGINT COMMENT 'FK to radiology report',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the follow recommending clinician within the radiology follow up record.',
    `follow_report_id` BIGINT COMMENT 'Unique identifier for the follow report within the radiology follow up record.',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `primary_follow_clinician_id` BIGINT COMMENT 'FK to follow-up clinician',
    `prior_auth_rule_id` BIGINT COMMENT 'FK to prior auth rule',
    `radiology_finding_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_finding. Business justification: follow_up tracks actionable follow-up recommendations generated from radiology findings (esp. incidental findings). radiology_finding is the SSOT for imaging findings with ACR scoring and follow-up fl',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `acr_category_code` STRING COMMENT 'The acr category code value classifying the radiology follow up record.',
    `acr_guideline_reference` STRING COMMENT 'The acr guideline reference of the radiology follow up record.',
    `care_gap_flag` BOOLEAN COMMENT 'Whether care gap exists',
    `cms_quality_measure_flag` BOOLEAN COMMENT 'Whether CMS quality measure applies',
    `completed_date` DATE COMMENT 'Timestamp capturing the completed date associated with the radiology follow up record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `declined_reason` STRING COMMENT 'Reason for decline',
    `due_date` DATE COMMENT 'Timestamp capturing the due date associated with the radiology follow up record.',
    `escalation_flag` BOOLEAN COMMENT 'Whether escalated',
    `escalation_reason` STRING COMMENT 'The escalation reason of the radiology follow up record.',
    `escalation_timestamp` TIMESTAMP COMMENT 'The escalation timestamp of the radiology follow up record.',
    `finding_body_region` STRING COMMENT 'The finding body region of the radiology follow up record.',
    `finding_category_code` STRING COMMENT 'The finding category code value classifying the radiology follow up record.',
    `finding_description` STRING COMMENT 'The finding description of the radiology follow up record.',
    `follow_up_status` STRING COMMENT 'The follow up status value classifying the radiology follow up record.',
    `lost_to_follow_up_date` DATE COMMENT 'Timestamp capturing the lost to follow up date associated with the radiology follow up record.',
    `ordering_provider_notification_status` STRING COMMENT 'The ordering provider notification status value classifying the radiology follow up record.',
    `ordering_provider_notification_timestamp` TIMESTAMP COMMENT 'The ordering provider notification timestamp of the radiology follow up record.',
    `pacs_study_instance_uid` STRING COMMENT 'The pacs study instance uid of the radiology follow up record.',
    `patient_notification_method` STRING COMMENT 'The patient notification method of the radiology follow up record.',
    `patient_notification_status` STRING COMMENT 'The patient notification status value classifying the radiology follow up record.',
    `patient_notification_timestamp` TIMESTAMP COMMENT 'The patient notification timestamp of the radiology follow up record.',
    `population_health_cohort` STRING COMMENT 'The population health cohort of the radiology follow up record.',
    `priority_level` STRING COMMENT 'The priority level of the radiology follow up record.',
    `recommendation_date` TIMESTAMP COMMENT 'Timestamp capturing the recommendation date associated with the radiology follow up record.',
    `recommendation_number` STRING COMMENT 'The recommendation number of the radiology follow up record.',
    `recommendation_status` STRING COMMENT 'The recommendation status value classifying the radiology follow up record.',
    `recommendation_text` STRING COMMENT 'The recommendation text of the radiology follow up record.',
    `recommendation_type` STRING COMMENT 'The recommendation type value classifying the radiology follow up record.',
    `recommended_due_date` DATE COMMENT 'Timestamp capturing the recommended due date associated with the radiology follow up record.',
    `recommended_modality` STRING COMMENT 'The recommended modality of the radiology follow up record.',
    `recommended_timeframe_days` STRING COMMENT 'Recommended timeframe in days',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'The report finalized timestamp of the radiology follow up record.',
    `ris_recommendation_code` STRING COMMENT 'The ris recommendation code value classifying the radiology follow up record.',
    `scheduled_date` DATE COMMENT 'Timestamp capturing the scheduled date associated with the radiology follow up record.',
    `specialist_referral_type` STRING COMMENT 'The specialist referral type value classifying the radiology follow up record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_follow_up PRIMARY KEY(`follow_up_id`)
) COMMENT 'Tracks actionable follow-up recommendations generated from radiology reports, supporting incidental finding management programs. Captures recommendation type (repeat imaging, biopsy, clinical correlation, specialist referral), recommended modality, recommended timeframe, recommendation status (pending, scheduled, completed, declined, lost-to-follow-up), patient notification status, ordering provider notification status, and escalation flag. Supports ACR incidental finding guidelines, CMS quality measures, and population health management workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` (
    `interventional_procedure_id` BIGINT COMMENT 'Primary key',
    `audit_finding_id` BIGINT COMMENT 'FK to audit finding',
    `specimen_id` BIGINT COMMENT 'FK to biopsy specimen',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `claim_id` BIGINT COMMENT 'FK to claim',
    `clinical_order_id` BIGINT COMMENT 'FK to clinical order',
    `drug_master_id` BIGINT COMMENT 'FK to contrast drug',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `icd_code_id` BIGINT COMMENT 'FK to primary diagnosis ICD code',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the interventional performing clinician within the radiology interventional procedure record.',
    `lab_order_id` BIGINT COMMENT 'FK to pre-procedure lab order',
    `material_master_id` BIGINT COMMENT 'FK to primary device material',
    `primary_interventional_clinician_id` BIGINT COMMENT 'FK to interventional clinician',
    `primary_operator_clinician_id` BIGINT COMMENT 'Unique identifier for the primary operator clinician within the radiology interventional procedure record.',
    `room_id` BIGINT COMMENT 'FK to procedure room',
    `radiology_study_id` BIGINT COMMENT 'Unique identifier for the radiology study within the radiology interventional procedure record.',
    `research_study_id` BIGINT COMMENT 'FK to research study',
    `surgical_case_id` BIGINT COMMENT 'FK to surgical case',
    `treatment_consent_id` BIGINT COMMENT 'FK to treatment consent',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `access_site` STRING COMMENT 'The access site of the radiology interventional procedure record.',
    `accession_number` STRING COMMENT 'The accession number of the radiology interventional procedure record.',
    `anesthesia_type` STRING COMMENT 'The anesthesia type value classifying the radiology interventional procedure record.',
    `asa_classification` STRING COMMENT 'The asa classification of the radiology interventional procedure record.',
    `blood_loss_ml` DECIMAL(18,2) COMMENT 'The blood loss ml of the radiology interventional procedure record.',
    `body_region` STRING COMMENT 'The body region of the radiology interventional procedure record.',
    `cancellation_reason` STRING COMMENT 'The cancellation reason of the radiology interventional procedure record.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The cancelled timestamp of the radiology interventional procedure record.',
    `complication_description` STRING COMMENT 'The complication description of the radiology interventional procedure record.',
    `complication_flag` BOOLEAN COMMENT 'The complication flag of the radiology interventional procedure record.',
    `complication_occurred` BOOLEAN COMMENT 'Whether complication occurred',
    `complication_severity` STRING COMMENT 'The complication severity of the radiology interventional procedure record.',
    `complication_type` STRING COMMENT 'The complication type value classifying the radiology interventional procedure record.',
    `contrast_agent_used` BOOLEAN COMMENT 'Whether contrast agent used',
    `contrast_used` BOOLEAN COMMENT 'The contrast used of the radiology interventional procedure record.',
    `contrast_volume_ml` DECIMAL(18,2) COMMENT 'Contrast volume in mL',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `device_implanted` STRING COMMENT 'The device implanted of the radiology interventional procedure record.',
    `device_name` STRING COMMENT 'The device name of the radiology interventional procedure record.',
    `device_udi` STRING COMMENT 'The device udi of the radiology interventional procedure record.',
    `fluoroscopy_time_min` DECIMAL(18,2) COMMENT 'The fluoroscopy time min of the radiology interventional procedure record.',
    `fluoroscopy_time_minutes` DECIMAL(18,2) COMMENT 'Fluoroscopy time in minutes',
    `fluoroscopy_time_sec` DECIMAL(18,2) COMMENT 'The fluoroscopy time sec of the radiology interventional procedure record.',
    `icd10_post_procedure_diagnosis_code` STRING COMMENT 'Post-procedure ICD-10 code',
    `imaging_guidance_modality` STRING COMMENT 'The imaging guidance modality of the radiology interventional procedure record.',
    `implant_used` BOOLEAN COMMENT 'Whether implant used',
    `laterality` STRING COMMENT 'The laterality of the radiology interventional procedure record.',
    `moderate_sedation_flag` BOOLEAN COMMENT 'The moderate sedation flag of the radiology interventional procedure record.',
    `operator_npi` STRING COMMENT 'The operator npi of the radiology interventional procedure record.',
    `performing_provider_npi` STRING COMMENT 'The performing provider npi of the radiology interventional procedure record.',
    `procedure_approach` STRING COMMENT 'The procedure approach of the radiology interventional procedure record.',
    `procedure_category` STRING COMMENT 'The procedure category of the radiology interventional procedure record.',
    `procedure_datetime` TIMESTAMP COMMENT 'Timestamp capturing the procedure datetime associated with the radiology interventional procedure record.',
    `procedure_description` STRING COMMENT 'The procedure description of the radiology interventional procedure record.',
    `procedure_end_datetime` TIMESTAMP COMMENT 'Timestamp capturing the procedure end datetime associated with the radiology interventional procedure record.',
    `procedure_end_timestamp` TIMESTAMP COMMENT 'The procedure end timestamp of the radiology interventional procedure record.',
    `procedure_name` STRING COMMENT 'The procedure name of the radiology interventional procedure record.',
    `procedure_start_datetime` TIMESTAMP COMMENT 'Timestamp capturing the procedure start datetime associated with the radiology interventional procedure record.',
    `procedure_start_timestamp` TIMESTAMP COMMENT 'The procedure start timestamp of the radiology interventional procedure record.',
    `procedure_status` STRING COMMENT 'The procedure status value classifying the radiology interventional procedure record.',
    `procedure_timestamp` TIMESTAMP COMMENT 'The procedure timestamp of the radiology interventional procedure record.',
    `radiation_dose_dap` DECIMAL(18,2) COMMENT 'The radiation dose dap of the radiology interventional procedure record.',
    `radiation_dose_dap_gycm2` DECIMAL(18,2) COMMENT 'Radiation dose DAP',
    `radiation_dose_kerma_mgy` DECIMAL(18,2) COMMENT 'Radiation dose kerma',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'The report finalized timestamp of the radiology interventional procedure record.',
    `report_status` STRING COMMENT 'The report status value classifying the radiology interventional procedure record.',
    `secondary_cpt_codes` STRING COMMENT 'The secondary cpt codes of the radiology interventional procedure record.',
    `sedation_provider_npi` STRING COMMENT 'The sedation provider npi of the radiology interventional procedure record.',
    `sedation_type` STRING COMMENT 'The sedation type value classifying the radiology interventional procedure record.',
    `specimen_collected` BOOLEAN COMMENT 'Whether specimen collected',
    `specimen_collected_flag` BOOLEAN COMMENT 'The specimen collected flag of the radiology interventional procedure record.',
    `specimen_obtained_flag` BOOLEAN COMMENT 'The specimen obtained flag of the radiology interventional procedure record.',
    `specimen_type` STRING COMMENT 'The specimen type value classifying the radiology interventional procedure record.',
    `technical_success` BOOLEAN COMMENT 'Whether technically successful',
    `technical_success_flag` BOOLEAN COMMENT 'The technical success flag of the radiology interventional procedure record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_interventional_procedure PRIMARY KEY(`interventional_procedure_id`)
) COMMENT 'Master record for interventional radiology (IR) procedures performed under imaging guidance. Covers vascular, non-vascular, neuro-IR, and oncologic interventions. Captures procedure details, imaging guidance modality, anesthesia type, pre/post diagnoses (ICD-10), complications, specimen collection, fluoroscopy time, radiation dose, and implant tracking (UDI). Supports IR case management, complication tracking, device surveillance, and procedural billing. Integrates with OR scheduling for hybrid suite procedures. Aligns with HL7 FHIR Procedure resource and IHE RAD profiles for interventional reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` (
    `radiology_order_status_history_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `corrected_history_id` BIGINT COMMENT 'Self-ref FK to corrected entry',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `message_log_id` BIGINT COMMENT 'FK to message log',
    `org_unit_id` BIGINT COMMENT 'FK to org unit',
    `employee_id` BIGINT COMMENT 'FK to radiology employee',
    `radiology_changed_by_employee_id` BIGINT COMMENT 'Unique identifier for the radiology changed by employee within the radiology radiology order status history record.',
    `radiology_study_id` BIGINT COMMENT 'Unique identifier for the radiology study within the radiology radiology order status history record.',
    `report_id` BIGINT COMMENT 'FK to report',
    `scheduling_appointment_id` BIGINT COMMENT 'FK to scheduling appointment',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `accession_number` STRING COMMENT 'The accession number of the radiology radiology order status history record.',
    `cancellation_category` STRING COMMENT 'The cancellation category of the radiology radiology order status history record.',
    `change_reason` STRING COMMENT 'The change reason of the radiology radiology order status history record.',
    `changed_by_user_npi` STRING COMMENT 'NPI of user who changed status',
    `changed_by_user_role` STRING COMMENT 'Role of user who changed status',
    `changed_timestamp` TIMESTAMP COMMENT 'The changed timestamp of the radiology radiology order status history record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `hl7_message_reference` STRING COMMENT 'The hl7 message reference of the radiology radiology order status history record.',
    `hl7_message_type` STRING COMMENT 'The hl7 message type value classifying the radiology radiology order status history record.',
    `ip_address` STRING COMMENT 'The ip address of the radiology radiology order status history record.',
    `is_corrective_entry` BOOLEAN COMMENT 'Whether corrective entry',
    `is_sla_breach` BOOLEAN COMMENT 'Whether SLA breach',
    `is_system_generated` BOOLEAN COMMENT 'Whether system generated',
    `modality_type` STRING COMMENT 'The modality type value classifying the radiology radiology order status history record.',
    `new_status` STRING COMMENT 'The new status value classifying the radiology radiology order status history record.',
    `on_hold_reason` STRING COMMENT 'The on hold reason of the radiology radiology order status history record.',
    `order_priority` STRING COMMENT 'The order priority of the radiology radiology order status history record.',
    `pacs_study_uid` STRING COMMENT 'The pacs study uid of the radiology radiology order status history record.',
    `previous_status` STRING COMMENT 'The previous status value classifying the radiology radiology order status history record.',
    `prior_status` STRING COMMENT 'The prior status value classifying the radiology radiology order status history record.',
    `ris_order_status_code` STRING COMMENT 'The ris order status code value classifying the radiology radiology order status history record.',
    `sequence_number` STRING COMMENT 'The sequence number of the radiology radiology order status history record.',
    `sla_threshold_seconds` STRING COMMENT 'SLA threshold in seconds',
    `source_system_event_code` STRING COMMENT 'The source system event code value classifying the radiology radiology order status history record.',
    `radiology_order_status_history_status` STRING COMMENT 'The radiology order status history status value classifying the radiology radiology order status history record.',
    `status_change_reason` STRING COMMENT 'The status change reason of the radiology radiology order status history record.',
    `status_change_reason_code` STRING COMMENT 'The status change reason code value classifying the radiology radiology order status history record.',
    `status_change_timestamp` TIMESTAMP COMMENT 'The status change timestamp of the radiology radiology order status history record.',
    `status_sequence` STRING COMMENT 'The status sequence of the radiology radiology order status history record.',
    `status_sequence_number` STRING COMMENT 'The status sequence number of the radiology radiology order status history record.',
    `status_timestamp` TIMESTAMP COMMENT 'The status timestamp of the radiology radiology order status history record.',
    `transition_duration_seconds` STRING COMMENT 'Transition duration in seconds',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `workstation_code` STRING COMMENT 'The workstation code value classifying the radiology radiology order status history record.',
    `changed_by` STRING COMMENT 'The changed by of the radiology radiology order status history record.',
    CONSTRAINT pk_radiology_order_status_history PRIMARY KEY(`radiology_order_status_history_id`)
) COMMENT 'Audit trail of all status transitions for imaging orders throughout the RIS workflow lifecycle. Records each status change event including prior status, new status, status change datetime, status change reason, changed-by user NPI, and source system. Status states include: ordered, scheduled, patient-arrived, exam-started, exam-completed, images-available, preliminary-read, final-read, report-signed, report-delivered, cancelled, and on-hold. Supports workflow analytics, SLA compliance auditing, and RIS process improvement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` (
    `report_distribution_id` BIGINT COMMENT 'Primary key',
    `direct_message_id` BIGINT COMMENT 'Unique identifier for the direct message within the radiology report distribution record.',
    `distribution_rule_id` BIGINT COMMENT 'Distribution rule that triggered this distribution',
    `message_log_id` BIGINT COMMENT 'FK to message log',
    `report_id` BIGINT COMMENT 'FK to radiology report',
    `clinician_id` BIGINT COMMENT 'Clinician who is the intended recipient of the distributed report.',
    `care_site_id` BIGINT COMMENT 'Facility associated with the distribution destination.',
    `report_recipient_care_site_id` BIGINT COMMENT 'Care site recipient of report',
    `routing_rule_id` BIGINT COMMENT 'Added to expand thin product order.report_distribution',
    `trading_partner_id` BIGINT COMMENT 'FK to trading partner',
    `acknowledged_at` TIMESTAMP COMMENT 'Added to expand thin product radiology.report_distribution',
    `acknowledged_flag` BOOLEAN COMMENT 'The acknowledged flag of the radiology report distribution record.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'The acknowledged timestamp of the radiology report distribution record.',
    `acknowledgment_code` STRING COMMENT 'The acknowledgment code value classifying the radiology report distribution record.',
    `acknowledgment_status` STRING COMMENT 'The acknowledgment status value classifying the radiology report distribution record.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The acknowledgment timestamp of the radiology report distribution record.',
    `attachment_count` STRING COMMENT 'Number of attachments included with report',
    `attachment_included_flag` BOOLEAN COMMENT 'Added to expand thin product radiology.report_distribution',
    `consent_verified_flag` BOOLEAN COMMENT 'Whether patient consent for distribution was verified',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution record was created.',
    `critical_result_flag` BOOLEAN COMMENT 'Whether report contains critical results requiring immediate notification',
    `delivered_at` TIMESTAMP COMMENT 'Added to expand thin product radiology.report_distribution',
    `delivered_timestamp` TIMESTAMP COMMENT 'The delivered timestamp of the radiology report distribution record.',
    `delivery_attempt_count` STRING COMMENT 'Added to expand thin product radiology.report_distribution',
    `delivery_confirmed_flag` BOOLEAN COMMENT 'The delivery confirmed flag of the radiology report distribution record.',
    `delivery_failure_reason` STRING COMMENT 'The delivery failure reason of the radiology report distribution record.',
    `delivery_latency_seconds` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `delivery_method` STRING COMMENT 'The delivery method of the radiology report distribution record.',
    `delivery_status` STRING COMMENT 'The delivery status value classifying the radiology report distribution record.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp of the radiology report distribution record.',
    `distribution_batch_number` BIGINT COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `distribution_channel` STRING COMMENT 'Added to expand thin product radiology.report_distribution',
    `distribution_method` STRING COMMENT 'Method used to distribute the report (e.g., HL7, fax, Direct message, portal).',
    `distribution_notes` STRING COMMENT 'Notes about distribution',
    `distribution_priority` STRING COMMENT 'Priority of distribution (routine, urgent, stat)',
    `distribution_status` STRING COMMENT 'The distribution status value classifying the radiology report distribution record.',
    `distribution_timestamp` TIMESTAMP COMMENT 'The distribution timestamp of the radiology report distribution record.',
    `document_format` STRING COMMENT 'The document format of the radiology report distribution record.',
    `encryption_method` STRING COMMENT 'Encryption method used for secure transmission',
    `error_message` STRING COMMENT 'The error message of the radiology report distribution record.',
    `escalation_flag` BOOLEAN COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `external_system_reference` STRING COMMENT 'Reference ID in external distribution system',
    `extra_attr_1` STRING COMMENT 'The extra attr 1 of the radiology report distribution record.',
    `extra_attr_2` STRING COMMENT 'The extra attr 2 of the radiology report distribution record.',
    `extra_attr_3` STRING COMMENT 'The extra attr 3 of the radiology report distribution record.',
    `extra_attr_4` STRING COMMENT 'The extra attr 4 of the radiology report distribution record.',
    `extra_attr_5` STRING COMMENT 'The extra attr 5 of the radiology report distribution record.',
    `failed_reason` STRING COMMENT 'Added to expand thin product radiology.report_distribution',
    `failure_reason` STRING COMMENT 'The failure reason of the radiology report distribution record.',
    `priority` STRING COMMENT 'Priority level of the distribution (e.g., stat, routine).',
    `priority_level` STRING COMMENT 'Priority level of distribution',
    `read_confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when recipient confirmed reading',
    `read_receipt_requested` BOOLEAN COMMENT 'Whether read receipt was requested',
    `read_receipt_timestamp` TIMESTAMP COMMENT 'Timestamp when recipient acknowledged reading report',
    `recipient_email` STRING COMMENT 'Email address used for report distribution.',
    `recipient_fax` STRING COMMENT 'Fax number of recipient',
    `recipient_fax_number` STRING COMMENT 'Fax number used for report distribution.',
    `recipient_name` STRING COMMENT 'The recipient name of the radiology report distribution record.',
    `recipient_npi` STRING COMMENT 'The recipient npi of the radiology report distribution record.',
    `recipient_organization` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `recipient_reference` BIGINT COMMENT 'Added to expand thin product radiology.report_distribution',
    `recipient_type` STRING COMMENT 'Type of recipient (provider, facility, patient)',
    `retry_count` STRING COMMENT 'The retry count of the radiology report distribution record.',
    `sent_timestamp` TIMESTAMP COMMENT 'The sent timestamp of the radiology report distribution record.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Whether SLA compliant',
    `transmission_timestamp` TIMESTAMP COMMENT 'The transmission timestamp of the radiology report distribution record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vibe_expanded_flag` BOOLEAN COMMENT 'Flag added by VIBE batch to expand thin product attribute set.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `viewed_timestamp` TIMESTAMP COMMENT 'When recipient viewed the report',
    CONSTRAINT pk_report_distribution PRIMARY KEY(`report_distribution_id`)
) COMMENT 'This association product represents the distribution event between radiology reports and external trading partners. It captures the transmission of a finalized radiology report to an external entity (HIE, referring provider, specialist, payer, patient portal) via interoperability standards. Each record links one report to one trading partner with transmission metadata, delivery status, acknowledgment tracking, and SLA compliance monitoring that exist only in the context of this specific distribution event.. Existence Justification: In healthcare interoperability operations, a single finalized radiology report is routinely distributed to multiple external trading partners (referring providers, specialists, HIEs, patient portals, payers) based on care coordination needs, regulatory requirements, and data sharing agreements. Each trading partner may receive hundreds or thousands of reports over time. The distribution relationship is an operational business process actively managed by interoperability teams, tracking transmission status, acknowledgments, retries, and SLA compliance per partner per report.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`transmission` (
    `transmission_id` BIGINT COMMENT 'Primary key',
    `dicom_series_id` BIGINT COMMENT 'Unique identifier for the dicom series within the radiology transmission record.',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `interface_channel_id` BIGINT COMMENT 'Unique identifier for the interface channel within the radiology transmission record.',
    `message_log_id` BIGINT COMMENT 'Unique identifier for the message log within the radiology transmission record.',
    `radiology_study_id` BIGINT COMMENT 'FK to radiology study',
    `report_id` BIGINT COMMENT 'Unique identifier for the report within the radiology transmission record.',
    `teleradiology_case_id` BIGINT COMMENT 'Unique identifier for the teleradiology case within the radiology transmission record.',
    `trading_partner_id` BIGINT COMMENT 'FK to trading partner',
    `acknowledgment_code` STRING COMMENT 'The acknowledgment code value classifying the radiology transmission record.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The acknowledgment timestamp of the radiology transmission record.',
    `bytes` BIGINT COMMENT 'The bytes of the radiology transmission record.',
    `bytes_transmitted` BIGINT COMMENT 'The bytes transmitted of the radiology transmission record.',
    `completion_timestamp` TIMESTAMP COMMENT 'The completion timestamp of the radiology transmission record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `datetime` TIMESTAMP COMMENT 'The datetime of the radiology transmission record.',
    `destination` STRING COMMENT 'The destination of the radiology transmission record.',
    `destination_ae_title` STRING COMMENT 'The destination ae title of the radiology transmission record.',
    `destination_system` STRING COMMENT 'The destination system of the radiology transmission record.',
    `error_message` STRING COMMENT 'The error message of the radiology transmission record.',
    `failure_reason` STRING COMMENT 'The failure reason of the radiology transmission record.',
    `image_count` STRING COMMENT 'The image count of the radiology transmission record.',
    `initiation_timestamp` TIMESTAMP COMMENT 'The initiation timestamp of the radiology transmission record.',
    `instance_count` STRING COMMENT 'The instance count of the radiology transmission record.',
    `method` STRING COMMENT 'Transmission method',
    `protocol` STRING COMMENT 'The protocol of the radiology transmission record.',
    `purpose` STRING COMMENT 'Purpose of transmission',
    `retransmission_count` STRING COMMENT 'The retransmission count of the radiology transmission record.',
    `retry_count` STRING COMMENT 'The retry count of the radiology transmission record.',
    `size_mb` DECIMAL(18,2) COMMENT 'Size in MB',
    `sla_met_flag` BOOLEAN COMMENT 'Whether SLA met',
    `source_ae_title` STRING COMMENT 'The source ae title of the radiology transmission record.',
    `study_instance_uid` STRING COMMENT 'The study instance uid of the radiology transmission record.',
    `success` BOOLEAN COMMENT 'The success of the radiology transmission record.',
    `transmission_status` STRING COMMENT 'The transmission status value classifying the radiology transmission record.',
    `transmission_timestamp` TIMESTAMP COMMENT 'The transmission timestamp of the radiology transmission record.',
    `transmission_type` STRING COMMENT 'The transmission type value classifying the radiology transmission record.',
    `transmitted_timestamp` TIMESTAMP COMMENT 'The transmitted timestamp of the radiology transmission record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_transmission PRIMARY KEY(`transmission_id`)
) COMMENT 'This association product represents the transmission event between an imaging study and an external trading partner. It captures the operational act of sending DICOM study data to external entities (referring facilities, specialists, teleradiology vendors, HIEs) for care coordination, second opinions, or regulatory reporting. Each record links one imaging study to one trading partner with transmission-specific metadata including delivery status, acknowledgments, retry attempts, and SLA compliance tracking. SSOT for outbound imaging study distribution to external partners.. Existence Justification: In healthcare radiology operations, a single imaging study is routinely transmitted to multiple external trading partners for different clinical purposes: the referring facility receives results, a specialist receives images for consultation, a teleradiology vendor provides after-hours interpretation, and an HIE receives data for regional care coordination. Conversely, each trading partner receives thousands of imaging studies over time from the healthcare organization. The transmission relationship is an operational business process actively managed by radiology IT and PACS administrators, with each transmission tracked for delivery status, acknowledgments, retry attempts, and SLA compliance per the data sharing agreement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` (
    `network_modality_participation_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the radiology network modality participation record.',
    `contract_id` BIGINT COMMENT 'FK to contract',
    `coverage_policy_id` BIGINT COMMENT 'Unique identifier for the coverage policy within the radiology network modality participation record.',
    `modality_id` BIGINT COMMENT 'FK to modality',
    `network_contract_id` BIGINT COMMENT 'Unique identifier for the network contract within the radiology network modality participation record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the radiology network modality participation record.',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `accepting_new_referrals_flag` BOOLEAN COMMENT 'Whether accepting new referrals',
    `authorization_required_flag` BOOLEAN COMMENT 'Whether authorization required',
    `authorization_threshold_amount` DECIMAL(18,2) COMMENT 'The authorization threshold amount of the radiology network modality participation record.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The contracted rate of the radiology network modality participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_verified_date` DATE COMMENT 'Timestamp capturing the credentialing verified date associated with the radiology network modality participation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the radiology network modality participation record.',
    `in_network_flag` BOOLEAN COMMENT 'The in network flag of the radiology network modality participation record.',
    `member_cost_share_tier` STRING COMMENT 'The member cost share tier of the radiology network modality participation record.',
    `network_adequacy_counted_flag` BOOLEAN COMMENT 'Whether counted for network adequacy',
    `network_status` STRING COMMENT 'The network status value classifying the radiology network modality participation record.',
    `next_credentialing_due_date` DATE COMMENT 'Timestamp capturing the next credentialing due date associated with the radiology network modality participation record.',
    `participation_status` STRING COMMENT 'The participation status value classifying the radiology network modality participation record.',
    `participation_type` STRING COMMENT 'The participation type value classifying the radiology network modality participation record.',
    `quality_tier_assignment` STRING COMMENT 'The quality tier assignment of the radiology network modality participation record.',
    `rate_type` STRING COMMENT 'The rate type value classifying the radiology network modality participation record.',
    `shared_service_flag` BOOLEAN COMMENT 'The shared service flag of the radiology network modality participation record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the radiology network modality participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_network_modality_participation PRIMARY KEY(`network_modality_participation_id`)
) COMMENT 'This association product represents the contractual participation of imaging modalities in payer-defined provider networks. It captures the business relationship where healthcare facilities contract specific imaging equipment into insurance networks, establishing in-network status, reimbursement rates, and authorization requirements. Each record links one modality to one provider_network with attributes that exist only in the context of this network participation agreement.. Existence Justification: Healthcare facilities contract specific imaging modalities into multiple payer-defined provider networks simultaneously, and each provider network includes multiple modalities across different facilities and equipment types. Payers actively manage these network participation relationships with modality-specific contracted rates, authorization requirements, credentialing verification, and network adequacy tracking. This is an operational business process where network managers create, update, and terminate modality participation agreements as part of network design and provider contracting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` (
    `radiology_finding_id` BIGINT COMMENT 'Primary key',
    `audit_finding_id` BIGINT COMMENT 'FK to audit finding',
    `clinical_finding_id` BIGINT COMMENT 'SSOT cross-reference to canonical clinical.clinical_finding',
    `demographics_id` BIGINT COMMENT 'FK to demographics',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code',
    `radiology_reading_clinician_id` BIGINT COMMENT 'Unique identifier for the radiology reading clinician within the radiology radiology finding record.',
    `radiology_study_id` BIGINT COMMENT 'Unique identifier for the radiology study within the radiology radiology finding record.',
    `report_id` BIGINT COMMENT 'FK to report',
    `research_study_id` BIGINT COMMENT 'FK to research study',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED concept',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `accession_number` STRING COMMENT 'The accession number of the radiology radiology finding record.',
    `acr_score_type` STRING COMMENT 'The acr score type value classifying the radiology radiology finding record.',
    `acr_score_value` DECIMAL(18,2) COMMENT 'The acr score value of the radiology radiology finding record.',
    `anatomic_location` STRING COMMENT 'The anatomic location of the radiology radiology finding record.',
    `anatomical_location` STRING COMMENT 'The anatomical location of the radiology radiology finding record.',
    `body_part` STRING COMMENT 'The body part of the radiology radiology finding record.',
    `body_region` STRING COMMENT 'The body region of the radiology radiology finding record.',
    `body_site_code` STRING COMMENT 'The body site code value classifying the radiology radiology finding record.',
    `body_site_description` STRING COMMENT 'The body site description of the radiology radiology finding record.',
    `code_system` STRING COMMENT 'The code system of the radiology radiology finding record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_flag` BOOLEAN COMMENT 'The critical flag of the radiology radiology finding record.',
    `data_source_method` STRING COMMENT 'The data source method of the radiology radiology finding record.',
    `dicom_series_uid` STRING COMMENT 'The dicom series uid of the radiology radiology finding record.',
    `dicom_sop_instance_uid` STRING COMMENT 'The dicom sop instance uid of the radiology radiology finding record.',
    `escalation_status` STRING COMMENT 'The escalation status value classifying the radiology radiology finding record.',
    `escalation_timestamp` TIMESTAMP COMMENT 'The escalation timestamp of the radiology radiology finding record.',
    `finding_category` STRING COMMENT 'The finding category of the radiology radiology finding record.',
    `finding_code` STRING COMMENT 'The finding code value classifying the radiology radiology finding record.',
    `finding_description` STRING COMMENT 'The finding description of the radiology radiology finding record.',
    `finding_domain` STRING COMMENT 'The finding domain of the radiology radiology finding record.',
    `finding_severity` STRING COMMENT 'The finding severity of the radiology radiology finding record.',
    `finding_status` STRING COMMENT 'The finding status value classifying the radiology radiology finding record.',
    `follow_up_completed_date` DATE COMMENT 'Timestamp capturing the follow up completed date associated with the radiology radiology finding record.',
    `follow_up_due_date` DATE COMMENT 'Timestamp capturing the follow up due date associated with the radiology radiology finding record.',
    `follow_up_modality` STRING COMMENT 'The follow up modality of the radiology radiology finding record.',
    `follow_up_recommended` BOOLEAN COMMENT 'Whether follow-up recommended',
    `follow_up_status` STRING COMMENT 'The follow up status value classifying the radiology radiology finding record.',
    `follow_up_timeframe_days` STRING COMMENT 'Follow-up timeframe in days',
    `follow_up_type` STRING COMMENT 'The follow up type value classifying the radiology radiology finding record.',
    `imaging_modality` STRING COMMENT 'The imaging modality of the radiology radiology finding record.',
    `incidental_flag` BOOLEAN COMMENT 'The incidental flag of the radiology radiology finding record.',
    `is_critical` BOOLEAN COMMENT 'Boolean flag indicating the is critical status of the radiology radiology finding record.',
    `is_critical_result` BOOLEAN COMMENT 'Whether critical result',
    `is_incidental_finding` BOOLEAN COMMENT 'Whether incidental finding',
    `laterality` STRING COMMENT 'The laterality of the radiology radiology finding record.',
    `measurement_unit` STRING COMMENT 'The measurement unit of the radiology radiology finding record.',
    `measurement_value` DECIMAL(18,2) COMMENT 'The measurement value of the radiology radiology finding record.',
    `nlp_confidence_score` DECIMAL(18,2) COMMENT 'The nlp confidence score of the radiology radiology finding record.',
    `patient_notification_timestamp` TIMESTAMP COMMENT 'The patient notification timestamp of the radiology radiology finding record.',
    `patient_notified` BOOLEAN COMMENT 'Whether patient notified',
    `provider_notification_timestamp` TIMESTAMP COMMENT 'The provider notification timestamp of the radiology radiology finding record.',
    `provider_notified` BOOLEAN COMMENT 'Whether provider notified',
    `radiology_icd10_icd_code_id` BIGINT COMMENT 'Unique identifier for the radiology icd10 icd code within the radiology radiology finding record.',
    `radlex_code` STRING COMMENT 'The radlex code value classifying the radiology radiology finding record.',
    `rads_category` STRING COMMENT 'The rads category of the radiology radiology finding record.',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'The report finalized timestamp of the radiology radiology finding record.',
    `severity` STRING COMMENT 'The severity of the radiology radiology finding record.',
    `source_system_finding_code` STRING COMMENT 'The source system finding code value classifying the radiology radiology finding record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: clinical.clinical_finding (duplicate reconciled to canonical)',
    `ssot_reference` STRING COMMENT 'The ssot reference of the radiology radiology finding record.',
    `study_date` DATE COMMENT 'Timestamp capturing the study date associated with the radiology radiology finding record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_radiology_finding PRIMARY KEY(`radiology_finding_id`)
) COMMENT 'Radiology-specific imaging findings with DICOM references, ACR scoring, and follow-up tracking. SSOT consumer extending clinical.clinical_finding with radiology-specific attributes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` (
    `radiology_peer_review_id` BIGINT COMMENT 'Primary key',
    `audit_finding_id` BIGINT COMMENT 'FK to audit finding',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `employee_id` BIGINT COMMENT 'FK to coordinator employee',
    `corrective_action_plan_id` BIGINT COMMENT 'FK to corrective action plan',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `org_unit_id` BIGINT COMMENT 'FK to org unit',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the originating clinician within the radiology radiology peer review record.',
    `quality_peer_review_id` BIGINT COMMENT 'SSOT cross-reference to canonical quality.quality_peer_review',
    `radiology_original_reader_clinician_id` BIGINT COMMENT 'Unique identifier for the radiology original reader clinician within the radiology radiology peer review record.',
    `report_id` BIGINT COMMENT 'FK to original report',
    `radiology_report_id` BIGINT COMMENT 'Unique identifier for the radiology report within the radiology radiology peer review record.',
    `radiology_reviewed_clinician_id` BIGINT COMMENT 'Unique identifier for the radiology reviewed clinician within the radiology radiology peer review record.',
    `radiology_reviewing_clinician_id` BIGINT COMMENT 'Unique identifier for the radiology reviewing clinician within the radiology radiology peer review record.',
    `radiology_study_id` BIGINT COMMENT 'Unique identifier for the radiology study within the radiology radiology peer review record.',
    `report_addendum_id` BIGINT COMMENT 'FK to report addendum',
    `reviewer_clinician_id` BIGINT COMMENT 'Unique identifier for the reviewer clinician within the radiology radiology peer review record.',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `accession_number` STRING COMMENT 'The accession number of the radiology radiology peer review record.',
    `acr_accreditation_cycle` STRING COMMENT 'The acr accreditation cycle of the radiology radiology peer review record.',
    `acr_radpeer_score` STRING COMMENT 'The acr radpeer score of the radiology radiology peer review record.',
    `agreement_flag` BOOLEAN COMMENT 'The agreement flag of the radiology radiology peer review record.',
    `agreement_score` DECIMAL(18,2) COMMENT 'The agreement score of the radiology radiology peer review record.',
    `blinded_review_flag` BOOLEAN COMMENT 'Whether review was blinded',
    `body_part_examined` STRING COMMENT 'The body part examined of the radiology radiology peer review record.',
    `case_conference_flag` BOOLEAN COMMENT 'Whether case conference held',
    `clinical_history_available_flag` BOOLEAN COMMENT 'Whether clinical history was available',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `discrepancy_category` STRING COMMENT 'Category of discrepancy',
    `discrepancy_clinical_significance` STRING COMMENT 'The discrepancy clinical significance of the radiology radiology peer review record.',
    `discrepancy_description` STRING COMMENT 'Description of discrepancy',
    `discrepancy_flag` BOOLEAN COMMENT 'The discrepancy flag of the radiology radiology peer review record.',
    `discrepancy_type` STRING COMMENT 'Type of discrepancy',
    `educational_feedback_flag` BOOLEAN COMMENT 'Whether educational feedback provided',
    `escalated_to_chair_flag` BOOLEAN COMMENT 'Whether escalated to chair',
    `icd10_finding_code` STRING COMMENT 'The icd10 finding code value classifying the radiology radiology peer review record.',
    `modality` STRING COMMENT 'The modality of the radiology radiology peer review record.',
    `modality_code` STRING COMMENT 'The modality code value classifying the radiology radiology peer review record.',
    `ocr_score` STRING COMMENT 'The ocr score of the radiology radiology peer review record.',
    `oppe_fppe_flag` BOOLEAN COMMENT 'Whether part of OPPE/FPPE',
    `original_radiologist_npi` STRING COMMENT 'The original radiologist npi of the radiology radiology peer review record.',
    `original_radiologist_response` STRING COMMENT 'The original radiologist response of the radiology radiology peer review record.',
    `original_report_finalized_datetime` TIMESTAMP COMMENT 'When original report was finalized',
    `patient_safety_event_flag` BOOLEAN COMMENT 'Whether patient safety event',
    `peer_review_program` STRING COMMENT 'The peer review program of the radiology radiology peer review record.',
    `peer_review_scope` STRING COMMENT 'The peer review scope of the radiology radiology peer review record.',
    `prior_study_available_flag` BOOLEAN COMMENT 'Whether prior study available',
    `radpeer_score` STRING COMMENT 'The radpeer score of the radiology radiology peer review record.',
    `response_datetime` TIMESTAMP COMMENT 'Timestamp capturing the response datetime associated with the radiology radiology peer review record.',
    `review_assigned_datetime` TIMESTAMP COMMENT 'When review was assigned',
    `review_date` DATE COMMENT 'Timestamp capturing the review date associated with the radiology radiology peer review record.',
    `review_datetime` TIMESTAMP COMMENT 'When review was performed',
    `review_disposition` STRING COMMENT 'The review disposition of the radiology radiology peer review record.',
    `review_outcome` STRING COMMENT 'The review outcome of the radiology radiology peer review record.',
    `review_program_type` STRING COMMENT 'The review program type value classifying the radiology radiology peer review record.',
    `review_status` STRING COMMENT 'The review status value classifying the radiology radiology peer review record.',
    `review_type` STRING COMMENT 'The review type value classifying the radiology radiology peer review record.',
    `reviewer_comments` STRING COMMENT 'The reviewer comments of the radiology radiology peer review record.',
    `reviewer_radiologist_npi` STRING COMMENT 'The reviewer radiologist npi of the radiology radiology peer review record.',
    `score_category` STRING COMMENT 'The score category of the radiology radiology peer review record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: quality.quality_peer_review (duplicate reconciled to canonical)',
    `ssot_reference` STRING COMMENT 'The ssot reference of the radiology radiology peer review record.',
    `study_datetime` TIMESTAMP COMMENT 'Timestamp capturing the study datetime associated with the radiology radiology peer review record.',
    `subspecialty` STRING COMMENT 'The subspecialty of the radiology radiology peer review record.',
    `subspecialty_matched_flag` BOOLEAN COMMENT 'Whether subspecialty matched',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure product is touched',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_radiology_peer_review PRIMARY KEY(`radiology_peer_review_id`)
) COMMENT 'Tracks radiology-specific peer review using ACR RADPEER scoring methodology, including discrepancy categorization, subspecialty matching, blinded review protocols, and radiology-specific quality metrics for diagnostic accuracy assessment.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` (
    `radiology_study_id` BIGINT COMMENT 'Primary key for the radiology study record.',
    `care_site_id` BIGINT COMMENT 'FK to the care site where the study was performed.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the radiology radiology study record.',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics.',
    `imaging_order_id` BIGINT COMMENT 'FK to the imaging order that generated this study.',
    `modality_id` BIGINT COMMENT 'FK to the imaging modality used.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the radiology radiology study record.',
    `clinician_id` BIGINT COMMENT 'FK to the reading radiologist.',
    `protocol_id` BIGINT COMMENT 'FK to the imaging protocol used.',
    `radiology_reading_radiologist_clinician_id` BIGINT COMMENT 'Unique identifier for the radiology reading radiologist clinician within the radiology radiology study record.',
    `research_study_id` BIGINT COMMENT 'FK to associated research study if applicable.',
    `visit_id` BIGINT COMMENT 'FK to the associated encounter visit.',
    `accession_number` STRING COMMENT 'RIS-assigned accession number for the study.',
    `body_part` STRING COMMENT 'The body part of the radiology radiology study record.',
    `body_part_examined` STRING COMMENT 'Body part imaged.',
    `contrast_administered` BOOLEAN COMMENT 'Whether contrast agent was administered.',
    `contrast_administered_flag` BOOLEAN COMMENT 'The contrast administered flag of the radiology radiology study record.',
    `contrast_used` BOOLEAN COMMENT 'The contrast used of the radiology radiology study record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `critical_finding_flag` BOOLEAN COMMENT 'Indicates a critical finding requiring immediate notification.',
    `critical_finding_notified_timestamp` TIMESTAMP COMMENT 'Timestamp when critical finding was communicated.',
    `dicom_study_instance_uid` STRING COMMENT 'DICOM globally unique study instance UID.',
    `image_count` STRING COMMENT 'Total number of images in the study.',
    `laterality` STRING COMMENT 'Left, right, bilateral, or not applicable.',
    `modality_type` STRING COMMENT 'The modality type value classifying the radiology radiology study record.',
    `mrn` STRING COMMENT 'The mrn of the radiology radiology study record.',
    `mvm_ecm_reconciled_flag` BOOLEAN COMMENT 'The mvm ecm reconciled flag of the radiology radiology study record.',
    `mvm_source_names` STRING COMMENT 'radiology.study mapped to radiology.radiology_study',
    `number_of_images` STRING COMMENT 'The number of images of the radiology radiology study record.',
    `number_of_series` STRING COMMENT 'The number of series of the radiology radiology study record.',
    `pacs_archive_location` STRING COMMENT 'Storage location in PACS.',
    `pacs_status` STRING COMMENT 'Status in the PACS archive.',
    `priority` STRING COMMENT 'Read priority: routine, urgent, stat.',
    `radiation_dose_ctdi` DECIMAL(18,2) COMMENT 'The radiation dose ctdi of the radiology radiology study record.',
    `radiation_dose_ctdi_vol` DECIMAL(18,2) COMMENT 'CT dose index volume in mGy.',
    `radiation_dose_dlp` DECIMAL(18,2) COMMENT 'Dose length product in mGy-cm.',
    `radiology_protocol_id` BIGINT COMMENT 'Unique identifier for the radiology protocol within the radiology radiology study record.',
    `report_finalized_timestamp` TIMESTAMP COMMENT 'Timestamp when the radiology report was finalized.',
    `report_status` STRING COMMENT 'Report status: preliminary, final, addended.',
    `series_count` STRING COMMENT 'Number of DICOM series in the study.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the study acquisition began.',
    `study_date` DATE COMMENT 'Date the study was performed.',
    `study_datetime` TIMESTAMP COMMENT 'Timestamp capturing the study datetime associated with the radiology radiology study record.',
    `study_description` STRING COMMENT 'Description of the imaging study.',
    `study_instance_uid` STRING COMMENT 'The study instance uid of the radiology radiology study record.',
    `study_scope` STRING COMMENT 'The study scope of the radiology radiology study record.',
    `study_status` STRING COMMENT 'Status: ordered, in-progress, completed, cancelled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the radiology radiology study record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_radiology_study PRIMARY KEY(`radiology_study_id`)
) COMMENT 'Canonical radiology study record (ECM superset of MVM radiology.study). Tracks DICOM studies, imaging orders, protocol, dose, and report status across all modalities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` (
    `distribution_rule_id` BIGINT COMMENT 'Primary key for distribution_rule',
    `parent_distribution_rule_id` BIGINT COMMENT 'Self-referencing FK on distribution_rule (parent_distribution_rule_id)',
    `acknowledgment_required` BOOLEAN COMMENT 'Indicates whether recipient read-receipt or closed-loop acknowledgment is mandatory for reports distributed under this rule.',
    `approval_status` STRING COMMENT 'Governance approval state of the distribution rule configuration.',
    `consent_verification_required` BOOLEAN COMMENT 'Indicates whether patient consent must be verified prior to distributing the report under this rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution rule record was first captured.',
    `criticality_level` STRING COMMENT 'Clinical criticality level of findings that this rule applies to, driving expedited notification of critical results.',
    `delivery_channel` STRING COMMENT 'Interface/channel through which the report is distributed to the recipient (HL7 interface, fax, email, patient portal, print, or API).',
    `effective_from_date` DATE COMMENT 'Date on which this distribution rule becomes active and eligible for enforcement.',
    `effective_until_date` DATE COMMENT 'Date on which this distribution rule expires; null indicates open-ended enforcement.',
    `escalation_recipient_role` STRING COMMENT 'Role to which distribution escalates when acknowledgment is not received within the escalation timeout.',
    `escalation_timeout_minutes` STRING COMMENT 'Number of minutes without acknowledgment after which the report distribution escalates to the next recipient or channel.',
    `external_share_allowed` BOOLEAN COMMENT 'Indicates whether reports matched by this rule may be distributed to organizations outside the health system.',
    `include_images` BOOLEAN COMMENT 'Indicates whether associated DICOM image links or renderings are included alongside the distributed report.',
    `message_template_code` STRING COMMENT 'Reference code for the notification/message template applied when formatting the distributed report.',
    `modality_scope` STRING COMMENT 'Imaging modalities to which this rule applies (e.g., CT, MRI, XR, US, PET). [ENUM-REF-CANDIDATE: CT|MRI|XR|US|PET|MG|NM|FL — promote to reference product]',
    `owner_department` STRING COMMENT 'Radiology sub-department or business unit that owns and maintains this distribution rule.',
    `phi_masking_required` BOOLEAN COMMENT 'Indicates whether Protected Health Information (PHI) must be masked or de-identified before distribution, e.g., for external sharing under HIPAA.',
    `priority_order` STRING COMMENT 'Numeric evaluation precedence indicating the order in which competing distribution rules are applied; lower numbers evaluate first.',
    `procedure_scope` STRING COMMENT 'CPT-coded radiology procedure(s) that trigger this distribution rule; comma-delimited CPT codes or code range applicable.',
    `quiet_hours_end` STRING COMMENT 'End of the daily quiet-hours window during which non-critical distributions are suppressed or deferred (HH:mm, 24-hour).',
    `quiet_hours_start` STRING COMMENT 'Start of the daily quiet-hours window during which non-critical distributions are suppressed or deferred (HH:mm, 24-hour).',
    `recipient_endpoint` STRING COMMENT 'Configured target endpoint address for delivery (e.g., HL7 receiving application/facility, direct message address, or interface node) used to route the report.',
    `recipient_role` STRING COMMENT 'Intended recipient role or audience for reports matched by this distribution rule.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this distribution rule supports a mandated regulatory or public-health reporting obligation (e.g., cancer registry, dose reporting).',
    `report_status_trigger` STRING COMMENT 'Radiology report status that triggers evaluation and firing of this distribution rule.',
    `retry_limit` STRING COMMENT 'Maximum number of automatic delivery retry attempts for failed distributions before the rule flags a delivery failure.',
    `rule_code` STRING COMMENT 'Externally-known unique short code used by the RIS/PACS to reference this distribution rule.',
    `rule_description` STRING COMMENT 'Detailed narrative describing the intent and business conditions under which this distribution rule applies.',
    `rule_name` STRING COMMENT 'Human-readable label for the report distribution rule, e.g., STAT CT to ED Physician.',
    `rule_status` STRING COMMENT 'Current lifecycle state of the distribution rule governing whether it is enforced in production.',
    `rule_type` STRING COMMENT 'Categorical classification of the distribution rule behavior (automatic routing, manual review, escalation, carbon-copy, external share, or hold).',
    `source_system` STRING COMMENT 'Originating RIS/PACS system that owns and enforces this distribution rule (e.g., Epic Radiant, Cerner RadNet).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution rule record was last modified.',
    CONSTRAINT pk_distribution_rule PRIMARY KEY(`distribution_rule_id`)
) COMMENT 'Master reference table for distribution_rule. Referenced by distribution_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_parent_protocol_id` FOREIGN KEY (`parent_protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_primary_superseded_by_protocol_id` FOREIGN KEY (`primary_superseded_by_protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_prior_assignment_reader_assignment_id` FOREIGN KEY (`prior_assignment_reader_assignment_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`reader_assignment`(`reader_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_follow_report_id` FOREIGN KEY (`follow_report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_radiology_finding_id` FOREIGN KEY (`radiology_finding_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_finding`(`radiology_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_corrected_history_id` FOREIGN KEY (`corrected_history_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history`(`radiology_order_status_history_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_distribution_rule_id` FOREIGN KEY (`distribution_rule_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`distribution_rule`(`distribution_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_dicom_series_id` FOREIGN KEY (`dicom_series_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`dicom_series`(`dicom_series_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_teleradiology_case_id` FOREIGN KEY (`teleradiology_case_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`teleradiology_case`(`teleradiology_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_radiology_report_id` FOREIGN KEY (`radiology_report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_report_addendum_id` FOREIGN KEY (`report_addendum_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report_addendum`(`report_addendum_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ADD CONSTRAINT `fk_radiology_distribution_rule_parent_distribution_rule_id` FOREIGN KEY (`parent_distribution_rule_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`distribution_rule`(`distribution_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`radiology` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`radiology` SET TAGS ('pii_domain' = 'radiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_entity_type' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Drug');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Material');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `accession_number` SET TAGS ('pii_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `body_part` SET TAGS ('pii_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `contrast_required` SET TAGS ('pii_business_glossary_term' = 'Contrast Required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `exam_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Exam End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `exam_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Exam Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `is_portable` SET TAGS ('pii_business_glossary_term' = 'Is Portable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `is_stat_override` SET TAGS ('pii_business_glossary_term' = 'Is STAT Override');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_priority` SET TAGS ('pii_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_source` SET TAGS ('pii_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordered_timestamp` SET TAGS ('pii_business_glossary_term' = 'Ordered Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `prior_auth_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `prior_auth_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_business_glossary_term' = 'Protocol Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose CTDI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose DLP');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `referring_department` SET TAGS ('pii_business_glossary_term' = 'Referring Department');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `report_finalized_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `scheduled_timestamp` SET TAGS ('pii_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `source_system_order_code` SET TAGS ('pii_business_glossary_term' = 'Source System Order Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_subdomain' = 'study_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_entity_type' = 'clinical_event');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `dicom_series_id` SET TAGS ('pii_business_glossary_term' = 'DICOM Series Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `dicom_series_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Protocol');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Performing Technologist');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `accession_number` SET TAGS ('pii_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `body_part_examined` SET TAGS ('pii_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_agent` SET TAGS ('pii_business_glossary_term' = 'Contrast Bolus Agent');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_route` SET TAGS ('pii_business_glossary_term' = 'Contrast Bolus Route');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_volume_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Bolus Volume');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `cpt_code` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `ctdi_vol_mgy` SET TAGS ('pii_business_glossary_term' = 'CTDI Vol');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `dlp_mgy_cm` SET TAGS ('pii_business_glossary_term' = 'DLP');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `exposure_ma` SET TAGS ('pii_business_glossary_term' = 'Exposure mA');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `exposure_time_ms` SET TAGS ('pii_business_glossary_term' = 'Exposure Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `image_orientation_patient` SET TAGS ('pii_business_glossary_term' = 'Image Orientation Patient');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `kvp` SET TAGS ('pii_business_glossary_term' = 'kVp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `number_of_series_related_instances` SET TAGS ('pii_business_glossary_term' = 'Number of Series Related Instances');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pacs_archive_status` SET TAGS ('pii_business_glossary_term' = 'PACS Archive Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pacs_storage_path` SET TAGS ('pii_business_glossary_term' = 'PACS Storage Path');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `patient_position` SET TAGS ('pii_business_glossary_term' = 'Patient Position');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_business_glossary_term' = 'Performing Physician Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_pii' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `performing_physician_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pixel_spacing_mm` SET TAGS ('pii_business_glossary_term' = 'Pixel Spacing');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_business_glossary_term' = 'Procedure Code Modifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `quality_control_comments` SET TAGS ('pii_business_glossary_term' = 'Quality Control Comments');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `quality_control_status` SET TAGS ('pii_business_glossary_term' = 'Quality Control Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_business_glossary_term' = 'Referring Physician NPI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_pii' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_business_glossary_term' = 'Requesting Physician Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_pii' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_completeness_flag` SET TAGS ('pii_business_glossary_term' = 'Series Completeness Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_date` SET TAGS ('pii_business_glossary_term' = 'Series Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_description` SET TAGS ('pii_business_glossary_term' = 'Series Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_instance_uid` SET TAGS ('pii_business_glossary_term' = 'Series Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_instance_uid` SET TAGS ('pii_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_number` SET TAGS ('pii_business_glossary_term' = 'Series Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_status` SET TAGS ('pii_business_glossary_term' = 'Series Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_time` SET TAGS ('pii_business_glossary_term' = 'Series Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `slice_thickness_mm` SET TAGS ('pii_business_glossary_term' = 'Slice Thickness');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('pii_subdomain' = 'reporting_interpretation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Report Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `direct_message_id` SET TAGS ('pii_business_glossary_term' = 'Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Primary Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Health Level Seven (HL7) Observation Result Unsolicited (ORU) Message ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Addendum Author ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `tertiary_report_reading_radiologist_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Reading Radiologist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Transcriptionist Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_sequence` SET TAGS ('pii_business_glossary_term' = 'Addendum Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('pii_business_glossary_term' = 'Addendum Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_timestamp` SET TAGS ('pii_business_glossary_term' = 'Addendum Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_type` SET TAGS ('pii_business_glossary_term' = 'Addendum Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_type` SET TAGS ('pii_value_regex' = 'addendum|amendment|correction|retraction');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `attestation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Attestation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_administered_flag` SET TAGS ('pii_business_glossary_term' = 'Contrast Administered Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_communicated_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Communicated Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_communicated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Communication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `dictation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Dictation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('pii_business_glossary_term' = 'Findings Narrative Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `follow_up_recommendation` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('pii_business_glossary_term' = 'Impression Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `modality_code` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `preliminary_timestamp` SET TAGS ('pii_business_glossary_term' = 'Preliminary Report Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose CT Dose Index Volume (CTDIvol) mGy');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Dose Length Product (DLP) mGy·cm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `rads_category` SET TAGS ('pii_business_glossary_term' = 'Reporting and Data System (RADS) Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_status` SET TAGS ('pii_value_regex' = 'preliminary|final|addendum|amended|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `ris_report_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Signing Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `stat_priority_flag` SET TAGS ('pii_business_glossary_term' = 'STAT Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `study_datetime` SET TAGS ('pii_business_glossary_term' = 'Study Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `study_description` SET TAGS ('pii_business_glossary_term' = 'Study Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `template_code` SET TAGS ('pii_business_glossary_term' = 'Report Template ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `transcription_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transcription Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` SET TAGS ('pii_subdomain' = 'reporting_interpretation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `report_addendum_id` SET TAGS ('pii_business_glossary_term' = 'Report Addendum ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `cdi_query_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'HL7 Message ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Department ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Original Radiology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Addendum Author Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `tertiary_report_ordering_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `acknowledgment_datetime` SET TAGS ('pii_business_glossary_term' = 'Provider Acknowledgment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_datetime` SET TAGS ('pii_business_glossary_term' = 'Addendum Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Addendum Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_status` SET TAGS ('pii_business_glossary_term' = 'Addendum Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_status` SET TAGS ('pii_value_regex' = 'draft|pending_review|finalized|retracted');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_text` SET TAGS ('pii_business_glossary_term' = 'Addendum Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_text` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_type` SET TAGS ('pii_business_glossary_term' = 'Addendum Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_type` SET TAGS ('pii_value_regex' = 'correction|clarification|clinical_update|addendum|retraction');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `addendum_word_count` SET TAGS ('pii_business_glossary_term' = 'Addendum Word Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `amendment_reason` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `amendment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_business_glossary_term' = 'Addendum Author National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `author_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_value_regex' = '^[0-9]+(.[0-9]+)+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `drg_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Diagnosis-Related Group (DRG) Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `finalized_datetime` SET TAGS ('pii_business_glossary_term' = 'Addendum Finalized Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `him_review_datetime` SET TAGS ('pii_business_glossary_term' = 'Health Information Management (HIM) Review Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `him_review_flag` SET TAGS ('pii_business_glossary_term' = 'Health Information Management (HIM) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `impression_changed_flag` SET TAGS ('pii_business_glossary_term' = 'Impression Changed Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_datetime` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Notification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_method` SET TAGS ('pii_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_method` SET TAGS ('pii_value_regex' = 'in_basket|secure_message|phone|fax|ehr_alert|email');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_status` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Notification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `notification_status` SET TAGS ('pii_value_regex' = 'not_required|pending|sent|acknowledged|failed');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `original_report_finalized_datetime` SET TAGS ('pii_business_glossary_term' = 'Original Report Finalized Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `peer_review_flag` SET TAGS ('pii_business_glossary_term' = 'Peer Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `peer_review_score` SET TAGS ('pii_business_glossary_term' = 'Peer Review Score');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `peer_review_score` SET TAGS ('pii_value_regex' = '1|2a|2b|3a|3b|4');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `source_system_addendum_code` SET TAGS ('pii_business_glossary_term' = 'Source System Addendum ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ALTER COLUMN `voice_recognition_flag` SET TAGS ('pii_business_glossary_term' = 'Voice Recognition Dictation Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('pii_subdomain' = 'study_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Primary Operator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'ACR Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_status` SET TAGS ('pii_business_glossary_term' = 'American College of Radiology (ACR) Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_status` SET TAGS ('pii_value_regex' = 'accredited|provisional|denied|expired|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ae_title` SET TAGS ('pii_business_glossary_term' = 'DICOM Application Entity (AE) Title');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ae_title` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{1,16}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `bore_diameter_cm` SET TAGS ('pii_business_glossary_term' = 'Gantry Bore Diameter (cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `building_code` SET TAGS ('pii_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `contrast_capable` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Capable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `decommission_date` SET TAGS ('pii_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `detector_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Detector Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dicom_modality_code` SET TAGS ('pii_business_glossary_term' = 'DICOM Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dicom_modality_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Tracking Enabled Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `equipment_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Equipment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_510k_number` SET TAGS ('pii_business_glossary_term' = 'FDA 510(k) Clearance Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_510k_number` SET TAGS ('pii_value_regex' = '^K[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_registration_number` SET TAGS ('pii_business_glossary_term' = 'FDA Device Registration Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_registration_number` SET TAGS ('pii_value_regex' = '^[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `installation_date` SET TAGS ('pii_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_business_glossary_term' = 'Mobile Equipment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `last_calibration_date` SET TAGS ('pii_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `last_preventive_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Preventive Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'Equipment Manufacturer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `max_patient_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Maximum Patient Weight Capacity (kg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_business_glossary_term' = 'Equipment Model Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `next_calibration_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `next_preventive_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Next Preventive Maintenance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `operational_status` SET TAGS ('pii_value_regex' = 'active|inactive|under_maintenance|decommissioned|pending_installation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_business_glossary_term' = 'PACS (Picture Archiving and Communication System) Node Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_business_glossary_term' = 'Radiation Emitting Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ris_resource_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_business_glossary_term' = 'Room Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `scheduled_hours_per_day` SET TAGS ('pii_business_glossary_term' = 'Scheduled Operating Hours Per Day');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `serial_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `service_contract_number` SET TAGS ('pii_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `shared_service_indicator` SET TAGS ('pii_business_glossary_term' = 'Shared Service Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `slice_count` SET TAGS ('pii_business_glossary_term' = 'CT Detector Slice Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `software_version` SET TAGS ('pii_business_glossary_term' = 'Equipment Software Version');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `tesla_field_strength` SET TAGS ('pii_business_glossary_term' = 'MRI Magnetic Field Strength (Tesla)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_code` SET TAGS ('pii_business_glossary_term' = 'Modality Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_business_glossary_term' = 'Modality Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_subdomain' = 'study_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_domain' = 'radiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Protocol Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Approving Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinician_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `parent_protocol_id` SET TAGS ('pii_business_glossary_term' = 'Parent Protocol ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `primary_superseded_by_protocol_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Protocol ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `primary_superseded_by_protocol_id` SET TAGS ('pii_self_reference' = 'clean');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_business_glossary_term' = 'ACR Appropriateness Criteria Rating');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_value_regex' = 'usually_appropriate|may_be_appropriate|usually_not_appropriate');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Protocol Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Approving Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_value_regex' = '^d{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_category` SET TAGS ('pii_business_glossary_term' = 'Protocol Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_category` SET TAGS ('pii_value_regex' = 'diagnostic|screening|interventional|research|emergency|pediatric');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_code` SET TAGS ('pii_business_glossary_term' = 'Protocol Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Dose (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_flow_rate_ml_per_sec` SET TAGS ('pii_business_glossary_term' = 'Contrast Flow Rate (mL/sec)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_required` SET TAGS ('pii_business_glossary_term' = 'Contrast Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_route` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Route');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_route` SET TAGS ('pii_value_regex' = 'intravenous|oral|rectal|intrathecal|intra_articular|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_business_glossary_term' = 'Dose Optimization Program');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_value_regex' = 'image_gently|image_wisely|acr_dir|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Protocol Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Fasting Duration (hours)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_business_glossary_term' = 'Fasting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `field_of_view_mm` SET TAGS ('pii_business_glossary_term' = 'Field of View (FOV) (mm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `implant_screening_required` SET TAGS ('pii_business_glossary_term' = 'Implant Screening Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `kvp` SET TAGS ('pii_business_glossary_term' = 'Peak Kilovoltage (kVp)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `magnetic_field_strength_tesla` SET TAGS ('pii_business_glossary_term' = 'Magnetic Field Strength (Tesla)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `mas` SET TAGS ('pii_business_glossary_term' = 'Milliampere-Seconds (mAs)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_business_glossary_term' = 'Protocol Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_business_glossary_term' = 'PACS Routing Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_population` SET TAGS ('pii_business_glossary_term' = 'Patient Population');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_population` SET TAGS ('pii_value_regex' = 'adult|pediatric|neonatal|geriatric|obstetric|all');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_prep_instructions` SET TAGS ('pii_business_glossary_term' = 'Patient Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pitch_factor` SET TAGS ('pii_business_glossary_term' = 'CT Pitch Factor');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_status` SET TAGS ('pii_business_glossary_term' = 'Protocol Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_status` SET TAGS ('pii_value_regex' = 'active|inactive|draft|retired|under_review');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pulse_sequence_type` SET TAGS ('pii_business_glossary_term' = 'MRI Pulse Sequence Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_business_glossary_term' = 'Reference CT Dose Index Volume (CTDIvol) (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_business_glossary_term' = 'Reference Radiation Dose - Dose Length Product (DLP) (mGy·cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radlex_code` SET TAGS ('pii_business_glossary_term' = 'RSNA RadLex Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radlex_code` SET TAGS ('pii_value_regex' = '^RIDd+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `reconstruction_algorithm` SET TAGS ('pii_business_glossary_term' = 'Reconstruction Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `renal_function_check_required` SET TAGS ('pii_business_glossary_term' = 'Renal Function Check Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `retirement_date` SET TAGS ('pii_business_glossary_term' = 'Protocol Retirement Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `scan_duration_estimate_sec` SET TAGS ('pii_business_glossary_term' = 'Estimated Scan Duration (seconds)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `sedation_required` SET TAGS ('pii_business_glossary_term' = 'Sedation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `slice_thickness_mm` SET TAGS ('pii_business_glossary_term' = 'Slice Thickness (mm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `total_exam_duration_min` SET TAGS ('pii_business_glossary_term' = 'Total Exam Duration Estimate (minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `version` SET TAGS ('pii_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('pii_subdomain' = 'study_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_admin_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Admin Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Administering Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Contrast Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Power Injector Device ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `ndc_drug_id` SET TAGS ('pii_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Study ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_business_glossary_term' = 'Administering Clinician National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_value_regex' = '^d{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_datetime` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_status` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_status` SET TAGS ('pii_value_regex' = 'completed|in-progress|not-done|on-hold|stopped|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_datetime` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_occurred` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Occurred Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Severity');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('pii_value_regex' = 'mild|moderate|severe|life-threatening');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_business_glossary_term' = 'Adverse Reaction Treatment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_class` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Class');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_class` SET TAGS ('pii_value_regex' = 'iodinated|gadolinium-based|barium|microbubble|manganese-based|iron-based');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_osmolality_type` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Osmolality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_osmolality_type` SET TAGS ('pii_value_regex' = 'low-osmolality|iso-osmolality|high-osmolality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `body_region` SET TAGS ('pii_business_glossary_term' = 'Imaging Body Region');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `catheter_gauge` SET TAGS ('pii_business_glossary_term' = 'Intravenous Catheter Gauge');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `concentration_mg_per_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Concentration (mg/mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_business_glossary_term' = 'Contrast Allergy Screening Result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_value_regex' = 'no-allergy|prior-reaction|allergy-confirmed|screening-not-done|contraindicated');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_protocol_name` SET TAGS ('pii_business_glossary_term' = 'Contrast Protocol Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_protocol_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_protocol_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_protocol_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_protocol_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_protocol_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_protocol_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_business_glossary_term' = 'Contrast Dose Amount (mg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_business_glossary_term' = 'Contrast Dose Volume (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `extravasation_occurred` SET TAGS ('pii_business_glossary_term' = 'Contrast Extravasation Occurred Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `extravasation_volume_ml` SET TAGS ('pii_business_glossary_term' = 'Extravasation Volume (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `informed_consent_obtained` SET TAGS ('pii_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `injection_rate_ml_per_sec` SET TAGS ('pii_business_glossary_term' = 'Injection Rate (mL/sec)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `injection_site` SET TAGS ('pii_business_glossary_term' = 'Injection Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `metformin_held` SET TAGS ('pii_business_glossary_term' = 'Metformin Held Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Patient Weight at Administration (kg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `power_injector_used` SET TAGS ('pii_business_glossary_term' = 'Power Injector Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_business_glossary_term' = 'Pregnancy Status at Administration');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_value_regex' = 'not-pregnant|pregnant|unknown|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_business_glossary_term' = 'Pre-Medication Details');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_business_glossary_term' = 'Pre-Medication Given Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('pii_business_glossary_term' = 'Prior Contrast Reaction Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `route_of_administration` SET TAGS ('pii_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `route_of_administration` SET TAGS ('pii_value_regex' = 'intravenous|oral|intrathecal|intra-arterial|intraperitoneal|rectal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('pii_business_glossary_term' = 'Thyroid Disease Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` SET TAGS ('pii_subdomain' = 'study_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_business_glossary_term' = 'Dose Record Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'Osha Safety Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_business_glossary_term' = 'Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewing Physicist Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `contrast_administered` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Administered Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `contrast_agent_type` SET TAGS ('pii_business_glossary_term' = 'Contrast Agent Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `contrast_agent_type` SET TAGS ('pii_value_regex' = 'iodinated|gadolinium|barium|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `ctdivol_mgy` SET TAGS ('pii_business_glossary_term' = 'CT Dose Index Volume (CTDIvol) in Milligray (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_business_glossary_term' = 'Cumulative Patient Radiation Dose (mSv)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `cumulative_dose_msv` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dap_gy_cm2` SET TAGS ('pii_business_glossary_term' = 'Dose Area Product (DAP) in Gray-Centimeter Squared (Gy·cm²)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dlp_mgy_cm` SET TAGS ('pii_business_glossary_term' = 'Dose Length Product (DLP) in Milligray-Centimeter (mGy·cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_business_glossary_term' = 'Dose Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_business_glossary_term' = 'Dose Alert Threshold Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_threshold_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_business_glossary_term' = 'Dose Alert Threshold Value');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_alert_value` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_business_glossary_term' = 'Dose Record Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_value_regex' = 'preliminary|final|amended|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_record_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_business_glossary_term' = 'ACR Dose Index Registry (DIR) Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_value_regex' = 'pending|submitted|accepted|rejected|not_required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Dose Registry Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `dose_registry_submission_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `drl_comparison_result` SET TAGS ('pii_business_glossary_term' = 'Diagnostic Reference Level (DRL) Comparison Result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `drl_comparison_result` SET TAGS ('pii_value_regex' = 'below_drl|at_drl|above_drl|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_business_glossary_term' = 'Effective Dose Estimate in Millisievert (mSv)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `effective_dose_msv` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_business_glossary_term' = 'Entrance Skin Dose (ESD) in Milligray (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `entrance_skin_dose_mgy` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `fluoroscopy_time_sec` SET TAGS ('pii_business_glossary_term' = 'Fluoroscopy Time in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `kvp` SET TAGS ('pii_business_glossary_term' = 'Peak Kilovoltage (kVp)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `number_of_exposures` SET TAGS ('pii_business_glossary_term' = 'Number of Exposures');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_age_at_study` SET TAGS ('pii_business_glossary_term' = 'Patient Age at Study (Years)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_size_cm` SET TAGS ('pii_business_glossary_term' = 'Patient Size (Effective Diameter) in Centimeters (cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_size_cm` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_size_cm` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Patient Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `physicist_review_flag` SET TAGS ('pii_business_glossary_term' = 'Medical Physicist Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `physicist_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Medical Physicist Review Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `procedure_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `rdsr_uid` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Structured Report (RDSR) Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `reference_air_kerma_mgy` SET TAGS ('pii_business_glossary_term' = 'Reference Air Kerma (RAK) in Milligray (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_manufacturer` SET TAGS ('pii_business_glossary_term' = 'Scanner Manufacturer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_model` SET TAGS ('pii_business_glossary_term' = 'Scanner Model Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_station_name` SET TAGS ('pii_business_glossary_term' = 'Scanner Station Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_station_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_station_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_station_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_station_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_station_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `scanner_station_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `ssde_mgy` SET TAGS ('pii_business_glossary_term' = 'Size-Specific Dose Estimate (SSDE) in Milligray (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `study_date` SET TAGS ('pii_business_glossary_term' = 'Study Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `study_timestamp` SET TAGS ('pii_business_glossary_term' = 'Study Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `tube_current_mas` SET TAGS ('pii_business_glossary_term' = 'Tube Current-Time Product (mAs)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_domain' = 'radiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_ssot' = 'scheduling.scheduling_appointment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_scope' = 'radiology_department');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_ssot_differentiated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_appointment_context' = 'imaging_workflow');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_ssot_canonical' = 'scheduling.scheduling_appointment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_ssot_primary' = 'scheduling.scheduling_appointment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_ssot_pair' = 'radiology.radiology_appointment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_ssot_reference' = 'scheduling.scheduling_appointment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `eligibility_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Technologist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `encounter_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Encounter Authorization');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `member_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Member Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Modality Room ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_room_id` SET TAGS ('pii_business_glossary_term' = 'Room');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiology_visit_reason_icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `referral_order_id` SET TAGS ('pii_business_glossary_term' = 'Referral Order');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `tertiary_radiology_referring_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Referring Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `enterprise_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Enterprise Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `actual_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `actual_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_comment` SET TAGS ('pii_business_glossary_term' = 'Appointment Comment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_number` SET TAGS ('pii_business_glossary_term' = 'Appointment Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_status` SET TAGS ('pii_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_status` SET TAGS ('pii_value_regex' = 'scheduled|arrived|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `appointment_type` SET TAGS ('pii_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `arrival_timestamp` SET TAGS ('pii_business_glossary_term' = 'Arrival Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `auth_status` SET TAGS ('pii_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `auth_status` SET TAGS ('pii_value_regex' = 'approved|pending|denied|not_required|expired');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `billing_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Billing Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `booking_channel` SET TAGS ('pii_business_glossary_term' = 'Booking Channel');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `booking_timestamp` SET TAGS ('pii_business_glossary_term' = 'Booking Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancellation Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_business_glossary_term' = 'Cancelled By');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('pii_business_glossary_term' = 'Check-In Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `confirmation_status` SET TAGS ('pii_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `confirmation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Confirmation Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `contrast_required` SET TAGS ('pii_business_glossary_term' = 'Contrast Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `contrast_type` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `contrast_type` SET TAGS ('pii_value_regex' = 'IV|oral|intrathecal|intra_articular|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `end_timestamp` SET TAGS ('pii_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('pii_business_glossary_term' = 'Insurance Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `insurance_verification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Insurance Verification Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `is_portable` SET TAGS ('pii_business_glossary_term' = 'Portable Imaging Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `is_stat` SET TAGS ('pii_business_glossary_term' = 'STAT Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `modality_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `no_show_flag` SET TAGS ('pii_business_glossary_term' = 'No Show');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `no_show_reason` SET TAGS ('pii_business_glossary_term' = 'No-Show Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_business_glossary_term' = 'Picture Archiving and Communication System (PACS) Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_value_regex' = '^[0-9]+(.[0-9]+)+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `patient_device_type` SET TAGS ('pii_business_glossary_term' = 'Patient Device Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `patient_location` SET TAGS ('pii_business_glossary_term' = 'Patient Location at Time of Appointment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `prep_instructions` SET TAGS ('pii_business_glossary_term' = 'Patient Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `prior_auth_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Pre-Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `procedure_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `provider_attestation_flag` SET TAGS ('pii_business_glossary_term' = 'Provider Attestation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Tracking Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `reschedule_count` SET TAGS ('pii_business_glossary_term' = 'Reschedule Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `ris_appointment_code` SET TAGS ('pii_business_glossary_term' = 'Radiology Information System (RIS) Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `roomed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Roomed Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Scheduled Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduling_source` SET TAGS ('pii_business_glossary_term' = 'Scheduling Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `scheduling_source` SET TAGS ('pii_value_regex' = 'provider_referral|patient_self|order_based|transfer|walk_in|portal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_business_glossary_term' = 'Telehealth Access Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_business_glossary_term' = 'Telehealth Connection Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session URL');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_modality` SET TAGS ('pii_business_glossary_term' = 'Visit Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_reason` SET TAGS ('pii_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ALTER COLUMN `visit_reason_code` SET TAGS ('pii_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` SET TAGS ('pii_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `reader_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Reader Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Radiologist Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `prior_assignment_reader_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Prior Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Study ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `report_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `stark_arrangement_id` SET TAGS ('pii_business_glossary_term' = 'Stark Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `addendum_flag` SET TAGS ('pii_business_glossary_term' = 'Report Addendum Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `addendum_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Addendum Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assigned_timestamp` SET TAGS ('pii_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_source` SET TAGS ('pii_business_glossary_term' = 'Assignment Source Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_source` SET TAGS ('pii_value_regex' = 'worklist_auto|manual|teleradiology_vendor|ai_routing|escalation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_value_regex' = 'assigned|in_progress|completed|cancelled|reassigned|pending');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_business_glossary_term' = 'Reader Assignment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_value_regex' = 'primary_read|second_read|peer_review|overread|teleradiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `body_part` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `contrast_used` SET TAGS ('pii_business_glossary_term' = 'Contrast Administration Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `critical_finding_notified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `dictation_method` SET TAGS ('pii_business_glossary_term' = 'Dictation Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `dictation_method` SET TAGS ('pii_value_regex' = 'voice_recognition|manual_transcription|structured_reporting|template');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `image_count` SET TAGS ('pii_business_glossary_term' = 'DICOM Image Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `is_teleradiology` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Assignment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_business_glossary_term' = 'Picture Archiving and Communication System (PACS) Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `pacs_study_uid` SET TAGS ('pii_value_regex' = '^[0-9]+(.[0-9]+)+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `peer_review_category` SET TAGS ('pii_business_glossary_term' = 'Peer Review Discrepancy Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `peer_review_category` SET TAGS ('pii_value_regex' = 'agree|minor_discrepancy|significant_discrepancy|major_discrepancy');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `peer_review_score` SET TAGS ('pii_business_glossary_term' = 'Peer Review Score');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `peer_review_score` SET TAGS ('pii_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Study Read Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'stat|urgent|routine|scheduled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose Length Product (DLP) mGy·cm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `read_complete_timestamp` SET TAGS ('pii_business_glossary_term' = 'Read Completion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `read_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Read Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `reading_site` SET TAGS ('pii_business_glossary_term' = 'Reading Site Location');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `reassignment_reason` SET TAGS ('pii_business_glossary_term' = 'Reassignment Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `report_signed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Signed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `rvu_value` SET TAGS ('pii_business_glossary_term' = 'Relative Value Unit (RVU) Value');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `sla_met` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Met Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `sla_target_minutes` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `subspecialty_match` SET TAGS ('pii_business_glossary_term' = 'Subspecialty Match Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `subspecialty_required` SET TAGS ('pii_business_glossary_term' = 'Required Radiologist Subspecialty');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `tat_minutes` SET TAGS ('pii_business_glossary_term' = 'Turnaround Time (TAT) Minutes');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Routing Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_value_regex' = 'after_hours|subspecialty_gap|volume_overflow|coverage_gap|stat_backup');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_routing_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_business_glossary_term' = 'Teleradiology Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `teleradiology_vendor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `vendor_accession_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ALTER COLUMN `worklist_code` SET TAGS ('pii_business_glossary_term' = 'RIS Worklist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('pii_subdomain' = 'reporting_interpretation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` SET TAGS ('pii_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `interpreting_radiologist_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `routing_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` SET TAGS ('pii_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `radiology_finding_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `population_health_cohort` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` SET TAGS ('pii_subdomain' = 'study_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `interventional_procedure_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `lab_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `room_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `blood_loss_ml` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `blood_loss_ml` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `blood_loss_ml` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `blood_loss_ml` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `blood_loss_ml` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `blood_loss_ml` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `blood_loss_ml` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `cancelled_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `device_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `icd10_post_procedure_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `operator_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `operator_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `operator_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `operator_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `operator_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `operator_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `operator_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `operator_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `performing_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_approach` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_end_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_start_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap_gycm2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap_gycm2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap_gycm2` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap_gycm2` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap_gycm2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap_gycm2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_dap_gycm2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_kerma_mgy` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_kerma_mgy` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_kerma_mgy` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_kerma_mgy` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_kerma_mgy` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_kerma_mgy` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `radiation_dose_kerma_mgy` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `sedation_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_collected_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_obtained_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_obtained_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_obtained_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_obtained_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_obtained_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_obtained_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_obtained_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` SET TAGS ('pii_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `corrected_history_id` SET TAGS ('pii_relationship' = 'correction');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `radiology_changed_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `radiology_changed_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `cancellation_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `cancellation_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `cancellation_category` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `cancellation_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `cancellation_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `cancellation_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `changed_by_user_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_subdomain' = 'external_distribution');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_association_edges' = 'radiology.report,interoperability.trading_partner');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Recipient Clinician');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `distribution_method` SET TAGS ('pii_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_business_glossary_term' = 'Recipient Email');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_business_glossary_term' = 'Recipient Fax');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_fax_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `recipient_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_subdomain' = 'external_distribution');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_association_edges' = 'radiology.study,interoperability.trading_partner');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_ae_title` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_ae_title` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_ae_title` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_ae_title` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_ae_title` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_ae_title` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_ae_title` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_system` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_system` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_system` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_system` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_system` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `destination_system` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_subdomain' = 'external_distribution');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_association_edges' = 'radiology.modality,insurance.provider_network');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `accepting_new_referrals_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `accepting_new_referrals_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `accepting_new_referrals_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `accepting_new_referrals_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `accepting_new_referrals_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `accepting_new_referrals_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `accepting_new_referrals_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_subdomain' = 'reporting_interpretation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_ssot_canonical' = 'clinical.clinical_finding');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_ssot_note' = 'radiology.radiology_finding retained as radiology-specific subtype');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_ssot_primary' = 'clinical.clinical_finding');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_ssot_duplicate_of' = 'clinical.clinical_finding');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` SET TAGS ('pii_duplicate_of' = 'clinical.clinical_finding');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `clinical_finding_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `finding_domain` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_subdomain' = 'reporting_interpretation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_scope' = 'radiology_specialty');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot_differentiated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_review_context' = 'radpeer_diagnostic_accuracy');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot_canonical' = 'quality.quality_peer_review');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot_primary' = 'quality.quality_peer_review');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot_duplicate_of' = 'quality.quality_peer_review');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` SET TAGS ('pii_duplicate_of' = 'quality.quality_peer_review');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `clinical_history_available_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_clinical_significance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_clinical_significance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_clinical_significance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_clinical_significance` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_clinical_significance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_clinical_significance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `discrepancy_clinical_significance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `original_radiologist_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `peer_review_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `reviewer_radiologist_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_subdomain' = 'study_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_mvm_alias' = 'radiology.study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ssot_canonical' = 'research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ssot_note' = 'Distinct concepts; enforce naming clarity');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ssot_pair' = 'research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_duplicate_of' = 'research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ssot_primary' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_mvm_ecm_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` SET TAGS ('pii_ecm_superset' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiology_study_id` SET TAGS ('pii_business_glossary_term' = 'Radiology Study Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `imaging_order_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `modality_id` SET TAGS ('pii_business_glossary_term' = 'Modality Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `protocol_id` SET TAGS ('pii_business_glossary_term' = 'Imaging Protocol Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `accession_number` SET TAGS ('pii_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `body_part_examined` SET TAGS ('pii_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `contrast_administered` SET TAGS ('pii_business_glossary_term' = 'Contrast Administered');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `critical_finding_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `critical_finding_notified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Critical Finding Notified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('pii_business_glossary_term' = 'DICOM Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `image_count` SET TAGS ('pii_business_glossary_term' = 'Image Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_business_glossary_term' = 'radiology.study');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `pacs_archive_location` SET TAGS ('pii_business_glossary_term' = 'PACS Archive Location');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `pacs_status` SET TAGS ('pii_business_glossary_term' = 'PACS Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose CTDIvol');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_ctdi_vol` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_business_glossary_term' = 'Radiation Dose DLP');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `report_finalized_timestamp` SET TAGS ('pii_business_glossary_term' = 'Report Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `series_count` SET TAGS ('pii_business_glossary_term' = 'Series Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_date` SET TAGS ('pii_business_glossary_term' = 'Study Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_description` SET TAGS ('pii_business_glossary_term' = 'Study Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `study_status` SET TAGS ('pii_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` SET TAGS ('pii_subdomain' = 'external_distribution');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `distribution_rule_id` SET TAGS ('pii_business_glossary_term' = 'Distribution Rule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `parent_distribution_rule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_scope` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_scope` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_scope` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_scope` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_scope` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_scope` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `procedure_scope` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `recipient_endpoint` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`distribution_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_mask_non_prod' = 'true');
