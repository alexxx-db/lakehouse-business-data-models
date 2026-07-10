-- Schema for Domain: order | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`order` COMMENT 'Manages the full lifecycle of clinical orders including CPOE (Computerized Physician Order Entry) for lab, radiology, pharmacy, and referral orders. Tracks order status, priority, routing, and fulfillment. Integrates with Epic Orders, Beaker (LIS), Radiant (RIS), and Willow (pharmacy) as the operational order management backbone.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`clinical_order` (
    `clinical_order_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical order record in the enterprise data lakehouse. Primary key for the clinical_order data product.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Prior authorization and medical necessity review: coverage policies govern whether a clinical order is covered. Utilization management teams and payer auditors require this link to validate that order',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: CPOE medication orders must reference the formulary at order entry to enforce formulary tier restrictions, prior authorization requirements, and quantity limits in real time. A clinical informatics ex',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Benefit-level order validation: health plan determines specific copay obligations, prior auth requirements, and covered benefits at order placement. Payer alone is insufficient — a payer administers m',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this clinical order was placed. Core PARTY_REFERENCE linking the order to the patient master record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Clinical orders are placed within a specific facility context. CMS billing, Joint Commission reporting, and order routing all require knowing which org/facility originated the order. ordering_provider',
    `parent_order_clinical_order_id` BIGINT COMMENT 'Reference to the parent clinical order when this order is a child or linked order in a chained order relationship (e.g., a reflex lab order triggered by a parent panel, or a follow-up order linked to an original). Null for top-level independent orders.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Every clinical order requires payer identification for real-time eligibility verification, coverage determination, and prior authorization checks at order entry. CPOE systems integrate payer data for ',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who entered or authorized this order via Computerized Physician Order Entry (CPOE). Corresponds to the ordering provider NPI-linked record in the provider master.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Prior authorization workflow: the specific prior_auth_rule that triggered the authorization requirement for a clinical order must be traceable for compliance auditing, denial management, and CPOE deci',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Clinical orders placed during an admission must be traceable to the registration/ADT event for billing reconciliation, compliance auditing, and care episode management. A domain expert expects orders ',
    `set_item_id` BIGINT COMMENT 'Identifier of the clinical order set or protocol from which this order was generated, if applicable. Order sets are pre-defined bundles of evidence-based orders (e.g., Sepsis Bundle, AMI Order Set). Null if the order was placed individually outside an order set.',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: A standing_order is a pre-authorized protocol that triggers the generation of individual clinical_orders (e.g., recurring lab draws, scheduled medication administrations). The clinical_order is the ch',
    `tertiary_clinical_authorizing_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who authorized or approved the order when different from the ordering provider (e.g., attending physician authorizing a resident-entered order). Supports order authentication and supervision compliance tracking.',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Medical necessity documentation and payer audits require linking each clinical order to the specific diagnosis that indicated it. CMS and commercial payers require diagnosis-to-order linkage for prior',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Clinical order management, charge capture, and clinical documentation all require knowing which visit generated an order. Every EHR order is placed in the context of a visit; this link is foundational',
    `authorization_number` STRING COMMENT 'Payer-issued prior authorization number obtained before order fulfillment for services requiring pre-authorization (e.g., advanced imaging, elective procedures, specialty referrals). Required for claims submission and denial prevention.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the order was cancelled or discontinued (e.g., Duplicate Order, Patient Refused, Clinical Contraindication, Order Error). Required for medication safety and quality reporting. [ENUM-REF-CANDIDATE: duplicate|patient_refused|contraindication|order_error|provider_request|clinical_change — promote to reference product]',
    `cancelled_datetime` TIMESTAMP COMMENT 'Timestamp when the order was cancelled or discontinued. Null for active or completed orders. Used for order lifecycle analytics, duplicate order detection, and medication safety reporting.',
    `clinical_decision_support_alert` STRING COMMENT 'Indicates whether a Clinical Decision Support (CDS) alert was triggered at order entry and the providers response. Supports medication safety monitoring, duplicate order detection, and CDS effectiveness analytics per AHRQ and ONC requirements.. Valid values are `no_alert|alert_accepted|alert_overridden|alert_cancelled`',
    `clinical_indication_text` STRING COMMENT 'Free-text clinical rationale or indication entered by the ordering provider to justify the order. Supplements the ICD-10 indication code with narrative context. Used by Clinical Documentation Improvement (CDI) and utilization management teams.',
    `clinical_order_status` STRING COMMENT 'The clinical order status value classifying the order clinical order record.',
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
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Referral authorization workflow: coverage policies define specialist referral requirements, authorized visit limits, and medical necessity criteria. referral_order.authorized_visits and authorization_',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom the referral order was placed. Links to the patient master record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Referral benefit verification: health_plan.requires_referral_for_specialist governs whether a referral is required. referral_order.plan_type is a denormalized representation of health_plan. Linking to',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Referral eligibility verification: active member enrollment at time of referral determines coverage eligibility, authorized visit counts, and benefit period validity. Referral management and payer aut',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Referral processing requires payer-specific authorization workflows, network validation, and timely filing requirements. Real-world process: referral management systems verify payer requirements, chec',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who originated and placed the referral order. Typically the patients Primary Care Physician (PCP) or treating provider.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Referral prior authorization: prior_auth_rules specify submission method, turnaround time, and documentation requirements for referral authorizations. Linking referral_order to the governing prior_aut',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to insurance.provider_network. Business justification: In-network referral routing: referrals must be directed to providers within the patients plan network. referral_order.receiving_provider_npi is a denormalized signal. Linking to provider_network supp',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Closed-loop referral management and network adequacy reporting require a structured FK to the receiving facility. receiving_facility_name is a denormalized text field; replacing it with receiving_org_',
    `receiving_provider_clinician_id` BIGINT COMMENT 'Reference to the specialist or external provider to whom the patient is being referred. May be null if the receiving provider has not yet been assigned.',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Discharge-planning and admission-initiated referrals must be linked to the originating registration/ADT event for care transition tracking, CMS discharge planning compliance, and referral loop closure',
    `clinical_order_id` BIGINT COMMENT 'The native order identifier from the originating operational system (e.g., Epic order ID, Salesforce referral record ID). Enables cross-system reconciliation and traceability back to the system of record.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Referral routing, network adequacy analysis, and payer authorization workflows require structured specialty linkage. Receiving_provider_clinician_id provides individual, but specialty_id enables speci',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Referral orders must document the specific diagnosis driving the referral for medical necessity, prior authorization, and referral loop closure quality reporting. Structured FK to visit_diagnosis repl',
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
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Order set items map directly to CDM entries for charge capture configuration. Healthcare revenue cycle teams maintain this mapping to ensure order sets generate correct charges. order_code on set_item',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Order set medication items must reference drug_master to enforce formulary compliance, LASA alerts, high-alert medication warnings, and REMS requirements at order set build and execution time. Clinica',
    `set_id` BIGINT COMMENT 'Reference to the parent order set that contains this item. Links this item to its containing order set bundle.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Order set management and lab catalog validation: when a set_item represents a laboratory test, it must reference the test_catalog entry to validate test codes, enforce specimen requirements, and suppo',
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
    `clinical_order_id` BIGINT COMMENT 'Identifier of the clinical order being routed. Links to the parent order from CPOE (Computerized Physician Order Entry) system.',
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
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Fulfillment drives charge capture by resolving the CDM entry before a charge record is created. Revenue cycle charge capture workflows require fulfillment→CDM linkage for real-time charge validation a',
    `clinical_order_id` BIGINT COMMENT 'Foreign key reference to the clinical order that was fulfilled. Links to the originating order in the order management system.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Charge capture and coverage validation: coverage policies govern which services are reimbursable and under what conditions. Linking fulfillment to coverage_policy supports charge capture validation, e',
    `demographics_id` BIGINT COMMENT 'Foreign key reference to the patient for whom the order was fulfilled. Links fulfillment to the patient master record.',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule. Business justification: Revenue cycle management: fee schedules determine contracted reimbursement rates for fulfilled services. fulfillment.charge_amount and revenue_code require fee schedule context for accurate charge cap',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Fulfillment events trigger charge capture and claim submission processes that require payer identification. Real-world process: revenue cycle systems link fulfilled orders to payer for billing, tracki',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Revenue cycle, charge capture, and quality reporting (e.g., CMS value-based programs) require knowing which facility performed the service. performing_department_code is department-level granularity; ',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider, technician, or clinician who performed or completed the fulfillment. May be a lab technician, radiologist, pharmacist, or other clinical staff.',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Order fulfillment during an inpatient stay must be tied to the registration/admission episode for charge capture, revenue cycle reconciliation, and UB-04 claim generation. Billing teams require fulfil',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen collected and used for fulfillment. Primarily applicable to laboratory and pathology orders. Links to specimen tracking systems.',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the patient visit or encounter during which the order was fulfilled. Links fulfillment to the clinical encounter context.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The gross charge amount associated with the fulfillment event. Represents the list price from the Charge Description Master (CDM) before adjustments, discounts, or contractual allowances.',
    `charge_capture_flag` BOOLEAN COMMENT 'Boolean indicator of whether a billable charge was captured for this fulfillment event. Used for revenue cycle management and billing reconciliation.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`standing_order` (
    `standing_order_id` BIGINT COMMENT 'Unique identifier for the standing order record. Primary key.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Standing order protocols are mapped to CDM entries to define which charges are generated upon execution. Revenue cycle configuration and charge capture planning require this link. Healthcare charge ca',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician or advanced practice provider who authorized this standing order protocol.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Standing order protocols must align with payer coverage policies to ensure reimbursement and avoid denials. Real-world process: protocol committees review payer policies when creating standing orders ',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Standing medication orders reference a specific drug for REMS compliance, high-alert medication safety checks, and controlled substance scheduling validation. medication_name is a denormalized drug_ma',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Standing medication protocols must be validated against the formulary to enforce prior authorization requirements, tier restrictions, and step therapy rules at protocol activation. Formulary complianc',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Standing orders are approved and scoped to a specific facility (e.g., hospital nursing protocols, SNF standing orders). Joint Commission and CMS require facility-level standing order governance. Witho',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Standing order protocol governance: prior_auth_rules define authorization requirements for recurring protocol-based orders. standing_order already links to coverage_policy; the prior_auth_rule provide',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: Standing orders for imaging procedures (e.g., annual low-dose CT lung screening, surveillance MRI) must reference the specific radiology protocol to be applied. This link enforces protocol governance,',
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
    `medication_route` STRING COMMENT 'Route of administration for medication orders. [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|inhalation|rectal|sublingual|transdermal|ophthalmic|otic|nasal — 12 candidates stripped; promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next required review of this standing order protocol.',
    `notification_recipient_role` STRING COMMENT 'Role or position of the clinician who should be notified when this standing order is executed (e.g., Attending Physician, Hospitalist, Charge Nurse).',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether the authorizing provider or other clinician must be notified when this standing order is executed.',
    `order_detail` STRING COMMENT 'Detailed specification of the order including drug name and dose, lab test panel, imaging modality, or intervention description.',
    `order_type` STRING COMMENT 'Category of clinical order covered by this standing order (medication, lab test, imaging study, nursing intervention, etc.). [ENUM-REF-CANDIDATE: medication|laboratory|radiology|nursing_intervention|referral|procedure|diet|therapy — 8 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'Priority level for execution of the standing order.. Valid values are `routine|urgent|stat|asap|timed`',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`diet_order` (
    `diet_order_id` BIGINT COMMENT 'Unique identifier for the diet order record. Primary key for the diet order entity.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: diet_order is a specialized type of clinical order (dietary orders for inpatient/observation patients). Linking to clinical_order as the parent order record establishes the subtype relationship. This ',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Nutritional support coverage determination: enteral nutrition and therapeutic diet orders require prior authorization under many health plans. Coverage policies define medical necessity criteria for n',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this diet order is prescribed. Links to the patient master record.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who ordered the diet. Links to the provider master record.',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Inpatient diet orders are tied to a specific admission episode. Linking diet_order to registration_event enables nutritional care tracking per admission, supports charge capture per stay, and satisfie',
    `superseded_diet_order_id` BIGINT COMMENT 'Self-referencing FK on diet_order (superseded_diet_order_id)',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient or observation encounter during which this diet order is active. Links to the encounter record.',
    `allergen_exclusions` STRING COMMENT 'Comma-separated list of food allergens that must be excluded from the diet such as peanuts, tree nuts, shellfish, dairy, eggs, soy, wheat, or fish. Cross-referenced with patient allergy records.',
    `calorie_target` STRING COMMENT 'Target daily caloric intake in kilocalories prescribed for the patient based on nutritional assessment and clinical needs.',
    `clinical_indication` STRING COMMENT 'Free-text description of the clinical reason for the diet order such as diabetes management, heart failure, chronic kidney disease, post-operative recovery, or malnutrition.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this diet order record was first created in the data platform.',
    `diet_order_status` STRING COMMENT 'The diet order status value classifying the order diet order record.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`set` (
    `set_id` BIGINT COMMENT 'Primary key for set',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who authored or owns the order set content.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Order sets are created and governed at the facility level — hospital-specific order sets are a standard EHR configuration artifact. Accreditation surveys, EHR governance, and facility-specific clinica',
    `parent_set_id` BIGINT COMMENT 'Self-referencing FK on set (parent_set_id)',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Order sets are authored and maintained by clinical specialty (e.g., cardiology, orthopedics). CPOE configuration, clinical decision support, and specialty-based order set governance all require a stru',
    `approving_authority` STRING COMMENT 'Governance committee or authority responsible for approving the order set content (e.g., Pharmacy & Therapeutics Committee, CPOE Governance Board).',
    `care_setting` STRING COMMENT 'Care setting context in which the order set is intended to be used.',
    `clinical_domain` STRING COMMENT 'Clinical ordering domain the set targets (lab, radiology, pharmacy, referral, nursing, etc.). [ENUM-REF-CANDIDATE: lab|radiology|pharmacy|referral|nursing|dietary|procedure|admission — promote to reference product]',
    `clinical_indication` STRING COMMENT 'Primary clinical condition or diagnosis the order set is intended to manage (e.g., sepsis, acute MI, pneumonia).',
    `set_code` STRING COMMENT 'Externally-known unique short code / mnemonic for the order set used across CPOE and interface engines to reference the set.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order set record was first captured in the system.',
    `default_priority` STRING COMMENT 'Default routing priority applied to orders instantiated from this set.',
    `set_description` STRING COMMENT 'Detailed description of the clinical purpose, intended use, and contents of the order set.',
    `effective_date` DATE COMMENT 'Date on which the order set becomes available for clinical use.',
    `evidence_source` STRING COMMENT 'Clinical guideline or evidence basis the order set derives from (e.g., Surviving Sepsis Campaign, ACC/AHA Guidelines).',
    `expiration_date` DATE COMMENT 'Date on which the order set is retired or scheduled for review; nullable for open-ended active sets.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this order set is the default selection for its clinical indication/specialty context.',
    `last_review_date` DATE COMMENT 'Date of the most recent clinical content review of the order set for currency and safety.',
    `set_name` STRING COMMENT 'Human-readable name of the order set (e.g., Sepsis Admission Order Set, Chest Pain ED Protocol). Serves as the identity label of this resource.',
    `next_review_date` DATE COMMENT 'Date the order set is next due for governance review per content maintenance policy.',
    `order_count` STRING COMMENT 'Number of individual orderable items contained within the order set — the principal quantitative measure of set size.',
    `requires_cosign` BOOLEAN COMMENT 'Indicates whether orders placed from this set require attending physician cosignature.',
    `routing_destination` STRING COMMENT 'Default ancillary system or department to which orders from this set are routed for fulfillment (e.g., Beaker LIS, Radiant RIS, Willow Pharmacy).',
    `set_status` STRING COMMENT 'Current lifecycle status of the order set within the CPOE content management workflow.',
    `set_type` STRING COMMENT 'Categorical classification of the order set structure (individual order set, SmartSet, protocol, panel, or power plan).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this order set record was last modified.',
    `version_number` STRING COMMENT 'Version label of the order set content, incremented on each approved revision.',
    CONSTRAINT pk_set PRIMARY KEY(`set_id`)
) COMMENT 'Master reference table for set. Referenced by set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_parent_order_clinical_order_id` FOREIGN KEY (`parent_order_clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_set_item_id` FOREIGN KEY (`set_item_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set_item`(`set_item_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_superseded_diet_order_id` FOREIGN KEY (`superseded_diet_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`diet_order`(`diet_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_parent_set_id` FOREIGN KEY (`parent_set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `set_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Cancelled Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_business_glossary_term' = 'Clinical Decision Support (CDS) Alert Response');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_value_regex' = 'no_alert|alert_accepted|alert_overridden|alert_cancelled');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication Free Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `completed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Completed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cosign_completed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Co-sign Completed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cosign_due_datetime` SET TAGS ('dbx_business_glossary_term' = 'Co-sign Due Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Order Frequency Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_cpoe_entered` SET TAGS ('dbx_business_glossary_term' = 'Computerized Physician Order Entry (CPOE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_order_set_member` SET TAGS ('dbx_business_glossary_term' = 'Order Set Member Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `is_verbal_order` SET TAGS ('dbx_business_glossary_term' = 'Verbal Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `number_of_occurrences` SET TAGS ('dbx_business_glossary_term' = 'Number of Order Occurrences');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_catalog_code` SET TAGS ('dbx_business_glossary_term' = 'Order Catalog Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_class` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Class');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ED|ambulatory');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_entered_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Entered Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_mode` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Mode');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_mode` SET TAGS ('dbx_value_regex' = 'electronic|verbal|written|telephone');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'STAT|routine|urgent|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled|on_hold|discontinued');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `stop_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Stop Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving (Specialist) Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit (Encounter) ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `authorized_visits` SET TAGS ('dbx_business_glossary_term' = 'Number of Authorized Visits');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `first_available_date` SET TAGS ('dbx_business_glossary_term' = 'Specialist First Available Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `is_stat_order` SET TAGS ('dbx_business_glossary_term' = 'STAT Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `loop_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Loop Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Placed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_business_glossary_term' = 'Order Source System');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|MEDITECH|Salesforce|manual');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Receiving Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_disposition` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_disposition` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|completed|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_loop_closed` SET TAGS ('dbx_business_glossary_term' = 'Referral Loop Closed Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'PCP|ED|inpatient|specialist|self|care_program');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'specialist|external_provider|care_program|second_opinion|diagnostic');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `scheduled_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Referred Appointment Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Referral Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|emergent');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visits_used` SET TAGS ('dbx_business_glossary_term' = 'Referral Visits Used');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('dbx_subdomain' = 'fulfillment_routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Item Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_max_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_min_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `alternative_order_options` SET TAGS ('dbx_business_glossary_term' = 'Alternative Order Options');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Body Site');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_business_glossary_term' = 'Conditional Inclusion Logic');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `contrast_indicator` SET TAGS ('dbx_business_glossary_term' = 'Contrast Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_business_glossary_term' = 'Default Dose');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_duration` SET TAGS ('dbx_business_glossary_term' = 'Default Duration');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_frequency` SET TAGS ('dbx_business_glossary_term' = 'Default Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('dbx_business_glossary_term' = 'Default Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_quantity` SET TAGS ('dbx_business_glossary_term' = 'Default Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_route` SET TAGS ('dbx_business_glossary_term' = 'Default Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Criteria');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Instruction Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_default_selected` SET TAGS ('dbx_business_glossary_term' = 'Default Selected Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'laboratory|radiology|pharmacy|procedure|referral|nursing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `patient_instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Patient Instruction Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_authorization` SET TAGS ('dbx_business_glossary_term' = 'Requires Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('dbx_business_glossary_term' = 'Order Set Item Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|under_review');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `vibe_mutation_added` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `weight_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `weight_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` SET TAGS ('dbx_subdomain' = 'fulfillment_routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Order Routing ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `acknowledgement_datetime` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `auto_route_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Route Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Completion Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Routing Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Routing Delay Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Workstation ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `destination_workstation_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `estimated_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Routing Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'automatic|manual_override|rule_based|load_balanced|escalated|emergency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Routing Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_business_glossary_term' = 'Patient Location at Routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `patient_location_at_routing` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'stat|urgent|routine|scheduled|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `priority_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Priority Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `queue_position` SET TAGS ('dbx_business_glossary_term' = 'Queue Position');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `reroute_count` SET TAGS ('dbx_business_glossary_term' = 'Reroute Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `reroute_reason` SET TAGS ('dbx_business_glossary_term' = 'Reroute Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Routing Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `specimen_collection_required_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'Routing System Source');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `transport_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transport Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `vibe_mutation_added` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ALTER COLUMN `workload_score` SET TAGS ('dbx_business_glossary_term' = 'Workload Score');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('dbx_subdomain' = 'fulfillment_routing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilling Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_capture_flag` SET TAGS ('dbx_business_glossary_term' = 'Charge Capture Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `exception_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'completed|partial|cancelled|failed|in_progress|pending');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'manual|automated|semi_automated|point_of_care|external_lab|outsourced');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `modifier_codes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier Codes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `partial_fulfillment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Fulfillment Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `performing_department_code` SET TAGS ('dbx_business_glossary_term' = 'Performing Department Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quality_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `result_availability_datetime` SET TAGS ('dbx_business_glossary_term' = 'Result Availability Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `vibe_mutation_added` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_business_glossary_term' = 'Activation Condition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `applicable_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Applicable Population Criteria');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `authorized_role` SET TAGS ('dbx_business_glossary_term' = 'Authorized Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `contraindication` SET TAGS ('dbx_business_glossary_term' = 'Contraindication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `documentation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirement');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `evidence_based_guideline_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence-Based Guideline Reference');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `imaging_modality` SET TAGS ('dbx_business_glossary_term' = 'Imaging Modality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `maximum_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duration Days');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_business_glossary_term' = 'Medication Dose');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_dose` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Medication Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_business_glossary_term' = 'Medication Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `notification_recipient_role` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `order_detail` SET TAGS ('dbx_business_glossary_term' = 'Order Detail');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `regulatory_compliance_note` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Note');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `renewal_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Days');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Diet Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `superseded_diet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Diet Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `superseded_diet_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `allergen_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Allergen Exclusions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `calorie_target` SET TAGS ('dbx_business_glossary_term' = 'Daily Calorie Target');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diet_type` SET TAGS ('dbx_business_glossary_term' = 'Diet Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diet_type_code` SET TAGS ('dbx_business_glossary_term' = 'Diet Type Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `feeding_route` SET TAGS ('dbx_business_glossary_term' = 'Feeding Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `feeding_route` SET TAGS ('dbx_value_regex' = 'oral|enteral|parenteral|nasogastric|gastrostomy|jejunostomy');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `fluid_consistency` SET TAGS ('dbx_business_glossary_term' = 'Fluid Consistency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `fluid_consistency` SET TAGS ('dbx_value_regex' = 'thin|nectar-thick|honey-thick|pudding-thick');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `fluid_restriction_ml` SET TAGS ('dbx_business_glossary_term' = 'Fluid Restriction in Milliliters (mL)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `food_preferences` SET TAGS ('dbx_business_glossary_term' = 'Food Preferences');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `meal_schedule` SET TAGS ('dbx_business_glossary_term' = 'Meal Schedule');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `npo_reason` SET TAGS ('dbx_business_glossary_term' = 'Nothing by Mouth (NPO) Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `npo_status` SET TAGS ('dbx_business_glossary_term' = 'Nothing by Mouth (NPO) Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `protein_target_grams` SET TAGS ('dbx_business_glossary_term' = 'Daily Protein Target in Grams');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `source_system_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Supplement Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Supplement Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `texture_modification` SET TAGS ('dbx_business_glossary_term' = 'Texture Modification');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `vibe_mutation_added` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `parent_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_domain` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `routing_destination` SET TAGS ('dbx_mask_non_prod' = 'true');
