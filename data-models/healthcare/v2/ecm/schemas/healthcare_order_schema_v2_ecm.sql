-- Schema for Domain: order | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`order` COMMENT 'Manages the full lifecycle of clinical orders including CPOE (Computerized Physician Order Entry) for lab, radiology, pharmacy, and referral orders. Tracks order status, priority, routing, and fulfillment. Integrates with Epic Orders, Beaker (LIS), Radiant (RIS), and Willow (pharmacy) as the operational order management backbone.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`clinical_order` (
    `clinical_order_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical order record in the enterprise data lakehouse. Primary key for the clinical_order data product.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure orders must link to CPT master for charge capture, prior authorization validation, RVU-based resource planning, and compliance with coding standards. Essential for revenue cycle and utilizat',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Core clinical ordering workflow requires validation of diagnosis indication against ICD-10 master for billing compliance, clinical decision support, quality reporting, and medical necessity documentat',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Surgical and procedural orders frequently specify medical devices, implants, or supplies by catalog number (e.g., orthopedic hardware, cardiac stents). Essential for charge capture, inventory depletio',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this clinical order was placed. Core PARTY_REFERENCE linking the order to the patient master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Clinical orders must be charged to departmental cost centers for accurate cost allocation, profitability analysis, and departmental budgeting. Essential for activity-based costing and service line fin',
    `parent_order_clinical_order_id` BIGINT COMMENT 'Reference to the parent clinical order when this order is a child or linked order in a chained order relationship (e.g., a reflex lab order triggered by a parent panel, or a follow-up order linked to an original). Null for top-level independent orders.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Every clinical order requires payer identification for real-time eligibility verification, coverage determination, and prior authorization checks at order entry. CPOE systems integrate payer data for ',
    `care_site_id` BIGINT COMMENT 'Reference to the clinical department or unit from which the order was placed (e.g., ICU, ED, Cardiology Clinic). Used for departmental utilization reporting, cost allocation, and operational analytics.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who entered or authorized this order via Computerized Physician Order Entry (CPOE). Corresponds to the ordering provider NPI-linked record in the provider master.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Clinical orders directly contribute to quality measure numerator/denominator calculation (e.g., timely antibiotic administration for sepsis, VTE prophylaxis orders). Quality reporting systems query or',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Clinical orders for investigational procedures, research labs, or study-specific imaging must link to the research study for research billing determination, coverage analysis (standard-of-care vs rese',
    `set_item_id` BIGINT COMMENT 'Identifier of the clinical order set or protocol from which this order was generated, if applicable. Order sets are pre-defined bundles of evidence-based orders (e.g., Sepsis Bundle, AMI Order Set). Null if the order was placed individually outside an order set.',
    `tertiary_clinical_authorizing_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who authorized or approved the order when different from the ordering provider (e.g., attending physician authorizing a resident-entered order). Supports order authentication and supervision compliance tracking.',
    `authorization_number` STRING COMMENT 'Payer-issued prior authorization number obtained before order fulfillment for services requiring pre-authorization (e.g., advanced imaging, elective procedures, specialty referrals). Required for claims submission and denial prevention.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the order was cancelled or discontinued (e.g., Duplicate Order, Patient Refused, Clinical Contraindication, Order Error). Required for medication safety and quality reporting. [ENUM-REF-CANDIDATE: duplicate|patient_refused|contraindication|order_error|provider_request|clinical_change — promote to reference product]',
    `cancelled_datetime` TIMESTAMP COMMENT 'Timestamp when the order was cancelled or discontinued. Null for active or completed orders. Used for order lifecycle analytics, duplicate order detection, and medication safety reporting.',
    `clinical_decision_support_alert` STRING COMMENT 'Indicates whether a Clinical Decision Support (CDS) alert was triggered at order entry and the providers response. Supports medication safety monitoring, duplicate order detection, and CDS effectiveness analytics per AHRQ and ONC requirements.. Valid values are `no_alert|alert_accepted|alert_overridden|alert_cancelled`',
    `clinical_indication_text` STRING COMMENT 'Free-text clinical rationale or indication entered by the ordering provider to justify the order. Supplements the ICD-10 indication code with narrative context. Used by Clinical Documentation Improvement (CDI) and utilization management teams.',
    `completed_datetime` TIMESTAMP COMMENT 'Timestamp when the order was fulfilled and marked as completed by the performing department or system. Used for turnaround time (TAT) measurement and order fulfillment analytics.',
    `cosign_completed_datetime` TIMESTAMP COMMENT 'Timestamp when the required co-signature for a verbal or telephone order was completed by the authorizing provider. Used to measure compliance with TJC verbal order authentication requirements.',
    `cosign_due_datetime` TIMESTAMP COMMENT 'Deadline by which a verbal or telephone order must be co-signed by the authorizing provider per TJC and CMS requirements (typically within 24-48 hours). Null for electronically-entered orders that do not require co-signature.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical order record was first created in the enterprise data lakehouse (Silver Layer). Serves as the RECORD_AUDIT_CREATED field for data lineage and audit trail purposes. Distinct from order_datetime (clinical event time).',
    `frequency_code` STRING COMMENT 'Standardized frequency code specifying how often a recurring order should be executed (e.g., QD for daily, BID for twice daily, Q4H for every 4 hours, PRN for as needed). Applicable primarily to pharmacy, nursing, and timed lab orders.',
    `is_cpoe_entered` BOOLEAN COMMENT 'Indicates whether the order was entered directly by the ordering provider via Computerized Physician Order Entry (CPOE) (True) versus entered by a nurse, pharmacist, or other staff on behalf of the provider (False). Key metric for CPOE adoption and Meaningful Use/Promoting Interoperability reporting.',
    `is_order_set_member` BOOLEAN COMMENT 'Indicates whether this order was placed as part of a clinical order set or protocol bundle (True) versus as a standalone individual order (False). Used for order set utilization analytics and evidence-based practice reporting.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this order is a recurring or standing order (True) that repeats on a defined schedule, versus a one-time order (False). Relevant for nursing, pharmacy, and lab orders with scheduled frequencies.',
    `is_verbal_order` BOOLEAN COMMENT 'Indicates whether this order was received verbally (True) and requires subsequent written or electronic authentication per TJC and CMS standards. Drives co-signature workflow and compliance monitoring.',
    `number_of_occurrences` STRING COMMENT 'Total number of times a recurring order is to be executed before automatic discontinuation. For example, a lab order for CBC x3 days would have number_of_occurrences = 3. Null for open-ended standing orders.',
    `order_catalog_code` STRING COMMENT 'Internal order catalog or procedure code from the source EHR system (Epic procedure ID or Cerner catalog item code). Used for order set management, CDM mapping, and charge capture reconciliation.',
    `order_class` STRING COMMENT 'Patient care setting classification for the order, indicating the clinical context in which the order was placed. Inpatient orders originate from admitted patients; ED orders from Emergency Department encounters; ambulatory from clinic visits.. Valid values are `inpatient|outpatient|ED|ambulatory`',
    `order_datetime` TIMESTAMP COMMENT 'The principal real-world timestamp when the clinical order was placed or entered into the CPOE system. Serves as the BUSINESS_EVENT_TIMESTAMP for this transaction. Used for turnaround time (TAT) calculations and regulatory reporting.',
    `order_entered_datetime` TIMESTAMP COMMENT 'Timestamp when the order was physically entered into the EHR system, which may differ from order_datetime (the clinically intended order time) for verbal or backdated orders. Used for CPOE compliance auditing and order authentication tracking.',
    `order_mode` STRING COMMENT 'Method by which the clinical order was entered or communicated. Electronic orders are entered directly via CPOE; verbal and telephone orders require co-signature per regulatory requirements. Supports compliance auditing and order authentication tracking.. Valid values are `electronic|verbal|written|telephone`',
    `order_name` STRING COMMENT 'Human-readable name or description of the ordered item or service as displayed in the EHR (e.g., CBC with Differential, Chest X-Ray PA and Lateral, Metoprolol 25mg PO). Sourced from the Charge Description Master (CDM) or order catalog.',
    `order_number` STRING COMMENT 'Externally-known, human-readable order identifier assigned by the source system (Epic Orders or Cerner Millennium). Used for cross-system reconciliation, audit trails, and communication with clinical staff. Serves as the BUSINESS_IDENTIFIER for this transaction.',
    `order_priority` STRING COMMENT 'Clinical urgency classification for the order. STAT indicates immediate action required; timed indicates a specific scheduled execution time. Embedded enum per product design specification. Drives turnaround time (TAT) SLA monitoring.. Valid values are `STAT|routine|urgent|timed`',
    `order_status` STRING COMMENT 'Current workflow lifecycle state of the clinical order. Drives downstream fulfillment routing and reporting. Values align with Epic Orders and HL7 FHIR ServiceRequest status codes.. Valid values are `pending|active|completed|cancelled|on_hold|discontinued`',
    `order_type` STRING COMMENT 'Classification of the clinical order by modality or service category. Determines routing to the appropriate fulfillment system: Beaker (LIS) for lab, Radiant (RIS) for radiology, Willow for pharmacy, etc. Embedded enum per product design specification. [ENUM-REF-CANDIDATE: lab|radiology|pharmacy|referral|nursing|dietary|consult — 7 candidates stripped; promote to reference product]',
    `ordering_provider_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the clinician who placed the order. Stored denormalized on the order for regulatory reporting, claims submission, and audit purposes per CMS requirements. Distinct from the FK to the provider master.. Valid values are `^[0-9]{10}$`',
    `patient_mrn` STRING COMMENT 'Medical Record Number (MRN) of the patient for whom the order was placed. Stored denormalized on the order for cross-system reconciliation, HL7 ADT message processing, and regulatory audit trails. Sourced from the Master Patient Index (MPI).',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Numeric quantity of the ordered item or service (e.g., number of lab panels, number of imaging views, medication dose quantity). Unit of measure is captured in quantity_unit. Used for supply chain, pharmacy dispensing, and charge capture.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity_ordered field (e.g., mg, mL, units, each, tablet). Follows UCUM (Unified Code for Units of Measure) standards for interoperability with HL7 FHIR.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Procedures, surgeries, and high-risk treatments require documented informed consent. Pre-procedure verification workflows mandate linking orders to the authorizing consent record. Core HIPAA and state',
    `start_datetime` TIMESTAMP COMMENT 'Datetime when the order is scheduled to begin or when fulfillment should commence. For timed orders, this is the precise execution start time. Distinct from order_datetime (when placed) and order_datetime (when entered).',
    `clinical_order_status` STRING COMMENT 'The clinical order status value classifying the order clinical order record.',
    `stop_datetime` TIMESTAMP COMMENT 'Datetime when the order expires, is discontinued, or fulfillment should cease. Critical for pharmacy and nursing orders to prevent over-administration. Nullable for one-time orders.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical order record was last modified in the enterprise data lakehouse. Serves as the RECORD_AUDIT_UPDATED field for change tracking, incremental ETL processing, and audit compliance.',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order clinical order record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the order clinical order record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_clinical_order PRIMARY KEY(`clinical_order_id`)
) COMMENT 'Core clinical order record capturing all order types placed via CPOE or other entry methods.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`referral_order` (
    `referral_order_id` BIGINT COMMENT 'Unique surrogate identifier for the referral order record in the lakehouse Silver layer. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site from which the referral was originated. Used for network management, referral pattern analytics, and facility-level reporting.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Referral service specification links anticipated procedure to CPT master for prior authorization submission, scheduling coordination, and expected reimbursement calculation. Essential for referral man',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom the referral order was placed. Links to the patient master record.',
    `employee_id` BIGINT COMMENT 'Reference to the care coordinator or case manager responsible for managing the referral workflow, including scheduling, authorization follow-up, and referral loop closure. Supports population health management workflows.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Referral authorization and medical necessity determination require valid ICD-10 linkage. Payers validate diagnosis against coverage policies for specialist referral approval, and providers need accura',
    `order_authorization_id` BIGINT COMMENT 'Reference to the payer prior authorization record associated with this referral, when authorization is required. Links to the encounter authorization entity.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Referral processing requires payer-specific authorization workflows, network validation, and timely filing requirements. Real-world process: referral management systems verify payer requirements, chec',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who originated and placed the referral order. Typically the patients Primary Care Physician (PCP) or treating provider.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Referral completion and timeliness are tracked quality metrics (HEDIS specialty care access, referral loop closure measures). Quality programs require linking referral orders to specific measures to c',
    `receiving_provider_clinician_id` BIGINT COMMENT 'Reference to the specialist or external provider to whom the patient is being referred. May be null if the receiving provider has not yet been assigned.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Referral management programs operate within specific departments with associated cost centers. Tracking referral costs by cost center enables ROI analysis of referral programs, network leakage cost as',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Referrals to research studies are common in academic medical centers for patient recruitment. Linking referral to target study supports recruitment metrics tracking, referral source analysis, and stud',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: SNOMED CT provides granular clinical semantics for referral routing, specialty matching, and interoperable care coordination. Supports clinical detail beyond ICD-10 for precise referral indication and',
    `clinical_order_id` BIGINT COMMENT 'The native order identifier from the originating operational system (e.g., Epic order ID, Salesforce referral record ID). Enables cross-system reconciliation and traceability back to the system of record.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Referral routing, network adequacy analysis, and payer authorization workflows require structured specialty linkage. Receiving_provider_clinician_id provides individual, but specialty_id enables speci',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit during which the referral order was initiated. Links to the encounter visit record.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether the patients payer requires prior authorization before the referral can be fulfilled. When True, the referral workflow is gated on obtaining a payer authorization number before scheduling.',
    `authorized_visits` STRING COMMENT 'The number of specialist visits or service encounters approved by the payer under this referral authorization. Used to track utilization against the authorized limit and trigger re-authorization workflows.',
    `cancellation_reason` STRING COMMENT 'The documented reason for cancellation of the referral order when order_status is cancelled. Captures clinical, administrative, or patient-driven reasons for cancellation to support quality improvement and operational analytics.',
    `clinical_indication` STRING COMMENT 'Structured or semi-structured clinical indication supporting the medical necessity of the referral. May include relevant findings, lab results, imaging results, or prior treatment history that justify the specialist consultation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral order record was first created in the lakehouse Silver layer. Used for audit trail and data lineage tracking.',
    `disposition_date` DATE COMMENT 'The date on which the referral disposition was recorded by the receiving provider or care coordinator. Used to measure referral loop closure timeliness and time-to-specialist metrics.',
    `disposition_notes` STRING COMMENT 'Free-text notes from the receiving provider or care coordinator documenting the reason for the referral disposition, particularly for declined or cancelled referrals. Supports clinical documentation improvement (CDI) and care coordination workflows.',
    `effective_date` DATE COMMENT 'The date on which the referral authorization becomes valid and the patient may begin receiving referred services. Typically the date the authorization was approved by the payer.',
    `expiration_date` DATE COMMENT 'The date after which the referral authorization is no longer valid and services cannot be rendered under this referral. Triggers re-authorization workflows and patient outreach when approaching expiry.',
    `first_available_date` DATE COMMENT 'The earliest available appointment date offered by the receiving provider at the time the referral was processed. Used to measure access to specialty care and network adequacy.',
    `is_stat_order` BOOLEAN COMMENT 'Indicates whether the referral order was placed as a STAT (immediate/urgent) order requiring expedited processing and scheduling. Distinct from urgency_level as this is the operational flag used by scheduling and authorization workflows.',
    `loop_closed_date` DATE COMMENT 'The date on which the referral communication loop was closed, meaning the referring provider received the specialists consultation report or outcome documentation.',
    `mrn` STRING COMMENT 'The patients Medical Record Number (MRN) as assigned by the facilitys Master Patient Index (MPI). Included on the referral for cross-system patient identification and payer submission.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'The date and time when the referring provider placed the referral order via Computerized Physician Order Entry (CPOE) in the Electronic Health Record (EHR). This is the principal business event timestamp for the referral lifecycle.',
    `order_source_system` STRING COMMENT 'The operational system of record from which the referral order was originated or ingested into the lakehouse. Supports data lineage, reconciliation, and multi-system integration auditing.. Valid values are `Epic|Cerner|MEDITECH|Salesforce|manual`',
    `order_status` STRING COMMENT 'Current workflow lifecycle state of the referral order. Drives downstream processing in Salesforce Health Cloud and Epic Orders. [ENUM-REF-CANDIDATE: pending|active|accepted|declined|completed|cancelled|expired — promote to reference product]',
    `plan_type` STRING COMMENT 'The type of health insurance plan governing the referral authorization requirements. HMO and POS plans typically require referrals; PPO plans may not. Drives authorization workflow logic. [ENUM-REF-CANDIDATE: HMO|PPO|POS|EPO|Medicare|Medicaid|self_pay — 7 candidates stripped; promote to reference product]',
    `receiving_facility_name` STRING COMMENT 'Name of the external facility or organization where the referred services will be rendered. Captured when the receiving provider is affiliated with an external organization not in the internal provider master.',
    `receiving_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the specialist or receiving provider to whom the patient is referred. Required for payer authorization and claims adjudication.. Valid values are `^[0-9]{10}$`',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Specialty referrals (behavioral health, substance use, HIV care) require specific consent for information sharing under 42 CFR Part 2 and state laws. Referral authorization workflow validates consent ',
    `referral_disposition` STRING COMMENT 'The outcome or final disposition of the referral as reported by the receiving provider. Indicates whether the specialist accepted, declined, completed, or the patient did not attend. Used for referral loop closure tracking and quality reporting.. Valid values are `pending|accepted|declined|completed|cancelled|no_show`',
    `referral_loop_closed` BOOLEAN COMMENT 'Indicates whether the referring provider has received and acknowledged the specialists consultation report, closing the referral communication loop. A key quality metric for NCQA HEDIS and PCMH accreditation.',
    `referral_number` STRING COMMENT 'Externally visible, human-readable business identifier for the referral order. Used in payer communications, patient correspondence, and cross-system tracking (e.g., Salesforce Health Cloud, Epic Orders). Format: REF- followed by 10 digits.. Valid values are `^REF-[0-9]{10}$`',
    `referral_reason_description` STRING COMMENT 'Free-text clinical narrative describing the reason for the referral, supplementing the ICD-10 code. Captures clinical context not fully expressed by the diagnosis code, such as symptom progression, treatment failure, or specific clinical question for the specialist.',
    `referral_source` STRING COMMENT 'The clinical setting or care context from which the referral originated. Indicates whether the referral was initiated by a Primary Care Physician (PCP), Emergency Department (ED), inpatient unit, specialist, patient self-referral, or care program enrollment.. Valid values are `PCP|ED|inpatient|specialist|self|care_program`',
    `referral_status` STRING COMMENT 'The referral status value classifying the order referral order record.',
    `referral_type` STRING COMMENT 'Categorizes the nature of the referral: to a specialist, external provider, care program, second opinion, or for a specific diagnostic workup. Used for operational routing and analytics segmentation.. Valid values are `specialist|external_provider|care_program|second_opinion|diagnostic`',
    `referring_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the referring provider as registered with CMS. Required on CMS-1500 and UB-04 claim forms and payer authorization requests.. Valid values are `^[0-9]{10}$`',
    `scheduled_appointment_date` DATE COMMENT 'The date on which the patients appointment with the receiving specialist or provider has been scheduled. Used to measure time-to-appointment and referral fulfillment timeliness.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral order record was last modified in the lakehouse Silver layer. Supports change detection and incremental processing.',
    `urgency_level` STRING COMMENT 'Clinical priority level assigned to the referral order by the referring provider. Drives scheduling priority at the receiving provider and payer authorization turnaround time requirements. Values: routine, urgent, stat, emergent.. Valid values are `routine|urgent|stat|emergent`',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order referral order record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `visits_used` STRING COMMENT 'The number of authorized visits that have been consumed against this referral to date. Compared against authorized_visits to determine remaining utilization and trigger re-authorization alerts.',
    CONSTRAINT pk_referral_order PRIMARY KEY(`referral_order_id`)
) COMMENT 'Referral orders tracking patient referrals to specialists or facilities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`set_item` (
    `set_item_id` BIGINT COMMENT 'Unique identifier for the order set item. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this order set item. Supports accountability and audit requirements for clinical content governance.',
    `set_id` BIGINT COMMENT 'Reference to the parent order set that contains this item. Links this item to its containing order set bundle.',
    `age_max_years` STRING COMMENT 'Maximum patient age in years for which this order item is appropriate. Used for age-based inclusion rules. Null indicates no maximum age restriction.',
    `age_min_years` STRING COMMENT 'Minimum patient age in years for which this order item is appropriate. Used for age-based inclusion rules. Null indicates no minimum age restriction.',
    `alternative_order_options` STRING COMMENT 'Comma-separated list of alternative order codes that can be substituted for this item. Supports clinical flexibility and formulary management.',
    `body_site` STRING COMMENT 'Anatomical location where the procedure or specimen collection should be performed. Uses standardized anatomical terminology.',
    `clinical_rationale` STRING COMMENT 'Evidence-based justification for including this order in the care pathway. May reference clinical guidelines, protocols, or best practices. Supports clinical decision support.',
    `collection_method` STRING COMMENT 'Method by which the specimen should be collected for laboratory orders (e.g., venipuncture, clean catch, biopsy). Ensures proper specimen quality.',
    `condition_expression` STRING COMMENT 'Formal expression defining the conditional logic criteria (e.g., age > 65, weight < 50kg, diagnosis = ICD-10:E11.9). Uses clinical decision support (CDS) rule syntax.',
    `condition_type` STRING COMMENT 'Category of conditional logic applied to this item. Determines which patient data elements are evaluated for inclusion/exclusion decisions. [ENUM-REF-CANDIDATE: age_based|weight_based|diagnosis_based|lab_value|allergy|medication_interaction|none — 7 candidates stripped; promote to reference product]',
    `conditional_inclusion_logic` STRING COMMENT 'Rule expression defining when this item should be automatically included or excluded from the order set. Evaluated at order set activation time based on patient context.',
    `contrast_indicator` BOOLEAN COMMENT 'Indicates whether contrast media should be used for radiology imaging orders. Affects patient preparation and allergy screening requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order set item record was first created in the system. Supports audit trail and compliance reporting.',
    `default_dose` STRING COMMENT 'Pre-configured dose amount for medication orders. May include numeric value and unit (e.g., 500 mg, 10 mL). Can be overridden at order entry.',
    `default_duration` STRING COMMENT 'Pre-configured duration for time-limited orders (e.g., 7 days, 2 weeks). Primarily used for medication orders with a defined treatment period.',
    `default_frequency` STRING COMMENT 'Pre-configured administration or execution frequency for this order (e.g., BID, TID, QD, Q4H). Primarily used for medication and nursing orders.',
    `default_priority` STRING COMMENT 'Pre-configured priority level for this order item. Can be overridden by the ordering provider at the time of order entry.. Valid values are `routine|urgent|stat|asap|timed`',
    `default_quantity` DECIMAL(18,2) COMMENT 'Pre-configured quantity for orders that require a count or volume (e.g., number of units to dispense, volume of fluid to administer).',
    `default_route` STRING COMMENT 'Pre-configured administration route for medication orders (e.g., oral, intravenous, intramuscular, subcutaneous). Can be overridden at order entry.',
    `diagnosis_criteria` STRING COMMENT 'ICD-10 diagnosis codes or diagnosis categories that must be present for this item to be included. Supports comma-separated list for multiple diagnoses.',
    `effective_end_date` DATE COMMENT 'Date when this order set item is no longer available for use. Null indicates the item remains effective indefinitely. Supports order set retirement and updates.',
    `effective_start_date` DATE COMMENT 'Date when this order set item becomes available for use. Supports versioning and phased rollout of order set changes.',
    `instruction_text` STRING COMMENT 'Additional instructions or guidance for the ordering provider or fulfillment team. Displayed during order entry and on order requisitions.',
    `is_default_selected` BOOLEAN COMMENT 'Indicates whether this item is pre-selected by default when the order set is opened. Providers can deselect optional items.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this order item must be included when the order set is activated. True means the item cannot be deselected by the ordering provider.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this order set item record was most recently updated. Supports change tracking and version control.',
    `laterality` STRING COMMENT 'Specifies which side of the body the order applies to for paired anatomical structures. Critical for surgical and imaging orders.. Valid values are `left|right|bilateral|unilateral|not_applicable`',
    `order_code` STRING COMMENT 'Standard code identifying the specific orderable item (e.g., LOINC for lab tests, CPT for procedures, NDC for medications). The vocabulary depends on order_type.',
    `order_description` STRING COMMENT 'Human-readable description of the order item. Displayed to clinicians during order set selection and order entry.',
    `order_type` STRING COMMENT 'Category of clinical order represented by this item. Determines which fulfillment system and workflow will process the order.. Valid values are `laboratory|radiology|pharmacy|procedure|referral|nursing`',
    `patient_instruction_text` STRING COMMENT 'Instructions intended for the patient regarding this order (e.g., fasting requirements, preparation steps, post-procedure care). May be printed on patient education materials.',
    `requires_authorization` BOOLEAN COMMENT 'Indicates whether this order item requires prior authorization from the payer before it can be performed. Used for revenue cycle and utilization management.',
    `requires_consent` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required before this order can be performed. Used for high-risk procedures and research protocols.',
    `sequence_number` STRING COMMENT 'Ordinal position of this item within the parent order set. Determines the display and execution order of items in the set.',
    `set_item_status` STRING COMMENT 'Current lifecycle status of this order set item. Only active items are available for use in clinical order entry.. Valid values are `active|inactive|retired|draft|under_review`',
    `specimen_type` STRING COMMENT 'Type of biological specimen required for laboratory orders (e.g., blood, urine, tissue, swab). Used for specimen collection and handling instructions.',
    `version_number` STRING COMMENT 'Version identifier for this order set item configuration. Supports change tracking and audit requirements for clinical content management.',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order set item record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `weight_max_kg` DECIMAL(18,2) COMMENT 'Maximum patient weight in kilograms for which this order item is appropriate. Used for weight-based dosing and inclusion rules. Null indicates no maximum weight restriction.',
    `weight_min_kg` DECIMAL(18,2) COMMENT 'Minimum patient weight in kilograms for which this order item is appropriate. Used for weight-based dosing and inclusion rules. Null indicates no minimum weight restriction.',
    CONSTRAINT pk_set_item PRIMARY KEY(`set_item_id`)
) COMMENT 'Individual order items within an order set, with conditional logic and defaults.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the order routing record. Primary key.',
    `business_associate_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.business_associate_agreement. Business justification: Order routing to external labs/imaging centers requires BAA. Interface partners are business associates receiving PHI via orders for HIPAA compliance and vendor management.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or campus where the destination department is located. Supports multi-site health systems.',
    `clinical_order_id` BIGINT COMMENT 'Identifier of the clinical order being routed. Links to the parent order from CPOE (Computerized Physician Order Entry) system.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who manually routed or overrode the automatic routing. Populated only for manual routing events.',
    `message_log_id` BIGINT COMMENT 'Unique identifier of the HL7 or FHIR interface message that transmitted the routing event between systems. Used for interface troubleshooting and audit.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or unit to which the order was routed for fulfillment. May be lab, radiology, pharmacy, or other ancillary service.',
    `routing_previous_destination_department_org_unit_id` BIGINT COMMENT 'Identifier of the department from which the order was rerouted. Populated only for rerouted orders to maintain routing history.',
    `routing_rule_id` BIGINT COMMENT 'Identifier of the routing rule or algorithm applied to determine the destination. Links to routing rule configuration for audit and optimization.',
    `hipaa_security_risk_id` BIGINT COMMENT 'Foreign key linking to compliance.hipaa_security_risk. Business justification: Order routing systems handle ePHI and are subject to security risk assessments (interface vulnerabilities, access control weaknesses, encryption gaps). Security risk register tracks routing system ris',
    `source_department_org_unit_id` BIGINT COMMENT 'Identifier of the department or unit from which the order originated. Typically the ordering clinicians department.',
    `acknowledgement_datetime` TIMESTAMP COMMENT 'Timestamp when the receiving department or system acknowledged receipt of the routed order. Used to measure queue wait time.',
    `auto_route_eligible_flag` BOOLEAN COMMENT 'Indicates whether the order was eligible for automatic routing based on order type, priority, and system configuration. False if manual routing was required.',
    `completion_datetime` TIMESTAMP COMMENT 'Timestamp when the routing event was marked complete, indicating the order reached its fulfillment destination and processing began.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the order routing record was first created in the system. Audit field for data lineage and troubleshooting.',
    `datetime` TIMESTAMP COMMENT 'Timestamp when the order was routed to the destination department or facility. Critical for SLA (Service Level Agreement) tracking and turnaround time analysis.',
    `delay_minutes` STRING COMMENT 'Number of minutes the routing event exceeded the SLA target. Null if SLA was met. Used for bottleneck analysis and process improvement.',
    `destination_workstation_code` STRING COMMENT 'Identifier of the specific workstation, instrument, or device to which the order was routed within the destination department. Used for lab analyzers, imaging modalities, and pharmacy dispensing systems.',
    `estimated_completion_datetime` TIMESTAMP COMMENT 'Predicted timestamp when the order fulfillment will be completed, based on current queue depth, workload, and historical turnaround times.',
    `method` STRING COMMENT 'Method by which the order was routed. Distinguishes between automated rule-based routing, manual clinician override, load balancing algorithms, and emergency escalation paths.. Valid values are `automatic|manual_override|rule_based|load_balanced|escalated|emergency`',
    `notes` STRING COMMENT 'Free-text notes entered by routing staff or system administrators regarding special handling, exceptions, or issues encountered during routing.',
    `patient_location_at_routing` STRING COMMENT 'Patient location (unit, room, bed) at the time the order was routed. Used to optimize routing for point-of-care services and specimen collection.',
    `priority` STRING COMMENT 'Priority level assigned to the routing event. STAT orders receive immediate routing and queue priority, urgent orders are expedited, routine orders follow standard workflows.. Valid values are `stat|urgent|routine|scheduled|timed`',
    `priority_override_flag` BOOLEAN COMMENT 'Indicates whether the routing priority was manually overridden by a clinician or supervisor. True if priority was escalated or de-escalated from the original order priority.',
    `priority_override_reason` STRING COMMENT 'Free-text explanation for why the routing priority was overridden. Captures clinical justification for escalation or de-escalation.',
    `queue_name` STRING COMMENT 'Name of the work queue to which the order was assigned within the destination department. Examples include STAT Lab Queue, Routine Radiology Queue, Pharmacy Verification Queue.',
    `queue_position` STRING COMMENT 'Position of the order within the assigned queue at the time of routing. Used to track queue depth and wait times.',
    `reroute_count` STRING COMMENT 'Number of times this order has been rerouted to different destinations. High reroute counts indicate routing rule issues or capacity constraints.',
    `reroute_reason` STRING COMMENT 'Reason why the order was rerouted from its original destination. Supports root cause analysis of routing failures and capacity planning. [ENUM-REF-CANDIDATE: capacity_exceeded|equipment_unavailable|staff_unavailable|patient_location_change|order_modification|system_error|clinical_decision — 7 candidates stripped; promote to reference product]',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing event. Tracks progression from initial queue assignment through fulfillment or failure. [ENUM-REF-CANDIDATE: queued|acknowledged|in_progress|completed|rerouted|failed|cancelled — 7 candidates stripped; promote to reference product]',
    `sequence` STRING COMMENT 'Sequential number indicating the order of routing events for a single order. Supports tracking of rerouting and escalation workflows.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the routing event met the defined SLA target. True if acknowledgement or completion occurred within the target timeframe.',
    `sla_target_minutes` STRING COMMENT 'Target turnaround time in minutes from routing to acknowledgement or completion, based on order priority and type. Used for SLA compliance monitoring.',
    `specimen_collection_required_flag` BOOLEAN COMMENT 'Indicates whether the routed order requires specimen collection before fulfillment. True for lab orders requiring phlebotomy or other collection procedures.',
    `system_source` STRING COMMENT 'Source system that generated or processed the routing event. Identifies whether routing originated from Epic Orders, Beaker LIS, Radiant RIS, Willow Pharmacy, or other integrated systems. [ENUM-REF-CANDIDATE: epic_orders|beaker_lis|radiant_ris|willow_pharmacy|cerner_orders|interface_engine|manual_entry — 7 candidates stripped; promote to reference product]',
    `transport_required_flag` BOOLEAN COMMENT 'Indicates whether patient transport is required to fulfill the order. True for imaging or procedure orders where the patient must be moved to the destination department.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when the order routing record was last modified. Tracks status changes, rerouting events, and data corrections.',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order routing record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `workload_score` DECIMAL(18,2) COMMENT 'Calculated workload score of the destination department or queue at the time of routing. Used by load balancing algorithms to distribute orders across available resources.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Order routing records tracking where and how orders are directed for fulfillment.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`fulfillment` (
    `fulfillment_id` BIGINT COMMENT 'Unique identifier for the order fulfillment record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Order fulfillment processes are audited for compliance (specimen handling, turnaround times, charge capture). Audit scope includes fulfillment operations for quality and regulatory compliance verifica',
    `care_site_id` BIGINT COMMENT 'Foreign key reference to the facility, department, or location where the order was fulfilled (e.g., lab, radiology suite, pharmacy).',
    `clinical_order_id` BIGINT COMMENT 'Foreign key reference to the clinical order that was fulfilled. Links to the originating order in the order management system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Order fulfillment activities (lab processing, imaging, procedures) generate direct costs that must be allocated to performing department cost centers. Critical for departmental expense tracking, varia',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Charge capture at fulfillment links completed service to CPT master for accurate billing, RVU calculation, reimbursement determination, and revenue cycle management. Essential for financial reconcilia',
    `demographics_id` BIGINT COMMENT 'Foreign key reference to the patient for whom the order was fulfilled. Links fulfillment to the patient master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this fulfillment record. Used for audit trail and accountability.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: DME, supplies, and ambulance service fulfillment require HCPCS code linkage to master for pricing determination, coverage validation, and billing compliance. Critical for non-physician service revenue',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Fulfillment events trigger charge capture and claim submission processes that require payer identification. Real-world process: revenue cycle systems link fulfilled orders to payer for billing, tracki',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider, technician, or clinician who performed or completed the fulfillment. May be a lab technician, radiologist, pharmacist, or other clinical staff.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Order fulfillment timeliness is a direct quality indicator (door-to-balloon time for STEMI, sepsis bundle completion within 3 hours). Quality measure calculation requires fulfillment timestamps to det',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Order fulfillment events (imaging studies, procedures, infusions) occur during scheduled appointments. Linking fulfillment to appointment enables turnaround time tracking, no-show impact analysis, and',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen collected and used for fulfillment. Primarily applicable to laboratory and pathology orders. Links to specimen tracking systems.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Fulfillment of research-related orders (labs, imaging, procedures) must track which subject enrollment triggered them for accurate research billing classification, protocol adherence monitoring, and s',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Fulfillment records may track which vendor supplied the item, especially for consignment inventory or vendor-managed stock. Essential for vendor performance metrics, rebate tracking, and consignment r',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the patient visit or encounter during which the order was fulfilled. Links fulfillment to the clinical encounter context.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The gross charge amount associated with the fulfillment event. Represents the list price from the Charge Description Master (CDM) before adjustments, discounts, or contractual allowances.',
    `charge_capture_flag` BOOLEAN COMMENT 'Boolean indicator of whether a billable charge was captured for this fulfillment event. Used for revenue cycle management and billing reconciliation.',
    `charge_code` STRING COMMENT 'The internal charge code or CDM code associated with the fulfilled service. Links to the Charge Description Master for billing and revenue cycle processing.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when this fulfillment record was first created in the data system. Audit trail field for data lineage and record lifecycle tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the order fulfillment record.',
    `datetime` TIMESTAMP COMMENT 'The date and time when the order was fulfilled or completed by the fulfilling department. This is the principal business event timestamp representing when the work was performed.',
    `exception_reason_code` STRING COMMENT 'Standardized code indicating why the order was not fulfilled as originally ordered. Used when status is cancelled, failed, or partial. Maps to internal exception reason reference data.',
    `exception_reason_description` STRING COMMENT 'Free-text description of the exception or reason why the order was not fulfilled as ordered. Provides additional context beyond the standardized exception reason code.',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'The actual quantity or amount fulfilled by the performing department. May differ from ordered quantity in cases of partial fulfillment, substitution, or unavailability.',
    `fulfillment_number` STRING COMMENT 'Business identifier for the fulfillment event. Human-readable unique number assigned by the fulfilling department or system (e.g., lab accession number, radiology case number, pharmacy dispense number).',
    `fulfillment_status` STRING COMMENT 'Current status of the fulfillment event. Indicates whether the order was fully completed, partially fulfilled, cancelled, failed, or is still in progress.. Valid values are `completed|partial|cancelled|failed|in_progress|pending`',
    `method` STRING COMMENT 'The method or process used to fulfill the order. Indicates whether the fulfillment was performed manually, using automated equipment, at point of care, or outsourced to an external provider.. Valid values are `manual|automated|semi_automated|point_of_care|external_lab|outsourced`',
    `modifier_codes` STRING COMMENT 'Comma-separated list of CPT or HCPCS modifier codes applied to the procedure. Modifiers provide additional information about the service performed (e.g., bilateral procedure, multiple procedures).',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the fulfilling provider or technician. May include technical details, observations, or special handling instructions relevant to the fulfillment.',
    `order_type` STRING COMMENT 'The category or type of clinical order that was fulfilled. Determines which downstream domain owns the detailed result data (laboratory, radiology, pharmacy). [ENUM-REF-CANDIDATE: laboratory|radiology|pharmacy|referral|procedure|therapy|consult — 7 candidates stripped; promote to reference product]',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity or amount originally ordered by the ordering provider. Used for comparison with actual fulfilled quantity to detect partial fulfillments.',
    `partial_fulfillment_flag` BOOLEAN COMMENT 'Boolean indicator of whether the order was partially fulfilled (True) or fully fulfilled (False). Set to True when fulfilled quantity is less than ordered quantity.',
    `performing_department_code` STRING COMMENT 'Standardized code identifying the department or service line that performed the fulfillment (e.g., LAB, RAD, PHARM, PT, OT). Maps to organizational department reference data.',
    `priority_code` STRING COMMENT 'The priority level assigned to the order at the time of fulfillment. Indicates urgency and expected turnaround time (STAT = immediate, urgent = within hours, routine = standard processing).. Valid values are `routine|urgent|stat|asap|timed`',
    `quality_flag` BOOLEAN COMMENT 'Boolean indicator of whether this fulfillment event has been flagged for quality review or audit. Used for quality assurance, compliance monitoring, and performance improvement initiatives.',
    `quality_review_notes` STRING COMMENT 'Free-text notes entered during quality review or audit of the fulfillment event. Documents quality concerns, corrective actions, or compliance findings.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the ordered and fulfilled quantities (e.g., mg, mL, tablets, tests, images, doses). Standardized using UCUM (Unified Code for Units of Measure).',
    `result_availability_datetime` TIMESTAMP COMMENT 'The date and time when the results of the fulfilled order became available for review. May differ from fulfillment datetime for orders requiring processing time (e.g., lab cultures, pathology).',
    `revenue_code` STRING COMMENT 'The UB-04 revenue code associated with the fulfillment for hospital billing. Identifies the department or type of service for institutional claims.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that generated the fulfillment record (e.g., EPIC_ORDERS, BEAKER_LIS, RADIANT_RIS, WILLOW_PHARM). Used for data lineage and integration tracking.',
    `turnaround_time_minutes` STRING COMMENT 'Calculated elapsed time in minutes from order placement to fulfillment completion. Key performance indicator for order processing efficiency and departmental performance measurement.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when this fulfillment record was last modified. Audit trail field for tracking changes and data quality monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the order fulfillment record.',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order fulfillment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the order fulfillment record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_fulfillment PRIMARY KEY(`fulfillment_id`)
) COMMENT 'Records of order fulfillment events including completion, partial fulfillment, and exceptions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`verbal_order` (
    `verbal_order_id` BIGINT COMMENT 'Unique identifier for the verbal order or co-signature event record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the verbal order was received and documented. Links to the facility master data.',
    `clinical_order_id` BIGINT COMMENT 'Reference to the clinical order that this verbal order or co-signature event is associated with. Links to the parent order in Epic Orders, Beaker, Radiant, or Willow.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Verbal orders must comply with specific organizational policies (read-back requirements, authentication timeframes, restricted medication lists). Policy governs verbal order process for Joint Commissi',
    `employee_id` BIGINT COMMENT 'Reference to the provider or administrator who authorized the waiver. Null if not waived.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom the clinical order was placed. Links to the master patient index (MPI).',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department or unit where the verbal order was received (e.g., Emergency Department, ICU, Medical-Surgical Unit).',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who originated the clinical order. For verbal/telephone orders, this is the provider who gave the order. For co-signatures, this is the primary ordering provider (e.g., resident or trainee).',
    `receiving_clinician_id` BIGINT COMMENT 'Reference to the clinician (nurse, physician assistant, or other licensed provider) who received and documented the verbal or telephone order. Required for verbal/telephone orders; null for co-signature events.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Verbal orders for research subjects must be tracked to enrollment for protocol deviation monitoring (verbal orders may violate study protocols), regulatory compliance audits, and research-specific aut',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter or visit during which the verbal order was placed. Links to the visit/encounter record.',
    `authentication_datetime` TIMESTAMP COMMENT 'Date and time when the ordering provider authenticated the verbal or telephone order, or when the co-signer completed the co-signature. Null if not yet authenticated.',
    `authentication_deadline_datetime` TIMESTAMP COMMENT 'Date and time by which the ordering provider must authenticate the verbal or telephone order. Typically 24-48 hours per TJC and CMS policy. Null for co-signature events.',
    `co_signature_datetime` TIMESTAMP COMMENT 'Date and time when the required co-signer completed the co-signature or countersignature. Null if co-signature is pending or not required.',
    `co_signature_deadline_datetime` TIMESTAMP COMMENT 'Date and time by which the co-signature must be completed per organizational policy or regulatory requirement. Null if no co-signature is required.',
    `co_signer_npi` STRING COMMENT 'National Provider Identifier (NPI) of the co-signer or countersigner. Null if no co-signature is required.. Valid values are `^[0-9]{10}$`',
    `co_signer_role` STRING COMMENT 'Role or credential type of the required co-signer. Indicates the supervisory relationship (attending supervising resident, pharmacist verifying controlled substance, etc.).. Valid values are `attending_physician|supervising_physician|pharmacist|charge_nurse|clinical_supervisor|other`',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether the order involves a DEA-controlled substance requiring additional countersignature per DEA regulations.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this verbal order record was first created in the system. Audit trail timestamp.',
    `dea_schedule` STRING COMMENT 'DEA schedule classification of the controlled substance (I, II, III, IV, or V). Null if not a controlled substance order.. Valid values are `I|II|III|IV|V`',
    `mrn` STRING COMMENT 'Medical Record Number (MRN) of the patient. Facility-specific unique patient identifier. Protected Health Information (PHI) under HIPAA.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the verbal order, authentication, or co-signature event. Used for clarifications, exceptions, or special circumstances.',
    `order_content` STRING COMMENT 'Free-text description of the clinical order content as received verbally or by telephone. Includes medication name, dose, route, frequency, or procedure/test details. Business-confidential clinical information.',
    `order_number` STRING COMMENT 'Human-readable business identifier for the clinical order. Externally visible order number used in clinical workflows and documentation.',
    `order_received_datetime` TIMESTAMP COMMENT 'Date and time when the verbal or telephone order was received by the clinician. Principal business event timestamp for verbal/telephone orders.',
    `order_status` STRING COMMENT 'Current lifecycle status of the verbal order or co-signature event. Tracks whether authentication or co-signature is pending, completed, overdue, waived, or cancelled.. Valid values are `pending_authentication|authenticated|overdue|waived|cancelled`',
    `order_type` STRING COMMENT 'Classification of the clinical order type. Indicates which clinical service line the order is directed to (lab, radiology, pharmacy, etc.). [ENUM-REF-CANDIDATE: lab|radiology|pharmacy|referral|procedure|nursing|diet|therapy|other — 9 candidates stripped; promote to reference product]',
    `ordering_provider_npi` STRING COMMENT 'National Provider Identifier (NPI) of the ordering provider. Ten-digit unique identifier assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `overdue_flag` BOOLEAN COMMENT 'Indicates whether the authentication or co-signature is overdue (current datetime exceeds the deadline). Calculated flag for compliance monitoring.',
    `priority` STRING COMMENT 'Clinical priority level of the order. STAT indicates immediate/emergency, urgent indicates expedited, routine indicates standard processing.. Valid values are `stat|urgent|routine`',
    `read_back_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the receiving clinician performed a read-back confirmation of the verbal or telephone order to the ordering provider. Required by TJC for patient safety.',
    `read_back_datetime` TIMESTAMP COMMENT 'Date and time when the read-back confirmation was performed. Null if read-back was not completed.',
    `receiving_clinician_npi` STRING COMMENT 'National Provider Identifier (NPI) of the clinician who received the verbal or telephone order. Null for co-signature events.. Valid values are `^[0-9]{10}$`',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Verbal orders in emergencies document whether consent was obtained, waived under emergency exception, or deferred. Emergency treatment documentation workflow links orders to consent status for regulat',
    `regulatory_basis` STRING COMMENT 'Regulatory or policy basis requiring the co-signature or authentication. Examples: resident supervision per GME requirements, DEA controlled substance countersignature, TJC verbal order authentication.',
    `updated_datetime` TIMESTAMP COMMENT 'Date and time when this verbal order record was last modified. Audit trail timestamp.',
    `verbal_order_type` STRING COMMENT 'Discriminator indicating the type of dual-authorization event: verbal order (in-person), telephone order (remote), co-signature (resident/trainee supervision), or countersignature (DEA controlled substance).. Valid values are `verbal|telephone|co_signature|countersignature`',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order verbal order record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `waiver_datetime` TIMESTAMP COMMENT 'Date and time when the waiver was granted. Null if not waived.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the authentication or co-signature requirement was waived per organizational policy or regulatory exception.',
    `waiver_reason` STRING COMMENT 'Free-text explanation of why the authentication or co-signature requirement was waived. Null if not waived.',
    CONSTRAINT pk_verbal_order PRIMARY KEY(`verbal_order_id`)
) COMMENT 'Verbal and telephone orders requiring authentication within regulatory timeframes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`standing_order` (
    `standing_order_id` BIGINT COMMENT 'Unique identifier for the standing order record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where this standing order protocol is authorized for use.',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician or advanced practice provider who authorized this standing order protocol.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Standing orders are governed by specific policies defining scope, approval process, and usage criteria. Policy framework for standing order programs ensures regulatory compliance and clinical governan',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Standing orders require approval under specific compliance programs (nursing protocols under state board requirements, emergency protocols under EMTALA). Regulatory governance of standing order progra',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Standing order protocols must align with payer coverage policies to ensure reimbursement and avoid denials. Real-world process: protocol committees review payer policies when creating standing orders ',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.consent_form_template. Business justification: Standing orders (nurse-initiated protocols, vaccination programs) specify which consent template must be used. Protocol compliance workflow ensures correct consent form is obtained before protocol exe',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Protocol-driven lab orders in standing order protocols require LOINC linkage for standardized test ordering, interoperability, results interpretation, and quality measure reporting. Supports evidence-',
    `org_unit_id` BIGINT COMMENT 'Identifier of the clinical department or unit where this standing order is applicable (e.g., Emergency Department, Intensive Care Unit, Medical-Surgical Unit).',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created this standing order record.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Standing orders are specialty-driven protocols (ED standing orders for chest pain, ICU sepsis protocols). Specialty governance committees approve and audit standing order usage by specialty. Required ',
    `activation_condition` STRING COMMENT 'Specific clinical trigger or condition that must be met before the standing order can be executed (e.g., Systolic BP >180, Blood glucose <70 mg/dL).',
    `applicable_population_criteria` STRING COMMENT 'Clinical criteria defining which patient populations are eligible for this standing order (e.g., Adults age 18+ with suspected sepsis, Pediatric patients with fever >38.5C).',
    `approval_date` DATE COMMENT 'Date when the standing order protocol was officially approved for use.',
    `approval_status` STRING COMMENT 'Current approval and lifecycle status of the standing order protocol. [ENUM-REF-CANDIDATE: draft|pending_review|approved|active|suspended|expired|retired — 7 candidates stripped; promote to reference product]',
    `authorized_role` STRING COMMENT 'Clinical role or credential level authorized to execute this standing order (e.g., Registered Nurse, Licensed Practical Nurse, Respiratory Therapist).',
    `clinical_indication` STRING COMMENT 'Medical reason or clinical scenario for which this standing order is intended.',
    `contraindication` STRING COMMENT 'Clinical conditions or circumstances under which this standing order should NOT be executed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this standing order record was first created in the system.',
    `documentation_requirement` STRING COMMENT 'Specific documentation that must be completed when this standing order is executed (e.g., vital signs, assessment findings, patient response).',
    `effective_end_date` DATE COMMENT 'Date when this standing order protocol expires or is no longer valid for use.',
    `effective_start_date` DATE COMMENT 'Date when this standing order protocol becomes active and available for use.',
    `evidence_based_guideline_reference` STRING COMMENT 'Citation or reference to clinical practice guidelines, research studies, or evidence-based protocols supporting this standing order.',
    `imaging_modality` STRING COMMENT 'Type of imaging study if this standing order is for radiology orders. [ENUM-REF-CANDIDATE: x_ray|ct|mri|ultrasound|nuclear_medicine|pet|fluoroscopy|mammography — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this standing order record was last updated.',
    `last_review_date` DATE COMMENT 'Date when this standing order protocol was last reviewed by the clinical governance committee or medical staff.',
    `maximum_duration_days` STRING COMMENT 'Maximum number of days this standing order remains active before requiring renewal or expiration.',
    `medication_dose` STRING COMMENT 'Dosage amount and unit for medication orders (e.g., 500 mg, 10 units).',
    `medication_frequency` STRING COMMENT 'Frequency of medication administration (e.g., BID, TID, Q4H, PRN).',
    `medication_name` STRING COMMENT 'Generic or brand name of the medication if this standing order is for pharmacy orders.',
    `medication_route` STRING COMMENT 'Route of administration for medication orders. [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|inhalation|rectal|sublingual|transdermal|ophthalmic|otic|nasal — 12 candidates stripped; promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next required review of this standing order protocol.',
    `notification_recipient_role` STRING COMMENT 'Role or position of the clinician who should be notified when this standing order is executed (e.g., Attending Physician, Hospitalist, Charge Nurse).',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether the authorizing provider or other clinician must be notified when this standing order is executed.',
    `order_detail` STRING COMMENT 'Detailed specification of the order including drug name and dose, lab test panel, imaging modality, or intervention description.',
    `order_type` STRING COMMENT 'Category of clinical order covered by this standing order (medication, lab test, imaging study, nursing intervention, etc.). [ENUM-REF-CANDIDATE: medication|laboratory|radiology|nursing_intervention|referral|procedure|diet|therapy — 8 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'Priority level for execution of the standing order.. Valid values are `routine|urgent|stat|asap|timed`',
    `protocol_code` STRING COMMENT 'Unique alphanumeric code identifying the standing order protocol within the organizations order catalog.',
    `protocol_name` STRING COMMENT 'The official name of the standing order protocol (e.g., Sepsis Bundle, Chest Pain Protocol, Fall Prevention Standing Orders).',
    `protocol_version` STRING COMMENT 'Version identifier for the standing order protocol to track revisions and updates over time.',
    `regulatory_compliance_note` STRING COMMENT 'Notes regarding compliance with regulatory requirements, accreditation standards, or organizational policies related to this standing order.',
    `renewal_frequency_days` STRING COMMENT 'Number of days between required renewals if renewal is required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this standing order requires periodic renewal by the authorizing provider.',
    `special_instructions` STRING COMMENT 'Additional clinical guidance, precautions, or instructions for executing this standing order.',
    `usage_count` STRING COMMENT 'Number of times this standing order has been executed since activation, used for utilization tracking and quality monitoring.',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order standing order record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_standing_order PRIMARY KEY(`standing_order_id`)
) COMMENT 'Pre-authorized standing orders for recurring clinical interventions without individual physician sign-off.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` (
    `cpoe_alert_id` BIGINT COMMENT 'Unique identifier for the CPOE clinical decision support alert event.',
    `alert_rule_id` BIGINT COMMENT 'Unique identifier of the specific clinical decision support rule or logic that triggered this alert, used for rule performance tracking and optimization.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key reference to the clinical order that triggered this alert during CPOE entry workflow.',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the clinician who was entering the order when the alert was triggered.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: CPOE alert rules implement clinical policies (formulary policy, dose range policy, duplicate therapy policy). Alert logic enforces policy compliance at point of order entry for medication safety.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: CPOE alerts fire based on payer coverage policies for non-covered services, step therapy requirements, and prior authorization needs. Real-world process: clinical decision support systems integrate pa',
    `mpi_record_id` BIGINT COMMENT 'Foreign key reference to the patient for whom the order was being entered when the alert fired.',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the patient encounter during which this alert was fired.',
    `alert_acknowledged_flag` BOOLEAN COMMENT 'Boolean indicator of whether the provider explicitly acknowledged viewing the alert before taking action.',
    `alert_display_duration_seconds` STRING COMMENT 'Number of seconds the alert was displayed on screen before the provider responded, used for alert fatigue analysis.',
    `alert_fire_timestamp` TIMESTAMP COMMENT 'Date and time when the clinical decision support alert was triggered during CPOE order entry workflow.',
    `alert_message` STRING COMMENT 'Full text message content of the alert explaining the clinical concern and recommended action.',
    `alert_priority` STRING COMMENT 'Priority level assigned to the alert based on clinical significance and potential patient harm.. Valid values are `critical|high|medium|low`',
    `alert_rule_version` STRING COMMENT 'Version number of the CDS rule at the time the alert was fired, supporting rule change tracking and historical analysis.',
    `alert_severity` STRING COMMENT 'Severity level of the alert indicating whether the order can proceed: hard stop (order blocked), soft stop (override allowed), informational (no action required), or warning (caution advised).. Valid values are `hard_stop|soft_stop|informational|warning`',
    `alert_source_system` STRING COMMENT 'Name of the clinical decision support system or knowledge base that generated the alert (e.g., Epic CDS, First Databank, Medi-Span, Micromedex).',
    `alert_suppressed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the alert was suppressed by system configuration or provider preference settings and not displayed to the ordering provider.',
    `alert_title` STRING COMMENT 'Short descriptive title of the alert displayed to the ordering provider in the CPOE interface.',
    `alert_trigger_detail` STRING COMMENT 'Detailed information about what triggered the alert, such as specific drug names in an interaction, allergy substance, or duplicate order details.',
    `alert_type` STRING COMMENT 'Category of clinical decision support alert fired during order entry. [ENUM-REF-CANDIDATE: drug_drug_interaction|drug_allergy|duplicate_order|dose_range_check|contraindication|formulary_substitution|critical_lab_value|renal_dosing|pregnancy_warning|age_based_warning|therapeutic_duplication|black_box_warning — promote to reference product]. Valid values are `drug_drug_interaction|drug_allergy|duplicate_order|dose_range_check|contraindication|formulary_substitution`',
    `allergy_substance` STRING COMMENT 'Allergen or substance that triggered a drug-allergy alert, matched against the patients documented allergy list.',
    `clinical_context` STRING COMMENT 'Additional clinical context at the time of alert such as patient location, care setting, or clinical indication that may influence alert interpretation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was first created in the system.',
    `duplicate_order_timeframe_hours` STRING COMMENT 'Number of hours within which a duplicate order was detected, used for duplicate order alerts to indicate how recently a similar order was placed.',
    `formulary_status` STRING COMMENT 'Formulary classification of the ordered medication that triggered a formulary substitution alert.. Valid values are `formulary|non_formulary|restricted|prior_auth_required`',
    `interacting_medication_1` STRING COMMENT 'First medication involved in a drug-drug interaction alert, typically the newly ordered medication.',
    `interacting_medication_2` STRING COMMENT 'Second medication involved in a drug-drug interaction alert, typically an existing active medication on the patients medication list.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was last modified or updated.',
    `ordered_dose` DECIMAL(18,2) COMMENT 'Medication dose that was ordered and triggered a dose range check alert.',
    `ordered_dose_unit` STRING COMMENT 'Unit of measure for the ordered dose (e.g., mg, mL, units) that triggered the dose range check alert.',
    `override_reason_code` STRING COMMENT 'Standardized code indicating the reason the provider chose to override the alert, required for soft stop alerts that are dismissed.',
    `override_reason_text` STRING COMMENT 'Free-text explanation provided by the ordering provider justifying why the alert was overridden.',
    `patient_age_at_alert` STRING COMMENT 'Patients age in years at the time the alert was fired, relevant for age-based dosing and contraindication alerts.',
    `patient_weight_kg` DECIMAL(18,2) COMMENT 'Patients weight in kilograms at the time of alert, used for weight-based dosing calculations in dose range check alerts.',
    `provider_response` STRING COMMENT 'Action taken by the ordering provider in response to the alert: accepted (order changed per alert), overridden (alert dismissed and order continued), modified (order adjusted), cancelled (order abandoned), or deferred (decision postponed).. Valid values are `accepted|overridden|modified|cancelled|deferred`',
    `recommended_dose_max` DECIMAL(18,2) COMMENT 'Maximum recommended dose from the clinical decision support knowledge base for dose range check alerts.',
    `recommended_dose_min` DECIMAL(18,2) COMMENT 'Minimum recommended dose from the clinical decision support knowledge base for dose range check alerts.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the ordering provider responded to the alert by accepting, overriding, or modifying the order.',
    `cpoe_alert_status` STRING COMMENT 'The cpoe alert status value classifying the order cpoe alert record.',
    `suggested_alternative_medication` STRING COMMENT 'Formulary-preferred alternative medication suggested by the alert as a therapeutic substitution.',
    `suppression_reason` STRING COMMENT 'Reason why the alert was suppressed, such as provider preference override, alert fatigue reduction rule, or duplicate alert within session.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the order cpoe alert record.',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order cpoe alert record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the order cpoe alert record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_cpoe_alert PRIMARY KEY(`cpoe_alert_id`)
) COMMENT 'Computerized physician order entry alerts fired during order entry with provider response tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'Unique identifier for the order reconciliation event. Primary key for the order reconciliation product.',
    `clinician_id` BIGINT COMMENT 'Internal identifier for the provider who performed the reconciliation.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Medication reconciliation is governed by specific policies implementing Joint Commission NPSG requirements. Policy defines reconciliation process and standards for transitions of care.',
    `message_log_id` BIGINT COMMENT 'Unique identifier for this reconciliation record in the source system, used for data lineage and reconciliation.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom medication and order reconciliation was performed.',
    `visit_id` BIGINT COMMENT 'Reference to the encounter or visit during which this reconciliation occurred.',
    `allergy_review_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether patient allergies were reviewed during the reconciliation process. True if reviewed, false otherwise.',
    `attestation_datetime` TIMESTAMP COMMENT 'Date and time when the provider attested to the accuracy and completeness of the reconciliation.',
    `attestation_signature` STRING COMMENT 'Electronic signature or attestation identifier of the provider who completed the reconciliation, confirming accuracy and completeness.',
    `completion_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the reconciliation was fully completed per regulatory requirements. True if completed, false otherwise.',
    `compliance_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the reconciliation met all regulatory and accreditation requirements. True if compliant, false otherwise.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this reconciliation record was first created in the system. Audit trail timestamp for record creation.',
    `datetime` TIMESTAMP COMMENT 'Date and time when the medication and order reconciliation was performed. Principal business event timestamp for this transaction.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies identified during the reconciliation process, including medication omissions, duplications, dosing errors, or therapeutic substitutions.',
    `discrepancy_identified_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether any discrepancies were identified during reconciliation. True if discrepancies found, false otherwise.',
    `discrepancy_severity` STRING COMMENT 'Clinical severity level of identified discrepancies. High for potentially life-threatening, medium for clinically significant, low for minor, none if no discrepancies.. Valid values are `high|medium|low|none`',
    `documentation_location` STRING COMMENT 'Location or section within the EMR where the reconciliation documentation is stored (e.g., admission note, discharge summary, medication administration record).',
    `drug_interaction_check_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether drug-drug interaction screening was performed during reconciliation. True if performed, false otherwise.',
    `duration_minutes` STRING COMMENT 'Total time in minutes spent performing the reconciliation process.',
    `formulary_check_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether formulary status was checked for medications during reconciliation. True if checked, false otherwise.',
    `home_medication_list_reviewed_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the patients home medication list was reviewed during reconciliation. True if reviewed, false otherwise.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Date and time when this reconciliation record was last modified. Audit trail timestamp for record updates.',
    `method` STRING COMMENT 'Method used to perform the reconciliation. CPOE (Computerized Physician Order Entry), paper-based, verbal, or hybrid approach.. Valid values are `cpoe|paper|verbal|hybrid`',
    `next_provider_communication_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the reconciled medication list was communicated to the next provider of care. True if communicated, false otherwise.',
    `non_compliance_reason` STRING COMMENT 'Reason for non-compliance if the reconciliation did not meet regulatory requirements (e.g., patient refused, clinically unstable, incomplete information).',
    `orders_added_count` STRING COMMENT 'Number of new orders added during the reconciliation process.',
    `orders_continued_count` STRING COMMENT 'Number of orders continued without modification during reconciliation.',
    `orders_discontinued_count` STRING COMMENT 'Number of orders discontinued during the reconciliation process.',
    `orders_modified_count` STRING COMMENT 'Number of orders modified during the reconciliation process (dose changes, frequency adjustments, route changes).',
    `orders_reviewed_count` STRING COMMENT 'Total number of orders reviewed during the reconciliation process.',
    `patient_communication_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the reconciled medication list was communicated to the patient or caregiver. True if communicated, false otherwise.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation process. Completed, incomplete, in progress, not required, or deferred.. Valid values are `completed|incomplete|in_progress|not_required|deferred`',
    `reconciliation_type` STRING COMMENT 'Type of care transition event that triggered the reconciliation process. Admission, transfer, discharge, pre-procedure, post-procedure, or outpatient visit.. Valid values are `admission|transfer|discharge|pre_procedure|post_procedure|outpatient_visit`',
    `reconciling_provider_npi` STRING COMMENT 'National Provider Identifier of the clinician who performed the medication reconciliation. Ten-digit unique identifier.. Valid values are `^[0-9]{10}$`',
    `source_medication_list_type` STRING COMMENT 'Source of the medication list used for reconciliation. Patient reported, pharmacy records, prior EMR, PCP records, family reported, or medication bottles.. Valid values are `patient_reported|pharmacy_records|prior_emr|pcp_records|family_reported|medication_bottles`',
    `transition_event` STRING COMMENT 'Specific care transition event that triggered the reconciliation requirement. Admit, transfer in, transfer out, discharge, pre-op, post-op, ED arrival, or ED departure. [ENUM-REF-CANDIDATE: admit|transfer_in|transfer_out|discharge|pre_op|post_op|ed_arrival|ed_departure — 8 candidates stripped; promote to reference product]',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order reconciliation record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Medication reconciliation records at care transitions ensuring medication list accuracy.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`diet_order` (
    `diet_order_id` BIGINT COMMENT 'Unique identifier for the diet order record. Primary key for the diet order entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the diet order is active.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: diet_order is a specialized type of clinical order (dietary orders for inpatient/observation patients). Linking to clinical_order as the parent order record establishes the subtype relationship. This ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this diet order is prescribed. Links to the patient master record.',
    `employee_id` BIGINT COMMENT 'Reference to the registered dietitian who reviewed or modified the diet order as part of nutritional assessment and care planning.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Therapeutic diet medical necessity documentation requires ICD-10 linkage for compliance with nutrition care standards, quality reporting, and reimbursement for medical nutrition therapy. Supports clin',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Diet orders may reference specific nutritional supplements, enteral feeding formulas, or feeding tube supplies by catalog number. Links clinical nutrition order to supply chain for fulfillment and cha',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department or nursing unit where the patient is located and where the diet will be delivered.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who ordered the diet. Links to the provider master record.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Nutrition screening and intervention orders are Joint Commission and CMS quality measures (malnutrition screening within 24 hours of admission, nutrition care plan for at-risk patients). Quality repor',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Research protocols often specify dietary interventions or restrictions. Linking diet orders to enrollment supports protocol compliance monitoring, nutritional study tracking, and research-specific die',
    `superseded_diet_order_id` BIGINT COMMENT 'Self-referencing FK on diet_order (superseded_diet_order_id)',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient or observation encounter during which this diet order is active. Links to the encounter record.',
    `allergen_exclusions` STRING COMMENT 'Comma-separated list of food allergens that must be excluded from the diet such as peanuts, tree nuts, shellfish, dairy, eggs, soy, wheat, or fish. Cross-referenced with patient allergy records.',
    `calorie_target` STRING COMMENT 'Target daily caloric intake in kilocalories prescribed for the patient based on nutritional assessment and clinical needs.',
    `clinical_indication` STRING COMMENT 'Free-text description of the clinical reason for the diet order such as diabetes management, heart failure, chronic kidney disease, post-operative recovery, or malnutrition.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this diet order record was first created in the data platform.',
    `diet_type` STRING COMMENT 'The primary classification of the diet order such as regular, cardiac, diabetic, renal, low sodium, clear liquid, full liquid, or NPO (nothing by mouth). Standardized using SNOMED CT diet codes where applicable.',
    `diet_type_code` STRING COMMENT 'Standardized code representing the diet type from SNOMED CT or institutional diet catalog.',
    `feeding_route` STRING COMMENT 'The route by which nutrition is delivered to the patient including oral intake, enteral tube feeding, or parenteral nutrition.. Valid values are `oral|enteral|parenteral|nasogastric|gastrostomy|jejunostomy`',
    `fluid_consistency` STRING COMMENT 'The required consistency level for liquids to prevent aspiration in patients with swallowing disorders.. Valid values are `thin|nectar-thick|honey-thick|pudding-thick`',
    `fluid_restriction_ml` DECIMAL(18,2) COMMENT 'Maximum daily fluid intake allowed in milliliters. Used for patients with heart failure, renal disease, or other conditions requiring fluid management.',
    `food_preferences` STRING COMMENT 'Patient-reported food preferences, cultural dietary requirements, or religious restrictions such as vegetarian, vegan, kosher, halal, or specific food dislikes.',
    `meal_schedule` STRING COMMENT 'Prescribed meal timing and frequency such as three meals daily, six small meals, continuous feeding, or NPO except medications.',
    `mrn` STRING COMMENT 'The patients medical record number as assigned by the healthcare organization. Used for patient identification and record linkage.',
    `npo_reason` STRING COMMENT 'Clinical rationale for NPO status such as pre-operative fasting, aspiration risk, bowel rest, or diagnostic testing requirements.',
    `npo_status` BOOLEAN COMMENT 'Indicates whether the patient is NPO (nothing by mouth) typically in preparation for surgery, procedures, or due to clinical contraindications for oral intake.',
    `ordering_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the ordering clinician as assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `protein_target_grams` DECIMAL(18,2) COMMENT 'Target daily protein intake in grams prescribed for the patient to support healing, muscle maintenance, or disease management.',
    `source_system_order_reference` STRING COMMENT 'The unique identifier for this diet order in the source operational system used for data lineage and reconciliation.',
    `special_instructions` STRING COMMENT 'Additional instructions for dietary services such as meal tray setup, adaptive utensils, feeding assistance requirements, or specific preparation notes.',
    `diet_order_status` STRING COMMENT 'The diet order status value classifying the order diet order record.',
    `supplement_frequency` STRING COMMENT 'Frequency of nutritional supplement administration such as once daily, twice daily, three times daily, with meals, or between meals.',
    `supplement_name` STRING COMMENT 'Name of the prescribed oral nutritional supplement such as Ensure, Boost, Glucerna, or specialized formulas for enteral nutrition support.',
    `texture_modification` STRING COMMENT 'Specification of food texture modifications required for safe swallowing such as pureed, mechanical soft, minced, ground, or chopped. Used for patients with dysphagia or chewing difficulties.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this diet order record was last modified in the data platform.',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order diet order record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the order diet order record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_diet_order PRIMARY KEY(`diet_order_id`)
) COMMENT 'Dietary and nutritional orders for inpatient and outpatient settings.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`therapy_order` (
    `therapy_order_id` BIGINT COMMENT 'Unique identifier for the therapy order. Primary key for the therapy order product.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility where the therapy service will be or is being delivered.',
    `clinical_order_id` BIGINT COMMENT 'Reference to the parent or original therapy order if this order is a renewal, modification, or continuation of a previous order.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Therapy orders implement rehabilitation policies (PT/OT/ST scope of practice, documentation requirements, authorization criteria). Policy framework for therapy services ensures regulatory compliance a',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Therapy service specification links therapy type to CPT master for scheduling, authorization submission, charge capture, and reimbursement. Essential for therapy department operations and revenue cycl',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: PT/OT/ST therapy authorization and medical necessity require valid ICD-10 diagnosis linkage. Payers validate diagnosis for therapy approval, and providers track diagnosis for functional outcome measur',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Therapy orders (PT/OT/RT) often specify durable medical equipment (walkers, CPAP, orthotics) by catalog item for patient use or loan. Links order to supply inventory for fulfillment and billing.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom the therapy order is placed.',
    `order_authorization_id` BIGINT COMMENT 'Reference to the payer authorization record if prior authorization was obtained for this therapy order.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department where the therapy service will be or is being performed.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Therapy orders require payer verification for authorization, session limits, and coverage determination before scheduling. Real-world process: therapy departments verify insurance coverage, obtain aut',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who ordered the therapy service.',
    `set_id` BIGINT COMMENT 'Reference to the order set or care pathway if this therapy order was generated as part of a standardized order set.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Therapy orders (PT, OT, RT) for research subjects link to enrollment for protocol-driven therapy tracking, research billing classification, and study-specific therapy intervention monitoring. Essentia',
    `superseded_therapy_order_id` BIGINT COMMENT 'Self-referencing FK on therapy_order (superseded_therapy_order_id)',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Therapy services (PT, OT, speech, respiratory) are delivered by departments with dedicated cost centers. Essential for therapy department financial performance monitoring, productivity analysis (cost ',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Physical, occupational, and speech therapy orders require treatment consent documenting risks, benefits, and alternatives. Therapy authorization workflow verifies consent before scheduling sessions. C',
    `visit_id` BIGINT COMMENT 'Reference to the encounter or visit during which the therapy order was placed.',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether payer authorization or prior approval is required before the therapy service can be performed.',
    `body_site` STRING COMMENT 'The anatomical location or body site that is the focus of the therapy service (e.g., left knee, right shoulder, lower back).',
    `cancellation_reason` STRING COMMENT 'The reason why the therapy order was cancelled, such as patient refusal, medical contraindication, or change in treatment plan.',
    `cancelled_datetime` TIMESTAMP COMMENT 'The date and time when the therapy order was cancelled, if applicable.',
    `clinical_indication` STRING COMMENT 'Free-text description of the clinical reason or medical necessity for ordering the therapy service.',
    `completed_datetime` TIMESTAMP COMMENT 'The date and time when the therapy order was marked as completed, indicating all ordered sessions have been fulfilled.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this therapy order record was first created in the data platform.',
    `duration_unit` STRING COMMENT 'Unit of measure for the duration value (e.g., minutes, hours).. Valid values are `minutes|hours`',
    `duration_value` STRING COMMENT 'Numeric value representing the length of time for each therapy session.',
    `end_date` DATE COMMENT 'The date when the therapy service is scheduled to end or when the treatment plan expires.',
    `frequency_code` STRING COMMENT 'Standardized code indicating how often the therapy service should be performed (e.g., daily, three times per week, twice daily).',
    `frequency_description` STRING COMMENT 'Human-readable description of the therapy frequency, providing additional detail beyond the frequency code.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this therapy order is part of a recurring or standing order protocol.',
    `laterality` STRING COMMENT 'Indicates whether the therapy is focused on the left side, right side, or both sides of the body.. Valid values are `left|right|bilateral`',
    `order_datetime` TIMESTAMP COMMENT 'The date and time when the therapy order was placed by the ordering provider. Principal business event timestamp.',
    `order_mode` STRING COMMENT 'The care setting or mode in which the therapy service will be delivered (e.g., inpatient, outpatient, home health, telehealth).. Valid values are `inpatient|outpatient|home_health|telehealth`',
    `order_number` STRING COMMENT 'Externally-known unique business identifier for the therapy order, used for tracking and communication across systems.',
    `order_status` STRING COMMENT 'Current lifecycle status of the therapy order indicating its workflow state.. Valid values are `draft|active|on-hold|completed|cancelled|discontinued`',
    `ordering_provider_npi` STRING COMMENT 'National Provider Identifier of the provider who ordered the therapy service.',
    `patient_instructions` STRING COMMENT 'Instructions or guidance to be provided to the patient regarding the therapy service, such as preparation steps or what to expect.',
    `priority` STRING COMMENT 'The urgency level of the therapy order indicating how quickly the service should be initiated.. Valid values are `routine|urgent|stat|asap`',
    `sessions_completed` STRING COMMENT 'The number of therapy sessions that have been completed to date.',
    `sessions_remaining` STRING COMMENT 'The number of therapy sessions remaining from the total authorized sessions.',
    `source_system_order_reference` STRING COMMENT 'The unique identifier for this therapy order in the source system, used for traceability and reconciliation.',
    `special_instructions` STRING COMMENT 'Additional instructions or notes from the ordering provider regarding the therapy service delivery, precautions, or patient-specific considerations.',
    `start_date` DATE COMMENT 'The date when the therapy service is scheduled to begin or when treatment should commence.',
    `therapy_service_code` STRING COMMENT 'Standardized code representing the specific therapy service ordered, typically from a clinical terminology system.',
    `therapy_service_description` STRING COMMENT 'Human-readable description of the therapy service being ordered.',
    `therapy_type` STRING COMMENT 'The type of therapy service ordered: physical therapy, occupational therapy, speech therapy, or respiratory therapy.. Valid values are `physical_therapy|occupational_therapy|speech_therapy|respiratory_therapy`',
    `total_sessions_ordered` STRING COMMENT 'The total number of therapy sessions authorized or ordered for this treatment plan.',
    `treatment_goal` STRING COMMENT 'The intended therapeutic outcome or goal for the therapy service, such as improving mobility, restoring function, or enhancing communication.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this therapy order record was last modified or updated in the data platform.',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order therapy order record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_therapy_order PRIMARY KEY(`therapy_order_id`)
) COMMENT 'Therapy orders for physical, occupational, speech, and other therapeutic services.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`alert_rule` (
    `alert_rule_id` BIGINT COMMENT 'Primary key for alert_rule',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical or administrative user who approved this alert rule for production use.',
    `alert_employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this alert rule record.',
    `alert_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this alert rule record.',
    `parent_alert_rule_id` BIGINT COMMENT 'Self-referencing FK on alert_rule (parent_alert_rule_id)',
    `alert_fatigue_risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score (0-100) indicating likelihood this alert contributes to clinician alert fatigue based on fire frequency and override rate.',
    `alert_message_template` STRING COMMENT 'Standardized message text template displayed to clinicians when the alert fires, may include placeholders for dynamic values.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this alert rule was approved for activation in production systems.',
    `auto_dismiss_seconds` STRING COMMENT 'Number of seconds after which the alert automatically dismisses if not acknowledged. Null means no auto-dismiss.',
    `clinical_specialty_scope` STRING COMMENT 'Comma-separated list of clinical specialties or departments where this rule is active. Empty means applies to all specialties.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alert rule record was first created in the system.',
    `display_priority` STRING COMMENT 'Numeric ranking used to determine display order when multiple alerts fire simultaneously. Lower numbers indicate higher priority.',
    `effective_end_date` DATE COMMENT 'Date when this alert rule is scheduled to be retired or deactivated. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this alert rule becomes active and begins firing in production systems.',
    `evidence_source` STRING COMMENT 'Citation or reference to the clinical evidence, guideline, or regulatory requirement that justifies this alert rule.',
    `evidence_strength_level` STRING COMMENT 'Classification of the strength of clinical evidence supporting this alert rule based on evidence-based medicine hierarchy.',
    `external_rule_code` STRING COMMENT 'Identifier for this alert rule in the source operational system, used for system integration and reconciliation.',
    `fire_count_total` BIGINT COMMENT 'Cumulative number of times this alert rule has fired since activation, used for alert fatigue analysis.',
    `hard_stop_flag` BOOLEAN COMMENT 'Indicates whether this alert prevents order completion until resolved (hard stop) or is advisory only (soft stop).',
    `integration_system_code` STRING COMMENT 'Code identifying the source clinical system where this alert rule is configured (e.g., Epic, Beaker, Radiant, Willow).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this alert rule record was last updated in the system.',
    `last_review_date` DATE COMMENT 'Date when this alert rule was last reviewed for clinical accuracy and operational effectiveness.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this alert rule to ensure continued clinical relevance.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, implementation guidance, or historical context about this alert rule.',
    `order_type_scope` STRING COMMENT 'Comma-separated list of order types this rule applies to (e.g., medication, lab, radiology, procedure). Empty means applies to all order types.',
    `override_allowed_flag` BOOLEAN COMMENT 'Indicates whether clinicians are permitted to override or dismiss this alert without taking action.',
    `override_count_total` BIGINT COMMENT 'Cumulative number of times clinicians have overridden this alert, used to assess alert appropriateness.',
    `override_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of alert fires that resulted in clinician override, calculated as (override_count / fire_count) * 100.',
    `override_reason_required_flag` BOOLEAN COMMENT 'Indicates whether a documented reason is mandatory when a clinician overrides this alert.',
    `patient_population_filter` STRING COMMENT 'Criteria defining which patient populations this rule applies to (e.g., age range, gender, diagnosis codes). Empty means applies to all patients.',
    `recommended_action` STRING COMMENT 'Clinical guidance or recommended action for the clinician to take when this alert is triggered.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this alert rule is mandated by regulatory or accreditation requirements and cannot be disabled.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of this alert rule for clinical and operational validation.',
    `rule_category` STRING COMMENT 'Classification of the alert rule by clinical domain or purpose.',
    `rule_code` STRING COMMENT 'Unique business identifier code for the alert rule, used for external reference and system integration.',
    `rule_description` STRING COMMENT 'Detailed clinical and operational description of what the alert rule detects and why it is important for patient safety.',
    `rule_name` STRING COMMENT 'Human-readable name of the alert rule displayed to clinicians and administrators.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the alert rule indicating whether it is actively firing in production systems.',
    `severity_level` STRING COMMENT 'Severity classification indicating the clinical urgency and required response level for the alert.',
    `alert_rule_status` STRING COMMENT 'The alert rule status value classifying the order alert rule record.',
    `trigger_condition` STRING COMMENT 'Business logic expression or criteria that must be met for the alert to fire, expressed in human-readable format.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the order alert rule record.',
    `version_number` STRING COMMENT 'Semantic version number of this alert rule configuration, incremented with each modification.',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order alert rule record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the order alert rule record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_alert_rule PRIMARY KEY(`alert_rule_id`)
) COMMENT 'Clinical decision support alert rule definitions governing when CPOE alerts fire.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`routing_rule` (
    `routing_rule_id` BIGINT COMMENT 'Primary key for routing_rule',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or location to which orders matching this rule should be routed.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or service area to which orders matching this rule should be routed.',
    `parent_routing_rule_id` BIGINT COMMENT 'Self-referencing FK on routing_rule (parent_routing_rule_id)',
    `primary_fallback_routing_rule_id` BIGINT COMMENT 'Identifier of an alternative routing rule to apply if this rule cannot be executed due to capacity, availability, or other constraints.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether orders routed by this rule require additional clinical or administrative approval before fulfillment.',
    `capacity_threshold` STRING COMMENT 'Maximum capacity or workload threshold at the target department or facility that triggers alternative routing when exceeded.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this routing rule is subject to regulatory compliance requirements such as HIPAA, Joint Commission, or CMS conditions of participation.',
    `condition_expression` STRING COMMENT 'Logical expression or criteria that must be met for this routing rule to be applied to an order. May include patient attributes, order attributes, or clinical context.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this routing rule record was first created in the system.',
    `day_of_week` STRING COMMENT 'Comma-separated list of days of week (Monday, Tuesday, etc.) when this routing rule is active, used for schedule-based routing.',
    `diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code or code pattern that triggers this routing rule, used for condition-based routing.',
    `effective_end_date` DATE COMMENT 'Date after which this routing rule is no longer active. Null indicates an open-ended rule.',
    `effective_start_date` DATE COMMENT 'Date from which this routing rule becomes active and applicable to order routing decisions.',
    `insurance_plan_type` STRING COMMENT 'Type of insurance plan or payer category for which this routing rule applies, used for network-based routing decisions.',
    `is_stat_override` BOOLEAN COMMENT 'Indicates whether this routing rule overrides normal routing for STAT or emergency priority orders.',
    `last_reviewed_date` DATE COMMENT 'Date when this routing rule was last reviewed and validated by clinical or operational leadership.',
    `modified_by` STRING COMMENT 'User or system identifier of the person or process that last modified this routing rule record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this routing rule record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this routing rule to ensure continued clinical and operational appropriateness.',
    `notification_recipient` STRING COMMENT 'Role, user, or group to be notified when an order is routed using this rule, used for alerting and workflow coordination.',
    `order_category` STRING COMMENT 'Clinical order category or service type to which this routing rule applies, such as diagnostic imaging, laboratory test, or medication order.',
    `ordering_provider_specialty` STRING COMMENT 'Specialty of the ordering provider for which this routing rule applies, used to route orders based on ordering physician specialty.',
    `patient_age_max` STRING COMMENT 'Maximum patient age in years for which this routing rule applies. Null indicates no upper age limit.',
    `patient_age_min` STRING COMMENT 'Minimum patient age in years for which this routing rule applies. Used for age-based routing to pediatric or geriatric services.',
    `patient_gender` STRING COMMENT 'Patient gender for which this routing rule applies. Used for gender-specific service routing such as obstetrics or urology.',
    `patient_location_type` STRING COMMENT 'Type of patient care setting or location for which this routing rule applies.',
    `priority_level` STRING COMMENT 'Priority classification that this routing rule applies to or assigns to orders.',
    `procedure_code` STRING COMMENT 'Specific procedure or service code (CPT, HCPCS, or LOINC) to which this routing rule applies.',
    `routing_sequence` STRING COMMENT 'Order of evaluation for this routing rule when multiple rules may apply. Lower numbers are evaluated first.',
    `rule_code` STRING COMMENT 'Business-assigned unique code for the routing rule, used for external reference and integration with Epic Orders, Beaker, Radiant, and Willow systems.',
    `rule_description` STRING COMMENT 'Detailed description of the routing rule logic, conditions, and intended behavior.',
    `rule_name` STRING COMMENT 'Human-readable name of the routing rule for display and identification purposes.',
    `rule_owner` STRING COMMENT 'Name or identifier of the department, role, or individual responsible for maintaining and approving changes to this routing rule.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the routing rule indicating whether it is actively applied to order routing decisions.',
    `rule_type` STRING COMMENT 'Category of clinical order this routing rule applies to, aligned with Epic Orders modules.',
    `specialty_code` STRING COMMENT 'Medical specialty or clinical service line to which this routing rule applies, using standard specialty taxonomy.',
    `time_of_day_end` STRING COMMENT 'End time of day (HH:MM format) during which this routing rule is active. Null indicates rule applies until end of day.',
    `time_of_day_start` STRING COMMENT 'Start time of day (HH:MM format) during which this routing rule is active, used for shift-based or time-dependent routing.',
    `version_number` STRING COMMENT 'Version identifier for this routing rule, used to track changes and maintain rule history for compliance and audit purposes.',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order routing rule record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `created_by` STRING COMMENT 'User or system identifier of the person or process that created this routing rule record.',
    CONSTRAINT pk_routing_rule PRIMARY KEY(`routing_rule_id`)
) COMMENT 'Rules governing automatic order routing to departments, workstations, and queues.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`order_authorization` (
    `order_authorization_id` BIGINT COMMENT 'Unique identifier for the order authorization within the order order authorization record.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the approved vendor within the order order authorization record.',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order within the order order authorization record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the order order authorization record.',
    `encounter_authorization_id` BIGINT COMMENT 'Optional FK to encounter.encounter_authorization when an order authorization is linked to a facility-level encounter authorization.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the icd code within the order order authorization record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master within the order order authorization record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the order order authorization record.',
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study within the order order authorization record.',
    `appeal_decision_date` DATE COMMENT 'Timestamp capturing the appeal decision date associated with the order order authorization record.',
    `appeal_filed_date` DATE COMMENT 'Timestamp capturing the appeal filed date associated with the order order authorization record.',
    `appeal_status` STRING COMMENT 'The appeal status value classifying the order order authorization record.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'The approved quantity of the order order authorization record.',
    `approved_quantity_unit` STRING COMMENT 'The approved quantity unit of the order order authorization record.',
    `authorization_number` STRING COMMENT 'The authorization number of the order order authorization record.',
    `authorization_scope` STRING COMMENT 'The authorization scope of the order order authorization record.',
    `authorization_status` STRING COMMENT 'The authorization status value classifying the order order authorization record.',
    `authorization_type` STRING COMMENT 'The authorization type value classifying the order order authorization record.',
    `clinical_notes` STRING COMMENT 'The clinical notes of the order order authorization record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the order order authorization record.',
    `decision_datetime` TIMESTAMP COMMENT 'Timestamp capturing the decision datetime associated with the order order authorization record.',
    `denial_reason_code` STRING COMMENT 'The denial reason code value classifying the order order authorization record.',
    `denial_reason_description` STRING COMMENT 'The denial reason description of the order order authorization record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the order order authorization record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the order order authorization record.',
    `patient_mrn` STRING COMMENT 'The patient mrn of the order order authorization record.',
    `peer_to_peer_conducted` BOOLEAN COMMENT 'The peer to peer conducted of the order order authorization record.',
    `peer_to_peer_date` DATE COMMENT 'Timestamp capturing the peer to peer date associated with the order order authorization record.',
    `priority` STRING COMMENT 'The priority of the order order authorization record.',
    `request_datetime` TIMESTAMP COMMENT 'Timestamp capturing the request datetime associated with the order order authorization record.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'The requested quantity of the order order authorization record.',
    `requesting_provider_name` STRING COMMENT 'The requesting provider name of the order order authorization record.',
    `requesting_provider_npi` STRING COMMENT 'The requesting provider npi of the order order authorization record.',
    `reviewer_name` STRING COMMENT 'The reviewer name of the order order authorization record.',
    `service_category` STRING COMMENT 'The service category of the order order authorization record.',
    `servicing_facility_name` STRING COMMENT 'The servicing facility name of the order order authorization record.',
    `servicing_provider_npi` STRING COMMENT 'The servicing provider npi of the order order authorization record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: encounter.encounter_authorization (duplicate reconciled to canonical)',
    `ssot_reference` STRING COMMENT 'The ssot reference of the order order authorization record.',
    `order_authorization_status` STRING COMMENT 'The order authorization status value classifying the order order authorization record.',
    `submission_method` STRING COMMENT 'The submission method of the order order authorization record.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'The turnaround time hours of the order order authorization record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the order order authorization record.',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order order authorization record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the order order authorization record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_order_authorization PRIMARY KEY(`order_authorization_id`)
) COMMENT 'Prior authorization records for orders requiring payer approval before fulfillment.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`order_status_history` (
    `order_status_history_id` BIGINT COMMENT 'Unique identifier for the order status history within the order order status history record.',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order within the order order status history record.',
    `cpoe_alert_id` BIGINT COMMENT 'Unique identifier for the cpoe alert within the order order status history record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the order order status history record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the order order status history record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit within the order order status history record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary order clinician within the order order status history record.',
    `message_log_id` BIGINT COMMENT 'Unique identifier for the primary order message log within the order order status history record.',
    `set_id` BIGINT COMMENT 'Unique identifier for the set within the order order status history record.',
    `source_system_event_message_log_id` BIGINT COMMENT 'Unique identifier for the source system event message log within the order order status history record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the order order status history record.',
    `cds_alert_overridden` BOOLEAN COMMENT 'The cds alert overridden of the order order status history record.',
    `cosignature_required` BOOLEAN COMMENT 'The cosignature required of the order order status history record.',
    `cosignature_timestamp` TIMESTAMP COMMENT 'The cosignature timestamp of the order order status history record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the order order status history record.',
    `dea_schedule` STRING COMMENT 'The dea schedule of the order order status history record.',
    `discontinuation_type` STRING COMMENT 'The discontinuation type value classifying the order order status history record.',
    `effective_datetime` TIMESTAMP COMMENT 'Timestamp capturing the effective datetime associated with the order order status history record.',
    `event_sequence_number` STRING COMMENT 'The event sequence number of the order order status history record.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp of the order order status history record.',
    `event_type` STRING COMMENT 'The event type value classifying the order order status history record.',
    `hipaa_audit_category` STRING COMMENT 'The hipaa audit category of the order order status history record.',
    `is_amendment` BOOLEAN COMMENT 'Boolean flag indicating the is amendment status of the order order status history record.',
    `is_controlled_substance` BOOLEAN COMMENT 'Boolean flag indicating the is controlled substance status of the order order status history record.',
    `is_verbal_order` BOOLEAN COMMENT 'Boolean flag indicating the is verbal order status of the order order status history record.',
    `modified_field_name` STRING COMMENT 'The modified field name of the order order status history record.',
    `modifying_provider_npi` STRING COMMENT 'The modifying provider npi of the order order status history record.',
    `modifying_user_role` STRING COMMENT 'The modifying user role of the order order status history record.',
    `new_status` STRING COMMENT 'The new status value classifying the order order status history record.',
    `new_value` DECIMAL(18,2) COMMENT 'The new value of the order order status history record.',
    `order_number` STRING COMMENT 'The order number of the order order status history record.',
    `order_priority` STRING COMMENT 'The order priority of the order order status history record.',
    `order_type` STRING COMMENT 'The order type value classifying the order order status history record.',
    `override_reason` STRING COMMENT 'The override reason of the order order status history record.',
    `previous_status` STRING COMMENT 'The previous status value classifying the order order status history record.',
    `previous_value` DECIMAL(18,2) COMMENT 'The previous value of the order order status history record.',
    `reason_code` STRING COMMENT 'The reason code value classifying the order order status history record.',
    `reason_text` STRING COMMENT 'The reason text of the order order status history record.',
    `renewal_sequence_number` STRING COMMENT 'The renewal sequence number of the order order status history record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: claim.status_history (duplicate reconciled to canonical)',
    `status_history_scope` STRING COMMENT 'The status history scope of the order order status history record.',
    `transmission_datetime` TIMESTAMP COMMENT 'Timestamp capturing the transmission datetime associated with the order order status history record.',
    `transmission_status` STRING COMMENT 'The transmission status value classifying the order order status history record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the order order status history record.',
    `verbal_order_authentication_datetime` TIMESTAMP COMMENT 'Timestamp capturing the verbal order authentication datetime associated with the order order status history record.',
    `vibe_batch_marker` STRING COMMENT 'Batch synthesis marker for domains 1-10 creation',
    `vibe_mutation_added` STRING COMMENT 'Marker added by VIBE mutator to ensure non‑empty diff.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the order order status history record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `workstation_code` STRING COMMENT 'The workstation code value classifying the order order status history record.',
    CONSTRAINT pk_order_status_history PRIMARY KEY(`order_status_history_id`)
) COMMENT 'Audit trail of all status transitions for clinical orders.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`set` (
    `set_id` BIGINT COMMENT 'Primary key for set',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who authored or owns the order set content.',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department or organizational unit that owns and maintains the order set.',
    `parent_set_id` BIGINT COMMENT 'Self-referencing FK on set (parent_set_id)',
    `approving_authority` STRING COMMENT 'Governance committee or authority responsible for approving the order set content (e.g., Pharmacy & Therapeutics Committee, CPOE Governance Board).',
    `care_setting` STRING COMMENT 'Care setting context in which the order set is intended to be used.',
    `clinical_domain` STRING COMMENT 'Clinical ordering domain the set targets (lab, radiology, pharmacy, referral, nursing, etc.). [ENUM-REF-CANDIDATE: lab|radiology|pharmacy|referral|nursing|dietary|procedure|admission — promote to reference product]',
    `clinical_indication` STRING COMMENT 'Primary clinical condition or diagnosis the order set is intended to manage (e.g., sepsis, acute MI, pneumonia).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order set record was first captured in the system.',
    `default_priority` STRING COMMENT 'Default routing priority applied to orders instantiated from this set.',
    `set_description` STRING COMMENT 'Detailed description of the clinical purpose, intended use, and contents of the order set.',
    `effective_date` DATE COMMENT 'Date on which the order set becomes available for clinical use.',
    `evidence_source` STRING COMMENT 'Clinical guideline or evidence basis the order set derives from (e.g., Surviving Sepsis Campaign, ACC/AHA Guidelines).',
    `expiration_date` DATE COMMENT 'Date on which the order set is retired or scheduled for review; nullable for open-ended active sets.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this order set is the default selection for its clinical indication/specialty context.',
    `last_review_date` DATE COMMENT 'Date of the most recent clinical content review of the order set for currency and safety.',
    `next_review_date` DATE COMMENT 'Date the order set is next due for governance review per content maintenance policy.',
    `order_count` STRING COMMENT 'Number of individual orderable items contained within the order set — the principal quantitative measure of set size.',
    `requires_cosign` BOOLEAN COMMENT 'Indicates whether orders placed from this set require attending physician cosignature.',
    `routing_destination` STRING COMMENT 'Default ancillary system or department to which orders from this set are routed for fulfillment (e.g., Beaker LIS, Radiant RIS, Willow Pharmacy).',
    `set_code` STRING COMMENT 'Externally-known unique short code / mnemonic for the order set used across CPOE and interface engines to reference the set.',
    `set_name` STRING COMMENT 'Human-readable name of the order set (e.g., Sepsis Admission Order Set, Chest Pain ED Protocol). Serves as the identity label of this resource.',
    `set_status` STRING COMMENT 'Current lifecycle status of the order set within the CPOE content management workflow.',
    `set_type` STRING COMMENT 'Categorical classification of the order set structure (individual order set, SmartSet, protocol, panel, or power plan).',
    `source_system` STRING COMMENT 'Operational system of record that maintains this order set content (e.g., Epic Orders, Beaker, Radiant, Willow).',
    `specialty` STRING COMMENT 'Medical specialty or service line for which the order set is designed (e.g., Cardiology, Oncology, Emergency Medicine).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this order set record was last modified.',
    `version_number` STRING COMMENT 'Version label of the order set content, incremented on each approved revision.',
    CONSTRAINT pk_set PRIMARY KEY(`set_id`)
) COMMENT 'Master reference table for set. Referenced by set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_parent_order_clinical_order_id` FOREIGN KEY (`parent_order_clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_set_item_id` FOREIGN KEY (`set_item_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set_item`(`set_item_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_order_authorization_id` FOREIGN KEY (`order_authorization_id`) REFERENCES `vibe_healthcare_v1`.`order`.`order_authorization`(`order_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_routing_rule_id` FOREIGN KEY (`routing_rule_id`) REFERENCES `vibe_healthcare_v1`.`order`.`routing_rule`(`routing_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_alert_rule_id` FOREIGN KEY (`alert_rule_id`) REFERENCES `vibe_healthcare_v1`.`order`.`alert_rule`(`alert_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_superseded_diet_order_id` FOREIGN KEY (`superseded_diet_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`diet_order`(`diet_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_order_authorization_id` FOREIGN KEY (`order_authorization_id`) REFERENCES `vibe_healthcare_v1`.`order`.`order_authorization`(`order_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_superseded_therapy_order_id` FOREIGN KEY (`superseded_therapy_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`therapy_order`(`therapy_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_parent_alert_rule_id` FOREIGN KEY (`parent_alert_rule_id`) REFERENCES `vibe_healthcare_v1`.`order`.`alert_rule`(`alert_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ADD CONSTRAINT `fk_order_routing_rule_parent_routing_rule_id` FOREIGN KEY (`parent_routing_rule_id`) REFERENCES `vibe_healthcare_v1`.`order`.`routing_rule`(`routing_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ADD CONSTRAINT `fk_order_routing_rule_primary_fallback_routing_rule_id` FOREIGN KEY (`primary_fallback_routing_rule_id`) REFERENCES `vibe_healthcare_v1`.`order`.`routing_rule`(`routing_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_cpoe_alert_id` FOREIGN KEY (`cpoe_alert_id`) REFERENCES `vibe_healthcare_v1`.`order`.`cpoe_alert`(`cpoe_alert_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_parent_set_id` FOREIGN KEY (`parent_set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`order` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`order` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('pii_subdomain' = 'order_entry');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('pii_critical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Indication Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Parent Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Department ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `set_item_id` SET TAGS ('pii_business_glossary_term' = 'Order Set ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_business_glossary_term' = 'Order Cancelled Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_business_glossary_term' = 'Clinical Decision Support (CDS) Alert Response');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_value_regex' = 'no_alert|alert_accepted|alert_overridden|alert_cancelled');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication Free Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `completed_datetime` SET TAGS ('pii_business_glossary_term' = 'Order Completed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cosign_completed_datetime` SET TAGS ('pii_business_glossary_term' = 'Co-sign Completed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cosign_due_datetime` SET TAGS ('pii_business_glossary_term' = 'Co-sign Due Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `frequency_code` SET TAGS ('pii_business_glossary_term' = 'Order Frequency Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_cpoe_entered` SET TAGS ('pii_business_glossary_term' = 'Computerized Physician Order Entry (CPOE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_order_set_member` SET TAGS ('pii_business_glossary_term' = 'Order Set Member Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_recurring` SET TAGS ('pii_business_glossary_term' = 'Recurring Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_verbal_order` SET TAGS ('pii_business_glossary_term' = 'Verbal Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `number_of_occurrences` SET TAGS ('pii_business_glossary_term' = 'Number of Order Occurrences');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_catalog_code` SET TAGS ('pii_business_glossary_term' = 'Order Catalog Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_class` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Class');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_class` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|ED|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_datetime` SET TAGS ('pii_business_glossary_term' = 'Order Placed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_entered_datetime` SET TAGS ('pii_business_glossary_term' = 'Order Entered Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_mode` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Mode');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_mode` SET TAGS ('pii_value_regex' = 'electronic|verbal|written|telephone');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_number` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('pii_value_regex' = 'STAT|routine|urgent|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('pii_value_regex' = 'pending|active|completed|cancelled|on_hold|discontinued');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_type` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `quantity_ordered` SET TAGS ('pii_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `quantity_unit` SET TAGS ('pii_business_glossary_term' = 'Order Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `start_datetime` SET TAGS ('pii_business_glossary_term' = 'Order Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `stop_datetime` SET TAGS ('pii_business_glossary_term' = 'Order Stop Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('pii_subdomain' = 'order_entry');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_order_id` SET TAGS ('pii_business_glossary_term' = 'Referral Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Referring Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Referral Reason Icd10 Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Payer Authorization ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Referring Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Receiving (Specialist) Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Referral Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Snomed Ct Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Source System Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit (Encounter) ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `authorization_required` SET TAGS ('pii_business_glossary_term' = 'Payer Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `authorized_visits` SET TAGS ('pii_business_glossary_term' = 'Number of Authorized Visits');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Referral Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `disposition_date` SET TAGS ('pii_business_glossary_term' = 'Referral Disposition Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `disposition_notes` SET TAGS ('pii_business_glossary_term' = 'Referral Disposition Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Referral Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Referral Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `first_available_date` SET TAGS ('pii_business_glossary_term' = 'Specialist First Available Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `is_stat_order` SET TAGS ('pii_business_glossary_term' = 'STAT Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `loop_closed_date` SET TAGS ('pii_business_glossary_term' = 'Referral Loop Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Referral Order Placed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('pii_business_glossary_term' = 'Order Source System');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('pii_value_regex' = 'Epic|Cerner|MEDITECH|Salesforce|manual');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Referral Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Health Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_facility_name` SET TAGS ('pii_business_glossary_term' = 'Receiving Facility Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_facility_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_facility_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_facility_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_facility_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_facility_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_facility_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_facility_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Receiving Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_disposition` SET TAGS ('pii_business_glossary_term' = 'Referral Disposition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_disposition` SET TAGS ('pii_value_regex' = 'pending|accepted|declined|completed|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_loop_closed` SET TAGS ('pii_business_glossary_term' = 'Referral Loop Closed Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_number` SET TAGS ('pii_business_glossary_term' = 'Referral Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_number` SET TAGS ('pii_value_regex' = '^REF-[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_reason_description` SET TAGS ('pii_business_glossary_term' = 'Referral Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_source` SET TAGS ('pii_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_source` SET TAGS ('pii_value_regex' = 'PCP|ED|inpatient|specialist|self|care_program');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_type` SET TAGS ('pii_business_glossary_term' = 'Referral Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_type` SET TAGS ('pii_value_regex' = 'specialist|external_provider|care_program|second_opinion|diagnostic');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Referring Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `scheduled_appointment_date` SET TAGS ('pii_business_glossary_term' = 'Referred Appointment Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('pii_business_glossary_term' = 'Referral Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('pii_value_regex' = 'routine|urgent|stat|emergent');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visits_used` SET TAGS ('pii_business_glossary_term' = 'Referral Visits Used');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('pii_subdomain' = 'order_entry');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_id` SET TAGS ('pii_business_glossary_term' = 'Order Set Item Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_id` SET TAGS ('pii_business_glossary_term' = 'Order Set Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_max_years` SET TAGS ('pii_business_glossary_term' = 'Maximum Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_min_years` SET TAGS ('pii_business_glossary_term' = 'Minimum Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `alternative_order_options` SET TAGS ('pii_business_glossary_term' = 'Alternative Order Options');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `body_site` SET TAGS ('pii_business_glossary_term' = 'Body Site');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `collection_method` SET TAGS ('pii_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('pii_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('pii_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('pii_business_glossary_term' = 'Conditional Inclusion Logic');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `contrast_indicator` SET TAGS ('pii_business_glossary_term' = 'Contrast Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('pii_business_glossary_term' = 'Default Dose');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_duration` SET TAGS ('pii_business_glossary_term' = 'Default Duration');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_frequency` SET TAGS ('pii_business_glossary_term' = 'Default Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('pii_business_glossary_term' = 'Default Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('pii_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_quantity` SET TAGS ('pii_business_glossary_term' = 'Default Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_route` SET TAGS ('pii_business_glossary_term' = 'Default Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Criteria');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `instruction_text` SET TAGS ('pii_business_glossary_term' = 'Instruction Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_default_selected` SET TAGS ('pii_business_glossary_term' = 'Default Selected Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_code` SET TAGS ('pii_business_glossary_term' = 'Order Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_description` SET TAGS ('pii_business_glossary_term' = 'Order Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('pii_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('pii_value_regex' = 'laboratory|radiology|pharmacy|procedure|referral|nursing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `patient_instruction_text` SET TAGS ('pii_business_glossary_term' = 'Patient Instruction Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_authorization` SET TAGS ('pii_business_glossary_term' = 'Requires Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_consent` SET TAGS ('pii_business_glossary_term' = 'Requires Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `sequence_number` SET TAGS ('pii_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('pii_business_glossary_term' = 'Order Set Item Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|draft|under_review');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('pii_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `weight_max_kg` SET TAGS ('pii_business_glossary_term' = 'Maximum Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `weight_min_kg` SET TAGS ('pii_business_glossary_term' = 'Minimum Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('pii_subdomain' = 'fulfillment_routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_business_glossary_term' = 'Order Routing ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Manual Route User ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Interface Message ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Destination Department ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_unit_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_unit_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_unit_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_unit_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_unit_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_unit_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `org_unit_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_previous_destination_department_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Previous Destination Department ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_previous_destination_department_org_unit_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_previous_destination_department_org_unit_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_previous_destination_department_org_unit_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_previous_destination_department_org_unit_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_previous_destination_department_org_unit_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_previous_destination_department_org_unit_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_previous_destination_department_org_unit_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_business_glossary_term' = 'Routing Rule ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `hipaa_security_risk_id` SET TAGS ('pii_business_glossary_term' = 'Security Risk Hipaa Security Risk Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `source_department_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Source Department ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `acknowledgement_datetime` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `auto_route_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Route Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `completion_datetime` SET TAGS ('pii_business_glossary_term' = 'Completion Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `datetime` SET TAGS ('pii_business_glossary_term' = 'Routing Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `delay_minutes` SET TAGS ('pii_business_glossary_term' = 'Routing Delay Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('pii_business_glossary_term' = 'Destination Workstation ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `estimated_completion_datetime` SET TAGS ('pii_business_glossary_term' = 'Estimated Completion Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Routing Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `method` SET TAGS ('pii_value_regex' = 'automatic|manual_override|rule_based|load_balanced|escalated|emergency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Routing Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('pii_business_glossary_term' = 'Patient Location at Routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Routing Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'stat|urgent|routine|scheduled|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority_override_flag` SET TAGS ('pii_business_glossary_term' = 'Priority Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority_override_reason` SET TAGS ('pii_business_glossary_term' = 'Priority Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('pii_business_glossary_term' = 'Queue Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_position` SET TAGS ('pii_business_glossary_term' = 'Queue Position');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `reroute_count` SET TAGS ('pii_business_glossary_term' = 'Reroute Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `reroute_reason` SET TAGS ('pii_business_glossary_term' = 'Reroute Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('pii_business_glossary_term' = 'Routing Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sequence` SET TAGS ('pii_business_glossary_term' = 'Routing Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sla_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sla_target_minutes` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('pii_business_glossary_term' = 'Specimen Collection Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `system_source` SET TAGS ('pii_business_glossary_term' = 'Routing System Source');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `transport_required_flag` SET TAGS ('pii_business_glossary_term' = 'Transport Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `workload_score` SET TAGS ('pii_business_glossary_term' = 'Workload Score');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('pii_subdomain' = 'fulfillment_routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_id` SET TAGS ('pii_business_glossary_term' = 'Order Fulfillment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Location Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Fulfilling Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduled Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('pii_business_glossary_term' = 'Specimen Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Vendor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_amount` SET TAGS ('pii_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_capture_flag` SET TAGS ('pii_business_glossary_term' = 'Charge Capture Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_code` SET TAGS ('pii_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `datetime` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `exception_reason_code` SET TAGS ('pii_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `exception_reason_description` SET TAGS ('pii_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfilled_quantity` SET TAGS ('pii_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_number` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('pii_value_regex' = 'completed|partial|cancelled|failed|in_progress|pending');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `method` SET TAGS ('pii_value_regex' = 'manual|automated|semi_automated|point_of_care|external_lab|outsourced');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `modifier_codes` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier Codes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `order_type` SET TAGS ('pii_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `ordered_quantity` SET TAGS ('pii_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `partial_fulfillment_flag` SET TAGS ('pii_business_glossary_term' = 'Partial Fulfillment Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `performing_department_code` SET TAGS ('pii_business_glossary_term' = 'Performing Department Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `priority_code` SET TAGS ('pii_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `priority_code` SET TAGS ('pii_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quality_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quality_review_notes` SET TAGS ('pii_business_glossary_term' = 'Quality Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quantity_unit` SET TAGS ('pii_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `result_availability_datetime` SET TAGS ('pii_business_glossary_term' = 'Result Availability Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `turnaround_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Turnaround Time in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` SET TAGS ('pii_subdomain' = 'order_entry');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `verbal_order_id` SET TAGS ('pii_business_glossary_term' = 'Verbal Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Waiver Authorized By ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Receiving Clinician ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_datetime` SET TAGS ('pii_business_glossary_term' = 'Authentication Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_deadline_datetime` SET TAGS ('pii_business_glossary_term' = 'Authentication Deadline Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_deadline_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_deadline_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_deadline_datetime` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_deadline_datetime` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_deadline_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_deadline_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `authentication_deadline_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_datetime` SET TAGS ('pii_business_glossary_term' = 'Co-Signature Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_datetime` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_business_glossary_term' = 'Co-Signature Deadline Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signature_deadline_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_business_glossary_term' = 'Co-Signer National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_role` SET TAGS ('pii_business_glossary_term' = 'Co-Signer Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `co_signer_role` SET TAGS ('pii_value_regex' = 'attending_physician|supervising_physician|pharmacist|charge_nurse|clinical_supervisor|other');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `controlled_substance_flag` SET TAGS ('pii_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_value_regex' = 'I|II|III|IV|V');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `dea_schedule` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `order_content` SET TAGS ('pii_business_glossary_term' = 'Order Content');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `order_content` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `order_number` SET TAGS ('pii_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `order_received_datetime` SET TAGS ('pii_business_glossary_term' = 'Order Received Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `order_status` SET TAGS ('pii_value_regex' = 'pending_authentication|authenticated|overdue|waived|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `order_type` SET TAGS ('pii_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `overdue_flag` SET TAGS ('pii_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'stat|urgent|routine');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `read_back_confirmed_flag` SET TAGS ('pii_business_glossary_term' = 'Read-Back Confirmed Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `read_back_datetime` SET TAGS ('pii_business_glossary_term' = 'Read-Back Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_business_glossary_term' = 'Receiving Clinician National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `receiving_clinician_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `regulatory_basis` SET TAGS ('pii_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `verbal_order_type` SET TAGS ('pii_business_glossary_term' = 'Verbal Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `verbal_order_type` SET TAGS ('pii_value_regex' = 'verbal|telephone|co_signature|countersignature');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `waiver_datetime` SET TAGS ('pii_business_glossary_term' = 'Waiver Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `waiver_flag` SET TAGS ('pii_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ALTER COLUMN `waiver_reason` SET TAGS ('pii_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('pii_subdomain' = 'order_entry');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `standing_order_id` SET TAGS ('pii_business_glossary_term' = 'Standing Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `form_template_id` SET TAGS ('pii_business_glossary_term' = 'Consent Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'Lab Test Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('pii_business_glossary_term' = 'Activation Condition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `applicable_population_criteria` SET TAGS ('pii_business_glossary_term' = 'Applicable Population Criteria');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `authorized_role` SET TAGS ('pii_business_glossary_term' = 'Authorized Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `contraindication` SET TAGS ('pii_business_glossary_term' = 'Contraindication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `documentation_requirement` SET TAGS ('pii_business_glossary_term' = 'Documentation Requirement');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `evidence_based_guideline_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence-Based Guideline Reference');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `imaging_modality` SET TAGS ('pii_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `maximum_duration_days` SET TAGS ('pii_business_glossary_term' = 'Maximum Duration Days');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('pii_business_glossary_term' = 'Medication Dose');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('pii_business_glossary_term' = 'Medication Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_business_glossary_term' = 'Medication Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('pii_business_glossary_term' = 'Medication Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `notification_recipient_role` SET TAGS ('pii_business_glossary_term' = 'Notification Recipient Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `notification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `order_detail` SET TAGS ('pii_business_glossary_term' = 'Order Detail');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `order_type` SET TAGS ('pii_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_code` SET TAGS ('pii_business_glossary_term' = 'Protocol Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_business_glossary_term' = 'Protocol Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_version` SET TAGS ('pii_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `regulatory_compliance_note` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Note');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `renewal_frequency_days` SET TAGS ('pii_business_glossary_term' = 'Renewal Frequency Days');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `special_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `usage_count` SET TAGS ('pii_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` SET TAGS ('pii_subdomain' = 'decision_support');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `cpoe_alert_id` SET TAGS ('pii_business_glossary_term' = 'Computerized Physician Order Entry (CPOE) Alert ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_rule_id` SET TAGS ('pii_business_glossary_term' = 'Alert Rule ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_acknowledged_flag` SET TAGS ('pii_business_glossary_term' = 'Alert Acknowledged Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_display_duration_seconds` SET TAGS ('pii_business_glossary_term' = 'Alert Display Duration Seconds');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_fire_timestamp` SET TAGS ('pii_business_glossary_term' = 'Alert Fire Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_message` SET TAGS ('pii_business_glossary_term' = 'Alert Message');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_priority` SET TAGS ('pii_business_glossary_term' = 'Alert Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_rule_version` SET TAGS ('pii_business_glossary_term' = 'Alert Rule Version');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_severity` SET TAGS ('pii_business_glossary_term' = 'Alert Severity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_severity` SET TAGS ('pii_value_regex' = 'hard_stop|soft_stop|informational|warning');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_source_system` SET TAGS ('pii_business_glossary_term' = 'Alert Source System');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_suppressed_flag` SET TAGS ('pii_business_glossary_term' = 'Alert Suppressed Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_title` SET TAGS ('pii_business_glossary_term' = 'Alert Title');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_trigger_detail` SET TAGS ('pii_business_glossary_term' = 'Alert Trigger Detail');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_type` SET TAGS ('pii_business_glossary_term' = 'Alert Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `alert_type` SET TAGS ('pii_value_regex' = 'drug_drug_interaction|drug_allergy|duplicate_order|dose_range_check|contraindication|formulary_substitution');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `allergy_substance` SET TAGS ('pii_business_glossary_term' = 'Allergy Substance');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `allergy_substance` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `allergy_substance` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `allergy_substance` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `allergy_substance` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `allergy_substance` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `allergy_substance` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `allergy_substance` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_context` SET TAGS ('pii_business_glossary_term' = 'Clinical Context');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_context` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_context` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_context` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_context` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_context` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_context` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `clinical_context` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `duplicate_order_timeframe_hours` SET TAGS ('pii_business_glossary_term' = 'Duplicate Order Timeframe Hours');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `formulary_status` SET TAGS ('pii_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `formulary_status` SET TAGS ('pii_value_regex' = 'formulary|non_formulary|restricted|prior_auth_required');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_business_glossary_term' = 'Interacting Medication 1');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_business_glossary_term' = 'Interacting Medication 2');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `interacting_medication_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose` SET TAGS ('pii_business_glossary_term' = 'Ordered Dose');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose_unit` SET TAGS ('pii_business_glossary_term' = 'Ordered Dose Unit');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose_unit` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose_unit` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose_unit` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose_unit` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose_unit` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose_unit` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `ordered_dose_unit` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `override_reason_code` SET TAGS ('pii_business_glossary_term' = 'Override Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `override_reason_text` SET TAGS ('pii_business_glossary_term' = 'Override Reason Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `patient_age_at_alert` SET TAGS ('pii_business_glossary_term' = 'Patient Age at Alert');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `patient_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Patient Weight Kilograms');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `provider_response` SET TAGS ('pii_business_glossary_term' = 'Provider Response');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `provider_response` SET TAGS ('pii_value_regex' = 'accepted|overridden|modified|cancelled|deferred');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_max` SET TAGS ('pii_business_glossary_term' = 'Recommended Dose Maximum');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_max` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_max` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_max` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_max` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_max` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_max` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_max` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_min` SET TAGS ('pii_business_glossary_term' = 'Recommended Dose Minimum');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_min` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_min` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_min` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_min` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_min` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_min` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `recommended_dose_min` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suggested_alternative_medication` SET TAGS ('pii_business_glossary_term' = 'Suggested Alternative Medication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suggested_alternative_medication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suggested_alternative_medication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suggested_alternative_medication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suggested_alternative_medication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suggested_alternative_medication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suggested_alternative_medication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suggested_alternative_medication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `suppression_reason` SET TAGS ('pii_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` SET TAGS ('pii_subdomain' = 'decision_support');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('pii_business_glossary_term' = 'Order Reconciliation ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Reconciling Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('pii_business_glossary_term' = 'Allergy Review Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `allergy_review_indicator` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `attestation_datetime` SET TAGS ('pii_business_glossary_term' = 'Attestation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `attestation_signature` SET TAGS ('pii_business_glossary_term' = 'Attestation Signature');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `attestation_signature` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `completion_indicator` SET TAGS ('pii_business_glossary_term' = 'Completion Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `compliance_indicator` SET TAGS ('pii_business_glossary_term' = 'Compliance Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `datetime` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_description` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_identified_indicator` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Identified Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_severity` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Severity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `discrepancy_severity` SET TAGS ('pii_value_regex' = 'high|medium|low|none');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `documentation_location` SET TAGS ('pii_business_glossary_term' = 'Documentation Location');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `drug_interaction_check_indicator` SET TAGS ('pii_business_glossary_term' = 'Drug Interaction Check Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `formulary_check_indicator` SET TAGS ('pii_business_glossary_term' = 'Formulary Check Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('pii_business_glossary_term' = 'Home Medication List Reviewed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `home_medication_list_reviewed_indicator` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `last_updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `method` SET TAGS ('pii_value_regex' = 'cpoe|paper|verbal|hybrid');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `next_provider_communication_indicator` SET TAGS ('pii_business_glossary_term' = 'Next Provider Communication Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `non_compliance_reason` SET TAGS ('pii_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_added_count` SET TAGS ('pii_business_glossary_term' = 'Orders Added Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('pii_business_glossary_term' = 'Orders Continued Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_continued_count` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('pii_business_glossary_term' = 'Orders Discontinued Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_discontinued_count` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_modified_count` SET TAGS ('pii_business_glossary_term' = 'Orders Modified Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `orders_reviewed_count` SET TAGS ('pii_business_glossary_term' = 'Orders Reviewed Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `patient_communication_indicator` SET TAGS ('pii_business_glossary_term' = 'Patient Communication Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'completed|incomplete|in_progress|not_required|deferred');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('pii_value_regex' = 'admission|transfer|discharge|pre_procedure|post_procedure|outpatient_visit');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Reconciling Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `reconciling_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_business_glossary_term' = 'Source Medication List Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_value_regex' = 'patient_reported|pharmacy_records|prior_emr|pcp_records|family_reported|medication_bottles');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `source_medication_list_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `transition_event` SET TAGS ('pii_business_glossary_term' = 'Transition Event');
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('pii_data_type' = 'Master');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('pii_subdomain' = 'order_entry');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diet_order_id` SET TAGS ('pii_business_glossary_term' = 'Diet Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Dietitian Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Indication Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `measure_id` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `superseded_diet_order_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Diet Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `superseded_diet_order_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `allergen_exclusions` SET TAGS ('pii_business_glossary_term' = 'Allergen Exclusions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `calorie_target` SET TAGS ('pii_business_glossary_term' = 'Daily Calorie Target');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diet_type` SET TAGS ('pii_business_glossary_term' = 'Diet Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diet_type_code` SET TAGS ('pii_business_glossary_term' = 'Diet Type Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `feeding_route` SET TAGS ('pii_business_glossary_term' = 'Feeding Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `feeding_route` SET TAGS ('pii_value_regex' = 'oral|enteral|parenteral|nasogastric|gastrostomy|jejunostomy');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `fluid_consistency` SET TAGS ('pii_business_glossary_term' = 'Fluid Consistency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `fluid_consistency` SET TAGS ('pii_value_regex' = 'thin|nectar-thick|honey-thick|pudding-thick');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `fluid_restriction_ml` SET TAGS ('pii_business_glossary_term' = 'Fluid Restriction in Milliliters (mL)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `food_preferences` SET TAGS ('pii_business_glossary_term' = 'Food Preferences');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `meal_schedule` SET TAGS ('pii_business_glossary_term' = 'Meal Schedule');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `npo_reason` SET TAGS ('pii_business_glossary_term' = 'Nothing by Mouth (NPO) Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `npo_status` SET TAGS ('pii_business_glossary_term' = 'Nothing by Mouth (NPO) Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `protein_target_grams` SET TAGS ('pii_business_glossary_term' = 'Daily Protein Target in Grams');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `source_system_order_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `special_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_frequency` SET TAGS ('pii_business_glossary_term' = 'Supplement Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('pii_business_glossary_term' = 'Nutritional Supplement Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `texture_modification` SET TAGS ('pii_business_glossary_term' = 'Texture Modification');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` SET TAGS ('pii_data_type' = 'Master');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` SET TAGS ('pii_subdomain' = 'order_entry');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_business_glossary_term' = 'Therapy Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Parent Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Icd10 Diagnosis Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Authorization Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Performing Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `set_id` SET TAGS ('pii_business_glossary_term' = 'Order Set Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Therapy Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Therapy Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `body_site` SET TAGS ('pii_business_glossary_term' = 'Body Site');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_business_glossary_term' = 'Cancelled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `completed_datetime` SET TAGS ('pii_business_glossary_term' = 'Completed Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `duration_unit` SET TAGS ('pii_business_glossary_term' = 'Duration Unit');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `duration_unit` SET TAGS ('pii_value_regex' = 'minutes|hours');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `duration_value` SET TAGS ('pii_business_glossary_term' = 'Duration Value');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Therapy End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `frequency_code` SET TAGS ('pii_business_glossary_term' = 'Frequency Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `frequency_description` SET TAGS ('pii_business_glossary_term' = 'Frequency Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `is_recurring` SET TAGS ('pii_business_glossary_term' = 'Is Recurring Order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `laterality` SET TAGS ('pii_value_regex' = 'left|right|bilateral');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_datetime` SET TAGS ('pii_business_glossary_term' = 'Order Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_mode` SET TAGS ('pii_business_glossary_term' = 'Order Mode');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_mode` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|home_health|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_number` SET TAGS ('pii_business_glossary_term' = 'Therapy Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Therapy Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_status` SET TAGS ('pii_value_regex' = 'draft|active|on-hold|completed|cancelled|discontinued');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `patient_instructions` SET TAGS ('pii_business_glossary_term' = 'Patient Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'routine|urgent|stat|asap');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `sessions_completed` SET TAGS ('pii_business_glossary_term' = 'Sessions Completed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `sessions_remaining` SET TAGS ('pii_business_glossary_term' = 'Sessions Remaining');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `source_system_order_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `special_instructions` SET TAGS ('pii_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Therapy Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('pii_business_glossary_term' = 'Therapy Service Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('pii_business_glossary_term' = 'Therapy Service Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_business_glossary_term' = 'Therapy Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_value_regex' = 'physical_therapy|occupational_therapy|speech_therapy|respiratory_therapy');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `total_sessions_ordered` SET TAGS ('pii_business_glossary_term' = 'Total Sessions Ordered');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_business_glossary_term' = 'Treatment Goal');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` SET TAGS ('pii_subdomain' = 'decision_support');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_rule_id` SET TAGS ('pii_business_glossary_term' = 'Alert Rule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `parent_alert_rule_id` SET TAGS ('pii_business_glossary_term' = 'Parent Alert Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `parent_alert_rule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_fatigue_risk_score` SET TAGS ('pii_business_glossary_term' = 'Alert Fatigue Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `alert_message_template` SET TAGS ('pii_business_glossary_term' = 'Alert Message Template');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `auto_dismiss_seconds` SET TAGS ('pii_business_glossary_term' = 'Auto Dismiss Seconds');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `clinical_specialty_scope` SET TAGS ('pii_business_glossary_term' = 'Clinical Specialty Scope');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `clinical_specialty_scope` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `clinical_specialty_scope` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `clinical_specialty_scope` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `clinical_specialty_scope` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `clinical_specialty_scope` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `clinical_specialty_scope` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `clinical_specialty_scope` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `display_priority` SET TAGS ('pii_business_glossary_term' = 'Display Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `evidence_source` SET TAGS ('pii_business_glossary_term' = 'Evidence Source');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `evidence_strength_level` SET TAGS ('pii_business_glossary_term' = 'Evidence Strength Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `external_rule_code` SET TAGS ('pii_business_glossary_term' = 'External Rule Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `fire_count_total` SET TAGS ('pii_business_glossary_term' = 'Fire Count Total');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `hard_stop_flag` SET TAGS ('pii_business_glossary_term' = 'Hard Stop Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `integration_system_code` SET TAGS ('pii_business_glossary_term' = 'Integration System Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `order_type_scope` SET TAGS ('pii_business_glossary_term' = 'Order Type Scope');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `override_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `override_count_total` SET TAGS ('pii_business_glossary_term' = 'Override Count Total');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `override_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Override Rate Percent');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `override_reason_required_flag` SET TAGS ('pii_business_glossary_term' = 'Override Reason Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `patient_population_filter` SET TAGS ('pii_business_glossary_term' = 'Patient Population Filter');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `recommended_action` SET TAGS ('pii_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `review_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_category` SET TAGS ('pii_business_glossary_term' = 'Rule Category');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_code` SET TAGS ('pii_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_description` SET TAGS ('pii_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `rule_status` SET TAGS ('pii_business_glossary_term' = 'Rule Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `trigger_condition` SET TAGS ('pii_business_glossary_term' = 'Trigger Condition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `trigger_condition` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `trigger_condition` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `trigger_condition` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `trigger_condition` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `trigger_condition` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `trigger_condition` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `trigger_condition` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` SET TAGS ('pii_subdomain' = 'fulfillment_routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_business_glossary_term' = 'Routing Rule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_rule_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_business_glossary_term' = 'Parent Routing Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `parent_routing_rule_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `primary_fallback_routing_rule_id` SET TAGS ('pii_business_glossary_term' = 'Fallback Routing Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `primary_fallback_routing_rule_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `primary_fallback_routing_rule_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `primary_fallback_routing_rule_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `primary_fallback_routing_rule_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `primary_fallback_routing_rule_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `primary_fallback_routing_rule_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `primary_fallback_routing_rule_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `capacity_threshold` SET TAGS ('pii_business_glossary_term' = 'Capacity Threshold');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `capacity_threshold` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `capacity_threshold` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `capacity_threshold` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `capacity_threshold` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `capacity_threshold` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `capacity_threshold` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `day_of_week` SET TAGS ('pii_business_glossary_term' = 'Day Of Week');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_subtype' = 'health');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_category' = 'health');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'PHI');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pattern' = 'health');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `insurance_plan_type` SET TAGS ('pii_business_glossary_term' = 'Insurance Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `is_stat_override` SET TAGS ('pii_business_glossary_term' = 'Is Stat Override');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `notification_recipient` SET TAGS ('pii_business_glossary_term' = 'Notification Recipient');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `order_category` SET TAGS ('pii_business_glossary_term' = 'Order Category');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `ordering_provider_specialty` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider Specialty');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_age_max` SET TAGS ('pii_business_glossary_term' = 'Patient Age Max');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_age_min` SET TAGS ('pii_business_glossary_term' = 'Patient Age Min');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_business_glossary_term' = 'Patient Gender');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_category' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_subtype' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_classification' = 'PHI');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_pattern' = 'special_category');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_gender` SET TAGS ('pii_special_category' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `patient_location_type` SET TAGS ('pii_business_glossary_term' = 'Patient Location Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_sequence` SET TAGS ('pii_business_glossary_term' = 'Routing Sequence');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_sequence` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_sequence` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_sequence` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_sequence` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_sequence` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_sequence` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `routing_sequence` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_code` SET TAGS ('pii_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_description` SET TAGS ('pii_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_owner` SET TAGS ('pii_business_glossary_term' = 'Rule Owner');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_status` SET TAGS ('pii_business_glossary_term' = 'Rule Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `rule_type` SET TAGS ('pii_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `time_of_day_end` SET TAGS ('pii_business_glossary_term' = 'Time Of Day End');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `time_of_day_start` SET TAGS ('pii_business_glossary_term' = 'Time Of Day Start');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_subdomain' = 'decision_support');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_ssot_canonical' = 'encounter.encounter_authorization');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_ssot_primary' = 'encounter.encounter_authorization');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_ssot_duplicate_of' = 'encounter.encounter_authorization');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` SET TAGS ('pii_duplicate_of' = 'encounter.encounter_authorization');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `encounter_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Encounter Authorization Reference');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `authorization_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_notes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_notes` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_notes` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_notes` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_notes` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `clinical_notes` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `reviewer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `reviewer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `reviewer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `reviewer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `reviewer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_facility_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `servicing_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_subdomain' = 'fulfillment_routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ssot_canonical' = 'claim.status_history');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ssot_note' = 'Distinct domains; retain both');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ensure_no_attribute_overlap' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ssot_pair' = 'claim.status_history');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ssot_duplicate_of' = 'claim.status_history');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('pii_duplicate_of' = 'claim.status_history');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `cosignature_required` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `cosignature_timestamp` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `status_history_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `vibe_mutation_added` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` SET TAGS ('pii_subdomain' = 'order_entry');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_id` SET TAGS ('pii_business_glossary_term' = 'Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `parent_set_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('pii_mask_non_prod' = 'true');
