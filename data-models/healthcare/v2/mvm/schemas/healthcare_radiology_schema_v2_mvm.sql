-- Schema for Domain: radiology | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`radiology` COMMENT 'Medical imaging and diagnostic radiology services. Owns imaging orders, modality scheduling (CT, MRI, X-ray, ultrasound, PET), PACS (Picture Archiving and Communication System) integration, radiology reports, DICOM image metadata, contrast administration, radiation dose tracking, radiologist interpretations, and CPT-coded procedures. Integrates with RIS (Radiology Information System) including Epic Radiant and Cerner RadNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` (
    `imaging_order_id` BIGINT COMMENT 'Unique identifier for the imaging order.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Radiology charge capture maps each imaging procedure to a CDM entry to determine the billable item, price, and revenue code. This procedure-to-CDM mapping is a standard radiology billing configuration',
    `drug_master_id` BIGINT COMMENT 'Contrast agent drug master record.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Coverage policy determination is required at imaging order creation to validate medical necessity, confirm procedure coverage, and satisfy payer documentation requirements. Radiology utilization manag',
    `demographics_id` BIGINT COMMENT 'Patient demographic record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Imaging orders are placed based on a clinical diagnosis for prior authorization, clinical decision support, and ICD-10 coding compliance. Payers require diagnosis linkage on imaging orders. A radiolog',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Imaging orders require member enrollment verification to confirm active coverage, benefit period validity, and network participation at order creation. This supports eligibility-at-time-of-service doc',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Imaging orders originate from a specific facility (hospital, imaging center). Billing, network adequacy reporting, and referral pattern analysis by facility require direct FK to org_provider. No exist',
    `payer_id` BIGINT COMMENT 'Insurance payer.',
    `clinician_id` BIGINT COMMENT 'Clinician who ordered the imaging study.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Advanced imaging (MRI, CT, PET) requires prior authorization governed by specific payer rules. imaging_order already tracks prior_auth_number and prior_auth_status as instance data; linking to the gov',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Radiology scheduling and billing workflows require PA validation before imaging procedures. Linking imaging_order directly to prior_authorization enables real-time PA status checks, eliminates denorma',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: An imaging order specifies the acquisition protocol to be used for the study. imaging_order currently stores protocol_name as a denormalized STRING. Adding protocol_id FK normalizes this reference to ',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Imaging orders placed as a result of a specialist referral require direct traceability to the originating referral_order for prior authorization validation, referral loop closure reporting, and payer ',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Inpatient imaging orders are placed within the context of an ADT registration event that determines patient class, financial class, and order routing rules. Linking imaging_order to registration_event',
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
    `procedure_description` STRING COMMENT 'Description of the imaging procedure.',
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
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: A DICOM series belongs to a specific imaging study, which corresponds to an imaging order in the RIS. This is a fundamental RIS/PACS relationship — every DICOM series is acquired as part of a study or',
    `protocol_id` BIGINT COMMENT 'Imaging protocol used for the series.',
    `modality_id` BIGINT COMMENT 'Foreign key linking to radiology.modality. Business justification: A DICOM series is acquired on a specific physical imaging equipment unit (modality). dicom_series currently only carries a free-text modality string plus denormalized equipment descriptors (manufactur',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: DICOM series are acquired at a specific facility. ACR accreditation tracking, NRDR dose registry reporting, and equipment-facility association for CMS certification all require knowing which org_provi',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: dicom_series.performing_physician_name is a denormalized clinician name. The performing physician must be linked to provider.clinician for credentialing verification, dose attribution, and MIPS qualit',
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
    `contrast_admin_id` BIGINT COMMENT 'Foreign key linking to radiology.contrast_admin. Business justification: A radiology report documents the findings from an imaging study, including contrast administration details. report currently stores contrast_agent_name as a denormalized STRING and contrast_administer',
    `imaging_order_id` BIGINT COMMENT 'Reference to the parent imaging order that triggered this radiology report. Links the report back to the order management workflow in the radiology domain.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of the imaging study and this report. Protected Health Information (PHI) under HIPAA. Links to the Master Patient Index (MPI).',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Radiology reports are generated at a specific performing facility. CMS billing (place of service), ACR quality reporting, and credentialing verification of reading radiologists by facility all require',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who authored the addendum or amendment. May differ from the original signing radiologist. Null for the original report.',
    `tertiary_report_reading_radiologist_clinician_id` BIGINT COMMENT 'Reference to the radiologist who performed the primary interpretation of the imaging study. May differ from the signing radiologist in teaching or supervisory contexts (e.g., resident reads, attending signs). Used for productivity tracking and RVU attribution.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit) during which the imaging study was ordered and performed. Enables linkage to the patient visit context for clinical and revenue cycle workflows.',
    `accession_number` STRING COMMENT 'Externally-known unique identifier assigned by the Radiology Information System (RIS) to the imaging order and its associated report. Used as the primary cross-system business key linking the report to the imaging order, PACS, and billing systems. Sourced from Epic Radiant and Cerner RadNet.',
    `addendum_sequence` STRING COMMENT 'Sequential number identifying the addendum within the reports amendment history. Null for the original report. Increments with each addendum or amendment added post-finalization. Used to order and display the full report amendment history.',
    `addendum_text` STRING COMMENT 'Full text content of the addendum or amendment added to the report post-finalization. Contains Protected Health Information (PHI). Null for the original report. Preserves the complete amendment history as versioned child records.',
    `addendum_timestamp` TIMESTAMP COMMENT 'Date and time when the addendum or amendment was authored and signed. Null for the original report. Used to track the timeline of post-final modifications.',
    `addendum_type` STRING COMMENT 'Classifies the type of post-final modification to the report. Addendum adds new information without changing the original; amendment modifies existing content; correction fixes a factual error; retraction withdraws the report. Null for the original report.. Valid values are `addendum|amendment|correction|retraction`',
    `attestation_timestamp` TIMESTAMP COMMENT 'Date and time when the signing radiologist attested and finalized the report, transitioning it to final status. This is the principal business event timestamp for the report lifecycle. Required for billing, legal, and compliance purposes.',
    `body_part` STRING COMMENT 'Anatomical region or body part that was the subject of the imaging study (e.g., CHEST, ABDOMEN, BRAIN, KNEE). Sourced from DICOM tag (0018,0015) and RIS order. Used for clinical classification and CPT code validation.',
    `contrast_administered_flag` BOOLEAN COMMENT 'Indicates whether contrast agent was administered during the imaging study. Relevant for CPT code selection, billing accuracy, radiation safety, and clinical documentation of contrast reactions.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`modality` (
    `modality_id` BIGINT COMMENT 'Unique surrogate identifier for the imaging modality unit within the enterprise data platform. Primary key for the modality master reference entity.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Each modality (CT, MRI scanner) is physically located at and operated by a specific org_provider. ACR accreditation, CMS equipment certification, and service contract management all require knowing wh',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: Each physical radiology modality (CT, MRI, X-ray room) must map to its corresponding schedulable_resource to enable equipment-level scheduling, maintenance window blocking, and utilization reporting. ',
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
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Imaging protocols define standard contrast agents for specific exam types. FK to drug_master ensures protocol-formulary alignment, supports automated order validation, and enables protocol updates whe',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Imaging protocols are authored and governed by specific facilities. Protocol governance workflows, ACR compliance audits, and multi-site protocol standardization programs require knowing which org_pro',
    `parent_protocol_id` BIGINT COMMENT 'Reference to the imaging_protocol_id of the parent protocol from which this protocol was derived or branched (e.g., a pediatric variant derived from an adult protocol). Supports protocol hierarchy and variant management within the Radiant protocol library.',
    `primary_superseded_by_protocol_id` BIGINT COMMENT 'Reference to the imaging_protocol_id of the newer protocol version that replaced this one upon retirement. Enables forward navigation through protocol version history and ensures continuity of care documentation.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Pre-procedure lab requirement definition: radiology protocols (e.g., contrast MRI, CT angiography) specify mandatory pre-procedure lab tests (eGFR, creatinine, PT/INR). Linking protocol to test_catalo',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Imaging protocols are subspecialty-specific (neuroradiology, musculoskeletal, body imaging). Protocol library management, specialty-specific prior authorization rules, and ordering decision support al',
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
    `allergy_id` BIGINT COMMENT 'Foreign key linking to clinical.allergy. Business justification: Contrast administration safety protocols require screening against the patients allergy record (especially prior contrast reactions and drug allergies). Linking contrast_admin to the specific allergy',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who received the contrast agent. Links to the Master Patient Index (MPI) record. Protected Health Information (PHI) under HIPAA.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Contrast agents are medications managed in pharmacy formulary. Currently has agent_name and ndc_code as text. FK to drug_master normalizes contrast agent data, enables allergy checking, formulary mana',
    `imaging_order_id` BIGINT COMMENT 'Reference to the parent imaging order that triggered this contrast administration event. Links to the radiology order in Epic Radiant or Cerner RadNet.',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: A contrast administration event is performed according to a specific radiology protocol that defines contrast agent, dose, flow rate, and route. contrast_admin currently stores contrast_protocol_name ',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`appointment` (
    `appointment_id` BIGINT COMMENT 'Primary key for appointment',
    `clinician_id` BIGINT COMMENT 'Primary clinician for the appointment',
    `appointment_type_id` BIGINT COMMENT 'Type of appointment (office visit, procedure, etc)',
    `care_plan_id` BIGINT COMMENT 'Associated care plan if appointment is part of care coordination',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Imaging appointments fulfill clinical orders. Scheduling workflows require linking appointments to orders for prep instruction delivery, authorization verification, and patient communication. Operatio',
    `demographics_id` BIGINT COMMENT 'Patient demographic information',
    `diagnosis_id` BIGINT COMMENT 'Primary diagnosis for appointment',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: A radiology appointment is scheduled to fulfill a specific imaging order. This is a core RIS workflow relationship — the imaging order drives the scheduling of the appointment. radiology_appointment c',
    `member_enrollment_id` BIGINT COMMENT 'Member enrollment record',
    `modality_id` BIGINT COMMENT 'Unique identifier for the modality within the radiology radiology appointment record.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient receiving the imaging service. Serves as the PARTY_REFERENCE for this transaction, linking to the patient master record.',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: Booking a radiology appointment consumes a specific open slot. This link supports slot utilization reporting, overbooking prevention, and scheduling capacity analytics — a core operational need in any',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Radiology appointments are performed at a specific org_provider (hospital, imaging center). Scheduling, network directory accuracy, and facility-level utilization reporting all require direct facility',
    `payer_id` BIGINT COMMENT 'Insurance payer',
    `primary_radiology_clinician_id` BIGINT COMMENT 'Reference to the clinician who placed the imaging order that generated this appointment. Used for referral tracking, utilization management, and RVU attribution.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Radiology appointment confirmation requires active PA verification. Direct FK to prior_authorization replaces denormalized prior_auth_number and auth_status fields, enabling schedulers to enforce PA r',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: A radiology appointment is scheduled according to a specific acquisition protocol that determines patient prep instructions, contrast requirements, fasting duration, and scan parameters. radiology_app',
    `referral_order_id` BIGINT COMMENT 'Referral order if appointment is from referral',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Inpatient and ED radiology appointments are initiated from an ADT registration event. Linking the appointment to the registration_event enables correct financial class assignment, patient class routin',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: Radiology appointments are booked against a specific schedulable resource (imaging room, scanner suite). This link enables room/equipment double-booking prevention and resource utilization reporting —',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Radiology scheduling operations generate recurring appointments (annual mammography, MRI surveillance) from standing orders. Linking radiology_appointment to standing_order enables scheduling systems ',
    `tertiary_radiology_referring_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who referred the patient for this imaging study, which may differ from the ordering provider. Used for referral analytics, network management, and payer reporting.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit associated with this imaging appointment. Connects the radiology scheduling event to the broader patient visit context.',
    `accession_number` STRING COMMENT 'Unique identifier assigned by the Radiology Information System (RIS) to this imaging study appointment. Used as the primary cross-system identifier linking the RIS, PACS, and EHR for this imaging event. Conforms to DICOM accession number format.',
    `actual_end_datetime` TIMESTAMP COMMENT 'The actual date and time the imaging procedure concluded. Combined with actual_start_datetime to compute actual procedure duration for throughput and capacity analytics.',
    `actual_start_datetime` TIMESTAMP COMMENT 'The actual date and time the imaging procedure began (patient on table / scan initiated). Used to measure schedule adherence, wait times, and operational efficiency.',
    `appointment_number` STRING COMMENT 'Human-readable appointment identifier',
    `appointment_status` STRING COMMENT 'Current workflow state of the radiology imaging appointment. Tracks the full lifecycle from initial scheduling through completion or cancellation. Aligns with IHE SWF appointment status codes.. Valid values are `scheduled|arrived|in_progress|completed|cancelled|no_show`',
    `appointment_type` STRING COMMENT 'Clinical classification of the imaging appointment indicating the urgency and purpose of the study. Drives scheduling priority, slot allocation, and workflow routing. [ENUM-REF-CANDIDATE: routine|urgent|stat|screening|follow_up|pre_op|research — promote to reference product if additional types are needed]',
    `arrival_timestamp` TIMESTAMP COMMENT 'Timestamp when patient arrived',
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
    `comment` STRING COMMENT 'Free-text clinical or operational notes associated with the imaging appointment (e.g., special patient needs, equipment requirements, interpreter needed, claustrophobia notes for MRI). Not intended for clinical documentation.',
    `confirmation_status` STRING COMMENT 'The confirmation status value classifying the radiology radiology appointment record.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'When appointment was confirmed',
    `contrast_required` BOOLEAN COMMENT 'Indicates whether intravenous or oral contrast agent is required for this imaging study. Drives pre-appointment prep instructions, allergy screening, renal function checks, and contrast timing workflows.',
    `contrast_type` STRING COMMENT 'The route of contrast agent administration planned for this imaging study. Used for pre-procedure preparation, patient safety screening, and contrast administration documentation.. Valid values are `IV|oral|intrathecal|intra_articular|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this imaging appointment record was first created in the system. Serves as the audit creation timestamp for data lineage, compliance, and change tracking.',
    `domain` STRING COMMENT 'Domain discriminator: RADIOLOGY or SCHEDULING',
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
    `scope` STRING COMMENT 'The appointment scope of the radiology radiology appointment record.',
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
    CONSTRAINT pk_appointment PRIMARY KEY(`appointment_id`)
) COMMENT 'SSOT resolved: defer to scheduling.scheduling_appointment as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` (
    `critical_result_id` BIGINT COMMENT 'Primary key',
    `clinical_order_id` BIGINT COMMENT 'FK to clinical order',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: TJC and CMS require critical radiology findings to be linked to the patients active diagnosis for safety event tracking and regulatory reporting. Linking critical_result to the clinical diagnosis sup',
    `imaging_order_id` BIGINT COMMENT 'FK to imaging order',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: TJC critical result reporting and patient safety event tracking require linking critical findings to the enterprise MPI record for cross-encounter patient identity resolution. Regulatory compliance (T',
    `clinician_id` BIGINT COMMENT 'FK to clinician who identified critical result',
    `report_id` BIGINT COMMENT 'FK to radiology report',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_contrast_admin_id` FOREIGN KEY (`contrast_admin_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`contrast_admin`(`contrast_admin_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_parent_protocol_id` FOREIGN KEY (`parent_protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_primary_superseded_by_protocol_id` FOREIGN KEY (`primary_superseded_by_protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ADD CONSTRAINT `fk_radiology_appointment_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ADD CONSTRAINT `fk_radiology_appointment_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ADD CONSTRAINT `fk_radiology_appointment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`radiology` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`radiology` SET TAGS ('dbx_domain' = 'radiology');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Contrast Drug');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `accession_number` SET TAGS ('dbx_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `body_part` SET TAGS ('dbx_business_glossary_term' = 'Body Part');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `body_part` SET TAGS ('dbx_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `contrast_required` SET TAGS ('dbx_business_glossary_term' = 'Contrast Required');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `critical_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `exam_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exam End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `exam_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exam Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `is_portable` SET TAGS ('dbx_business_glossary_term' = 'Is Portable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `is_stat_override` SET TAGS ('dbx_business_glossary_term' = 'Is STAT Override');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `modality_type` SET TAGS ('dbx_business_glossary_term' = 'Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ordered Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `procedure_description` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_business_glossary_term' = 'Radiation Dose CTDI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_business_glossary_term' = 'Radiation Dose DLP');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `referring_department` SET TAGS ('dbx_business_glossary_term' = 'Referring Department');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `report_finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Finalized Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `source_system_order_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Order Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` SET TAGS ('dbx_subdomain' = 'image_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `dicom_series_id` SET TAGS ('dbx_business_glossary_term' = 'DICOM Series Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `dicom_series_id` SET TAGS ('dbx_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Protocol');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `modality_id` SET TAGS ('dbx_business_glossary_term' = 'Modality Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `accession_number` SET TAGS ('dbx_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `body_part_examined` SET TAGS ('dbx_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `body_part_examined` SET TAGS ('dbx_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_agent` SET TAGS ('dbx_business_glossary_term' = 'Contrast Bolus Agent');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_route` SET TAGS ('dbx_business_glossary_term' = 'Contrast Bolus Route');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `contrast_bolus_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Contrast Bolus Volume');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `ctdi_vol_mgy` SET TAGS ('dbx_business_glossary_term' = 'CTDI Vol');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `dlp_mgy_cm` SET TAGS ('dbx_business_glossary_term' = 'DLP');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `exposure_ma` SET TAGS ('dbx_business_glossary_term' = 'Exposure mA');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `exposure_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Exposure Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `image_orientation_patient` SET TAGS ('dbx_business_glossary_term' = 'Image Orientation Patient');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `kvp` SET TAGS ('dbx_business_glossary_term' = 'kVp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `modality` SET TAGS ('dbx_business_glossary_term' = 'Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `number_of_series_related_instances` SET TAGS ('dbx_business_glossary_term' = 'Number of Series Related Instances');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pacs_archive_status` SET TAGS ('dbx_business_glossary_term' = 'PACS Archive Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pacs_storage_path` SET TAGS ('dbx_business_glossary_term' = 'PACS Storage Path');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `patient_position` SET TAGS ('dbx_business_glossary_term' = 'Patient Position');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `pixel_spacing_mm` SET TAGS ('dbx_business_glossary_term' = 'Pixel Spacing');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code Modifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `procedure_code_modifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `quality_control_comments` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Comments');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('dbx_business_glossary_term' = 'Radiation Dose');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `radiation_dose_mgy` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_business_glossary_term' = 'Referring Physician NPI');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_pii' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Physician Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_pii' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `requesting_physician_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_completeness_flag` SET TAGS ('dbx_business_glossary_term' = 'Series Completeness Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_date` SET TAGS ('dbx_business_glossary_term' = 'Series Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_description` SET TAGS ('dbx_business_glossary_term' = 'Series Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_instance_uid` SET TAGS ('dbx_business_glossary_term' = 'Series Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_instance_uid` SET TAGS ('dbx_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_number` SET TAGS ('dbx_business_glossary_term' = 'Series Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_status` SET TAGS ('dbx_business_glossary_term' = 'Series Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `series_time` SET TAGS ('dbx_business_glossary_term' = 'Series Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `slice_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Slice Thickness');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` SET TAGS ('dbx_subdomain' = 'clinical_interpretation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_admin_id` SET TAGS ('dbx_business_glossary_term' = 'Contrast Admin Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Addendum Author ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `tertiary_report_reading_radiologist_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reading Radiologist ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_sequence` SET TAGS ('dbx_business_glossary_term' = 'Addendum Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('dbx_business_glossary_term' = 'Addendum Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Addendum Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_type` SET TAGS ('dbx_business_glossary_term' = 'Addendum Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `addendum_type` SET TAGS ('dbx_value_regex' = 'addendum|amendment|correction|retraction');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `attestation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attestation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `body_part` SET TAGS ('dbx_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `contrast_administered_flag` SET TAGS ('dbx_business_glossary_term' = 'Contrast Administered Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_communicated_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Finding Communicated Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_communicated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Critical Finding Communication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `critical_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `dicom_study_instance_uid` SET TAGS ('dbx_business_glossary_term' = 'DICOM Study Instance Unique Identifier (UID)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `dictation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dictation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('dbx_business_glossary_term' = 'Findings Narrative Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `findings_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `follow_up_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('dbx_business_glossary_term' = 'Impression Text');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `impression_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unspecified');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `modality_code` SET TAGS ('dbx_business_glossary_term' = 'Imaging Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `preliminary_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Report Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_business_glossary_term' = 'Radiation Dose CT Dose Index Volume (CTDIvol) mGy');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_ctdi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_business_glossary_term' = 'Radiation Dose Dose Length Product (DLP) mGy·cm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `radiation_dose_dlp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `rads_category` SET TAGS ('dbx_business_glossary_term' = 'Reporting and Data System (RADS) Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|addendum|amended|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `ris_report_code` SET TAGS ('dbx_business_glossary_term' = 'Radiology Information System (RIS) Report ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_business_glossary_term' = 'Signing Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `signing_radiologist_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `stat_priority_flag` SET TAGS ('dbx_business_glossary_term' = 'STAT Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `study_datetime` SET TAGS ('dbx_business_glossary_term' = 'Study Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `study_description` SET TAGS ('dbx_business_glossary_term' = 'Study Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Report Template ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `transcription_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transcription Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` SET TAGS ('dbx_subdomain' = 'image_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `modality_id` SET TAGS ('dbx_business_glossary_term' = 'Modality ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'ACR Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'American College of Radiology (ACR) Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `acr_accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|expired|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ae_title` SET TAGS ('dbx_business_glossary_term' = 'DICOM Application Entity (AE) Title');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ae_title` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,16}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `bore_diameter_cm` SET TAGS ('dbx_business_glossary_term' = 'Gantry Bore Diameter (cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `contrast_capable` SET TAGS ('dbx_business_glossary_term' = 'Contrast Administration Capable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `department_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `detector_type` SET TAGS ('dbx_business_glossary_term' = 'Imaging Detector Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dicom_modality_code` SET TAGS ('dbx_business_glossary_term' = 'DICOM Modality Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dicom_modality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radiation Dose Tracking Enabled Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `dose_tracking_enabled` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Imaging Equipment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_510k_number` SET TAGS ('dbx_business_glossary_term' = 'FDA 510(k) Clearance Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_510k_number` SET TAGS ('dbx_value_regex' = '^K[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Device Registration Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('dbx_business_glossary_term' = 'Mobile Equipment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `is_mobile` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `last_preventive_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preventive Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Equipment Manufacturer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `max_patient_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Patient Weight Capacity (kg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `model_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `next_preventive_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance Due Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_maintenance|decommissioned|pending_installation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('dbx_business_glossary_term' = 'PACS (Picture Archiving and Communication System) Node Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `pacs_node_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('dbx_business_glossary_term' = 'Radiation Emitting Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `radiation_emitting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `ris_resource_code` SET TAGS ('dbx_business_glossary_term' = 'Radiology Information System (RIS) Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `room_identifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `scheduled_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Operating Hours Per Day');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `shared_service_indicator` SET TAGS ('dbx_business_glossary_term' = 'Shared Service Indicator');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `slice_count` SET TAGS ('dbx_business_glossary_term' = 'CT Detector Slice Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Equipment Software Version');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `tesla_field_strength` SET TAGS ('dbx_business_glossary_term' = 'MRI Magnetic Field Strength (Tesla)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Modality Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Modality Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `unit_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` SET TAGS ('dbx_subdomain' = 'image_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinician_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Contrast Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `parent_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Protocol ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `primary_superseded_by_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Protocol ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `primary_superseded_by_protocol_id` SET TAGS ('dbx_self_reference' = 'clean');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Required Lab Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_business_glossary_term' = 'ACR Appropriateness Criteria Rating');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_value_regex' = 'usually_appropriate|may_be_appropriate|usually_not_appropriate');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `acr_appropriateness_rating` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_business_glossary_term' = 'Approving Radiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_value_regex' = '^d{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `approving_radiologist_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `body_part` SET TAGS ('dbx_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_category` SET TAGS ('dbx_business_glossary_term' = 'Protocol Category');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_category` SET TAGS ('dbx_value_regex' = 'diagnostic|screening|interventional|research|emergency|pediatric');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_code` SET TAGS ('dbx_business_glossary_term' = 'Protocol Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('dbx_business_glossary_term' = 'Contrast Dose (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_dose_ml` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_flow_rate_ml_per_sec` SET TAGS ('dbx_business_glossary_term' = 'Contrast Flow Rate (mL/sec)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_required` SET TAGS ('dbx_business_glossary_term' = 'Contrast Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_route` SET TAGS ('dbx_business_glossary_term' = 'Contrast Administration Route');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `contrast_route` SET TAGS ('dbx_value_regex' = 'intravenous|oral|rectal|intrathecal|intra_articular|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_business_glossary_term' = 'Dose Optimization Program');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_value_regex' = 'image_gently|image_wisely|acr_dir|none');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `dose_optimization_program` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Fasting Duration (hours)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_duration_hours` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('dbx_business_glossary_term' = 'Fasting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `fasting_required` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `field_of_view_mm` SET TAGS ('dbx_business_glossary_term' = 'Field of View (FOV) (mm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `implant_screening_required` SET TAGS ('dbx_business_glossary_term' = 'Implant Screening Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `kvp` SET TAGS ('dbx_business_glossary_term' = 'Peak Kilovoltage (kVp)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `magnetic_field_strength_tesla` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Field Strength (Tesla)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `mas` SET TAGS ('dbx_business_glossary_term' = 'Milliampere-Seconds (mAs)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `modality_type` SET TAGS ('dbx_business_glossary_term' = 'Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_business_glossary_term' = 'Protocol Name');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('dbx_business_glossary_term' = 'PACS Routing Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pacs_routing_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_population` SET TAGS ('dbx_business_glossary_term' = 'Patient Population');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_population` SET TAGS ('dbx_value_regex' = 'adult|pediatric|neonatal|geriatric|obstetric|all');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `patient_prep_instructions` SET TAGS ('dbx_business_glossary_term' = 'Patient Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pitch_factor` SET TAGS ('dbx_business_glossary_term' = 'CT Pitch Factor');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_status` SET TAGS ('dbx_business_glossary_term' = 'Protocol Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `protocol_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|under_review');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `pulse_sequence_type` SET TAGS ('dbx_business_glossary_term' = 'MRI Pulse Sequence Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('dbx_business_glossary_term' = 'Reference CT Dose Index Volume (CTDIvol) (mGy)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_ctdi_vol_mgy` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('dbx_business_glossary_term' = 'Reference Radiation Dose - Dose Length Product (DLP) (mGy·cm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radiation_dose_dlp_mgy_cm` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radlex_code` SET TAGS ('dbx_business_glossary_term' = 'RSNA RadLex Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `radlex_code` SET TAGS ('dbx_value_regex' = '^RIDd+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `reconstruction_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Reconstruction Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `renal_function_check_required` SET TAGS ('dbx_business_glossary_term' = 'Renal Function Check Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Retirement Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Radiology Information System (RIS) Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `ris_procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `scan_duration_estimate_sec` SET TAGS ('dbx_business_glossary_term' = 'Estimated Scan Duration (seconds)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `sedation_required` SET TAGS ('dbx_business_glossary_term' = 'Sedation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `slice_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Slice Thickness (mm)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `total_exam_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Total Exam Duration Estimate (minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` SET TAGS ('dbx_subdomain' = 'image_acquisition');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_admin_id` SET TAGS ('dbx_business_glossary_term' = 'Contrast Admin Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `allergy_id` SET TAGS ('dbx_business_glossary_term' = 'Allergy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_business_glossary_term' = 'Administering Clinician National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_value_regex' = '^d{10}$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administering_clinician_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_datetime` SET TAGS ('dbx_business_glossary_term' = 'Contrast Administration Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_status` SET TAGS ('dbx_business_glossary_term' = 'Contrast Administration Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `administration_status` SET TAGS ('dbx_value_regex' = 'completed|in-progress|not-done|on-hold|stopped|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_datetime` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_occurred` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Occurred Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Severity');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life-threatening');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_severity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reaction Treatment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `adverse_reaction_treatment` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_class` SET TAGS ('dbx_business_glossary_term' = 'Contrast Agent Class');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_class` SET TAGS ('dbx_value_regex' = 'iodinated|gadolinium-based|barium|microbubble|manganese-based|iron-based');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_osmolality_type` SET TAGS ('dbx_business_glossary_term' = 'Contrast Agent Osmolality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `agent_osmolality_type` SET TAGS ('dbx_value_regex' = 'low-osmolality|iso-osmolality|high-osmolality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `body_region` SET TAGS ('dbx_business_glossary_term' = 'Imaging Body Region');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `catheter_gauge` SET TAGS ('dbx_business_glossary_term' = 'Intravenous Catheter Gauge');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `concentration_mg_per_ml` SET TAGS ('dbx_business_glossary_term' = 'Contrast Agent Concentration (mg/mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_agent_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Contrast Allergy Screening Result');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_value_regex' = 'no-allergy|prior-reaction|allergy-confirmed|screening-not-done|contraindicated');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `contrast_allergy_screening_result` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('dbx_business_glossary_term' = 'Contrast Dose Amount (mg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_amount_mg` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_ml` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Contrast Dose Volume (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `dose_volume_ml` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `extravasation_occurred` SET TAGS ('dbx_business_glossary_term' = 'Contrast Extravasation Occurred Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `extravasation_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Extravasation Volume (mL)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `informed_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `injection_rate_ml_per_sec` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate (mL/sec)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `injection_site` SET TAGS ('dbx_business_glossary_term' = 'Injection Site');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `metformin_held` SET TAGS ('dbx_business_glossary_term' = 'Metformin Held Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `modality` SET TAGS ('dbx_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Patient Weight at Administration (kg)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `patient_weight_kg` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `power_injector_used` SET TAGS ('dbx_business_glossary_term' = 'Power Injector Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Status at Administration');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_value_regex' = 'not-pregnant|pregnant|unknown|not-applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('dbx_business_glossary_term' = 'Pre-Medication Details');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_details` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('dbx_business_glossary_term' = 'Pre-Medication Given Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `premedication_given` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Contrast Reaction Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `prior_contrast_reaction_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_value_regex' = 'intravenous|oral|intrathecal|intra-arterial|intraperitoneal|rectal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('dbx_business_glossary_term' = 'Thyroid Disease Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `thyroid_disease_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `primary_radiology_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `tertiary_radiology_referring_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Radiology Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_value_regex' = 'scheduled|arrived|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Arrival Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `billing_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `body_part` SET TAGS ('dbx_business_glossary_term' = 'Body Part Examined');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Appointment Comment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `contrast_required` SET TAGS ('dbx_business_glossary_term' = 'Contrast Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `contrast_type` SET TAGS ('dbx_business_glossary_term' = 'Contrast Administration Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `contrast_type` SET TAGS ('dbx_value_regex' = 'IV|oral|intrathecal|intra_articular|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `insurance_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `is_portable` SET TAGS ('dbx_business_glossary_term' = 'Portable Imaging Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `is_stat` SET TAGS ('dbx_business_glossary_term' = 'STAT Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `modality_type` SET TAGS ('dbx_business_glossary_term' = 'Imaging Modality Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `no_show_reason` SET TAGS ('dbx_business_glossary_term' = 'No-Show Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `pacs_study_uid` SET TAGS ('dbx_business_glossary_term' = 'Picture Archiving and Communication System (PACS) Study Instance UID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `pacs_study_uid` SET TAGS ('dbx_value_regex' = '^[0-9]+(.[0-9]+)+$');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Device Type');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `patient_location` SET TAGS ('dbx_business_glossary_term' = 'Patient Location at Time of Appointment');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `prep_instructions` SET TAGS ('dbx_business_glossary_term' = 'Patient Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `procedure_description` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `procedure_description` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `procedure_description` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `provider_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Attestation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('dbx_business_glossary_term' = 'Radiation Dose Tracking Flag');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `radiation_dose_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `reschedule_count` SET TAGS ('dbx_business_glossary_term' = 'Reschedule Count');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `ris_appointment_code` SET TAGS ('dbx_business_glossary_term' = 'Radiology Information System (RIS) Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `roomed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roomed Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scheduling_source` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Source');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scheduling_source` SET TAGS ('dbx_value_regex' = 'provider_referral|patient_self|order_based|transfer|walk_in|portal');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `scope` SET TAGS ('dbx_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Access Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Connection Status');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session URL');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `visit_modality` SET TAGS ('dbx_business_glossary_term' = 'Visit Modality');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`appointment` ALTER COLUMN `visit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` SET TAGS ('dbx_subdomain' = 'clinical_interpretation');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `notified_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `pacs_system_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `patient_care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `radiologist_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
