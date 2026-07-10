-- Schema for Domain: order | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-10 16:21:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`order` COMMENT 'Manages the full lifecycle of clinical orders including CPOE (Computerized Physician Order Entry) for lab, radiology, pharmacy, and referral orders. Tracks order status, priority, routing, and fulfillment. Integrates with Epic Orders, Beaker (LIS), Radiant (RIS), and Willow (pharmacy) as the operational order management backbone.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`clinical_order` (
    `clinical_order_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical order record in the enterprise data lakehouse. Primary key for the clinical_order data product.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure orders must link to CPT master for charge capture, prior authorization validation, RVU-based resource planning, and compliance with coding standards. Essential for revenue cycle and utilizat',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Orders must validate against specific plan benefits, formulary restrictions, and coverage policies. Real-world process: CPOE systems check plan-specific authorization requirements, copays, and covered',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Clinical orders for DME, outpatient supplies, and ambulatory services require HCPCS coding for CMS claims submission, prior authorization, and revenue cycle processing. A healthcare billing analyst wo',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Core clinical ordering workflow requires validation of diagnosis indication against ICD-10 master for billing compliance, clinical decision support, quality reporting, and medical necessity documentat',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Procedures, surgeries, and high-risk treatments require documented informed consent. Pre-procedure verification workflows mandate linking orders to the authorizing consent record. Core HIPAA and state',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Clinical orders for labs and observations are identified by LOINC codes per HL7 FHIR ServiceRequest and ONC interoperability mandates. Lab order routing, result matching, and quality measure reporting',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this clinical order was placed. Core PARTY_REFERENCE linking the order to the patient master record.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Surgical and procedural orders frequently specify medical devices, implants, or supplies by catalog number (e.g., orthopedic hardware, cardiac stents). Essential for charge capture, inventory depletio',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Site-of-service reporting, CMS place-of-service billing compliance, and operational analytics require knowing the specific care location where a clinical order was placed. Network participation status',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Clinical orders are placed within a specific organizational provider context (hospital, clinic). CMS place-of-service compliance, facility-level quality reporting, and credentialing verification (was ',
    `parent_order_clinical_order_id` BIGINT COMMENT 'Reference to the parent clinical order when this order is a child or linked order in a chained order relationship (e.g., a reflex lab order triggered by a parent panel, or a follow-up order linked to an original). Null for top-level independent orders.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who entered or authorized this order via Computerized Physician Order Entry (CPOE). Corresponds to the ordering provider NPI-linked record in the provider master.',
    `set_id` BIGINT COMMENT 'Identifier of the clinical order set or protocol from which this order was generated, if applicable. Order sets are pre-defined bundles of evidence-based orders (e.g., Sepsis Bundle, AMI Order Set). Null if the order was placed individually outside an order set.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR ServiceRequest uses SNOMED CT for procedure and clinical indication coding. Clinical decision support, care gap analysis, and CMS quality reporting programs require SNOMED-coded orders alongside ',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Surgical and procedural order reconciliation requires linking the clinical order that generated a procedure to the resulting visit_procedure record. Revenue cycle charge capture audits and OR scheduli',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: A standing_order is a pre-authorized, protocol-driven order that can be executed to generate one or many clinical_orders. Adding standing_order_id to clinical_order establishes the traceability from a',
    `tertiary_clinical_authorizing_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who authorized or approved the order when different from the ordering provider (e.g., attending physician authorizing a resident-entered order). Supports order authentication and supervision compliance tracking.',
    `triage_assessment_id` BIGINT COMMENT 'Foreign key linking to encounter.triage_assessment. Business justification: ED sepsis bundle and stroke protocol compliance reporting require linking protocol-triggered orders (sepsis_alert_flag, stroke_alert_flag) to the specific triage assessment that activated them. Door-t',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: CDI and DRG optimization reporting require tracing which specific visit_diagnosis triggered each clinical order. Payer audits and quality measure reporting (e.g., CMS core measures) depend on linking ',
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
    `start_datetime` TIMESTAMP COMMENT 'Datetime when the order is scheduled to begin or when fulfillment should commence. For timed orders, this is the precise execution start time. Distinct from order_datetime (when placed) and order_datetime (when entered).',
    `stop_datetime` TIMESTAMP COMMENT 'Datetime when the order expires, is discontinued, or fulfillment should cease. Critical for pharmacy and nursing orders to prevent over-administration. Nullable for one-time orders.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical order record was last modified in the enterprise data lakehouse. Serves as the RECORD_AUDIT_UPDATED field for change tracking, incremental ETL processing, and audit compliance.',
    CONSTRAINT pk_clinical_order PRIMARY KEY(`clinical_order_id`)
) COMMENT 'Core master record for every clinical order entered via CPOE (Computerized Physician Order Entry) in Epic Orders or Cerner Millennium. Captures the authoritative order identity, ordering provider NPI, patient MRN, order type (lab, radiology, pharmacy, referral, nursing, dietary, consult), order priority (STAT, routine, urgent, timed), order mode (verbal, written, electronic), clinical indication (ICD-10 coded), ordering datetime, start and stop datetimes, order source system, order set membership flag, parent order reference for linked/chained orders, current order status, and order class (inpatient, outpatient, ED, ambulatory). SSOT for all clinical order identity, metadata, and type/priority classification across the enterprise. Absorbs order_type and order_priority reference attributes as embedded enums. All modality-specific attributes are owned by extension products (lab_order, radiology_order, pharmacy_order, referral_order).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`order_status_history` (
    `order_status_history_id` BIGINT COMMENT 'Unique surrogate identifier for each order lifecycle event record in the immutable audit trail. Primary key for this append-only event log.',
    `clinical_order_id` BIGINT COMMENT 'Reference to the parent clinical order whose lifecycle event is being recorded. Links this history record to the originating order in the order management system (Epic Orders / Cerner Millennium).',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the Clinical Decision Support (CDS) alert (drug-drug interaction, allergy, dosing alert, duplicate order) that was triggered and may have prompted this lifecycle event. Null if no CDS alert was associated. Supports CDS effectiveness analysis and alert fatigue reporting.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who originally placed the order. Used for accountability tracking and CPOE audit trails.',
    `scheduling_appointment_id` BIGINT COMMENT 'The HL7 message control ID (MSH-10) of the HL7 v2 or FHIR message that triggered or communicated this order lifecycle event. Supports interoperability audit trails and Health Information Exchange (HIE) reconciliation.',
    `set_id` BIGINT COMMENT 'Identifier of the clinical order set or protocol from which the parent order was generated, if applicable. Supports analysis of order set adherence and protocol-driven order modification patterns.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter (visit, admission, or ED episode) during which this order lifecycle event occurred. Supports encounter-level order audit and CDI review.',
    `cds_alert_overridden` BOOLEAN COMMENT 'Indicates whether a Clinical Decision Support (CDS) alert was overridden by the provider when this event was triggered. True = alert was acknowledged and overridden; False = alert was not overridden or no alert was present. Critical for patient safety audit and alert override rate reporting.',
    `cosignature_required` BOOLEAN COMMENT 'Indicates whether this order modification or event requires a co-signature from a supervising or authorizing provider before the change takes effect. Applies to resident/trainee orders and controlled substance modifications per institutional policy.',
    `cosignature_timestamp` TIMESTAMP COMMENT 'The date and time at which the required co-signature was completed by the supervising provider. Null if co-signature has not yet been obtained. Used to measure co-signature turnaround time for compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this history record was first written to the lakehouse silver layer. Represents the ETL ingestion time, distinct from event_timestamp (the real-world clinical event time). Used for data pipeline monitoring and late-arrival detection.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule (CI through CV) applicable to the medication order at the time of this event. Populated only when is_controlled_substance is True. Determines regulatory handling requirements.. Valid values are `CI|CII|CIII|CIV|CV`',
    `discontinuation_type` STRING COMMENT 'Classifies the reason category for order discontinuation when event_type is DISCONTINUATION. AMA = Against Medical Advice. Supports medication reconciliation, discharge planning, and quality reporting. [ENUM-REF-CANDIDATE: COMPLETED|PROVIDER_DISCONTINUED|PATIENT_REFUSED|AMA|FORMULARY|DUPLICATE|PROTOCOL — promote to reference product]',
    `effective_datetime` TIMESTAMP COMMENT 'The date and time at which this lifecycle event becomes clinically effective (e.g., when a renewed order becomes active, when a hold is lifted). May differ from event_timestamp when events are scheduled or backdated. Supports medication administration record (MAR) reconciliation.',
    `event_sequence_number` STRING COMMENT 'Monotonically increasing sequence number for all lifecycle events belonging to the same parent order. Enables chronological ordering of events within an orders history and detection of out-of-order event delivery from source systems.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which this lifecycle event occurred in the clinical system. This is the authoritative real-world event time, distinct from record audit timestamps. Stored in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `event_type` STRING COMMENT 'Discriminator classifying the kind of lifecycle event recorded. STATUS_CHANGE = workflow state transition; MODIFICATION = dose/frequency/route/priority change; AMENDMENT = clinical content update; CORRECTION = error correction; RENEWAL = order re-authorization; DISCONTINUATION = order stopped; COSIGN_REQUEST = co-signature required; COSIGN_COMPLETED = co-signature fulfilled. [ENUM-REF-CANDIDATE: STATUS_CHANGE|MODIFICATION|AMENDMENT|CORRECTION|RENEWAL|DISCONTINUATION|COSIGN_REQUEST|COSIGN_COMPLETED — promote to reference product]',
    `hipaa_audit_category` STRING COMMENT 'HIPAA-defined audit event category for this order lifecycle event, used for compliance reporting to OCR and internal privacy audits. Classifies the event as an access, modification, disclosure, correction, or deletion of PHI per HIPAA Security Rule requirements.. Valid values are `ACCESS|MODIFICATION|DISCLOSURE|CORRECTION|DELETION`',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether this event represents a formal clinical amendment to the order record (as opposed to a routine status change or system-generated update). True = formal amendment requiring clinical documentation. Supports HIM and CDI amendment tracking.',
    `is_controlled_substance` BOOLEAN COMMENT 'Indicates whether the order subject to this lifecycle event involves a DEA-scheduled controlled substance. True = controlled substance order. Triggers enhanced audit requirements and DEA compliance tracking.',
    `is_verbal_order` BOOLEAN COMMENT 'Indicates whether this order event was initiated as a verbal or telephone order requiring subsequent written authentication. True = verbal/telephone order; False = directly entered CPOE order. Tracked for Joint Commission verbal order compliance.',
    `modified_field_name` STRING COMMENT 'The name of the specific clinical order field that was changed during a MODIFICATION, AMENDMENT, or CORRECTION event (e.g., dose, frequency, route, quantity, priority, start_date, stop_date, indication). Null for pure status transitions.',
    `modifying_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the licensed provider who triggered this event, when the modifying user is a credentialed clinician. Denormalized from the provider record to preserve the NPI value at the time of the event for regulatory audit purposes. Required for CMS and OIG compliance reporting.. Valid values are `^[0-9]{10}$`',
    `modifying_user_role` STRING COMMENT 'The clinical or operational role of the user who triggered this lifecycle event at the time of the event. Supports role-based audit analysis and compliance review (e.g., identifying unauthorized order modifications). [ENUM-REF-CANDIDATE: PHYSICIAN|NURSE|PHARMACIST|RESIDENT|SYSTEM|ADMIN|TECHNICIAN — 7 candidates stripped; promote to reference product]',
    `new_status` STRING COMMENT 'The order workflow status immediately after this lifecycle event. Together with previous_status, defines the state transition that occurred. [ENUM-REF-CANDIDATE: DRAFT|PENDING|ACTIVE|HOLD|SUSPENDED|COMPLETED|DISCONTINUED|CANCELLED|EXPIRED|ERROR — promote to reference product]',
    `new_value` DECIMAL(18,2) COMMENT 'The value of the modified clinical field immediately after this modification event. Paired with previous_value to form a complete before/after audit record. Contains PHI when the field relates to medication or clinical details.',
    `order_number` STRING COMMENT 'The human-readable, externally visible order identifier (e.g., Epic order number, Cerner accession number) at the time of this event. Denormalized from the order header to support direct lookup in audit reports without joining to the order table.',
    `order_priority` STRING COMMENT 'The priority level of the order at the time of this event. Captures the priority as it existed at this point in the lifecycle, enabling detection of priority escalations or de-escalations over time.. Valid values are `ROUTINE|URGENT|STAT|ASAP`',
    `order_type` STRING COMMENT 'Classification of the clinical order category at the time of this event. Determines routing to downstream fulfillment systems: LAB → Beaker/LIS; RADIOLOGY → Radiant/RIS; PHARMACY → Willow; REFERRAL → Cadence. Denormalized here to support event-level analytics without joining back to the order header. [ENUM-REF-CANDIDATE: LAB|RADIOLOGY|PHARMACY|REFERRAL|PROCEDURE|NURSING|DIET|CONSULT — 8 candidates stripped; promote to reference product]',
    `override_reason` STRING COMMENT 'The structured or free-text reason provided by the provider when overriding a Clinical Decision Support (CDS) alert associated with this order event. Populated only when cds_alert_overridden is True. Supports patient safety review and quality improvement programs.',
    `previous_status` STRING COMMENT 'The order workflow status immediately before this lifecycle event. Enables reconstruction of the full state machine history and supports CDI review and medication reconciliation. [ENUM-REF-CANDIDATE: DRAFT|PENDING|ACTIVE|HOLD|SUSPENDED|COMPLETED|DISCONTINUED|CANCELLED|EXPIRED|ERROR — promote to reference product]',
    `previous_value` DECIMAL(18,2) COMMENT 'The value of the modified clinical field (dose, frequency, route, priority, quantity, etc.) immediately before this modification event. Stored as a string to accommodate heterogeneous field types across order categories. Populated only for MODIFICATION, AMENDMENT, and CORRECTION event types. Contains PHI when the field relates to medication or clinical details.',
    `reason_code` STRING COMMENT 'Structured reason code explaining why this lifecycle event occurred (e.g., CLINICAL_CHANGE, PATIENT_REQUEST, PROVIDER_CORRECTION, DUPLICATE_ORDER, ALLERGY_ALERT, DRUG_INTERACTION, FORMULARY_SUBSTITUTION, PROTOCOL_CHANGE). Sourced from the EHR reason code catalog. Supports CDI and quality review workflows.',
    `reason_text` STRING COMMENT 'Free-text clinical justification or narrative explanation provided by the user or system for this lifecycle event. Supplements the structured reason_code with provider-authored context. May contain PHI when clinical rationale references patient-specific information.',
    `renewal_sequence_number` STRING COMMENT 'Sequential counter indicating which renewal iteration this event represents for the parent order. Starts at 1 for the first renewal. Null for non-renewal events. Supports chronic medication management and long-term order tracking.',
    `transmission_datetime` TIMESTAMP COMMENT 'The date and time at which this order event was transmitted to the downstream fulfillment system (Beaker, Radiant, Willow, etc.). Null if transmission is not required or has not yet occurred.',
    `transmission_status` STRING COMMENT 'Status of the order transmission to the downstream fulfillment system (pharmacy, lab, radiology) following this lifecycle event. Tracks whether the event was successfully communicated to the executing department.. Valid values are `SENT|PENDING|FAILED|ACKNOWLEDGED|NOT_REQUIRED`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this history record was last updated in the lakehouse silver layer. Although the event log is intended to be immutable, this field captures any correction or reprocessing events applied to the record for data quality purposes.',
    `verbal_order_authentication_datetime` TIMESTAMP COMMENT 'The date and time at which a verbal or telephone order was authenticated (signed) by the ordering provider. Null for non-verbal orders. Must occur within the timeframe required by Joint Commission standards (typically 24-48 hours).',
    `workstation_code` STRING COMMENT 'Identifier of the clinical workstation, device, or terminal from which this order lifecycle event was initiated. Supports HIPAA access audit trails and security incident investigation.',
    CONSTRAINT pk_order_status_history PRIMARY KEY(`order_status_history_id`)
) COMMENT 'Immutable audit trail of every lifecycle event for a clinical order, including status transitions, modifications (dose, frequency, route, priority changes), amendments, corrections, renewals, and discontinuations. Captures event type, previous and new values, modification details, the datetime of each event, the user or system that triggered it, reason codes, clinical justification, co-signature requirements for modifications, modifying provider NPI, and the source system event. SSOT for all order lifecycle changes — no other product in this domain records order state transitions or modifications. Supports HIPAA audit compliance, CDI (Clinical Documentation Improvement), medication reconciliation, and clinical quality review.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`referral_order` (
    `referral_order_id` BIGINT COMMENT 'Unique surrogate identifier for the referral order record in the lakehouse Silver layer. Primary key for this entity.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Referral orders are governed by specific policies (referral management policy, authorization policy, specialist access policy). Policy framework ensures appropriate referrals and regulatory compliance',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Referral service specification links anticipated procedure to CPT master for prior authorization submission, scheduling coordination, and expected reimbursement calculation. Essential for referral man',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom the referral order was placed. Links to the patient master record.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Referral authorization and medical necessity determination require valid ICD-10 linkage. Payers validate diagnosis against coverage policies for specialist referral approval, and providers need accura',
    `insurance_coverage_id` BIGINT COMMENT 'Reference to the payer prior authorization record associated with this referral, when authorization is required. Links to the encounter authorization entity.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Referral completion and timeliness are tracked quality metrics (HEDIS specialty care access, referral loop closure measures). Quality programs require linking referral orders to specific measures to c',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Specialty referrals (behavioral health, substance use, HIV care) require specific consent for information sharing under 42 CFR Part 2 and state laws. Referral authorization workflow validates consent ',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who originated and placed the referral order. Typically the patients Primary Care Physician (PCP) or treating provider.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Closed-loop referral tracking and prior authorization workflows require knowing which organizational provider (hospital, clinic, specialist group) receives the referral. receiving_facility_name is a d',
    `receiving_provider_clinician_id` BIGINT COMMENT 'Reference to the specialist or external provider to whom the patient is being referred. May be null if the receiving provider has not yet been assigned.',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Referrals are directed to a specific care site location (e.g., downtown vs. suburban office). Referral loop closure, patient scheduling, and provider directory accuracy require the specific location. ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: SNOMED CT provides granular clinical semantics for referral routing, specialty matching, and interoperable care coordination. Supports clinical detail beyond ICD-10 for precise referral indication and',
    `clinical_order_id` BIGINT COMMENT 'The native order identifier from the originating operational system (e.g., Epic order ID, Salesforce referral record ID). Enables cross-system reconciliation and traceability back to the system of record.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Referral routing, network adequacy analysis, and payer authorization workflows require structured specialty linkage. Receiving_provider_clinician_id provides individual, but specialty_id enables speci',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether the patients payer requires prior authorization before the referral can be fulfilled. When True, the referral workflow is gated on obtaining a payer authorization number before scheduling.',
    `authorized_visits` STRING COMMENT 'The number of specialist visits or service encounters approved by the payer under this referral authorization. Used to track utilization against the authorized limit and trigger re-authorization workflows.',
    `cancellation_reason` STRING COMMENT 'The documented reason for cancellation of the referral order when order_status is cancelled. Captures clinical, administrative, or patient-driven reasons for cancellation to support quality improvement and operational analytics.',
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
    `receiving_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the specialist or receiving provider to whom the patient is referred. Required for payer authorization and claims adjudication.. Valid values are `^[0-9]{10}$`',
    `referral_disposition` STRING COMMENT 'The outcome or final disposition of the referral as reported by the receiving provider. Indicates whether the specialist accepted, declined, completed, or the patient did not attend. Used for referral loop closure tracking and quality reporting.. Valid values are `pending|accepted|declined|completed|cancelled|no_show`',
    `referral_loop_closed` BOOLEAN COMMENT 'Indicates whether the referring provider has received and acknowledged the specialists consultation report, closing the referral communication loop. A key quality metric for NCQA HEDIS and PCMH accreditation.',
    `referral_number` STRING COMMENT 'Externally visible, human-readable business identifier for the referral order. Used in payer communications, patient correspondence, and cross-system tracking (e.g., Salesforce Health Cloud, Epic Orders). Format: REF- followed by 10 digits.. Valid values are `^REF-[0-9]{10}$`',
    `referral_reason_description` STRING COMMENT 'Free-text clinical narrative describing the reason for the referral, supplementing the ICD-10 code. Captures clinical context not fully expressed by the diagnosis code, such as symptom progression, treatment failure, or specific clinical question for the specialist.',
    `referral_source` STRING COMMENT 'The clinical setting or care context from which the referral originated. Indicates whether the referral was initiated by a Primary Care Physician (PCP), Emergency Department (ED), inpatient unit, specialist, patient self-referral, or care program enrollment.. Valid values are `PCP|ED|inpatient|specialist|self|care_program`',
    `referral_type` STRING COMMENT 'Categorizes the nature of the referral: to a specialist, external provider, care program, second opinion, or for a specific diagnostic workup. Used for operational routing and analytics segmentation.. Valid values are `specialist|external_provider|care_program|second_opinion|diagnostic`',
    `referring_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier (NPI) of the referring provider as registered with CMS. Required on CMS-1500 and UB-04 claim forms and payer authorization requests.. Valid values are `^[0-9]{10}$`',
    `scheduled_appointment_date` DATE COMMENT 'The date on which the patients appointment with the receiving specialist or provider has been scheduled. Used to measure time-to-appointment and referral fulfillment timeliness.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral order record was last modified in the lakehouse Silver layer. Supports change detection and incremental processing.',
    `urgency_level` STRING COMMENT 'Clinical priority level assigned to the referral order by the referring provider. Drives scheduling priority at the receiving provider and payer authorization turnaround time requirements. Values: routine, urgent, stat, emergent.. Valid values are `routine|urgent|stat|emergent`',
    `visits_used` STRING COMMENT 'The number of authorized visits that have been consumed against this referral to date. Compared against authorized_visits to determine remaining utilization and trigger re-authorization alerts.',
    CONSTRAINT pk_referral_order PRIMARY KEY(`referral_order_id`)
) COMMENT 'Clinical order for patient referral to a specialist, external provider, or care program. Captures referring provider NPI, receiving provider NPI, specialty type, referral reason (ICD-10 coded), urgency level, authorization requirement flag, payer authorization number, referral expiration date, number of authorized visits, referral source (PCP, ED, inpatient), and referral disposition (accepted, declined, pending, completed). Integrates with Salesforce Health Cloud Referral Management and payer authorization workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`set_item` (
    `set_item_id` BIGINT COMMENT 'Unique identifier for the order set item. Primary key for this entity.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Individual order set items (e.g., post-op follow-up, procedure prep) specify a required appointment type for downstream scheduling automation. Clinical informaticists building CPOE order sets associat',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Order set items must map to CDM (charge description master) entries for automated charge capture configuration. Revenue cycle and clinical informatics teams maintain this mapping to ensure order set i',
    `clinician_id` BIGINT COMMENT 'Identifier of the user who created this order set item. Supports accountability and audit requirements for clinical content governance.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Each order set item representing a procedure must link to a CPT code for charge capture validation, RVU-based cost estimation, and order set governance review. Clinical informatics teams require this ',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Order set medication items must be validated against the pharmacy drug master during P&T committee review and formulary updates. Pharmacy clinical informatics teams require this link to identify order',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Order set items have diagnosis_criteria governing conditional inclusion. Linking to icd_code normalizes this condition logic, enabling CDS rule engines to evaluate medical necessity and supporting ord',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Order set items for laboratory orders must reference LOINC codes per FHIR PlanDefinition and HL7 order catalog standards. Lab interoperability, result routing, and quality measure inclusion all requir',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Order set items for medication orders must reference NDC codes for formulary validation, drug interaction checking, and medication safety alerts at order set build time. Pharmacy informatics requires ',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: Order set items for imaging procedures must reference the radiology protocol to enforce standardized exam execution in CPOE-driven workflows. ACR and Joint Commission require protocol compliance; link',
    `set_id` BIGINT COMMENT 'Reference to the parent order set that contains this item. Links this item to its containing order set bundle.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: CPOE order set build and execution: each lab-type set_item must reference the test_catalog entry to enforce specimen requirements, methodology, and collection instructions at order time. Order set gov',
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
    `order_description` STRING COMMENT 'Human-readable description of the order item. Displayed to clinicians during order set selection and order entry.',
    `order_type` STRING COMMENT 'Category of clinical order represented by this item. Determines which fulfillment system and workflow will process the order.. Valid values are `laboratory|radiology|pharmacy|procedure|referral|nursing`',
    `patient_instruction_text` STRING COMMENT 'Instructions intended for the patient regarding this order (e.g., fasting requirements, preparation steps, post-procedure care). May be printed on patient education materials.',
    `requires_authorization` BOOLEAN COMMENT 'Indicates whether this order item requires prior authorization from the payer before it can be performed. Used for revenue cycle and utilization management.',
    `requires_consent` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required before this order can be performed. Used for high-risk procedures and research protocols.',
    `sequence_number` STRING COMMENT 'Ordinal position of this item within the parent order set. Determines the display and execution order of items in the set.',
    `set_item_status` STRING COMMENT 'Current lifecycle status of this order set item. Only active items are available for use in clinical order entry.. Valid values are `active|inactive|retired|draft|under_review`',
    `specimen_type` STRING COMMENT 'Type of biological specimen required for laboratory orders (e.g., blood, urine, tissue, swab). Used for specimen collection and handling instructions.',
    `version_number` STRING COMMENT 'Version identifier for this order set item configuration. Supports change tracking and audit requirements for clinical content management.',
    `weight_max_kg` DECIMAL(18,2) COMMENT 'Maximum patient weight in kilograms for which this order item is appropriate. Used for weight-based dosing and inclusion rules. Null indicates no maximum weight restriction.',
    `weight_min_kg` DECIMAL(18,2) COMMENT 'Minimum patient weight in kilograms for which this order item is appropriate. Used for weight-based dosing and inclusion rules. Null indicates no minimum weight restriction.',
    CONSTRAINT pk_set_item PRIMARY KEY(`set_item_id`)
) COMMENT 'Individual order line within an order set, defining each component order that is pre-configured for a care pathway. Captures the parent order set, sequence number, order type, default values (dose, frequency, priority, route), mandatory vs. optional flag, conditional inclusion logic (e.g., if lab value exceeds threshold then include order), conditional logic trigger criteria, age/weight/diagnosis-based inclusion rules, clinical rationale, and alternative order options. Enables granular management of order set content and supports clinical decision support (CDS) rule evaluation at the item level. SSOT for the composition and conditional logic of order set bundles.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`fulfillment` (
    `fulfillment_id` BIGINT COMMENT 'Unique identifier for the order fulfillment record. Primary key.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key reference to the clinical order that was fulfilled. Links to the originating order in the order management system.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Charge capture at fulfillment links completed service to CPT master for accurate billing, RVU calculation, reimbursement determination, and revenue cycle management. Essential for financial reconcilia',
    `demographics_id` BIGINT COMMENT 'Foreign key reference to the patient for whom the order was fulfilled. Links fulfillment to the patient master record.',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Medication order fulfillment-to-dispense reconciliation is a core pharmacy operations process. Linking fulfillment to dispense_event enables charge capture validation, medication turnaround time repor',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider, technician, or clinician who performed or completed the fulfillment. May be a lab technician, radiologist, pharmacist, or other clinical staff.',
    `fulfillment_ordering_provider_clinician_id` BIGINT COMMENT 'Foreign key reference to the provider who originally placed the clinical order. Distinct from the fulfilling provider.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: DME, supplies, and ambulance service fulfillment require HCPCS code linkage to master for pricing determination, coverage validation, and billing compliance. Critical for non-physician service revenue',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Fulfillment records require ICD diagnosis codes for medical necessity validation, charge capture, and claims submission. Revenue cycle and compliance teams require diagnosis coding at the fulfillment ',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Radiology charge capture and fulfillment reconciliation require directly linking a fulfillment record to the specific imaging order it satisfies. RIS/billing workflows verify that each imaging_order h',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Place-of-service billing (CMS requirement), network adequacy reporting, and operational throughput analytics require the specific location where a service was fulfilled. A revenue cycle expert would c',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Fulfillment of lab orders must carry LOINC codes for result reporting, HL7 ORU message generation, and CMS quality measure reporting. Lab directors and informaticists expect LOINC on every fulfilled l',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medication order fulfillment (administration) must reference NDC codes for medication administration records (MAR), 340B drug tracking, DEA controlled substance reporting, and pharmacy charge capture ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Revenue cycle and claims processing require knowing which organizational provider performed/fulfilled the service. Credentialing compliance audits verify the performing facility was credentialed. perf',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the specimen collected and used for fulfillment. Primarily applicable to laboratory and pathology orders. Links to specimen tracking systems.',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: When a standing order is executed by nursing or ancillary staff, a fulfillment record is created to capture the completion event. The fulfillment table currently links only to clinical_order, but stan',
    `charge_amount` DECIMAL(18,2) COMMENT 'The gross charge amount associated with the fulfillment event. Represents the list price from the Charge Description Master (CDM) before adjustments, discounts, or contractual allowances.',
    `charge_capture_flag` BOOLEAN COMMENT 'Boolean indicator of whether a billable charge was captured for this fulfillment event. Used for revenue cycle management and billing reconciliation.',
    `charge_code` STRING COMMENT 'The internal charge code or CDM code associated with the fulfilled service. Links to the Charge Description Master for billing and revenue cycle processing.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when this fulfillment record was first created in the data system. Audit trail field for data lineage and record lifecycle tracking.',
    `datetime` TIMESTAMP COMMENT 'The date and time when the order was fulfilled or completed by the fulfilling department. This is the principal business event timestamp representing when the work was performed.',
    `exception_reason_code` STRING COMMENT 'Standardized code indicating why the order was not fulfilled as originally ordered. Used when status is cancelled, failed, or partial. Maps to internal exception reason reference data.',
    `exception_reason_description` STRING COMMENT 'Free-text description of the exception or reason why the order was not fulfilled as ordered. Provides additional context beyond the standardized exception reason code.',
    `fulfilled_quantity` DECIMAL(18,2) COMMENT 'The actual quantity or amount fulfilled by the performing department. May differ from ordered quantity in cases of partial fulfillment, substitution, or unavailability.',
    `fulfillment_status` STRING COMMENT 'Current status of the fulfillment event. Indicates whether the order was fully completed, partially fulfilled, cancelled, failed, or is still in progress.. Valid values are `completed|partial|cancelled|failed|in_progress|pending`',
    `method` STRING COMMENT 'The method or process used to fulfill the order. Indicates whether the fulfillment was performed manually, using automated equipment, at point of care, or outsourced to an external provider.. Valid values are `manual|automated|semi_automated|point_of_care|external_lab|outsourced`',
    `modifier_codes` STRING COMMENT 'Comma-separated list of CPT or HCPCS modifier codes applied to the procedure. Modifiers provide additional information about the service performed (e.g., bilateral procedure, multiple procedures).',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the fulfilling provider or technician. May include technical details, observations, or special handling instructions relevant to the fulfillment.',
    `number` STRING COMMENT 'Business identifier for the fulfillment event. Human-readable unique number assigned by the fulfilling department or system (e.g., lab accession number, radiology case number, pharmacy dispense number).',
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
    CONSTRAINT pk_fulfillment PRIMARY KEY(`fulfillment_id`)
) COMMENT 'Transactional record capturing the completion or execution of a clinical order by the fulfilling department, serving as the order domains acknowledgment that downstream work was performed. Captures fulfillment datetime, fulfilling provider or technician, fulfillment location, fulfillment method, actual vs. ordered quantity, partial fulfillment indicator, fulfillment notes, exception reason if the order was not fulfilled as ordered, fulfillment status, and turnaround time (order-to-fulfillment elapsed time). Bridges the order intent (clinical_order) with the result or dispensing event in downstream domains (laboratory, radiology, pharmacy). SSOT boundary: this product tracks fulfillment status and timing from the order perspective only. Detailed result data (lab values, imaging reports, dispensing records) is owned by the respective downstream domain — laboratory, radiology, or pharmacy.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`standing_order` (
    `standing_order_id` BIGINT COMMENT 'Unique identifier for the standing order record. Primary key.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Standing orders (protocol-driven recurring orders) must reference CDM entries to configure automated charge generation rules. Revenue cycle requires this link to ensure each standing order protocol ma',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician or advanced practice provider who authorized this standing order protocol.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Standing orders are governed by specific policies defining scope, approval process, and usage criteria. Policy framework for standing order programs ensures regulatory compliance and clinical governan',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Standing orders for procedures (e.g., recurring wound care, routine vitals) require CPT coding for billing authorization, RVU tracking, and compliance with CMS coverage policies. Clinical operations a',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Standing medication orders (PRN protocols, insulin sliding scales) must reference the pharmacy drug master for formulary compliance validation by the Pharmacy & Therapeutics committee. medication_name',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Standing medication orders require direct formulary validation to ensure protocol-driven medications are formulary-approved. This supports pharmacy formulary compliance audits and P&T committee review',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Standing order protocols must align with payer coverage policies to ensure reimbursement and avoid denials. Real-world process: protocol committees review payer policies when creating standing orders ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Standing orders are activated by clinical conditions (diagnoses). Linking to icd_code normalizes the clinical_indication field, enabling condition-based activation logic, medical necessity documentati',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Protocol-driven lab orders in standing order protocols require LOINC linkage for standardized test ordering, interoperability, results interpretation, and quality measure reporting. Supports evidence-',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Standing medication orders reference specific NDC drugs. The existing medication_name column is a denormalized drug name; normalizing via ndc_drug_id enables formulary validation, drug interaction che',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Standing orders are approved and scoped to specific organizational providers (e.g., a hospitals nursing protocols). Regulatory compliance audits, medical staff governance, and Joint Commission accred',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: Standing imaging orders (e.g., ICU daily chest X-ray, annual screening mammography) must reference the specific radiology protocol to ensure consistent exam parameters across recurring executions. Rad',
    `set_id` BIGINT COMMENT 'Foreign key linking to order.order_set. Business justification: Standing orders are frequently governed and bundled within order sets (e.g., a sepsis protocol order set includes standing orders for vitals monitoring, IV fluids, and blood cultures). Linking standin',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Standing orders are specialty-driven protocols (ED standing orders for chest pain, ICU sepsis protocols). Specialty governance committees approve and audit standing order usage by specialty. Required ',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Standing lab orders (e.g., daily CBC, weekly BMP) must reference the test_catalog to define which specific test recurs, its specimen type, turnaround expectations, and collection instructions. Protoco',
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
    CONSTRAINT pk_standing_order PRIMARY KEY(`standing_order_id`)
) COMMENT 'Master record for pre-authorized, protocol-driven orders that can be executed by nursing or ancillary staff without individual provider sign-off for each instance. Captures protocol name, authorizing provider, applicable patient population criteria, order parameters (drug, dose, frequency, lab test, intervention), activation conditions, maximum duration, renewal requirements, and approval status. Supports nurse-initiated protocols, ED standing orders, and population health standing order programs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`diet_order` (
    `diet_order_id` BIGINT COMMENT 'Unique identifier for the diet order record. Primary key for the diet order entity.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Heart failure, diabetes, and renal care plans include diet orders as structured interventions. Care plan adherence reporting and readmission reduction programs require linking diet orders to their car',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: diet_order is a specialized type of clinical order (dietary orders for inpatient/observation patients). Linking to clinical_order as the parent order record establishes the subtype relationship. This ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom this diet order is prescribed. Links to the patient master record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Dietitian-driven care and CMS condition-specific diet protocols (e.g., renal diet for CKD, cardiac diet for CHF) require linking the diet order to the specific diagnosis instance driving the dietary r',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Enteral and parenteral nutrition services are billed using HCPCS codes (e.g., B4000-series). Dietitians and revenue cycle teams require HCPCS coding on diet orders for CMS claims, prior authorization ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Therapeutic diet medical necessity documentation requires ICD-10 linkage for compliance with nutrition care standards, quality reporting, and reimbursement for medical nutrition therapy. Supports clin',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Diet orders may reference specific nutritional supplements, enteral feeding formulas, or feeding tube supplies by catalog number. Links clinical nutrition order to supply chain for fulfillment and cha',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician who ordered the diet. Links to the provider master record.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Pre-procedure NPO diet orders and post-surgical diet initiations are directly triggered by a scheduled appointment. Care coordinators and dietitians require this link to associate diet orders with the',
    `superseded_diet_order_id` BIGINT COMMENT 'Self-referencing FK on diet_order (superseded_diet_order_id)',
    `adt_event_id` BIGINT COMMENT 'Foreign key linking to encounter.adt_event. Business justification: Pre-operative NPO orders and diet changes on unit transfer are directly triggered by specific ADT events. Nutrition care documentation and pre-procedure compliance audits require linking the diet orde',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Nutritional care planning and Joint Commission nutrition screening compliance require linking diet orders to the specific diagnosis driving them (e.g., renal diet for CKD, diabetic diet for DM). Quali',
    `visit_id` BIGINT COMMENT 'Reference to the inpatient or observation encounter during which this diet order is active. Links to the encounter record.',
    `allergen_exclusions` STRING COMMENT 'Comma-separated list of food allergens that must be excluded from the diet such as peanuts, tree nuts, shellfish, dairy, eggs, soy, wheat, or fish. Cross-referenced with patient allergy records.',
    `calorie_target` STRING COMMENT 'Target daily caloric intake in kilocalories prescribed for the patient based on nutritional assessment and clinical needs.',
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
    `supplement_frequency` STRING COMMENT 'Frequency of nutritional supplement administration such as once daily, twice daily, three times daily, with meals, or between meals.',
    `supplement_name` STRING COMMENT 'Name of the prescribed oral nutritional supplement such as Ensure, Boost, Glucerna, or specialized formulas for enteral nutrition support.',
    `texture_modification` STRING COMMENT 'Specification of food texture modifications required for safe swallowing such as pureed, mechanical soft, minced, ground, or chopped. Used for patients with dysphagia or chewing difficulties.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this diet order record was last modified in the data platform.',
    CONSTRAINT pk_diet_order PRIMARY KEY(`diet_order_id`)
) COMMENT 'Clinical dietary orders for inpatient and observation patients specifying diet type, texture modifications, fluid restrictions, allergen avoidance, and nutritional supplements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`therapy_order` (
    `therapy_order_id` BIGINT COMMENT 'Unique identifier for the therapy order. Primary key for the therapy order product.',
    `clinical_order_id` BIGINT COMMENT 'Reference to the parent or original therapy order if this order is a renewal, modification, or continuation of a previous order.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Therapy service specification links therapy type to CPT master for scheduling, authorization submission, charge capture, and reimbursement. Essential for therapy department operations and revenue cycl',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Physical, occupational, and speech therapy services are billed using HCPCS codes for Medicare/Medicaid claims. Prior authorization, therapy cap tracking, and functional reporting requirements all depe',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: PT/OT/ST therapy authorization and medical necessity require valid ICD-10 diagnosis linkage. Payers validate diagnosis for therapy approval, and providers track diagnosis for functional outcome measur',
    `insurance_coverage_id` BIGINT COMMENT 'Reference to the payer authorization record if prior authorization was obtained for this therapy order.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Therapy orders (PT/OT/ST) are tracked for rehabilitation quality measures, functional outcome metrics, and post-acute care quality reporting. CMS IRF-PAI and SNF quality measures require therapy order',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom the therapy order is placed.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Therapy orders (PT, OT, ST) are directed to specific therapy facilities or hospital departments. Prior authorization, network participation verification, and claims require knowing which org provider ',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who ordered the therapy service.',
    `set_id` BIGINT COMMENT 'Reference to the order set or care pathway if this therapy order was generated as part of a standardized order set.',
    `superseded_therapy_order_id` BIGINT COMMENT 'Self-referencing FK on therapy_order (superseded_therapy_order_id)',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Therapy is delivered at a specific care location. Patient scheduling, network directory accuracy, and place-of-service billing require the specific location. Therapy benefit management and prior auth ',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether payer authorization or prior approval is required before the therapy service can be performed.',
    `body_site` STRING COMMENT 'The anatomical location or body site that is the focus of the therapy service (e.g., left knee, right shoulder, lower back).',
    `cancellation_reason` STRING COMMENT 'The reason why the therapy order was cancelled, such as patient refusal, medical contraindication, or change in treatment plan.',
    `cancelled_datetime` TIMESTAMP COMMENT 'The date and time when the therapy order was cancelled, if applicable.',
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
    CONSTRAINT pk_therapy_order PRIMARY KEY(`therapy_order_id`)
) COMMENT 'Clinical orders for physical therapy, occupational therapy, speech therapy, and respiratory therapy services including frequency, duration, and treatment goals.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`order`.`set` (
    `set_id` BIGINT COMMENT 'Unique surrogate identifier for the order set record in the lakehouse Silver layer. Primary key for the order_set data product.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: Order sets designed for specific appointment types (annual wellness visit order set, pre-operative order set) standardize care delivery. Linking order sets to appointment types enables protocol-driven',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: DRG-based order sets support case management, utilization review, and cost containment initiatives. Links protocol to DRG master for expected LOS management, resource utilization tracking, and bundled',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Health systems create plan-specific order sets for value-based care contracts, formulary compliance, and coverage optimization. Real-world process: clinical informatics teams build order sets aligned ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Order set activation logic depends on diagnosis-driven protocol triggering. Links to ICD-10 master enables automated clinical pathway initiation, evidence-based care delivery, and quality measure comp',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Order sets are governed and owned by specific organizational providers. CMS core measure compliance, formulary alignment, and medical staff governance require knowing which org owns each order set. ow',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician or clinical leader who formally approved the order set on behalf of the approving committee. Supports governance accountability and regulatory audit requirements.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR PlanDefinition (the standard representation of order sets) uses SNOMED CT to define the clinical condition triggering the order set. CDS Hooks, clinical pathway governance, and ONC interoperabili',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Order sets are specialty-specific clinical protocols (cardiology admission order sets, oncology treatment pathways). Healthcare organizations maintain specialty-based order set libraries, track specia',
    `approval_date` DATE COMMENT 'Date on which the approving clinical committee formally approved the current version of the order set. Establishes the official governance record for audit and regulatory reporting purposes.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the order set within the clinical governance process. Drives whether the order set is available for provider use in CPOE. draft = under development; pending_review = submitted to approving committee; approved = active and available; retired = superseded; suspended = temporarily withdrawn.. Valid values are `draft|pending_review|approved|retired|suspended`',
    `approving_committee` STRING COMMENT 'Name of the clinical governance committee or body responsible for reviewing and approving the order set (e.g., Pharmacy and Therapeutics Committee, Medical Executive Committee, Clinical Quality Council). Required for Joint Commission accreditation and CMS Conditions of Participation compliance.',
    `care_pathway_name` STRING COMMENT 'Name of the clinical care pathway or protocol bundle with which this order set is associated (e.g., Sepsis Care Pathway, Hip Replacement Enhanced Recovery After Surgery (ERAS) Pathway). Links the executable order bundle to the broader clinical protocol framework.',
    `care_setting` STRING COMMENT 'Clinical care setting in which the order set is intended to be used. Restricts order set availability to appropriate clinical contexts within the EHR. inpatient = admitted patients; outpatient = clinic/ambulatory; emergency = Emergency Department (ED); icu = Intensive Care Unit (ICU); surgical = Operating Room (OR)/perioperative; observation = observation status.. Valid values are `inpatient|outpatient|emergency|icu|surgical|observation`',
    `clinical_indication` STRING COMMENT 'Free-text or structured description of the clinical condition, diagnosis, or scenario that triggers activation of this order set (e.g., Suspected sepsis with organ dysfunction, Acute ST-elevation myocardial infarction). Complements the ICD-10 trigger code.',
    `compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of triggered clinical scenarios where the order set was activated by providers, as reported by the EHR analytics module. Sourced from Epic reporting or Cerner analytics — not computed in the lakehouse. Supports HEDIS, MIPS, and VBP quality measure reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order set record was first created in the source system or lakehouse. Supports audit trail requirements per HIPAA Security Rule, Joint Commission, and HIM governance policies.',
    `set_description` STRING COMMENT 'Detailed narrative description of the order sets clinical purpose, intended patient population, and scope of included orders. Supports clinical documentation improvement (CDI) and provider education.',
    `effective_date` DATE COMMENT 'Date on which the order set version becomes clinically effective and available for provider use in CPOE. Aligns with the approved go-live date established by the governing clinical committee.',
    `evidence_level` STRING COMMENT 'Strength of clinical evidence supporting the order set, using standard evidence grading. A = strong evidence from multiple randomized controlled trials; B = moderate evidence; C = limited evidence; D = very limited evidence; expert_consensus = based on expert opinion in absence of trials. Supports quality measurement and regulatory reporting.. Valid values are `A|B|C|D|expert_consensus`',
    `expiration_date` DATE COMMENT 'Date on which the order set version expires and is no longer valid for clinical use. Null indicates no scheduled expiration. Triggers mandatory review workflow when approaching expiration per clinical governance policy.',
    `fhir_plan_definition_reference` STRING COMMENT 'HL7 FHIR PlanDefinition resource identifier corresponding to this order set, enabling interoperability with Health Information Exchange (HIE) platforms and external clinical decision support systems. Aligns with HL7 FHIR R4 PlanDefinition resource.',
    `governance_level` STRING COMMENT 'Classification of the governance authority underpinning the order set protocol. guideline = based on published clinical practice guidelines; consensus = based on institutional expert consensus without external guideline; regulatory_mandate = required by CMS, Joint Commission, or other regulatory body (e.g., CMS Core Measures, EMTALA requirements).. Valid values are `guideline|consensus|regulatory_mandate`',
    `guideline_reference` STRING COMMENT 'Citation or reference to the external clinical practice guideline, systematic review, or regulatory mandate that underpins the order set (e.g., Surviving Sepsis Campaign 2021 Guidelines, AHA/ACC STEMI Management Guidelines 2023, CMS Sepsis Core Measure SEP-1). Supports clinical documentation improvement (CDI) and regulatory compliance.',
    `includes_lab_orders` BOOLEAN COMMENT 'Indicates whether the order set bundle contains laboratory orders routed to Beaker (LIS) or equivalent Laboratory Information System (LIS). True = lab orders present; False = no lab orders included.',
    `includes_pharmacy_orders` BOOLEAN COMMENT 'Indicates whether the order set bundle contains medication orders routed to Willow (pharmacy) or equivalent pharmacy system. True = pharmacy/medication orders present; False = no pharmacy orders included. Relevant for DEA controlled substance tracking.',
    `includes_radiology_orders` BOOLEAN COMMENT 'Indicates whether the order set bundle contains radiology/imaging orders routed to Radiant (RIS) or equivalent Radiology Information System (RIS). True = radiology orders present; False = no radiology orders included.',
    `includes_referral_orders` BOOLEAN COMMENT 'Indicates whether the order set bundle contains referral orders to specialists or ancillary services. True = referral orders present; False = no referral orders included. Supports care coordination and transitions of care workflows.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the order set is currently active and available for selection in the CPOE workflow. True = active and selectable by providers; False = inactive and hidden from the order entry interface. Distinct from approval_status — an approved order set may be temporarily deactivated without retiring it.',
    `is_cms_core_measure` BOOLEAN COMMENT 'Indicates whether this order set is directly associated with a CMS Core Measure or quality reporting requirement (e.g., SEP-1 Sepsis Bundle, VTE Prophylaxis). True = linked to a CMS Core Measure; False = not a CMS Core Measure order set. Supports quality measurement and regulatory reporting.',
    `is_hipaa_sensitive` BOOLEAN COMMENT 'Indicates whether the order set is associated with HIPAA-sensitive clinical categories requiring enhanced access controls (e.g., behavioral health, substance use disorder, HIV/AIDS, reproductive health). True = sensitive category requiring additional PHI protections; False = standard clinical order set.',
    `last_review_date` DATE COMMENT 'Date of the most recent clinical review of the order set, regardless of whether a version change resulted. Supports mandatory periodic review cycles (typically annual) required by Joint Commission and institutional policy.',
    `set_name` STRING COMMENT 'Human-readable name of the pre-defined, evidence-based order set bundle as displayed in the Computerized Physician Order Entry (CPOE) interface (e.g., Sepsis Bundle — Adult ICU, Community-Acquired Pneumonia Admission Orders).',
    `next_review_date` DATE COMMENT 'Date by which the next mandatory clinical review of the order set must be completed. Drives governance workflow alerts and ensures compliance with periodic review requirements per Joint Commission and institutional policy.',
    `order_count` STRING COMMENT 'Total number of individual clinical orders (lab, radiology, pharmacy, nursing, referral) included in the order set bundle. Provides a quick indicator of order set complexity and scope for provider review.',
    `order_set_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the order set within the source system (e.g., Epic Orders catalog ID or Cerner Millennium order set mnemonic). Used for cross-system referencing and integration with Beaker (LIS), Radiant (RIS), and Willow (pharmacy).',
    `order_set_type` STRING COMMENT 'Classification of the order set by its clinical purpose in the care continuum. admission = admission orders bundle; discharge = discharge planning orders; procedure = pre/intra/post-procedure orders; condition = condition-specific management bundle; preventive = preventive care protocol; transition = transitions of care orders.. Valid values are `admission|discharge|procedure|condition|preventive|transition`',
    `owning_department` STRING COMMENT 'Name of the clinical department or service line that owns and is responsible for maintaining the order set (e.g., Department of Cardiology, Emergency Medicine, Pharmacy). Establishes accountability for content governance and periodic review.',
    `population_age_group` STRING COMMENT 'Target patient age group for which the order set is clinically appropriate. Restricts order set availability to appropriate patient populations in CPOE. pediatric = patients under 18; adult = 18-64; geriatric = 65+; neonatal = newborns; all = all age groups.. Valid values are `pediatric|adult|geriatric|neonatal|all`',
    `renal_adjustment_required` BOOLEAN COMMENT 'Indicates whether the order set contains medications requiring renal function-based dose adjustments (e.g., creatinine clearance-based dosing). True = renal adjustment logic embedded; False = no renal adjustment required. Supports clinical decision support (CDS) alerts in CPOE.',
    `source_system_code` STRING COMMENT 'Native identifier of the order set in the originating operational system (e.g., Epic Orders internal record ID, Cerner Millennium order set catalog ID). Supports ETL lineage tracking and cross-system reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the order set record in the source system or lakehouse. Supports change tracking, audit trail requirements, and ETL incremental load processing.',
    `usage_count` STRING COMMENT 'Cumulative count of the number of times this order set version has been activated by providers in CPOE. Supports utilization analytics, adoption tracking, and clinical quality improvement initiatives. Not a calculated aggregate — sourced directly from the EHR order set activation log.',
    `version_number` STRING COMMENT 'Semantic version number of the order set (e.g., 1.0, 2.3, 3.1.2). Incremented upon each approved revision to support version control, audit trails, and rollback capabilities per Health Information Management (HIM) governance requirements.. Valid values are `^d+.d+(.d+)?$`',
    `weight_based_dosing` BOOLEAN COMMENT 'Indicates whether any pharmacy orders within the order set use weight-based dosing calculations (e.g., mg/kg). True = weight-based dosing required; False = fixed dosing. Critical for pediatric and oncology order sets and for pharmacy safety validation in Willow/PharmNet.',
    CONSTRAINT pk_set PRIMARY KEY(`set_id`)
) COMMENT 'Master record for pre-defined, evidence-based bundles of clinical orders (order sets) and their governing clinical protocols and care pathways. Captures order set name, clinical indication, specialty, version number, effective and expiration dates, approval status, approving committee, evidence-based guideline reference, associated DRG or care pathway, active/inactive flag, protocol governance attributes (governance level — guideline, consensus, regulatory mandate), clinical condition or diagnosis trigger (ICD-10), applicable care setting, owning clinical department, evidence level, parent protocol hierarchy, and approval workflow status. SSOT for both the executable order bundle and the clinical policy that governs its activation. Managed in Epic Orders and Cerner Millennium.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_parent_order_clinical_order_id` FOREIGN KEY (`parent_order_clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_standing_order_id` FOREIGN KEY (`standing_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`standing_order`(`standing_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_superseded_diet_order_id` FOREIGN KEY (`superseded_diet_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`diet_order`(`diet_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_superseded_therapy_order_id` FOREIGN KEY (`superseded_therapy_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`therapy_order`(`therapy_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`order` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Indication Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `parent_order_clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Source Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `tertiary_clinical_authorizing_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `triage_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Triage Assessment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Cancelled Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_business_glossary_term' = 'Clinical Decision Support (CDS) Alert Response');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_decision_support_alert` SET TAGS ('dbx_value_regex' = 'no_alert|alert_accepted|alert_overridden|alert_cancelled');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `clinical_indication_text` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication Free Text');
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
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'STAT|routine|urgent|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled|on_hold|discontinued');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Start Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `stop_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Stop Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `order_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status History ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Decision Support (CDS) Alert ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Health Level Seven (HL7) Message ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `cds_alert_overridden` SET TAGS ('dbx_business_glossary_term' = 'Clinical Decision Support (CDS) Alert Overridden Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `cosignature_required` SET TAGS ('dbx_business_glossary_term' = 'Co-Signature Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `cosignature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Co-Signature Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'CI|CII|CIII|CIV|CV');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `discontinuation_type` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `effective_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Event Effective Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Order Event Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `hipaa_audit_category` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Audit Category');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `hipaa_audit_category` SET TAGS ('dbx_value_regex' = 'ACCESS|MODIFICATION|DISCLOSURE|CORRECTION|DELETION');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `is_verbal_order` SET TAGS ('dbx_business_glossary_term' = 'Verbal Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modified_field_name` SET TAGS ('dbx_business_glossary_term' = 'Modified Field Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Modifying Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `modifying_user_role` SET TAGS ('dbx_business_glossary_term' = 'Modifying User Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Field Value');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `new_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `new_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'ROUTINE|URGENT|STAT|ASAP');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'CDS Alert Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `override_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `override_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `previous_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Field Value');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `previous_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `previous_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `reason_text` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Free Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `reason_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `reason_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `renewal_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `transmission_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Transmission Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Order Transmission Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `transmission_status` SET TAGS ('dbx_value_regex' = 'SENT|PENDING|FAILED|ACKNOWLEDGED|NOT_REQUIRED');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `verbal_order_authentication_datetime` SET TAGS ('dbx_business_glossary_term' = 'Verbal Order Authentication Datetime');
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ALTER COLUMN `workstation_code` SET TAGS ('dbx_business_glossary_term' = 'Workstation ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason Icd10 Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving (Specialist) Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Ct Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Payer Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `authorized_visits` SET TAGS ('dbx_business_glossary_term' = 'Number of Authorized Visits');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Disposition Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `first_available_date` SET TAGS ('dbx_business_glossary_term' = 'Specialist First Available Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `is_stat_order` SET TAGS ('dbx_business_glossary_term' = 'STAT Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `loop_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Loop Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Placed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_business_glossary_term' = 'Order Source System');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|MEDITECH|Salesforce|manual');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Receiving Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `receiving_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
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
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `scheduled_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Referred Appointment Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Referral Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|emergent');
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ALTER COLUMN `visits_used` SET TAGS ('dbx_business_glossary_term' = 'Referral Visits Used');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` SET TAGS ('dbx_subdomain' = 'protocol_configuration');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Item Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_max_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_max_years` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_min_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age in Years');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `age_min_years` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `alternative_order_options` SET TAGS ('dbx_business_glossary_term' = 'Alternative Order Options');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Body Site');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `conditional_inclusion_logic` SET TAGS ('dbx_business_glossary_term' = 'Conditional Inclusion Logic');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `contrast_indicator` SET TAGS ('dbx_business_glossary_term' = 'Contrast Indicator');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_dose` SET TAGS ('dbx_business_glossary_term' = 'Default Dose');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_duration` SET TAGS ('dbx_business_glossary_term' = 'Default Duration');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_frequency` SET TAGS ('dbx_business_glossary_term' = 'Default Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('dbx_business_glossary_term' = 'Default Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap|timed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_quantity` SET TAGS ('dbx_business_glossary_term' = 'Default Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `default_route` SET TAGS ('dbx_business_glossary_term' = 'Default Route');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Criteria');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `diagnosis_criteria` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Instruction Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_default_selected` SET TAGS ('dbx_business_glossary_term' = 'Default Selected Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|unilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_description` SET TAGS ('dbx_business_glossary_term' = 'Order Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'laboratory|radiology|pharmacy|procedure|referral|nursing');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `patient_instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Patient Instruction Text');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_authorization` SET TAGS ('dbx_business_glossary_term' = 'Requires Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `requires_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('dbx_business_glossary_term' = 'Order Set Item Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `set_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|under_review');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `weight_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ALTER COLUMN `weight_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight in Kilograms (kg)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` SET TAGS ('dbx_subdomain' = 'service_execution');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilling Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_ordering_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_capture_flag` SET TAGS ('dbx_business_glossary_term' = 'Charge Capture Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `exception_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfilled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Quantity');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'completed|partial|cancelled|failed|in_progress|pending');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'manual|automated|semi_automated|point_of_care|external_lab|outsourced');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `modifier_codes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier Codes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Number');
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
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ALTER COLUMN `updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` SET TAGS ('dbx_subdomain' = 'protocol_configuration');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `activation_condition` SET TAGS ('dbx_business_glossary_term' = 'Activation Condition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `applicable_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Applicable Population Criteria');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `authorized_role` SET TAGS ('dbx_business_glossary_term' = 'Authorized Role');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
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
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Medication Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `medication_route` SET TAGS ('dbx_business_glossary_term' = 'Medication Route');
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
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` SET TAGS ('dbx_subdomain' = 'service_execution');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Diet Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Indication Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `superseded_diet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Diet Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `superseded_diet_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Adt Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `allergen_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Allergen Exclusions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `calorie_target` SET TAGS ('dbx_business_glossary_term' = 'Daily Calorie Target');
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
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `npo_reason` SET TAGS ('dbx_business_glossary_term' = 'Nothing by Mouth (NPO) Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `npo_status` SET TAGS ('dbx_business_glossary_term' = 'Nothing by Mouth (NPO) Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `protein_target_grams` SET TAGS ('dbx_business_glossary_term' = 'Daily Protein Target in Grams');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `source_system_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Supplement Frequency');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `supplement_name` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Supplement Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `texture_modification` SET TAGS ('dbx_business_glossary_term' = 'Texture Modification');
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` SET TAGS ('dbx_subdomain' = 'service_execution');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_order_id` SET TAGS ('dbx_business_glossary_term' = 'Therapy Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Diagnosis Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Therapy Order Id');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `superseded_therapy_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Therapy Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `body_site` SET TAGS ('dbx_business_glossary_term' = 'Body Site');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `completed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Completed Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `duration_unit` SET TAGS ('dbx_business_glossary_term' = 'Duration Unit');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `duration_unit` SET TAGS ('dbx_value_regex' = 'minutes|hours');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `duration_value` SET TAGS ('dbx_business_glossary_term' = 'Duration Value');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Therapy End Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Frequency Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `frequency_description` SET TAGS ('dbx_business_glossary_term' = 'Frequency Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Order');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_datetime` SET TAGS ('dbx_business_glossary_term' = 'Order Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_mode` SET TAGS ('dbx_business_glossary_term' = 'Order Mode');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_mode` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|home_health|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Therapy Order Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Therapy Order Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|active|on-hold|completed|cancelled|discontinued');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `patient_instructions` SET TAGS ('dbx_business_glossary_term' = 'Patient Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `sessions_completed` SET TAGS ('dbx_business_glossary_term' = 'Sessions Completed');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `sessions_remaining` SET TAGS ('dbx_business_glossary_term' = 'Sessions Remaining');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `source_system_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Therapy Start Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_code` SET TAGS ('dbx_business_glossary_term' = 'Therapy Service Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_service_description` SET TAGS ('dbx_business_glossary_term' = 'Therapy Service Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('dbx_business_glossary_term' = 'Therapy Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `therapy_type` SET TAGS ('dbx_value_regex' = 'physical_therapy|occupational_therapy|speech_therapy|respiratory_therapy');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `total_sessions_ordered` SET TAGS ('dbx_business_glossary_term' = 'Total Sessions Ordered');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('dbx_business_glossary_term' = 'Treatment Goal');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `treatment_goal` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` SET TAGS ('dbx_subdomain' = 'protocol_configuration');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Default Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `formulary_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `formulary_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd10 Trigger Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Order Set Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Order Set Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|retired|suspended');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `approving_committee` SET TAGS ('dbx_business_glossary_term' = 'Approving Clinical Committee');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_pathway_name` SET TAGS ('dbx_business_glossary_term' = 'Associated Care Pathway Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Applicable Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|icu|surgical|observation');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Order Set Compliance Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_description` SET TAGS ('dbx_business_glossary_term' = 'Order Set Description');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Order Set Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `evidence_level` SET TAGS ('dbx_business_glossary_term' = 'Evidence Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `evidence_level` SET TAGS ('dbx_value_regex' = 'A|B|C|D|expert_consensus');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Order Set Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `fhir_plan_definition_reference` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) PlanDefinition ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `governance_level` SET TAGS ('dbx_business_glossary_term' = 'Protocol Governance Level');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `governance_level` SET TAGS ('dbx_value_regex' = 'guideline|consensus|regulatory_mandate');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `guideline_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence-Based Guideline Reference');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `includes_lab_orders` SET TAGS ('dbx_business_glossary_term' = 'Includes Laboratory Orders Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `includes_pharmacy_orders` SET TAGS ('dbx_business_glossary_term' = 'Includes Pharmacy Orders Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `includes_radiology_orders` SET TAGS ('dbx_business_glossary_term' = 'Includes Radiology Orders Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `includes_referral_orders` SET TAGS ('dbx_business_glossary_term' = 'Includes Referral Orders Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Order Set Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `is_cms_core_measure` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Core Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `is_hipaa_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Sensitive Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Clinical Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `set_name` SET TAGS ('dbx_business_glossary_term' = 'Order Set Name');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `order_set_code` SET TAGS ('dbx_business_glossary_term' = 'Order Set Code');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `order_set_type` SET TAGS ('dbx_business_glossary_term' = 'Order Set Type');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `order_set_type` SET TAGS ('dbx_value_regex' = 'admission|discharge|procedure|condition|preventive|transition');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `owning_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Clinical Department');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `population_age_group` SET TAGS ('dbx_business_glossary_term' = 'Target Population Age Group');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `population_age_group` SET TAGS ('dbx_value_regex' = 'pediatric|adult|geriatric|neonatal|all');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `population_age_group` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `renal_adjustment_required` SET TAGS ('dbx_business_glossary_term' = 'Renal Dose Adjustment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Order Set ID');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Order Set Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Order Set Version Number');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ALTER COLUMN `weight_based_dosing` SET TAGS ('dbx_business_glossary_term' = 'Weight-Based Dosing Flag');
