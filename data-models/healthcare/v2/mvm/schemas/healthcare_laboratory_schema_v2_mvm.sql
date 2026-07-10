-- Schema for Domain: laboratory | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-10 16:21:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`laboratory` COMMENT 'Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` (
    `lab_order_id` BIGINT COMMENT 'Primary key for lab_order',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Lab orders reference the CDM entry to determine billable service, revenue code, and price. This is a standard charge capture process: the CDM entry governs what gets billed for each ordered test. bil',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Lab orders monitored for appropriateness, overutilization, and compliance with clinical pathways. Utilization management and compliance monitoring programs require linking orders to monitoring activit',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient for whom the laboratory test was ordered. Links to the patient master data.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Lab orders require structured ICD-10 linkage for clinical indication validation, medical necessity determination, billing compliance, and quality measure reporting. The diagnosis_code text field shoul',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Specific health plan determines coverage policies, prior authorization requirements, and fee schedules for lab services. Utilization management and authorization workflows require plan-level rules, no',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Outpatient and ASC lab orders are billed using HCPCS Level II codes (e.g., P-codes for pathology collection, G-codes for specific lab tests). Claims processing and outpatient billing require HCPCS cod',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Lab orders require prior authorization and billing against a specific insurance coverage plan. lab_order carries authorization_number and billing_code as plain attributes but has no FK to insurance_co',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Lab orders trigger quality measure opportunities (ordering appropriate screening tests like colonoscopy prep labs, pre-op testing). Quality gap closure workflows track which measures are addressed by ',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Lab orders for genetic testing, HIV, substance abuse screening, and research protocols require documented patient consent before specimen collection. Real-world lab workflows verify consent status at ',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Lab orders often specify required reagent kits or test consumables for supply chain fulfillment and charge capture. Healthcare operations track which material items are consumed per order for cost acc',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Lab order routing and result reporting require knowing which CLIA-licensed org_provider performed the test. performing_lab_location is a denormalized plain-text field; normalizing to org_provider_id',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the healthcare provider (physician, nurse practitioner, physician assistant) who ordered the laboratory test via CPOE (Computerized Physician Order Entry).',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Lab orders are frequently scheduled appointments (fasting blood work, timed specimen collection). Enables appointment-based lab workflow, no-show reconciliation, and collection verification. Standard ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Lab orders generated for research protocols must link to originating study for protocol compliance tracking, coverage analysis (standard-of-care vs research), regulatory reporting, and research billin',
    `tertiary_lab_cancelled_by_provider_clinician_id` BIGINT COMMENT 'Unique identifier for the healthcare provider who cancelled or discontinued the laboratory order. Used for audit trail and accountability.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Lab orders request specific catalog tests. Currently lab_order has test_code/test_name/test_category but no FK. Business reality: orders reference catalog tests for what to perform. Adding test_catalo',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Medical necessity documentation and payer audit defense require linking each lab order to the specific encounter diagnosis that prompted it. Quality reporting (appropriate test ordering per diagnosis)',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical encounter or visit during which the laboratory order was placed. Links to the visit/encounter record.',
    `authorization_required` BOOLEAN COMMENT 'Boolean flag indicating whether payer prior authorization is required before performing this laboratory test. True for high-cost or specialized tests that require pre-approval for reimbursement.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason why the laboratory order was cancelled. Examples: duplicate order, ordered in error, patient refused, specimen quality insufficient, test no longer clinically indicated. Used for quality improvement and utilization review.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory order was cancelled or discontinued. Populated only when order_status is cancelled or discontinued.',
    `clinical_indication` STRING COMMENT 'Free-text clinical reason or diagnosis justifying the laboratory order. Provides context for medical necessity, supports appropriate utilization, and may be required for insurance authorization and reimbursement.',
    `collection_date` DATE COMMENT 'Calendar date when the specimen was collected from the patient. May differ from order date for scheduled or delayed collections.',
    `collection_method` STRING COMMENT 'Technique or procedure used to collect the specimen. Examples: venipuncture, capillary stick, clean catch, catheterized, biopsy. Affects specimen quality and test validity.',
    `collection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the specimen was collected from the patient. Critical for time-sensitive tests and stability calculations. Used as the start point for laboratory turnaround time measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this laboratory order record was first created in the data lakehouse. Audit field for data lineage and record lifecycle tracking.',
    `diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code associated with the laboratory order, documenting the clinical condition being investigated or monitored. Required for claims processing and medical necessity validation.',
    `expected_turnaround_time_hours` STRING COMMENT 'Expected number of hours from specimen collection to result availability, based on test type and performing laboratory. Used for result expectation management and delay identification. For send-out orders, includes shipping and reference lab processing time.',
    `fasting_required` BOOLEAN COMMENT 'Boolean flag indicating whether the patient must fast prior to specimen collection for accurate test results. True for tests such as fasting glucose, lipid panel. Used for patient preparation instructions.',
    `is_send_out` BOOLEAN COMMENT 'Boolean flag indicating whether this laboratory order is sent to an external reference laboratory for testing (True) or performed internally (False). Send-out orders require additional tracking for shipping and result receipt.',
    `order_date` DATE COMMENT 'Calendar date when the laboratory order was placed by the ordering provider via CPOE (Computerized Physician Order Entry). Used for turnaround time calculations and operational metrics.',
    `order_number` STRING COMMENT 'The externally-known unique order number or accession number assigned to this laboratory order by the LIS (Laboratory Information System) such as Epic Beaker or Cerner PathNet. Used for tracking and reference across systems.',
    `order_priority` STRING COMMENT 'Clinical priority level assigned to the laboratory order. STAT indicates immediate/emergency processing, routine for standard turnaround, ASAP for expedited but not emergency, timed for specific collection time requirements, urgent for high-priority processing.. Valid values are `STAT|routine|ASAP|timed|urgent`',
    `order_set_name` STRING COMMENT 'Name of the clinical order set or protocol from which this laboratory order was generated. Order sets bundle commonly-ordered tests for specific clinical scenarios (admission panels, pre-operative workup, sepsis workup).',
    `order_status` STRING COMMENT 'Current lifecycle status of the laboratory order. Tracks progression from order placement through specimen collection, processing, and result delivery. For send-out orders, includes sent_out status when specimen is shipped to reference laboratory. [ENUM-REF-CANDIDATE: ordered|collected|in_process|sent_out|resulted|cancelled|discontinued|on_hold — 8 candidates stripped; promote to reference product]',
    `order_timestamp` TIMESTAMP COMMENT 'Precise date and time when the laboratory order was electronically placed in the system. The principal business event timestamp for this transaction. Critical for STAT order tracking and turnaround time analysis.',
    `point_of_care_test` BOOLEAN COMMENT 'Boolean flag indicating whether this is a point-of-care test performed at or near the patient location (bedside, clinic exam room, emergency department) rather than in the central laboratory. Examples: glucose meter, rapid strep test, blood gas analyzer.',
    `reference_lab_accession_number` STRING COMMENT 'Unique accession or tracking number assigned by the external reference laboratory to this specimen. Used for result reconciliation and inquiry. Populated only for send-out orders.',
    `reference_lab_name` STRING COMMENT 'Name of the external reference laboratory to which the specimen is sent for testing. Populated only for send-out orders. Examples: Quest Diagnostics, LabCorp, Mayo Clinic Laboratories, ARUP Laboratories.',
    `result_integration_status` STRING COMMENT 'Status of electronic result integration from the reference laboratory into the internal LIS and EHR (Electronic Health Record). Tracks whether results were successfully auto-imported or require manual intervention. Populated only for send-out orders.. Valid values are `pending|integrated|failed|manual_entry_required`',
    `result_received_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory result was received back from the reference laboratory and integrated into the LIS (Laboratory Information System). Populated only for send-out orders. Marks completion of the send-out order lifecycle.',
    `shipping_carrier` STRING COMMENT 'Name of the courier or shipping service used to transport the specimen to the reference laboratory. Examples: FedEx, UPS, DHL, courier service. Populated only for send-out orders.',
    `shipping_tracking_number` STRING COMMENT 'Carrier-provided tracking number for the specimen shipment. Enables real-time tracking of specimen in transit and confirmation of delivery to reference laboratory. Populated only for send-out orders.',
    `source_system_order_number` STRING COMMENT 'Unique identifier for this laboratory order in the source operational system (Epic Beaker, Cerner PathNet). Used for cross-system reconciliation and drill-back to source records.',
    `specimen_shipped_timestamp` TIMESTAMP COMMENT 'Date and time when the specimen was shipped or dispatched to the external reference laboratory. Used to track send-out order logistics and calculate total turnaround time. Populated only for send-out orders.',
    `specimen_source` STRING COMMENT 'Anatomical site or body location from which the specimen was collected. Examples: left arm venipuncture, throat swab, wound site, right knee joint. Important for pathology and microbiology orders.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for the laboratory test. Examples: blood, serum, plasma, urine, tissue, swab, cerebrospinal fluid. Determines handling and processing requirements.',
    `standing_order` BOOLEAN COMMENT 'Boolean flag indicating whether this order is part of a standing order protocol (recurring orders based on clinical protocol or care plan) rather than a one-time order. Examples: daily morning labs for ICU patients, weekly monitoring for chronic conditions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this laboratory order record was last modified in the data lakehouse. Audit field for change tracking and data freshness monitoring.',
    CONSTRAINT pk_lab_order PRIMARY KEY(`lab_order_id`)
) COMMENT 'Core transactional record of every laboratory test order placed via CPOE (Computerized Physician Order Entry) in Epic Beaker or Cerner PathNet, including orders routed to external reference laboratories (send-outs). Captures the ordering provider, ordering encounter, ordered test (LOINC code from test catalog), order priority (STAT, routine, ASAP, timed), order status lifecycle (ordered, collected, in-process, sent-out, resulted, cancelled), clinical indication, order date/time, source system identifiers. For send-out orders: reference lab name, reference lab accession number, specimen shipping date/time, shipping carrier and tracking, expected turnaround time, result receipt date/time, and result integration status. SSOT for all lab order identity and lifecycle within the laboratory domain, including both internal and send-out orders.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` (
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Identifier of the healthcare provider or phlebotomist who collected the specimen. Supports chain of custody and quality tracking.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Specimen collection for biobanking, research studies, genetic testing, and tissue retention requires documented consent. Pathology specimens used in teaching or future research require explicit patien',
    `lab_order_id` BIGINT COMMENT 'Identifier of the clinical order that requested the laboratory tests for which this specimen was collected. Links specimen to ordering workflow.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient from whom the specimen was collected. Links specimen to patient master record.',
    `parent_specimen_id` BIGINT COMMENT 'Identifier of the parent specimen if this specimen is an aliquot or derivative. Supports specimen lineage tracking.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Specimen chain-of-custody and CLIA compliance require tracking which org_provider received and processed each specimen. receiving_lab_location is a denormalized plain-text field; linking to org_prov',
    `study_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_study. Business justification: Image-guided specimen collection (CT-guided biopsy, ultrasound-guided FNA, IR-guided aspiration) requires linking the specimen to the guiding radiology study for procedure correlation, pathology-radio',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: LOINC codes specimen types (e.g., LOINC 122575003 for urine). HL7 v2 OBR-15 and FHIR R4 Specimen.type require LOINC-coded specimen type for LIS interoperability and public health reporting. Role prefi',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: SNOMED CT codes specimen types (e.g., Venous blood specimen = SNOMED 122555007). FHIR R4 Specimen.type uses SNOMED coding. Clinical decision support rules and infection control systems reference SNO',
    `accession_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was received and accessioned into the Laboratory Information System (LIS). Marks the beginning of laboratory custody and processing.',
    `accession_number` STRING COMMENT 'Laboratory Information System (LIS) assigned unique work-unit identifier for the specimen. This is the operational identity in Epic Beaker and Cerner PathNet, used to track the specimen through the laboratory workflow from receipt through testing and disposal.',
    `accession_status` STRING COMMENT 'Current lifecycle status of the specimen in the laboratory workflow. Tracks progression from receipt through testing to final disposition.. Valid values are `received|processing|resulted|archived|rejected`',
    `biohazard_level` STRING COMMENT 'Biohazard risk classification of the specimen based on known or suspected infectious agents. Determines safety precautions and handling protocols.. Valid values are `standard|high_risk|unknown`',
    `chain_of_custody_status` STRING COMMENT 'Indicates whether the chain of custody has been maintained throughout specimen handling. Critical for forensic, toxicology, and legal specimens.. Valid values are `intact|broken|not_applicable`',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was collected from the patient. Critical for time-sensitive tests and stability assessments.',
    `collection_duration_minutes` STRING COMMENT 'Duration of specimen collection in minutes. Relevant for timed collections such as 24-hour urine or glucose tolerance tests.',
    `collection_method` STRING COMMENT 'Technique or procedure used to collect the specimen (e.g., venipuncture, clean catch, biopsy, swab). Critical for quality assessment and result interpretation.',
    `collector_role` STRING COMMENT 'Professional role or title of the person who collected the specimen (e.g., phlebotomist, registered nurse, physician). Provides context for collection quality and training requirements.',
    `comments` STRING COMMENT 'Free-text comments or notes about the specimen, collection circumstances, or quality observations. Provides additional context for laboratory staff and clinicians.',
    `condition_at_receipt` STRING COMMENT 'Assessment of specimen quality and integrity upon receipt at the laboratory. Documents any pre-analytical issues that may affect test results.. Valid values are `acceptable|hemolyzed|clotted|insufficient|contaminated|unlabeled`',
    `container_type` STRING COMMENT 'Type of collection container or tube used (e.g., red top, lavender top EDTA, sterile cup). Determines appropriate tests and handling requirements.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this specimen record was first created in the system. Supports audit trail and data lineage tracking.',
    `disposal_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was disposed of or destroyed. Supports retention policy compliance and inventory management.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the specimen (e.g., biohazard waste, incineration, autoclave). Ensures compliance with safety and environmental regulations.',
    `fasting_status` STRING COMMENT 'Indicates whether the patient was fasting at the time of specimen collection. Critical for interpretation of glucose, lipid, and metabolic tests.. Valid values are `fasting|non_fasting|unknown`',
    `number_of_aliquots` STRING COMMENT 'Count of aliquots or sub-specimens created from the original specimen for distribution to different testing sections or for storage.',
    `priority` STRING COMMENT 'Processing priority level assigned to the specimen. Determines turnaround time expectations and workflow sequencing.. Valid values are `routine|urgent|stat|asap`',
    `rejection_reason` STRING COMMENT 'Reason for specimen rejection if not acceptable for testing (e.g., hemolyzed, insufficient quantity, unlabeled, expired). Supports quality improvement and recollection requests.',
    `retention_expiration_date` DATE COMMENT 'Date when the specimen retention period expires and the specimen may be disposed of per laboratory policy.',
    `retention_status` STRING COMMENT 'Current retention status of the specimen relative to laboratory retention policies. Indicates whether specimen is available for additional testing or has been disposed.. Valid values are `active|retained|disposed|archived`',
    `source` STRING COMMENT 'Anatomical site or body location from which the specimen was collected (e.g., left antecubital vein, throat, wound site). Provides clinical context for interpretation of test results.',
    `special_handling_instructions` STRING COMMENT 'Any special handling requirements or precautions for the specimen (e.g., keep frozen, protect from light, handle as infectious). Ensures proper specimen management.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected (e.g., blood, urine, tissue, cerebrospinal fluid, swab, stool). Defines the nature of the material submitted for laboratory analysis.. Valid values are `blood|urine|tissue|csf|swab|stool`',
    `storage_location` STRING COMMENT 'Physical location where the specimen is currently stored (e.g., refrigerator ID, freezer location, room number). Supports specimen retrieval and inventory management.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the specimen is stored, measured in degrees Celsius. Critical for specimen stability and quality assurance.',
    `transport_duration_minutes` STRING COMMENT 'Time elapsed between specimen collection and laboratory receipt, measured in minutes. Critical for time-sensitive analytes and quality assessment.',
    `transport_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the specimen was transported from collection site to laboratory, measured in degrees Celsius. Affects specimen stability and quality.',
    `updated_datetime` TIMESTAMP COMMENT 'Date and time when this specimen record was last modified. Supports audit trail and change tracking.',
    `volume_collected_ml` DECIMAL(18,2) COMMENT 'Volume of specimen collected, measured in milliliters. Used to determine test feasibility and aliquot planning.',
    CONSTRAINT pk_specimen PRIMARY KEY(`specimen_id`)
) COMMENT 'Master record for every biological specimen collected for laboratory testing and the SSOT for specimen identity, accessioning, chain of custody, and full specimen lifecycle. Tracks specimen type (blood, urine, tissue, CSF, swab), collection method, collection date/time, collector identity and role, collection site (body location), container type, volume, accession number (LIS-assigned unique work-unit identifier), accession date/time, accession status (received, processing, resulted, archived), receiving lab location, priority, chain-of-custody status, storage location, specimen condition at receipt, number of aliquots, and disposal/retention status. Consolidates the former accession and specimen collection event concepts — the accession is the specimens operational identity in Epic Beaker and Cerner PathNet. Supports CLIA-compliant specimen tracking from collection through accessioning, testing, and disposal.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Unique identifier for the laboratory test result record. Primary key for the test result entity.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Lab test results are core data elements for clinical quality measures (CQMs/eCQMs). Measure calculation engines query lab results by measure_id to determine numerator compliance for quality reporting ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this test was performed. Links to the master patient record.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Test results linked to diagnosis codes enable outcomes tracking, quality measure calculation (e.g., HbA1c results for diabetes patients), and clinical correlation analysis. Required for value-based ca',
    `lab_order_id` BIGINT COMMENT 'Reference to the parent laboratory order that requested this test. Links to the clinical order that initiated the test.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Test results require LOINC linkage for standardized result reporting, HIE exchange, quality measure calculation, and clinical decision support. Enables semantic interoperability for result interpretat',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Results disclosure for genetic tests, HIV, substance abuse screening requires consent verification before release. Patient portal access to sensitive lab results, results sharing with third parties, a',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CLIA compliance, payer billing, and result reporting require attributing each test result to a specific licensed org_provider. performing_lab_facility is a denormalized plain-text field; normalizing',
    `clinician_id` BIGINT COMMENT 'Reference to the pathologist who reviewed and verified the result, particularly for complex tests requiring physician oversight. Required for certain test categories under CLIA.',
    `reference_range_id` BIGINT COMMENT 'Foreign key linking to laboratory.reference_range. Business justification: Test results are interpreted using reference ranges. Currently test_result has reference_range_low/high/text embedded. Business reality: reference ranges are applied to results for interpretation and ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Test results with coded values require SNOMED CT linkage for semantic interoperability and clinical decision support. The result_value_coded field needs structured terminology; proper FK enables autom',
    `specimen_id` BIGINT COMMENT 'Reference to the specimen from which this test result was derived. Links to the specimen collection and tracking record.',
    `tertiary_test_ordering_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who ordered the laboratory test. Used for result routing and clinical communication.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Test results are instances of tests defined in the catalog. Currently test_result has loinc_code/loinc_display_name but no FK to test_catalog. Business reality: every result is for a cataloged test. A',
    `abnormal_flag` BOOLEAN COMMENT 'Indicator of whether the result falls outside the normal reference range. Values include normal, low, high, critical_low, critical_high, or abnormal for non-numeric results.',
    `amendment_datetime` TIMESTAMP COMMENT 'Date and time when the result was amended or corrected. Critical for audit trail and understanding result history.',
    `amendment_reason` STRING COMMENT 'Documented reason for amending or correcting the result (e.g., transcription error, instrument malfunction, specimen mix-up, calculation error). Required for CLIA compliance.',
    `clia_number` STRING COMMENT 'CLIA certification number of the laboratory that performed the test. Federally required identifier for all clinical laboratories performing testing on human specimens.. Valid values are `^[0-9]{2}D[0-9]{7}$`',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this test result record was first created in the system. Audit timestamp for data lineage and compliance.',
    `critical_value_acknowledgment_datetime` TIMESTAMP COMMENT 'Date and time when the provider acknowledged receipt and understanding of the critical value. Completes the critical value notification loop.',
    `critical_value_alert_generated_datetime` TIMESTAMP COMMENT 'Date and time when the critical value alert was generated by the Laboratory Information System (LIS). Marks the start of the critical value notification workflow.',
    `critical_value_escalation_action` STRING COMMENT 'Description of escalation actions taken if initial notification was unsuccessful (e.g., contacted backup provider, notified charge nurse, paged on-call physician).',
    `critical_value_notification_datetime` TIMESTAMP COMMENT 'Date and time when the critical value notification was successfully delivered to the provider. Used to calculate notification turnaround time.',
    `critical_value_notification_method` STRING COMMENT 'Method used to notify the provider of the critical value (e.g., phone, secure message, EHR alert, page). Required for compliance documentation.. Valid values are `phone|secure_message|ehr_alert|page|fax|in_person`',
    `critical_value_resolution_note` STRING COMMENT 'Free-text note documenting the resolution of the critical value alert, including any clinical actions taken or follow-up orders placed.',
    `is_amended` BOOLEAN COMMENT 'Boolean flag indicating whether this result has been amended or corrected after initial release. Triggers amendment tracking and notification workflows.',
    `is_critical_value` BOOLEAN COMMENT 'Boolean flag indicating whether this result exceeds critical thresholds requiring immediate clinical notification. Triggers critical value alert workflow.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Date and time when this test result record was last modified. Audit timestamp for tracking changes and data quality.',
    `original_result_value_numeric` DECIMAL(18,2) COMMENT 'Original numeric result value before amendment or correction. Preserved for audit trail and compliance purposes.',
    `original_result_value_text` STRING COMMENT 'Original text result value before amendment or correction. Preserved for audit trail and compliance purposes.',
    `performing_lab_section` STRING COMMENT 'Laboratory section or department that performed the test (e.g., Chemistry, Hematology, Microbiology, Pathology). Used for operational tracking and quality control.',
    `result_comment` STRING COMMENT 'Additional comments, notes, or observations about the test result. May include technical notes, specimen quality issues, or other relevant information.',
    `result_datetime` TIMESTAMP COMMENT 'Date and time when the laboratory test result was produced or finalized. Represents the official result timestamp for clinical and regulatory purposes.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation or commentary provided by the laboratory professional regarding the result. May include clinical significance, recommendations, or contextual notes.',
    `result_released_datetime` TIMESTAMP COMMENT 'Date and time when the result was officially released from the laboratory and made available to clinicians. Used for turnaround time calculations.',
    `result_status` STRING COMMENT 'Current lifecycle status of the test result. Tracks progression from preliminary through final, and captures corrections or cancellations. Critical for clinical decision-making and compliance.. Valid values are `preliminary|final|corrected|cancelled|entered_in_error`',
    `result_unit` STRING COMMENT 'Unit of measure for the numeric result value (e.g., mg/dL, mmol/L, cells/uL). Critical for clinical interpretation and comparison against reference ranges.',
    `result_value_coded` STRING COMMENT 'Standardized coded value for the test result using terminology systems such as SNOMED CT. Enables structured data exchange and analytics.',
    `result_value_numeric` DECIMAL(18,2) COMMENT 'Numeric value of the laboratory test result for quantitative tests. Stores the measured value with precision appropriate for clinical decision-making.',
    `result_value_text` STRING COMMENT 'Text or string value of the laboratory test result for qualitative tests, narrative findings, or coded results. Used when result cannot be expressed numerically.',
    `specimen_received_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was received in the laboratory. Used for tracking specimen handling and turnaround time metrics.',
    CONSTRAINT pk_test_result PRIMARY KEY(`test_result_id`)
) COMMENT 'Transactional record of every individual laboratory test result produced for a specimen, including result amendments and critical value notifications. Stores LOINC-coded test identifier, result value (numeric, text, coded), result unit of measure, reference range applied, result status lifecycle (preliminary, final, corrected, cancelled), abnormal flag (normal, low, high, critical low, critical high), result date/time, performing lab section, instrument identifier, verifying technologist. Owns the full amendment/correction history: original value, amended value, amendment reason, amending user, amendment timestamp. When a result exceeds critical thresholds, owns the critical value alert lifecycle: alert generation timestamp, notified provider, notification method (phone, secure message, EHR alert), acknowledgment timestamp, acknowledging clinician, escalation actions, and resolution notes. Consolidates the former critical_value_alert and result_amendment concepts. Supports CLIA critical value compliance, Joint Commission NPSG requirements, HIM audit requirements, and downstream clinical decision-making.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` (
    `reference_range_id` BIGINT COMMENT 'Unique identifier for the laboratory reference range record. Primary key.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Reference ranges are LOINC-specific and vary by test methodology. Structured linkage enables proper result interpretation across systems, supports automated abnormal flag generation, and ensures clini',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR R4 ObservationDefinition.qualifiedInterval uses SNOMED to code the clinical condition/context for which a reference range applies (e.g., Pregnancy SNOMED 77386006). Clinical decision support en',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Reference ranges are defined FOR specific tests in the catalog. Currently reference_range has test_code/test_name but no FK to test_catalog. Business reality: reference ranges are test-specific and sh',
    `age_group` STRING COMMENT 'Age group or age range for which this reference range applies (e.g., Neonate, Infant, Child, Adolescent, Adult, Geriatric, or specific age ranges like 0-1 years, 1-12 years, 18-65 years). Reference ranges are age-dependent for many tests.',
    `alert_priority` STRING COMMENT 'Priority level for clinical alerts triggered when results fall outside this reference range. Critical priority requires immediate notification within minutes; urgent within hours; routine for next business day review.. Valid values are `routine|urgent|critical|stat`',
    `alert_trigger_flag` BOOLEAN COMMENT 'Indicates whether results outside this reference range should trigger automated clinical alerts or notifications. True for critical value ranges requiring immediate provider notification per Joint Commission requirements.',
    `clinical_significance` STRING COMMENT 'Clinical interpretation guidance describing the significance of values outside this reference range. Provides context for clinicians interpreting abnormal results (e.g., elevated values may indicate infection, dehydration, or malignancy).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reference range record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_high_threshold` DECIMAL(18,2) COMMENT 'The critical high value threshold (panic value) above which immediate clinical notification is required. Represents life-threatening high values requiring urgent intervention.',
    `critical_low_threshold` DECIMAL(18,2) COMMENT 'The critical low value threshold (panic value) below which immediate clinical notification is required. Represents life-threatening low values requiring urgent intervention.',
    `effective_end_date` DATE COMMENT 'The date through which this reference range remains valid. Null indicates the range is currently active with no planned end date. Supports historical tracking and periodic review requirements.',
    `effective_start_date` DATE COMMENT 'The date from which this reference range becomes valid and should be used for result interpretation. Supports versioning of reference ranges over time.',
    `instrument_platform` STRING COMMENT 'Specific laboratory instrument or analyzer platform for which this reference range is validated (e.g., Roche Cobas, Abbott Architect, Siemens Atellica). Different platforms may require different reference ranges.',
    `interpretation_code` STRING COMMENT 'Standardized code used by result interpretation logic to assign abnormal flags when test results fall outside this reference range. Maps to HL7 observation interpretation codes.. Valid values are `normal|low|high|critical_low|critical_high|abnormal`',
    `last_review_date` DATE COMMENT 'Date when this reference range was last reviewed and validated by the laboratory medical director or quality team. CLIA and CAP require periodic review of reference ranges at least annually or when methodology changes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this reference range record was last modified. Supports change tracking and audit compliance.',
    `lis_system_code` STRING COMMENT 'Internal system code or identifier used by the Laboratory Information System (Epic Beaker, Cerner PathNet) to reference this range in result interpretation logic and reporting.',
    `lower_normal_limit` DECIMAL(18,2) COMMENT 'The lower boundary of the normal reference range. Values below this threshold are typically flagged as low or abnormal.',
    `medical_director_override_flag` BOOLEAN COMMENT 'Indicates whether this reference range represents an institutional medical director override of standard published ranges. True if the laboratory medical director has approved a deviation from manufacturer or published ranges based on local population characteristics.',
    `methodology` STRING COMMENT 'The analytical method or instrument platform used to establish this reference range (e.g., Spectrophotometry, Immunoassay, Mass Spectrometry, PCR). Reference ranges may vary by methodology for the same test.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this reference range. Supports compliance with CLIA and CAP requirements for annual review and documentation.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this reference range. May include information about interfering substances, pre-analytical requirements, or special patient populations.',
    `override_justification` STRING COMMENT 'Clinical justification and documentation for medical director override of standard reference ranges. Required when medical_director_override_flag is true. Includes rationale, supporting data, and approval documentation.',
    `population_basis` STRING COMMENT 'Description of the reference population used to establish this range (e.g., healthy adult volunteers, local patient population, manufacturer validation study). Documents the basis for the reference interval per CLSI guidelines.',
    `pregnancy_status` STRING COMMENT 'Pregnancy status for which this reference range applies. Certain laboratory values have distinct reference ranges during pregnancy (e.g., thyroid function tests, hemoglobin).. Valid values are `pregnant|not_pregnant|not_applicable|unknown`',
    `race_ethnicity` STRING COMMENT 'Race or ethnicity group for which this reference range applies, when clinically validated differences exist (e.g., creatinine clearance adjustments for African American patients). Only populated when evidence-based clinical guidelines support race-specific ranges.',
    `review_status` STRING COMMENT 'Current review and approval status of this reference range. Tracks lifecycle state for quality management and compliance purposes.. Valid values are `current|pending_review|under_revision|retired`',
    `sample_size` STRING COMMENT 'Number of individuals in the reference population used to establish this range. CLSI recommends minimum 120 samples for robust reference intervals. Documents statistical validity of the range.',
    `sex` STRING COMMENT 'Biological sex for which this reference range applies. Many laboratory tests have sex-specific reference ranges (e.g., hemoglobin, creatinine).. Valid values are `male|female|all|unknown`',
    `source_citation` STRING COMMENT 'Detailed citation or reference to the authoritative source document (e.g., CAP guideline version, manufacturer package insert identifier, peer-reviewed journal article, institutional policy document). Required for CLIA compliance and periodic review.',
    `source_type` STRING COMMENT 'The type of authoritative source from which this reference range was derived. CLIA requires documentation of reference range sources.. Valid values are `cap|clia|manufacturer|institutional|peer_reviewed`',
    `statistical_method` STRING COMMENT 'Statistical method used to calculate the reference interval (e.g., parametric 95% confidence interval, non-parametric percentile method, robust method). Documents the analytical approach per CLSI standards.',
    `unit_of_measure` STRING COMMENT 'The standardized unit of measure for the reference range values (e.g., mg/dL, mmol/L, g/dL, cells/mcL, IU/L). Must match the unit used in test results for proper interpretation.',
    `upper_normal_limit` DECIMAL(18,2) COMMENT 'The upper boundary of the normal reference range. Values above this threshold are typically flagged as high or abnormal.',
    CONSTRAINT pk_reference_range PRIMARY KEY(`reference_range_id`)
) COMMENT 'Reference data defining normal, abnormal, and critical value thresholds for each laboratory test, stratified by patient demographics (age group, sex, pregnancy status, race/ethnicity where clinically validated) and specimen type. Includes lower and upper normal limits, critical low and critical high thresholds, panic value definitions, unit of measure, effective date range, and the authoritative source (CAP, CLIA, manufacturer insert, institutional medical director override). Used by result interpretation logic to assign abnormal flags and trigger critical value alerts in test_result. Supports CLIA-required documentation of reference range sources and periodic review.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` (
    `pathology_report_id` BIGINT COMMENT 'Unique identifier for the pathology report. Primary key for this entity.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Anatomic pathology procedures are billed via CPT codes 88300–88399 (e.g., CPT 88305 for surgical pathology Level IV). Professional billing for pathology requires a direct CPT FK on the pathology repor',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this pathology report was generated.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Pathology reports require structured ICD-10 linkage for cancer registry reporting, tumor board case selection, billing compliance, and outcomes research. The diagnosis_code text field is denormalized;',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Pathology findings (diagnostic discrepancies, unexpected malignancies, margin status issues) are reviewed in peer review processes. Quality committees link pathology reports to peer review cases for d',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Pathology reports are generated in response to lab orders. Currently no FK exists. Business reality: pathology work is ordered via CPOE as lab orders. This links the report back to the original order ',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Pathology report types are LOINC-coded (e.g., LOINC 11529-5 Surgical pathology study). FHIR R4 DiagnosticReport.code and HL7 CDA document type require LOINC coding for pathology reports. Health info',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Pathology specimens used in research, teaching, tumor registries, or biobanking require documented consent. Tissue retention beyond diagnostic use, molecular profiling for research, and future contact',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Cancer registry reporting, CLIA compliance, and pathology billing require linking each pathology report to the performing org_provider. performing_laboratory is a denormalized plain-text field; norm',
    `clinician_id` BIGINT COMMENT 'Reference to the physician or provider who ordered the pathology examination.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Pathology reports require structured SNOMED CT linkage for cancer registry reporting, tumor board analytics, and pathology data exchange. The snomed_code text field is denormalized; proper FK enables ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Pathology reports in oncology trials are primary/secondary endpoints (tumor response, histologic grade, biomarkers). Must link to study for endpoint adjudication, tumor board review, cancer registry r',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Pathology reports are generated FROM specimens. Currently no FK exists. Business reality: pathology reports analyze specific specimens (tissue, cytology). Adding specimen_id FK allows joining to get s',
    `study_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_study. Business justification: Pathology-radiology correlation is a named clinical workflow required for tumor board review, cancer staging, and CAP accreditation. Pathology reports on image-guided biopsy specimens must directly re',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Pathology reports are generated for catalog tests. Currently pathology_report has report_type but no FK. Business reality: pathology work (surgical path, cytology) is ordered as catalog tests. Adding ',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Cancer registry reporting (CoC accreditation) and CDI require linking pathology findings to the coded encounter diagnosis they establish or confirm. pathology_report has diagnosis_icd_code_id (code) a',
    `accession_number` STRING COMMENT 'The unique laboratory accession number assigned when the specimen was received by the laboratory. Links to the specimen tracking system.',
    `addendum_history` STRING COMMENT 'Complete chronological record of all addenda added to the original report, including dates and content of each addendum.',
    `amended_timestamp` TIMESTAMP COMMENT 'The date and time when the report was amended or corrected after initial sign-out.',
    `amendment_reason` STRING COMMENT 'Explanation for why the pathology report was amended or corrected. Required for regulatory compliance and quality assurance.',
    `cancer_registry_reportable_flag` BOOLEAN COMMENT 'Indicates whether this case meets criteria for mandatory reporting to the cancer registry per state and federal requirements.',
    `case_number` STRING COMMENT 'The externally-known unique case identifier assigned by the pathology laboratory for tracking and reference purposes. This is the business identifier used in clinical workflows and correspondence.',
    `clia_number` STRING COMMENT 'The Clinical Laboratory Improvement Amendments (CLIA) certification number of the performing laboratory. Required for regulatory compliance.',
    `comment` STRING COMMENT 'Additional interpretive comments, clinical correlation, recommendations for further testing, or clarifications provided by the pathologist.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pathology report record was first created in the system.',
    `critical_value_flag` BOOLEAN COMMENT 'Indicates whether this report contains a critical or life-threatening finding that requires immediate physician notification per laboratory policy.',
    `critical_value_notification_timestamp` TIMESTAMP COMMENT 'The date and time when the critical finding was communicated to the ordering provider or responsible clinician.',
    `final_diagnosis` STRING COMMENT 'The conclusive diagnostic interpretation rendered by the pathologist based on gross and microscopic examination. This is the primary clinical finding of the report.',
    `gross_description` STRING COMMENT 'Detailed macroscopic description of the specimen as observed during gross examination by the pathologist or pathology assistant. Includes measurements, appearance, and dissection details.',
    `histologic_grade` STRING COMMENT 'The degree of differentiation of the tumor cells, indicating how closely the tumor resembles normal tissue. Used for prognosis and treatment planning.. Valid values are `well_differentiated|moderately_differentiated|poorly_differentiated|undifferentiated|not_applicable`',
    `histologic_type` STRING COMMENT 'The microscopic classification of the tumor based on cell type and tissue architecture (e.g., adenocarcinoma, squamous cell carcinoma).',
    `immunohistochemistry_results` STRING COMMENT 'Results of immunohistochemical staining performed to identify specific antigens or markers in the tissue. Includes marker names and interpretation (positive/negative/equivocal).',
    `lymph_nodes_examined` STRING COMMENT 'Total count of lymph nodes identified and examined microscopically in the specimen.',
    `lymph_nodes_positive` STRING COMMENT 'Count of lymph nodes containing metastatic tumor. Used for N classification in cancer staging.',
    `margin_status` STRING COMMENT 'Indicates whether tumor cells are present at the surgical resection margins. Critical for determining completeness of excision and need for additional treatment.. Valid values are `negative|positive|close|indeterminate|not_applicable`',
    `microscopic_description` STRING COMMENT 'Detailed microscopic findings observed during histological examination of the tissue sections. Describes cellular architecture, morphology, and pathological changes.',
    `molecular_testing_results` STRING COMMENT 'Results of molecular or genetic testing performed on the specimen (e.g., EGFR mutation, KRAS, HER2, MSI status). Critical for targeted therapy decisions.',
    `preliminary_report_timestamp` TIMESTAMP COMMENT 'The date and time when a preliminary or interim report was issued, if applicable. Used for urgent or critical findings that require immediate communication.',
    `received_date` DATE COMMENT 'The date on which the specimen was received by the pathology laboratory.',
    `report_status` STRING COMMENT 'Current lifecycle status of the pathology report indicating whether it is preliminary, finalized, or has been amended.. Valid values are `preliminary|final|amended|corrected|cancelled`',
    `report_type` STRING COMMENT 'The category of pathology report indicating the subspecialty or type of examination performed.. Valid values are `surgical_pathology|cytology|hematopathology|dermatopathology|neuropathology|autopsy`',
    `sign_out_timestamp` TIMESTAMP COMMENT 'The date and time when the pathologist finalized and electronically signed the pathology report, making it available for clinical use.',
    `special_stains_performed` STRING COMMENT 'List of special histochemical stains performed on the tissue sections to aid in diagnosis (e.g., PAS, GMS, AFB, trichrome).',
    `synoptic_report_elements` STRING COMMENT 'Structured data elements from CAP cancer protocol checklists presented in a standardized format. Includes all required synoptic reporting fields for the specific tumor type.',
    `tnm_stage` STRING COMMENT 'The combined TNM (Tumor, Node, Metastasis) stage classification for cancer cases following AJCC staging guidelines.',
    `tumor_board_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this case was presented and discussed at a multidisciplinary tumor board conference.',
    `tumor_site` STRING COMMENT 'Specific anatomical location of the tumor or lesion, used for cancer staging and registry reporting.',
    `tumor_size_cm` DECIMAL(18,2) COMMENT 'The greatest dimension of the tumor measured in centimeters. Critical for cancer staging (T classification).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this pathology report record was last modified in the system.',
    CONSTRAINT pk_pathology_report PRIMARY KEY(`pathology_report_id`)
) COMMENT 'Master record for surgical pathology and cytology reports generated by pathologists. Includes case number, specimen source, gross description, microscopic description, final diagnosis (ICD-10 coded), synoptic reporting elements (CAP cancer protocols), pathologist of record, sign-out date/time, report status (preliminary, final, amended), and addendum history. Supports oncology care coordination, tumor board workflows, and cancer registry reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` (
    `microbiology_culture_id` BIGINT COMMENT 'Unique identifier for the microbiology culture and sensitivity test record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider who ordered the microbiology culture test.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Infectious disease trials require culture results linked to study for efficacy endpoints (pathogen clearance, resistance patterns), safety monitoring (superinfections), and antibiotic stewardship prot',
    `demographics_id` BIGINT COMMENT 'Reference to the patient from whom the specimen was collected.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Microbiology cultures require ICD-10 linkage for HAI surveillance, infection control reporting, antibiotic stewardship program analytics, and public health case reporting. Enables stratification of cu',
    `lab_order_id` BIGINT COMMENT 'Reference to the parent laboratory order that requested this microbiology culture test.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Microbiology culture results are LOINC-coded (e.g., LOINC 600-7 Bacteria identified in Blood by Culture). NHSN public health reporting, HL7 ORU messages, and FHIR DiagnosticReport require LOINC-code',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Microbiology cultures in substance abuse treatment programs (42 CFR Part 2) require specialized consent for disclosure. Drug screening cultures, infectious disease testing in SUD settings, and public ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Microbiology cultures require SNOMED CT linkage for organism identification, infection surveillance, and antibiotic stewardship reporting. The organism_code text field is denormalized; proper FK enabl',
    `specimen_id` BIGINT COMMENT 'Reference to the biological specimen collected and submitted for culture testing.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Microbiology cultures are catalog tests. Currently microbiology_culture has culture_type but no FK to test_catalog. Business reality: cultures are ordered as catalog tests (e.g., blood culture, urine ',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: A microbiology culture is a specialized laboratory result that corresponds to a test_result record in the unified results repository. Linking microbiology_culture.test_result_id → test_result.test_res',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: HAI (healthcare-associated infection) surveillance and infection control regulatory reporting (NHSN) require linking culture results to the specific encounter diagnosis they confirm or establish. micr',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned identifier for tracking the specimen and associated tests throughout the laboratory workflow. Business identifier for external reference.',
    `antibiotic_stewardship_flag` BOOLEAN COMMENT 'Indicates whether this culture result triggered an antibiotic stewardship program intervention or review.',
    `collection_datetime` TIMESTAMP COMMENT 'Date and time when the biological specimen was collected from the patient. Critical for interpreting culture growth timing and clinical relevance.',
    `colony_count` BIGINT COMMENT 'Quantitative count of colony forming units per milliliter or per plate, used to assess infection severity and clinical significance.',
    `colony_count_unit` STRING COMMENT 'Unit of measure for the colony count (e.g., CFU/mL for urine cultures, CFU/plate for wound cultures).. Valid values are `CFU/mL|CFU/plate|CFU/gram`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this microbiology culture record was first created in the laboratory information system.',
    `critical_value_flag` BOOLEAN COMMENT 'Indicates whether this culture result represents a critical or panic value requiring immediate clinical notification (e.g., positive blood culture, multi-drug resistant organism).',
    `critical_value_notified_datetime` TIMESTAMP COMMENT 'Date and time when the critical value was communicated to the ordering provider or clinical team.',
    `culture_status` STRING COMMENT 'Current lifecycle status of the culture test indicating workflow stage and result availability.. Valid values are `ordered|in_progress|preliminary|final|corrected|cancelled`',
    `culture_type` STRING COMMENT 'Classification of the microbiology culture method and target organism category (e.g., aerobic bacteria, anaerobic bacteria, fungal, acid-fast bacilli, viral). [ENUM-REF-CANDIDATE: aerobic|anaerobic|fungal|mycobacterial|viral|blood|urine|wound|respiratory — 9 candidates stripped; promote to reference product]',
    `gram_stain_result` STRING COMMENT 'Result of Gram staining procedure used for preliminary bacterial classification (gram-positive, gram-negative, or gram-variable).. Valid values are `gram_positive|gram_negative|gram_variable|not_applicable`',
    `growth_result` STRING COMMENT 'Qualitative assessment of organism growth observed in the culture (e.g., no growth, light growth, moderate growth, heavy growth, mixed flora).. Valid values are `no_growth|light_growth|moderate_growth|heavy_growth|mixed_flora|contaminated`',
    `hai_associated_flag` BOOLEAN COMMENT 'Indicates whether this culture is associated with a healthcare-associated infection event for quality reporting and surveillance.',
    `hai_event_type` STRING COMMENT 'Specific type of healthcare-associated infection event linked to this culture (e.g., CLABSI, CAUTI, SSI, VAP, CDI) for regulatory reporting.. Valid values are `CLABSI|CAUTI|SSI|VAP|CDI`',
    `incubation_start_datetime` TIMESTAMP COMMENT 'Date and time when the culture was inoculated and incubation began.',
    `infection_control_notified_flag` BOOLEAN COMMENT 'Indicates whether the infection control department was notified of this culture result for surveillance or outbreak investigation.',
    `isolation_datetime` TIMESTAMP COMMENT 'Date and time when the organism was first isolated and identified from the culture medium.',
    `mdro_flag` BOOLEAN COMMENT 'Indicates whether the isolated organism is classified as a multi-drug resistant organism, triggering infection control protocols and antibiotic stewardship interventions.',
    `mdro_type` STRING COMMENT 'Specific classification of the multi-drug resistant organism (e.g., MRSA, VRE, ESBL, CRE) for infection control surveillance and reporting.. Valid values are `MRSA|VRE|ESBL|CRE|MDR_Acinetobacter|MDR_Pseudomonas`',
    `morphology` STRING COMMENT 'Microscopic morphological characteristics of the organism (e.g., cocci, bacilli, yeast, hyphae).',
    `public_health_reportable_flag` BOOLEAN COMMENT 'Indicates whether this culture result represents a notifiable disease or condition requiring reporting to public health authorities.',
    `quality_control_passed_flag` BOOLEAN COMMENT 'Indicates whether the culture test passed all required quality control checks and validation procedures per CLIA requirements.',
    `received_datetime` TIMESTAMP COMMENT 'Date and time when the specimen was received and accessioned by the laboratory.',
    `result_comments` STRING COMMENT 'Free-text comments, notes, or additional observations provided by laboratory staff regarding the culture result, methodology, or clinical context.',
    `result_datetime` TIMESTAMP COMMENT 'Date and time when the culture result was finalized and released for clinical use.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation or commentary provided by the microbiologist regarding the significance of the culture result and recommended actions.',
    `specimen_source_code` STRING COMMENT 'Standardized SNOMED CT code for the specimen source site.',
    `susceptibility_method` STRING COMMENT 'Laboratory method used to perform antimicrobial susceptibility testing (e.g., disk diffusion, broth microdilution, E-test, automated system).. Valid values are `disk_diffusion|broth_microdilution|etest|automated_system`',
    `susceptibility_panel_performed` BOOLEAN COMMENT 'Indicates whether antimicrobial susceptibility testing was performed on the isolated organism to guide antibiotic therapy.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from specimen collection to final result reporting, used for laboratory performance monitoring and quality improvement.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this microbiology culture record was last modified or updated.',
    CONSTRAINT pk_microbiology_culture PRIMARY KEY(`microbiology_culture_id`)
) COMMENT 'Transactional record for microbiology culture and sensitivity (C&S) testing. Tracks organism identification (SNOMED CT coded), culture type (aerobic, anaerobic, fungal, AFB, viral), growth result, colony count, isolation date/time, and the associated antimicrobial susceptibility panel. Supports infection control surveillance, antibiotic stewardship programs, and HAI (Healthcare-Associated Infection) reporting including CLABSI and CAUTI tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` (
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the blood product unit. Primary key for the blood bank unit record.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Blood products are billable items defined in the CDM. Linking blood_bank_unit to cdm_entry enables automated charge capture for blood products, price transparency compliance, and cost accounting. pro',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: FDA hemovigilance reporting and blood product traceability require linking each blood bank unit to the collecting org_provider facility. collection_facility_code is a denormalized plain-text field; ',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Blood bank units are crossmatched against patient specimens. Currently no FK exists. Business reality: crossmatch requires patient specimen (type and screen). Adding crossmatch_specimen_id FK (nullabl',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Blood product units require HCPCS linkage for billing, inventory valuation, and utilization reporting. The hcpcs_code text field is denormalized; proper FK enables automated charge capture, payer cont',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Blood products and transfusion supplies (filters, tubing, warmers, collection sets) are inventory items in the material master. This link enables blood bank inventory management, charge capture, and r',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: AABB hemovigilance and transfusion safety regulations require blood units reserved for a specific patient to be traceable to that patients enterprise MPI record. The existing denormalized reserved_f',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Surgical blood product management requires reserving and tracking blood bank units against a specific surgical case for pre-operative type-and-screen, intraoperative transfusion planning, and blood ut',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Blood product administration requires documented consent. Directed donations (family member to patient), autologous transfusions (patients own blood), and Jehovahs Witness refusals all require conse',
    `abo_blood_group` STRING COMMENT 'ABO blood type of the unit. Critical for compatibility matching with recipient to prevent hemolytic transfusion reactions.. Valid values are `A|B|AB|O`',
    `bacterial_contamination_testing_status` STRING COMMENT 'Status of bacterial detection testing, primarily for platelet units which are stored at room temperature. Positive results require unit quarantine and discard.. Valid values are `tested_negative|tested_positive|pending|not_applicable`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Amount charged to the patient or payer for this blood unit. Used for revenue cycle management and billing.',
    `cmv_status` STRING COMMENT 'CMV serology status of the donor. CMV-negative or CMV-safe (leukoreduced) units are required for immunocompromised patients, neonates, and pregnant women.. Valid values are `cmv_negative|cmv_positive|cmv_safe`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Acquisition or production cost of the blood unit. Used for inventory valuation, cost accounting, and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blood bank unit record was first created in the system. Used for audit trail and data lineage.',
    `crossmatch_required_flag` BOOLEAN COMMENT 'Indicates whether a serologic crossmatch is required before issuing this unit. May be waived for type O emergency release or for patients with negative antibody screens.',
    `discard_reason` STRING COMMENT 'Reason why the unit was discarded. Used for quality improvement, waste reduction initiatives, and regulatory reporting. [ENUM-REF-CANDIDATE: expired|temperature_excursion|positive_test_result|damaged|contaminated|outdated|quality_control_failure|other — 8 candidates stripped; promote to reference product]',
    `discard_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was discarded. Triggers waste tracking and quality review processes.',
    `donation_date` DATE COMMENT 'Date when the blood was collected from the donor. Used to calculate product age and expiration date.',
    `donation_identification_number` STRING COMMENT 'Unique identifier assigned to the original blood donation from which this unit was derived. Links unit to donor record for traceability and recall purposes.',
    `expiration_date` DATE COMMENT 'Date after which the blood product is no longer suitable for transfusion. Varies by product type and storage conditions (e.g., 42 days for packed red cells, 5 days for platelets).',
    `extended_phenotype` STRING COMMENT 'Additional red blood cell antigen profile beyond ABO/Rh (e.g., Kell, Duffy, Kidd, MNS). Used for patients with alloantibodies or those requiring antigen-matched units.',
    `hemoglobin_s_status` STRING COMMENT 'Indicates presence of sickle hemoglobin in the donor unit. Some institutions avoid sickle trait units for neonatal or exchange transfusions.. Valid values are `negative|trait|positive|unknown`',
    `infectious_disease_testing_status` STRING COMMENT 'Overall status of mandatory infectious disease testing (HIV, HBV, HCV, syphilis, HTLV, West Nile Virus, Zika, Chagas). Only units testing negative are released for transfusion.. Valid values are `tested_negative|tested_positive|pending|not_tested`',
    `irradiation_date` DATE COMMENT 'Date when the blood unit was irradiated. Irradiated units have reduced shelf life (typically 28 days from irradiation or original expiration, whichever is sooner).',
    `irradiation_status` STRING COMMENT 'Indicates whether the unit has been gamma-irradiated to prevent transfusion-associated graft-versus-host disease (TA-GVHD) in immunocompromised patients.. Valid values are `irradiated|non_irradiated`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was issued from the blood bank to the clinical area for transfusion. Starts the clock for return or transfusion completion.',
    `issued_to_location` STRING COMMENT 'Clinical unit or department to which the blood unit was issued (e.g., OR 3, ICU 2, ED). Used for tracking and accountability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this blood bank unit record was last modified. Supports change tracking and audit compliance.',
    `leukoreduction_status` STRING COMMENT 'Indicates whether white blood cells have been removed from the unit. Leukoreduction reduces febrile reactions, CMV transmission risk, and HLA alloimmunization.. Valid values are `leukoreduced|non_leukoreduced`',
    `lot_number` STRING COMMENT 'Lot number for pooled products (e.g., pooled platelets, pooled cryoprecipitate) or for products manufactured from multiple donations. Required for recall management.',
    `product_type` STRING COMMENT 'Classification of the blood component or product. Determines storage requirements, shelf life, and clinical indications for transfusion.. Valid values are `packed_red_blood_cells|platelets|fresh_frozen_plasma|cryoprecipitate|whole_blood|granulocytes`',
    `quarantine_reason` STRING COMMENT 'Reason why the unit has been placed in quarantine status (e.g., pending investigation, donor callback, positive test result, temperature deviation). Prevents inadvertent release.',
    `quarantine_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was placed into quarantine status. Initiates investigation and documentation requirements.',
    `reservation_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was reserved for a specific patient. Used to manage hold times and release units if not transfused within policy timeframe.',
    `return_timestamp` TIMESTAMP COMMENT 'Date and time when an issued unit was returned to the blood bank unused. Units returned within acceptable time and temperature may be re-entered into inventory.',
    `rh_type` STRING COMMENT 'Rh (D antigen) status of the blood unit. Essential for preventing Rh alloimmunization, especially in Rh-negative recipients.. Valid values are `positive|negative`',
    `special_processing_codes` STRING COMMENT 'Comma-separated list of special processing or modifications applied to the unit (e.g., washed, volume-reduced, split, pooled). Affects clinical use and billing.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Current storage temperature in Celsius. Must be maintained within product-specific ranges (e.g., 1-6°C for red cells, 20-24°C for platelets, ≤-18°C for FFP).',
    `supplier_facility_code` STRING COMMENT 'Identifier of the external blood supplier or blood center if the unit was not collected in-house. Used for vendor management and recall coordination.',
    `temperature_alarm_flag` BOOLEAN COMMENT 'Indicates whether a temperature excursion alarm has been triggered for this unit. Temperature deviations may render the unit unsuitable for transfusion.',
    `transfusion_timestamp` TIMESTAMP COMMENT 'Date and time when the transfusion was started. Critical for hemovigilance reporting and adverse event investigation.',
    `unit_number` STRING COMMENT 'Globally unique blood unit identifier encoded using ISBT 128 standard barcode format. Enables worldwide traceability of blood products from donor to recipient.. Valid values are `^[A-Z0-9]{13,14}$`',
    `unit_status` STRING COMMENT 'Current lifecycle status of the blood unit. Tracks the unit from availability through final disposition (transfused, discarded, or returned). [ENUM-REF-CANDIDATE: available|reserved|crossmatched|issued|transfused|returned|discarded|quarantined|expired — 9 candidates stripped; promote to reference product]',
    `volume_ml` DECIMAL(18,2) COMMENT 'Volume of the blood product in milliliters. Used for dosing calculations and inventory management.',
    CONSTRAINT pk_blood_bank_unit PRIMARY KEY(`blood_bank_unit_id`)
) COMMENT 'Master record for each blood product unit managed by the transfusion medicine / blood bank service. Tracks unit number (ISBT 128 coded), product type (packed red cells, platelets, FFP, cryoprecipitate, whole blood, granulocytes), ABO/Rh type, donation date, expiration date, irradiation status, leukoreduction status, CMV status, sickle trait status, unit status lifecycle (available, reserved, crossmatched, issued, transfused, discarded, returned, quarantined), storage location, and temperature monitoring. SSOT for blood product inventory, traceability, and regulatory compliance. Supports AABB standards, FDA blood establishment regulations, and hemovigilance reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` (
    `transfusion_event_id` BIGINT COMMENT 'Unique identifier for the transfusion event record. Primary key.',
    `blood_bank_unit_id` BIGINT COMMENT 'Unique identifier for the specific blood product unit transfused. Links to blood bank inventory.',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Transfusion events generate billable charges for blood products and administration services. Direct link supports charge capture at point of transfusion, enables blood bank revenue tracking, facilitat',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Blood transfusions are high-cost billable events generating claims for blood products, administration, and compatibility testing. Critical for blood bank revenue capture, transfusion service billing, ',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order authorizing the transfusion.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the medical laboratory technologist who performed the crossmatch testing.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Transfusion procedures are CPT-coded (e.g., CPT 36430 transfusion blood, CPT 36440 push transfusion). Professional and facility billing for transfusion services requires a CPT FK on the transfusion ev',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: A transfusion event is authorized by a crossmatch/compatibility test result (type & screen, crossmatch). Linking transfusion_event.crossmatch_test_result_id → test_result.test_result_id formally conne',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient receiving the transfusion. Links to the patient master record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Transfusion events require a structured diagnosis link (e.g., acute blood loss anemia, thrombocytopenia) for medical necessity, billing, and hemovigilance regulatory reporting. The existing clinical_i',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Transfusion events require HCPCS linkage for billing, hemovigilance reporting, and utilization management. Enables automated charge capture for blood administration, supports transfusion reaction cost',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Transfusions administered during or immediately after surgical procedures must be linked to the procedure_event for perioperative blood utilization reporting, surgical quality metrics, and Joint Commi',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Transfusion events trigger blood administration notifications to blood bank systems and hemovigilance reporting to FDA/AABB. Links transfusion to transmission event for adverse reaction reporting audi',
    `specimen_id` BIGINT COMMENT 'Identifier for the patient blood specimen used for compatibility testing. Critical for ensuring correct patient-unit matching.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Blood transfusions during surgery are common and require tracking for blood bank management, surgical quality metrics, and hemovigilance reporting. Essential for linking intra-operative transfusions t',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: Joint Commission and AABB standards require documented informed consent for transfusion, traceable to the patients consent record. transfusion_event has consent_obtained and consent_datetime as plain',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Transfusion reactions are ICD-10-CM coded (T80.xx series) for hemovigilance reporting, CMS hospital-acquired condition (HAC) tracking, and inpatient claims. transfusion_event.transfusion_reaction_type',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Transfusion reaction types are SNOMED-coded for hemovigilance reporting (ISBT/SHOT standards) and FHIR R4 AdverseEvent.event. transfusion_event.transfusion_reaction_type is plain text; SNOMED coding e',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical encounter during which the transfusion occurred.',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Perioperative blood utilization reporting, AABB hemovigilance compliance, and surgical quality metrics require linking transfusion events to the specific procedure during which blood was administered.',
    `antibody_screen_result` STRING COMMENT 'Result of the antibody screening test to detect unexpected antibodies in patient serum that could cause transfusion reactions.. Valid values are `positive|negative|not_performed|indeterminate`',
    `consent_datetime` TIMESTAMP COMMENT 'Date and time when informed consent for transfusion was obtained.',
    `consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether informed consent for transfusion was obtained from the patient or authorized representative prior to administration.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this transfusion event record was first created in the system. Audit trail timestamp.',
    `crossmatch_datetime` TIMESTAMP COMMENT 'Date and time when the crossmatch compatibility testing was completed.',
    `crossmatch_result` STRING COMMENT 'Outcome of the compatibility testing between donor unit and patient sample. Compatible indicates safe to transfuse, incompatible indicates potential reaction risk.. Valid values are `compatible|incompatible|not_performed|indeterminate`',
    `crossmatch_type` STRING COMMENT 'Type of compatibility testing performed prior to transfusion. Electronic crossmatch uses computer verification, immediate spin is abbreviated testing, full serologic is complete antiglobulin testing.. Valid values are `electronic|immediate_spin|full_serologic|type_and_screen|emergency_release`',
    `hemovigilance_reported` BOOLEAN COMMENT 'Boolean flag indicating whether this transfusion event was reported to the institutional or national hemovigilance surveillance system, typically for adverse reactions.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Date and time when this transfusion event record was most recently modified. Audit trail timestamp.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments related to the transfusion event, including any special circumstances, patient tolerance, or follow-up actions.',
    `post_transfusion_blood_pressure_diastolic` STRING COMMENT 'Patient diastolic blood pressure in mmHg measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_blood_pressure_systolic` STRING COMMENT 'Patient systolic blood pressure in mmHg measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_pulse` STRING COMMENT 'Patient pulse rate in beats per minute measured after transfusion completion. Used to detect hemodynamic changes.',
    `post_transfusion_respiratory_rate` STRING COMMENT 'Patient respiratory rate in breaths per minute measured after transfusion completion. Used to detect respiratory complications.',
    `post_transfusion_temperature` DECIMAL(18,2) COMMENT 'Patient body temperature in degrees Celsius measured after transfusion completion. Used to detect febrile reactions.',
    `pre_transfusion_blood_pressure_diastolic` STRING COMMENT 'Patient diastolic blood pressure in mmHg measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_blood_pressure_systolic` STRING COMMENT 'Patient systolic blood pressure in mmHg measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_pulse` STRING COMMENT 'Patient pulse rate in beats per minute measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_respiratory_rate` STRING COMMENT 'Patient respiratory rate in breaths per minute measured immediately before transfusion start. Baseline for reaction monitoring.',
    `pre_transfusion_temperature` DECIMAL(18,2) COMMENT 'Patient body temperature in degrees Celsius measured immediately before transfusion start. Baseline for reaction monitoring.',
    `reaction_description` STRING COMMENT 'Free-text clinical description of the transfusion reaction signs, symptoms, and clinical course. May include fever, chills, rash, dyspnea, hypotension, or other manifestations.',
    `reaction_onset_datetime` TIMESTAMP COMMENT 'Date and time when the transfusion reaction symptoms were first observed. Critical for determining reaction type and causality.',
    `reaction_severity` STRING COMMENT 'Clinical severity classification of the transfusion reaction. Mild reactions may require monitoring only, severe and life-threatening reactions require immediate intervention.. Valid values are `mild|moderate|severe|life_threatening`',
    `special_requirements` STRING COMMENT 'Any special processing or handling requirements for the transfusion (e.g., irradiated, CMV-negative, leukoreduced, washed). Critical for immunocompromised patients.',
    `transfusion_end_datetime` TIMESTAMP COMMENT 'Date and time when the blood product transfusion was completed or discontinued.',
    `transfusion_number` STRING COMMENT 'Human-readable business identifier for the transfusion event, often used for tracking and audit purposes.',
    `transfusion_rate` DECIMAL(18,2) COMMENT 'Rate at which the blood product was administered (e.g., 100 mL/hour, slow infusion over 4 hours). Important for patient safety and reaction prevention.',
    `transfusion_reaction_occurred` BOOLEAN COMMENT 'Boolean flag indicating whether any adverse transfusion reaction was observed during or after the transfusion.',
    `transfusion_reaction_type` STRING COMMENT 'Classification of the adverse transfusion reaction type if one occurred. Includes febrile non-hemolytic reaction (FNHTR), allergic, anaphylactic, acute hemolytic, delayed hemolytic, transfusion-related acute lung injury (TRALI), and transfusion-associated circulatory overload (TACO). [ENUM-REF-CANDIDATE: febrile_non_hemolytic|allergic|anaphylactic|acute_hemolytic|delayed_hemolytic|transfusion_related_acute_lung_injury|transfusion_associated_circulatory_overload — 7 candidates stripped; promote to reference product]',
    `transfusion_site` STRING COMMENT 'Anatomical location or clinical area where the transfusion was administered (e.g., right antecubital, left hand, central line).',
    `transfusion_start_datetime` TIMESTAMP COMMENT 'Date and time when the blood product transfusion was initiated. Critical for monitoring transfusion duration and reaction timing.',
    `transfusion_status` STRING COMMENT 'Current lifecycle status of the transfusion event. Tracks progression from order through completion or discontinuation.. Valid values are `ordered|prepared|in_progress|completed|discontinued|cancelled`',
    `unexpected_antibody_identified` STRING COMMENT 'Specific antibody or antibodies identified during antibody identification testing, if antibody screen was positive. May include multiple antibodies separated by commas.',
    `volume_transfused_ml` STRING COMMENT 'Total volume of blood product transfused in milliliters. Used for dosing verification and fluid balance monitoring.',
    CONSTRAINT pk_transfusion_event PRIMARY KEY(`transfusion_event_id`)
) COMMENT 'Transactional record of the full blood product transfusion lifecycle from crossmatch/compatibility testing through administration and post-transfusion monitoring. Owns crossmatch and compatibility testing: crossmatch type (electronic, immediate spin, full serologic), compatibility result (compatible, incompatible), antibody screen result, unexpected antibody identification, patient blood sample reference, performing technologist, crossmatch date/time. Owns transfusion administration: blood bank unit transfused, transfusion start and end date/time, transfusion site, administering nurse, pre- and post-transfusion vital signs, transfusion reaction indicator and type, reaction severity, and clinical indication. Consolidates the former crossmatch product. Supports hemovigilance reporting, AABB compliance, blood bank audit trails, and patient safety surveillance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` (
    `test_catalog_id` BIGINT COMMENT 'Unique identifier for the laboratory test catalog entry. Primary key for the test catalog product.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Every orderable lab test maps to a CDM entry defining charge amount, revenue code, and billing rules. This is a fundamental revenue cycle relationship for charge capture and price transparency. test_',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Test catalog entries require structured CPT linkage for charge master maintenance, billing compliance, RVU-based productivity reporting, and payer contract validation. The cpt_code text field is denor',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Lab test catalog entries require HCPCS Level II codes (P-codes, G-codes) for outpatient and Medicare billing alongside CPT codes. CMS Clinical Laboratory Fee Schedule uses HCPCS coding. test_catalog a',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Test catalog entries require structured LOINC linkage for interoperability, HIE result exchange, quality measure reporting, and EHR integration. The loinc_code text field is denormalized; proper FK en',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Lab order routing and network adequacy require knowing which org_provider can perform each cataloged test. performing_lab_location is a denormalized plain-text field; normalizing to org_provider_id ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Test catalog entries require SNOMED CT linkage for clinical terminology standardization, order set management, and semantic interoperability. Enables precise test ordering, supports clinical decision ',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether payer prior authorization is typically required before performing this test due to cost or medical necessity criteria. Supports revenue cycle management.',
    `clia_complexity` STRING COMMENT 'CLIA complexity classification of the test: waived (simple, low risk), moderate complexity, or high complexity. Determines regulatory requirements and personnel qualifications.. Valid values are `waived|moderate|high`',
    `clinical_indication` STRING COMMENT 'Primary clinical use case, indication, or purpose for ordering this test. Supports clinical decision support and appropriate test utilization.',
    `collection_instructions` STRING COMMENT 'Detailed instructions for phlebotomy or specimen collection staff, including special handling, order of draw, collection technique, or timing requirements.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether informed patient consent is required before performing this test (e.g., genetic testing, HIV testing, research testing). Supports regulatory compliance and patient rights.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test catalog entry was first created in the system. Supports audit trail and historical tracking.',
    `critical_high_value` DECIMAL(18,2) COMMENT 'Upper threshold for critical value alerting. Results at or above this value trigger immediate notification to the ordering provider per Joint Commission and patient safety requirements.',
    `critical_low_value` DECIMAL(18,2) COMMENT 'Lower threshold for critical value alerting. Results at or below this value trigger immediate notification to the ordering provider per Joint Commission and patient safety requirements.',
    `effective_date` DATE COMMENT 'Date when this test catalog entry became or will become active and available for ordering. Supports test catalog version control and historical tracking.',
    `expiration_date` DATE COMMENT 'Date when this test catalog entry was or will be retired or inactivated. Null for currently active tests with no planned retirement date.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this test catalog entry was last modified. Supports audit trail and change tracking for regulatory compliance.',
    `methodology` STRING COMMENT 'Analytical method or technology used to perform the test (e.g., immunoassay, PCR, mass spectrometry, flow cytometry, enzymatic assay, culture). Important for result interpretation and quality control.',
    `minimum_volume` STRING COMMENT 'Minimum volume of specimen required to perform the test, typically expressed with units (e.g., 2 mL, 5 mL, 0.5 mL). Critical for specimen adequacy assessment.',
    `orderable_flag` BOOLEAN COMMENT 'Indicates whether this test is currently available for ordering by clinicians through CPOE (Computerized Physician Order Entry) systems. False for retired, suspended, or component-only tests.',
    `orderable_status` STRING COMMENT 'Current lifecycle status of the test in the catalog. Active tests are available for ordering; inactive/retired tests are no longer available; suspended tests are temporarily unavailable; pending validation tests are under review.. Valid values are `active|inactive|suspended|retired|pending_validation`',
    `ordering_instructions` STRING COMMENT 'Special instructions or requirements for ordering this test, including patient preparation (e.g., fasting required, medication restrictions), timing considerations, or authorization requirements.',
    `panic_value_flag` BOOLEAN COMMENT 'Indicates whether this test can produce panic or critical values requiring immediate clinical notification and documentation of provider acknowledgment.',
    `patient_preparation` STRING COMMENT 'Specific patient preparation requirements prior to specimen collection (e.g., 8-hour fast, discontinue medications, timed collection, dietary restrictions). Critical for accurate test results.',
    `preferred_volume` STRING COMMENT 'Preferred or optimal volume of specimen for best test performance and to allow for repeat testing if needed.',
    `reference_lab_code` STRING COMMENT 'Test code used by the external reference laboratory for ordering and tracking. Used for send-out test routing and result reconciliation.',
    `reference_lab_name` STRING COMMENT 'Name of the external reference laboratory if this is a send-out test not performed in-house. Null for tests performed internally.',
    `reference_range_adult` STRING COMMENT 'Normal reference range for adult patients, typically expressed as a range (e.g., 3.5-5.0, <10, negative). May vary by gender and age subgroups.',
    `reference_range_pediatric` STRING COMMENT 'Normal reference range for pediatric patients. May be age-stratified (e.g., neonate, infant, child, adolescent) due to developmental physiology differences.',
    `result_type` STRING COMMENT 'Type of result produced by the test: quantitative (numeric with units), qualitative (positive/negative/detected), semi-quantitative (titers, grades), narrative (free text interpretation), culture results, or microscopic findings.. Valid values are `quantitative|qualitative|semi_quantitative|narrative|culture|microscopic`',
    `specimen_container` STRING COMMENT 'Type of collection container or tube required (e.g., red top, lavender top EDTA, green top heparin, yellow top ACD, sterile container). Includes tube color and additive information.',
    `specimen_stability` STRING COMMENT 'Duration for which the specimen remains stable under specified storage conditions before testing must be performed (e.g., 24 hours at room temperature, 7 days refrigerated).',
    `specimen_type` STRING COMMENT 'Type of biological specimen required for the test (e.g., blood, serum, plasma, urine, CSF, tissue, swab). Critical for specimen collection and handling.',
    `storage_temperature` STRING COMMENT 'Required storage temperature for the specimen prior to testing (e.g., room temperature, refrigerated 2-8°C, frozen -20°C, frozen -80°C). Critical for specimen stability.',
    `test_abbreviation` STRING COMMENT 'Short abbreviation or mnemonic for the test used in clinical documentation and reporting (e.g., CBC, BMP, CMP, TSH).',
    `test_category` STRING COMMENT 'High-level classification of the test by laboratory discipline or department (e.g., chemistry, hematology, microbiology, immunology, molecular diagnostics, anatomic pathology). [ENUM-REF-CANDIDATE: chemistry|hematology|microbiology|immunology|molecular|pathology|blood_bank|coagulation|toxicology|urinalysis — 10 candidates stripped; promote to reference product]',
    `test_name` STRING COMMENT 'Full descriptive name of the laboratory test or panel as displayed to clinicians and in order entry systems.',
    `test_type` STRING COMMENT 'Indicates whether this catalog entry represents an individual test, a panel (group of related tests), a profile, a reflex test (automatically triggered based on results), or an add-on test.. Valid values are `individual_test|panel|profile|reflex_test|add_on_test`',
    `transport_conditions` STRING COMMENT 'Special transport requirements for the specimen (e.g., transport on ice, ambient temperature, protect from light, transport immediately). Ensures specimen integrity during transport.',
    `turnaround_time_routine` STRING COMMENT 'Expected turnaround time for routine test orders from specimen receipt to result availability, typically expressed in hours or days (e.g., 4 hours, 24 hours, 3-5 days).',
    `turnaround_time_stat` STRING COMMENT 'Expected turnaround time for STAT (urgent) test orders requiring expedited processing, typically expressed in minutes or hours (e.g., 30 minutes, 1 hour, 2 hours).',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantitative test results (e.g., mg/dL, mmol/L, IU/mL, cells/mcL, %). Aligned with UCUM (Unified Code for Units of Measure) standards.',
    CONSTRAINT pk_test_catalog PRIMARY KEY(`test_catalog_id`)
) COMMENT 'Reference master of all laboratory tests and test panels offered by the health system, serving as the SSOT for the laboratory test compendium. For individual tests: captures LOINC code, test name, CPT code(s) for billing, specimen requirements, container type, minimum volume, storage and transport conditions, turnaround time targets (routine and STAT), performing lab (internal section or reference lab name), methodology, and orderable flag. For panels and profiles (e.g., BMP, CMP, CBC with differential, lipid panel, hepatic function panel): captures panel LOINC code, panel name, component test relationships, clinical use case, panel-specific ordering rules, and orderable status. Also covers send-out test catalog entries with reference lab routing information. Consolidates the former test_panel product. Used by clinicians, order entry systems (CPOE), clinical decision support, and CDM charge alignment.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_parent_specimen_id` FOREIGN KEY (`parent_specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_blood_bank_unit_id` FOREIGN KEY (`blood_bank_unit_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit`(`blood_bank_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`laboratory` SET TAGS ('dbx_domain' = 'laboratory');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` SET TAGS ('dbx_subdomain' = 'diagnostic_testing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Activity Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `tertiary_lab_cancelled_by_provider_clinician_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Cancelled Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 (International Classification of Diseases 10th Revision) Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `expected_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Expected Turnaround Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `fasting_required` SET TAGS ('dbx_business_glossary_term' = 'Fasting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `is_send_out` SET TAGS ('dbx_business_glossary_term' = 'Is Send-Out Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'STAT|routine|ASAP|timed|urgent');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_set_name` SET TAGS ('dbx_business_glossary_term' = 'Order Set Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `point_of_care_test` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Care Test Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_accession_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Result Integration Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_integration_status` SET TAGS ('dbx_value_regex' = 'pending|integrated|failed|manual_entry_required');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `result_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Shipping Carrier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `shipping_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Tracking Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `source_system_order_number` SET TAGS ('dbx_business_glossary_term' = 'Source System Order ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Specimen Shipped Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_source` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `standing_order` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` SET TAGS ('dbx_subdomain' = 'diagnostic_testing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Collector Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `parent_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Specimen Identifier');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Radiology Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_datetime` SET TAGS ('dbx_business_glossary_term' = 'Accession Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_status` SET TAGS ('dbx_business_glossary_term' = 'Accession Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `accession_status` SET TAGS ('dbx_value_regex' = 'received|processing|resulted|archived|rejected');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `biohazard_level` SET TAGS ('dbx_business_glossary_term' = 'Biohazard Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `biohazard_level` SET TAGS ('dbx_value_regex' = 'standard|high_risk|unknown');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'intact|broken|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_datetime` SET TAGS ('dbx_business_glossary_term' = 'Collection Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Collection Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `collector_role` SET TAGS ('dbx_business_glossary_term' = 'Collector Role');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Specimen Comments');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_business_glossary_term' = 'Condition at Receipt');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `condition_at_receipt` SET TAGS ('dbx_value_regex' = 'acceptable|hemolyzed|clotted|insufficient|contaminated|unlabeled');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `disposal_datetime` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_business_glossary_term' = 'Fasting Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `fasting_status` SET TAGS ('dbx_value_regex' = 'fasting|non_fasting|unknown');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `number_of_aliquots` SET TAGS ('dbx_business_glossary_term' = 'Number of Aliquots');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Specimen Priority');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `retention_status` SET TAGS ('dbx_value_regex' = 'active|retained|disposed|archived');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'blood|urine|tissue|csf|swab|stool');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `transport_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Transport Duration (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `transport_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Transport Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ALTER COLUMN `volume_collected_ml` SET TAGS ('dbx_business_glossary_term' = 'Volume Collected (Milliliters)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` SET TAGS ('dbx_subdomain' = 'diagnostic_testing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Verifying Pathologist Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `reference_range_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Result Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `tertiary_test_ordering_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `abnormal_flag` SET TAGS ('dbx_business_glossary_term' = 'Abnormal Flag Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `amendment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Amendment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Result Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clia_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `clia_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}D[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_acknowledgment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Acknowledgment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_alert_generated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Alert Generated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_escalation_action` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Escalation Action');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_notification_method` SET TAGS ('dbx_value_regex' = 'phone|secure_message|ehr_alert|page|fax|in_person');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `critical_value_resolution_note` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Resolution Note');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Result Amended Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `is_critical_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Original Numeric Result Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `original_result_value_text` SET TAGS ('dbx_business_glossary_term' = 'Original Text Result Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `performing_lab_section` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Section');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_business_glossary_term' = 'Result Comment or Note');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Clinical Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_released_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Released Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status Lifecycle');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|corrected|cancelled|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_coded` SET TAGS ('dbx_business_glossary_term' = 'Coded Result Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_numeric` SET TAGS ('dbx_business_glossary_term' = 'Numeric Result Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `result_value_text` SET TAGS ('dbx_business_glossary_term' = 'Text Result Value');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ALTER COLUMN `specimen_received_datetime` SET TAGS ('dbx_business_glossary_term' = 'Specimen Received Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` SET TAGS ('dbx_subdomain' = 'diagnostic_testing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `reference_range_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Patient Age Group');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `age_group` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `alert_priority` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `alert_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical|stat');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `alert_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Trigger Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `critical_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical High Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `critical_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `instrument_platform` SET TAGS ('dbx_business_glossary_term' = 'Instrument Platform');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `interpretation_code` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `interpretation_code` SET TAGS ('dbx_value_regex' = 'normal|low|high|critical_low|critical_high|abnormal');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `lis_system_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information System (LIS) System Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `lower_normal_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Normal Limit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Director Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `medical_director_override_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Methodology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `population_basis` SET TAGS ('dbx_business_glossary_term' = 'Reference Population Basis');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `pregnancy_status` SET TAGS ('dbx_value_regex' = 'pregnant|not_pregnant|not_applicable|unknown');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Race and Ethnicity');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'current|pending_review|under_revision|retired');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Reference Population Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Patient Sex');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|all|unknown');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `sex` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `source_citation` SET TAGS ('dbx_business_glossary_term' = 'Source Citation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Source Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'cap|clia|manufacturer|institutional|peer_reviewed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ALTER COLUMN `upper_normal_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Normal Limit');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` SET TAGS ('dbx_subdomain' = 'pathology_services');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_business_glossary_term' = 'Pathology Report ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Radiology Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `addendum_history` SET TAGS ('dbx_business_glossary_term' = 'Addendum History');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `amended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Amendment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `cancer_registry_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancer Registry Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Pathology Case Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `clia_number` SET TAGS ('dbx_business_glossary_term' = 'CLIA Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Pathologist Comment');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `critical_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `critical_value_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Final Pathological Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `final_diagnosis` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `gross_description` SET TAGS ('dbx_business_glossary_term' = 'Gross Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_grade` SET TAGS ('dbx_business_glossary_term' = 'Histologic Grade');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_grade` SET TAGS ('dbx_value_regex' = 'well_differentiated|moderately_differentiated|poorly_differentiated|undifferentiated|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `histologic_type` SET TAGS ('dbx_business_glossary_term' = 'Histologic Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `immunohistochemistry_results` SET TAGS ('dbx_business_glossary_term' = 'Immunohistochemistry (IHC) Results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_examined` SET TAGS ('dbx_business_glossary_term' = 'Number of Lymph Nodes Examined');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `lymph_nodes_positive` SET TAGS ('dbx_business_glossary_term' = 'Number of Lymph Nodes Positive for Metastasis');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `margin_status` SET TAGS ('dbx_business_glossary_term' = 'Surgical Margin Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `margin_status` SET TAGS ('dbx_value_regex' = 'negative|positive|close|indeterminate|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `microscopic_description` SET TAGS ('dbx_business_glossary_term' = 'Microscopic Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `molecular_testing_results` SET TAGS ('dbx_business_glossary_term' = 'Molecular Testing Results');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `preliminary_report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Report Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Received Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|amended|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Pathology Report Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'surgical_pathology|cytology|hematopathology|dermatopathology|neuropathology|autopsy');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `sign_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Sign-Out Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `special_stains_performed` SET TAGS ('dbx_business_glossary_term' = 'Special Stains Performed');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `synoptic_report_elements` SET TAGS ('dbx_business_glossary_term' = 'Synoptic Report Elements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tnm_stage` SET TAGS ('dbx_business_glossary_term' = 'TNM Stage');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tnm_stage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_board_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Tumor Board Reviewed Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_site` SET TAGS ('dbx_business_glossary_term' = 'Tumor Site');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `tumor_size_cm` SET TAGS ('dbx_business_glossary_term' = 'Tumor Size in Centimeters');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` SET TAGS ('dbx_subdomain' = 'pathology_services');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `microbiology_culture_id` SET TAGS ('dbx_business_glossary_term' = 'Microbiology Culture Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory (Lab) Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Organism Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accession Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `antibiotic_stewardship_flag` SET TAGS ('dbx_business_glossary_term' = 'Antibiotic Stewardship Program (ASP) Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `collection_datetime` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count` SET TAGS ('dbx_business_glossary_term' = 'Colony Forming Units (CFU) Count');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count_unit` SET TAGS ('dbx_business_glossary_term' = 'Colony Count Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `colony_count_unit` SET TAGS ('dbx_value_regex' = 'CFU/mL|CFU/plate|CFU/gram');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `critical_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `critical_value_notified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Critical Value Notification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_status` SET TAGS ('dbx_business_glossary_term' = 'Culture Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_status` SET TAGS ('dbx_value_regex' = 'ordered|in_progress|preliminary|final|corrected|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `culture_type` SET TAGS ('dbx_business_glossary_term' = 'Culture Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('dbx_business_glossary_term' = 'Gram Stain Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `gram_stain_result` SET TAGS ('dbx_value_regex' = 'gram_positive|gram_negative|gram_variable|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('dbx_business_glossary_term' = 'Culture Growth Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `growth_result` SET TAGS ('dbx_value_regex' = 'no_growth|light_growth|moderate_growth|heavy_growth|mixed_flora|contaminated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_associated_flag` SET TAGS ('dbx_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_event_type` SET TAGS ('dbx_business_glossary_term' = 'Healthcare-Associated Infection (HAI) Event Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `hai_event_type` SET TAGS ('dbx_value_regex' = 'CLABSI|CAUTI|SSI|VAP|CDI');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `incubation_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incubation Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `infection_control_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Notification Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `isolation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Organism Isolation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Drug Resistant Organism (MDRO) Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_type` SET TAGS ('dbx_business_glossary_term' = 'Multi-Drug Resistant Organism (MDRO) Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `mdro_type` SET TAGS ('dbx_value_regex' = 'MRSA|VRE|ESBL|CRE|MDR_Acinetobacter|MDR_Pseudomonas');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `morphology` SET TAGS ('dbx_business_glossary_term' = 'Organism Morphology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Health Reportable Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `public_health_reportable_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `quality_control_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Passed Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `received_datetime` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Receipt Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_comments` SET TAGS ('dbx_business_glossary_term' = 'Result Comments and Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Finalization Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Clinical Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `specimen_source_code` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_method` SET TAGS ('dbx_business_glossary_term' = 'Susceptibility Testing Method');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_method` SET TAGS ('dbx_value_regex' = 'disk_diffusion|broth_microdilution|etest|automated_system');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `susceptibility_panel_performed` SET TAGS ('dbx_business_glossary_term' = 'Antimicrobial Susceptibility Testing (AST) Performed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Turnaround Time in Hours');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` SET TAGS ('dbx_subdomain' = 'transfusion_medicine');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Blood Bank Unit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Specimen Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Reserved For Patient Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_business_glossary_term' = 'ABO Blood Group');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `abo_blood_group` SET TAGS ('dbx_value_regex' = 'A|B|AB|O');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_business_glossary_term' = 'Bacterial Contamination Testing Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `bacterial_contamination_testing_status` SET TAGS ('dbx_value_regex' = 'tested_negative|tested_positive|pending|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cmv_status` SET TAGS ('dbx_business_glossary_term' = 'Cytomegalovirus (CMV) Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cmv_status` SET TAGS ('dbx_value_regex' = 'cmv_negative|cmv_positive|cmv_safe');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `crossmatch_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `discard_reason` SET TAGS ('dbx_business_glossary_term' = 'Discard Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `discard_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discard Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `donation_date` SET TAGS ('dbx_business_glossary_term' = 'Blood Donation Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `donation_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Donation Identification Number (DIN)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `extended_phenotype` SET TAGS ('dbx_business_glossary_term' = 'Extended Red Cell Phenotype');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hemoglobin_s_status` SET TAGS ('dbx_business_glossary_term' = 'Hemoglobin S (Sickle Cell) Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `hemoglobin_s_status` SET TAGS ('dbx_value_regex' = 'negative|trait|positive|unknown');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_business_glossary_term' = 'Infectious Disease Testing Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `infectious_disease_testing_status` SET TAGS ('dbx_value_regex' = 'tested_negative|tested_positive|pending|not_tested');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_date` SET TAGS ('dbx_business_glossary_term' = 'Irradiation Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_status` SET TAGS ('dbx_business_glossary_term' = 'Irradiation Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `irradiation_status` SET TAGS ('dbx_value_regex' = 'irradiated|non_irradiated');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `issued_to_location` SET TAGS ('dbx_business_glossary_term' = 'Issued to Clinical Location');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `leukoreduction_status` SET TAGS ('dbx_business_glossary_term' = 'Leukoreduction Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `leukoreduction_status` SET TAGS ('dbx_value_regex' = 'leukoreduced|non_leukoreduced');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Blood Product Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'packed_red_blood_cells|platelets|fresh_frozen_plasma|cryoprecipitate|whole_blood|granulocytes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `quarantine_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `reservation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `rh_type` SET TAGS ('dbx_business_glossary_term' = 'Rh Factor Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `rh_type` SET TAGS ('dbx_value_regex' = 'positive|negative');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `special_processing_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Processing Codes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `supplier_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Facility Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `temperature_alarm_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Alarm Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `transfusion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Number (ISBT 128)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{13,14}$');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ALTER COLUMN `volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Blood Unit Volume (Milliliters)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` SET TAGS ('dbx_subdomain' = 'transfusion_medicine');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Event Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Blood Bank Unit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Technologist Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Blood Sample Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Consent Reference Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Reaction Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Reaction Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `antibody_screen_result` SET TAGS ('dbx_business_glossary_term' = 'Antibody Screen Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `antibody_screen_result` SET TAGS ('dbx_value_regex' = 'positive|negative|not_performed|indeterminate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_datetime` SET TAGS ('dbx_business_glossary_term' = 'Consent Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_datetime` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_result` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Result');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_result` SET TAGS ('dbx_value_regex' = 'compatible|incompatible|not_performed|indeterminate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_type` SET TAGS ('dbx_business_glossary_term' = 'Crossmatch Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `crossmatch_type` SET TAGS ('dbx_value_regex' = 'electronic|immediate_spin|full_serologic|type_and_screen|emergency_release');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `hemovigilance_reported` SET TAGS ('dbx_business_glossary_term' = 'Hemovigilance Reported Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Notes');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_diastolic` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Blood Pressure Diastolic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_blood_pressure_systolic` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Blood Pressure Systolic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_pulse` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Pulse Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_respiratory_rate` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Respiratory Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `post_transfusion_temperature` SET TAGS ('dbx_business_glossary_term' = 'Post-Transfusion Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_diastolic` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Blood Pressure Diastolic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_blood_pressure_systolic` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Blood Pressure Systolic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_pulse` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Pulse Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_respiratory_rate` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Respiratory Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `pre_transfusion_temperature` SET TAGS ('dbx_business_glossary_term' = 'Pre-Transfusion Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_description` SET TAGS ('dbx_business_glossary_term' = 'Reaction Description');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_onset_datetime` SET TAGS ('dbx_business_glossary_term' = 'Reaction Onset Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_severity` SET TAGS ('dbx_business_glossary_term' = 'Reaction Severity');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `reaction_severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life_threatening');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Transfusion End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_number` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Number');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_rate` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Rate');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_reaction_occurred` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Reaction Occurred Indicator');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_reaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Reaction Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_site` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Site');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_status` SET TAGS ('dbx_business_glossary_term' = 'Transfusion Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `transfusion_status` SET TAGS ('dbx_value_regex' = 'ordered|prepared|in_progress|completed|discontinued|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `unexpected_antibody_identified` SET TAGS ('dbx_business_glossary_term' = 'Unexpected Antibody Identified');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ALTER COLUMN `volume_transfused_ml` SET TAGS ('dbx_business_glossary_term' = 'Volume Transfused in Milliliters (mL)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` SET TAGS ('dbx_subdomain' = 'diagnostic_testing');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Complexity Level');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_value_regex' = 'waived|moderate|high');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `collection_instructions` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `critical_high_value` SET TAGS ('dbx_business_glossary_term' = 'Critical High Value Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `critical_low_value` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Value Threshold');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Methodology');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `minimum_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Specimen Volume');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_status` SET TAGS ('dbx_business_glossary_term' = 'Orderable Status');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `orderable_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|pending_validation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `ordering_instructions` SET TAGS ('dbx_business_glossary_term' = 'Ordering Instructions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `panic_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Panic Value Flag');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `patient_preparation` SET TAGS ('dbx_business_glossary_term' = 'Patient Preparation Requirements');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `preferred_volume` SET TAGS ('dbx_business_glossary_term' = 'Preferred Specimen Volume');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_code` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Test Code');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_lab_name` SET TAGS ('dbx_business_glossary_term' = 'Reference Laboratory Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_range_adult` SET TAGS ('dbx_business_glossary_term' = 'Adult Reference Range');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `reference_range_pediatric` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Reference Range');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Result Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `result_type` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|semi_quantitative|narrative|culture|microscopic');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_container` SET TAGS ('dbx_business_glossary_term' = 'Specimen Container Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_stability` SET TAGS ('dbx_business_glossary_term' = 'Specimen Stability Duration');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `storage_temperature` SET TAGS ('dbx_business_glossary_term' = 'Specimen Storage Temperature');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `storage_temperature` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_abbreviation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Abbreviation');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Category');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Name');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Type');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'individual_test|panel|profile|reflex_test|add_on_test');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `transport_conditions` SET TAGS ('dbx_business_glossary_term' = 'Specimen Transport Conditions');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_routine` SET TAGS ('dbx_business_glossary_term' = 'Routine Turnaround Time (TAT)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `turnaround_time_stat` SET TAGS ('dbx_business_glossary_term' = 'STAT Turnaround Time (TAT)');
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
