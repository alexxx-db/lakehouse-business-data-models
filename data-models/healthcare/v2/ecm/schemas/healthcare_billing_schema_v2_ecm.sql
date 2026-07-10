-- Schema for Domain: billing | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`billing` COMMENT 'SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charge` (
    `charge_id` BIGINT COMMENT 'Unique identifier for the charge record. Primary key for the charge entity. System-generated surrogate key used to uniquely identify each billable charge transaction in the revenue cycle management system.',
    `bed_id` BIGINT COMMENT 'Foreign key linking to facility.bed. Business justification: Bed-level charge attribution supports accurate accommodation billing with ICU/step-down differential rates, bed utilization analysis for capacity planning, and matching charges to patient location for',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Charges are captured with knowledge of which insurance coverage will be billed. FK links charge to the specific patient-payer-plan coverage instance. Cardinality: N charges : 1 coverage. No columns re',
    `care_site_id` BIGINT COMMENT 'Reference to the originating department or service line where the charge was generated. Used for cost center allocation and departmental revenue reporting.',
    `case_cart_id` BIGINT COMMENT 'Foreign key linking to the surgical case cart from which supplies were consumed',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Every billable charge references a CDM (Charge Description Master) entry for pricing, coding, and revenue classification. CDM is the authoritative catalog. FK allows retrieval of cdm_description, reve',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider who performed or supervised the billable service. Used for professional billing and National Provider Identifier (NPI) reporting.',
    `charge_ordering_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who ordered the service or procedure. Required for certain claim types and medical necessity validation.',
    `claim_id` BIGINT COMMENT 'Reference to the claim on which this charge was submitted to the payer. Links charge to claim for payment posting and denial management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Charges must track originating cost center for cost accounting, profitability analysis by department, variance reporting against budget, and contribution margin analysis. Required for departmental per',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Charges use CPT codes for procedure billing. Existing cpt_code column is denormalized string; FK enables validation against current CPT reference, RVU lookup, and NCCI edit checking required for clean',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Medication charges require drug master reference for NDC validation, formulary compliance, and accurate revenue capture. Essential for charge audits, coding accuracy, and payer claim submission where ',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who voided the charge. Used for audit trail and compliance tracking.',
    `fulfillment_id` BIGINT COMMENT 'Foreign key linking to order.order_fulfillment. Business justification: Charge-on-fulfillment workflows require linking charges to specific fulfillment events for accurate revenue recognition timing, reconciling billed services to delivered services, and supporting charge',
    `guarantor_id` BIGINT COMMENT 'Reference to the party financially responsible for the charge. May be the patient or another individual/entity.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Charges use HCPCS codes for supplies, DME, and non-physician services billing. Existing hcpcs_code column is denormalized string; FK enables validation, pricing lookup, and coverage determination requ',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Charges must reference the specific patient insurance coverage active at service time for accurate claim submission, adjudication, and coordination of benefits. Critical for revenue cycle operations a',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Charges for implantable devices, supplies, and drugs require direct material master linkage for accurate billing, cost accounting, UDI tracking, NDC billing compliance, and revenue cycle analytics. Es',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received the billable service or supply. Links charge to the patient master record.',
    `original_charge_id` BIGINT COMMENT 'Reference to the original charge record that this charge corrects. Used to maintain audit trail when charges are corrected rather than voided.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Outpatient pharmacy charges originate from prescriptions. Required for charge reconciliation, audit trails linking billable services to clinical orders, and dispute resolution when patients or payers ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Charges require validated diagnosis codes for medical necessity determination, claims adjudication, and compliance. Diagnosis_pointer references position in diagnosis list; need FK to actual ICD code ',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Room-level charge capture is necessary for accurate accommodation billing (room and board charges), matching charges to patient location for claim accuracy, and supporting room-specific rate different',
    `scheduling_appointment_id` BIGINT COMMENT 'add column scheduling_appointment_id (BIGINT) with FK to scheduling.scheduling_appointment.scheduling_appointment_id - charges often originate from scheduled appointments and this link is missing for revenue cycle reconciliation',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Charges require specialty attribution for RVU-based physician fee schedule lookups (specialty-specific conversion factors), network adequacy reporting by specialty, prior authorization rules (specialt',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Medical necessity validation and compliance audits require linking procedure charges to documented treatment consent. Payers deny claims without proof of informed consent for procedures. Essential for',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Charges originate from specific clinical units (ED, ICU, OR, etc.). Unit-level attribution is required for departmental profitability analysis, cost accounting, staffing productivity models, and charg',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter or visit during which this charge was generated. Links the charge to the clinical episode of care.',
    `charge_category` STRING COMMENT 'High-level grouping of the charge for financial reporting and analytics. Examples include surgical services, diagnostic imaging, laboratory, pharmacy, room and board.',
    `charge_code` STRING COMMENT 'Internal charge code from the Charge Description Master (CDM). Maps to procedure codes, revenue codes, and pricing schedules. Core reference for billing and reimbursement.',
    `correction_reason` STRING COMMENT 'Explanation for why the charge was corrected. Examples: incorrect code, incorrect quantity, incorrect provider. Required for compliance and audit purposes when is_corrected is true.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the charge record was first created in the billing system. Used for audit trail, charge lag analysis, and data lineage tracking.',
    `diagnosis_pointer` STRING COMMENT 'Reference to the diagnosis code(s) that justify medical necessity for this charge. Typically a comma-separated list of pointers (e.g., 1,2,3) linking to diagnosis codes on the claim.',
    `drug_unit_of_measure` STRING COMMENT 'Unit of measure for pharmaceutical charges. Examples: ML (milliliters), GR (grams), UN (units), F2 (international units). Required for NDC billing.',
    `expected_reimbursement_amount` DECIMAL(18,2) COMMENT 'Estimated payment amount based on payer contract, fee schedule, or payment methodology. Used for revenue forecasting and variance analysis. May be derived from DRG grouper, fee schedule lookup, or contract rate.',
    `gross_charge_amount` DECIMAL(18,2) COMMENT 'Total charge amount before any adjustments, discounts, or contractual allowances. Calculated as quantity multiplied by unit price. Represents the full standard charge.',
    `hold_date` DATE COMMENT 'Date the charge was placed on hold. Used to track charge lag and identify revenue cycle bottlenecks.',
    `hold_reason` STRING COMMENT 'Explanation for why the charge is on hold and not released for billing. Examples: pending authorization, missing documentation, coding review required, medical necessity review.',
    `implant_flag` BOOLEAN COMMENT 'Indicates whether this charge represents an implantable device from the case cart requiring UDI documentation and FDA tracking. Used for regulatory compliance and implant registry reporting.',
    `is_billable` BOOLEAN COMMENT 'Flag indicating whether this charge should be included on patient claims. Some charges may be tracked for cost accounting but not billed to payers (e.g., bundled services, courtesy charges).',
    `is_corrected` BOOLEAN COMMENT 'Flag indicating whether this charge is a correction of a previously posted charge. Corrected charges replace original charges and maintain audit trail linkage.',
    `is_patient_responsible` BOOLEAN COMMENT 'Flag indicating whether the patient has financial responsibility for this charge. Used to determine patient statement inclusion and collections workflow.',
    `is_voided` BOOLEAN COMMENT 'Flag indicating whether this charge has been voided and should not be included in financial reporting or claim submission. Voided charges are retained for audit trail purposes.',
    `modifier_1` STRING COMMENT 'First CPT or HCPCS modifier providing additional information about the service performed. Used to indicate special circumstances, bilateral procedures, or multiple procedures.',
    `modifier_2` STRING COMMENT 'Second CPT or HCPCS modifier providing additional information about the service performed.',
    `modifier_3` STRING COMMENT 'Third CPT or HCPCS modifier providing additional information about the service performed.',
    `modifier_4` STRING COMMENT 'Fourth CPT or HCPCS modifier providing additional information about the service performed.',
    `ndc_code` STRING COMMENT 'National Drug Code for pharmaceutical charges. Required for drug billing to Medicare Part B and Medicaid. Identifies the specific drug product, manufacturer, and package size.',
    `number` STRING COMMENT 'Human-readable business identifier for the charge. May be used for charge reconciliation, audit trails, and external communication. Typically system-generated or derived from encounter number and line sequence.',
    `place_of_service_code` STRING COMMENT 'Two-digit code identifying the location where the service was provided. Required on professional claims. Examples: 11 (office), 21 (inpatient hospital), 22 (outpatient hospital), 23 (emergency department).',
    `posting_date` DATE COMMENT 'Date the charge was posted to the patient account in the billing system. Used for revenue cycle reporting, aging analysis, and financial period assignment. May differ from service date due to charge lag.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units of the service or supply provided. Used to calculate extended charge amount. May represent minutes, units, visits, or other unit of measure depending on the charge type.',
    `quantity_used` DECIMAL(18,2) COMMENT 'Number of units of the supply item consumed from this specific case cart and billed on this charge. May differ from quantity picked if partial usage or waste occurred. Used for supply chain reconciliation and charge validation.',
    `released_date` DATE COMMENT 'Date the charge was released from hold and made available for claim submission. Used to calculate days in accounts receivable and charge lag metrics.',
    `revenue_code` STRING COMMENT 'Three-digit code used on UB-04 facility claims to classify the type of service or accommodation provided. Required for hospital billing.',
    `service_date` DATE COMMENT 'Date on which the billable service or supply was provided to the patient. Used for claim submission, timely filing, and revenue recognition. Critical for determining billing period and payer coverage.',
    `service_end_time` TIMESTAMP COMMENT 'Timestamp when the service ended. Used for time-based billing, anesthesia minutes, and critical care time tracking.',
    `service_start_time` TIMESTAMP COMMENT 'Timestamp when the service began. Used for time-based billing, anesthesia minutes, and critical care time tracking.',
    `charge_status` STRING COMMENT 'Current lifecycle status of the charge in the revenue cycle. Indicates whether the charge is awaiting review, posted to account, submitted on claim, paid by payer, or voided/corrected. [ENUM-REF-CANDIDATE: pending|posted|billed|paid|adjusted|voided|corrected|on_hold|denied — 9 candidates stripped; promote to reference product]',
    `charge_type` STRING COMMENT 'Classification of the charge based on billing type. Determines claim form (CMS-1500 vs UB-04), revenue recognition rules, and reporting category.. Valid values are `professional|facility|ancillary|pharmacy|supply|accommodation`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the service or supply as defined in the Charge Description Master (CDM) or fee schedule. Used to calculate gross charge amount before adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the charge record was last modified. Used for audit trail, change tracking, and incremental data processing.',
    `void_date` DATE COMMENT 'Date the charge was voided in the billing system. Used for audit trail and financial period reconciliation.',
    `void_reason` STRING COMMENT 'Explanation for why the charge was voided. Examples: duplicate charge, service not performed, incorrect patient, incorrect code. Required for compliance and audit purposes when is_voided is true.',
    `waste_flag` BOOLEAN COMMENT 'Indicates whether the supply item from this case cart was opened but not used (wasted) versus actually consumed. Critical for supply chain waste tracking and determining whether the charge should be billed to the patient or absorbed as facility cost.',
    CONSTRAINT pk_charge PRIMARY KEY(`charge_id`)
) COMMENT 'Core transactional record of every billable charge captured in the revenue cycle. Represents a single billable service, procedure, supply, or accommodation generated from clinical activity. Owns charge code (CDM reference), quantity, unit price, revenue code, service date, posting date, charge status, voided/corrected flag, and originating department. SSOT for charge capture in Epic Resolute PB/HB and Cerner Revenue Cycle. Links to encounter, rendering provider, CDM entry, and fee schedule for expected reimbursement. Governance note: this product has 27 outgoing foreign keys, above the recommended maximum of 25; consider splitting into multiple products or refactoring as a junction table.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` (
    `cdm_entry_id` BIGINT COMMENT 'Unique identifier for the CDM entry. Primary key for the charge description master catalog.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: CDM entries map internal charge codes to CPT codes for billing. Existing cpt_code is denormalized string; FK enables automated price updates when CPT RVUs change, ensures valid billable codes, and sup',
    `care_site_id` BIGINT COMMENT 'add column facility_care_site_id (BIGINT) with FK to facility.care_site.care_site_id - CDM entries vary by facility but cdm_entry lacks a direct care_site FK (site_cdm_pricing exists as a bridge but the base CDM should also have a default s',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: CDM entries map to HCPCS codes for supplies and DME pricing. Existing hcpcs_code is denormalized string; FK enables automated pricing updates, ensures valid codes, and supports charge master maintenan',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: CDM entries for chargeable supplies, drugs, and implants must link to material master to maintain pricing consistency, automate charge capture, support supply cost vs. charge analysis, and enable char',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this CDM entry. Used for accountability and audit compliance.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the clinical or operational department that owns and delivers this CDM item. Links to the department master for organizational reporting.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this CDM entry is currently active and available for charge capture. Inactive items cannot be billed.',
    `apc_code` STRING COMMENT 'Four-digit APC code used for outpatient prospective payment system (OPPS) reimbursement. Groups similar services for payment purposes.. Valid values are `^[0-9]{4}$`',
    `bundled_payment_flag` BOOLEAN COMMENT 'Indicates whether this CDM item is included in bundled payment arrangements and should not be separately billed in certain contexts.',
    `cdm_code` STRING COMMENT 'The unique alphanumeric code assigned to this billable item in the CDM. Used as the primary lookup key for charge capture and billing.',
    `cdm_description` STRING COMMENT 'Full text description of the billable service or supply item. Provides human-readable detail for billing and reporting.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Standard gross charge amount for this CDM item in US dollars. Represents the list price before contractual adjustments or discounts.',
    `charge_capture_method` STRING COMMENT 'Method by which charges for this CDM item are typically captured: manual entry, system interface, order-driven, implant log, supply chain integration, or pharmacy system.. Valid values are `manual|interface|order_driven|implant_log|supply_chain|pharmacy`',
    `charge_category` STRING COMMENT 'Billing category indicating the care setting or encounter type for which this CDM item is applicable. Determines claim form and billing rules. [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|observation|ambulatory_surgery|home_health|hospice — 7 candidates stripped; promote to reference product]',
    `cost_amount` DECIMAL(18,2) COMMENT 'Estimated cost to the organization for providing this service or supply. Used for margin analysis and cost accounting.',
    `cost_center_code` STRING COMMENT 'General ledger cost center code to which revenue and expenses for this CDM item are posted. Used for financial accounting and budget tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CDM entry record was first created in the system. Used for audit trail and data lineage.',
    `default_quantity` DECIMAL(18,2) COMMENT 'Default quantity to be charged when this CDM item is ordered without an explicit quantity. Typically 1.0 for most services.',
    `drg_weight` DECIMAL(18,2) COMMENT 'Relative weight assigned to this CDM item for DRG-based reimbursement calculation. Used in inpatient prospective payment system (IPPS).',
    `effective_date` DATE COMMENT 'Date on which this CDM entry becomes active and available for use in charge capture and billing.',
    `expiration_date` DATE COMMENT 'Date on which this CDM entry expires and is no longer available for charge capture. Null indicates no expiration.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue recognition. Maps CDM charges to the appropriate revenue account in the chart of accounts.',
    `item_type` STRING COMMENT 'Classification of the CDM item by type: service (professional procedure), supply (consumable), drug (pharmaceutical), implant (surgical device), device (durable equipment), accommodation (room/bed), or ancillary (diagnostic/therapeutic support). [ENUM-REF-CANDIDATE: service|supply|drug|implant|device|accommodation|ancillary — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this CDM entry record was last updated. Used for change tracking and audit compliance.',
    `last_price_update_date` DATE COMMENT 'Date when the charge amount for this CDM item was last updated. Used for price change tracking and audit compliance.',
    `modifier_1` STRING COMMENT 'Primary two-character CPT or HCPCS modifier that provides additional information about the service or circumstance. Used for claim adjudication.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_2` STRING COMMENT 'Secondary two-character CPT or HCPCS modifier for additional service detail. Used when multiple modifiers are required.. Valid values are `^[A-Z0-9]{2}$`',
    `ndc_code` STRING COMMENT 'Eleven-digit National Drug Code for pharmaceutical items. Required for drug billing and pharmacy claims. Null for non-drug items.. Valid values are `^[0-9]{11}$`',
    `notes` STRING COMMENT 'Free-text notes or comments about this CDM entry. Used for special billing instructions, coding guidance, or administrative remarks.',
    `place_of_service_code` STRING COMMENT 'Two-digit code identifying the location where this service is typically rendered (e.g., 11=office, 21=inpatient hospital, 22=outpatient hospital).. Valid values are `^[0-9]{2}$`',
    `price_transparency_flag` BOOLEAN COMMENT 'Indicates whether this CDM item must be included in public price transparency disclosures per CMS regulations.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this CDM item is associated with quality measurement programs such as HEDIS, MIPS, or hospital value-based purchasing.',
    `requires_authorization_flag` BOOLEAN COMMENT 'Indicates whether this CDM item typically requires prior authorization from payers before service delivery. Used for authorization workflow triggers.',
    `revenue_code` STRING COMMENT 'Four-digit UB-04 revenue code that classifies the type of service or accommodation for facility billing. Required for hospital claims submission.. Valid values are `^[0-9]{4}$`',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'Malpractice RVU component representing professional liability insurance cost for this service. Used for reimbursement calculation.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'Practice expense RVU component representing overhead costs for this service. Used for reimbursement calculation.',
    `rvu_work` DECIMAL(18,2) COMMENT 'Work RVU component representing physician time, effort, and skill required for this service. Used for physician compensation and productivity tracking.',
    `short_description` STRING COMMENT 'Abbreviated description of the CDM item for display on patient statements and condensed reports.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether this CDM item is subject to sales tax or other applicable taxes. Used for patient billing and revenue accounting.',
    `type_of_bill_code` STRING COMMENT 'Three-digit code on UB-04 claim form indicating facility type, care type, and billing frequency. Determines claim processing rules.. Valid values are `^[0-9]{3}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for billing this CDM item (e.g., each, unit, dose, hour, day). Defines the quantity basis for charge calculation. [ENUM-REF-CANDIDATE: each|unit|dose|hour|day|visit|procedure|test|mile|liter — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_cdm_entry PRIMARY KEY(`cdm_entry_id`)
) COMMENT 'Charge Description Master (CDM) — the authoritative catalog of all billable items offered by the healthcare organization. Each entry defines a service or supply with its CDM code, description, revenue code, default CPT/HCPCS code, charge amount, cost center, department, active status, and effective/expiration dates. Managed in Epic Resolute HB and 3M HIS. Serves as the pricing and coding reference for charge capture.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice record. Primary key for the invoice entity representing a professional or facility bill generated for a patient encounter or episode of care.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Patient invoices create AR accounts in the general ledger. Required for aging analysis, collection tracking, cash application, allowance for doubtful accounts, and GAAP-compliant revenue recognition i',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Claims submission workflow: invoices are transmitted as CDA documents (e.g., CMS-1500, UB-04 electronic equivalents) to payers and HIEs for adjudication. Tracking which CDA document represents each in',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Invoices are billing-side representations of claims submitted to payers. Revenue cycle reconciliation, claim-to-cash tracking, and payment variance analysis require linking invoices to their correspon',
    `clinician_id` BIGINT COMMENT 'Reference to the provider or organization submitting the bill. Holds the National Provider Identifier (NPI) for the billing entity on the claim form.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Invoices selected for compliance audit sampling (RAC, MAC, internal billing audits, accreditation surveys) must link to the audit record for documentation, sample frame tracking, extrapolation calcula',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoices should track responsible cost center for revenue attribution, departmental performance measurement, cost-to-collect analysis, and profitability reporting by service line or department. Requir',
    `fhir_resource_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_resource_log. Business justification: FHIR-based claims submission: invoices transmitted as FHIR Claim resources require tracking which fhir_resource_log entry represents the submission. Enables monitoring submission status, retry logic, ',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for payment of this invoice. May be the patient or another party who has accepted financial responsibility.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Invoices are adjudicated against specific health plan benefits, fee schedules, and coverage rules. Real-world claims processing requires plan-level detail for benefit determination, allowed amount cal',
    `payer_id` BIGINT COMMENT 'Reference to the secondary insurance payer for this invoice. The second payer in the coordination of benefits sequence, billed after primary payer adjudication.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received services and is responsible for or associated with this invoice. Primary party for billing purposes.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Institutional claims (UB-04 forms) are billed by organizational providers. Invoice must reference org_provider_id to identify the billing facility for hospital inpatient/outpatient claims, validate NP',
    `primary_payer_id` BIGINT COMMENT 'Reference to the primary insurance payer for this invoice. The first payer in the coordination of benefits sequence responsible for adjudicating the claim.',
    `provider_location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Place of service on claims must reference specific provider location for accurate reimbursement (facility vs non-facility rates differ significantly), network validation (location-specific contracts),',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Referral orders generate separate professional service invoices; billing departments track referral-specific revenue, authorization compliance, and payer-specific referral billing rules by linking inv',
    `tertiary_payer_id` BIGINT COMMENT 'Reference to the tertiary insurance payer for this invoice. The third payer in the coordination of benefits sequence, billed after secondary payer adjudication.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter for which this invoice was generated. Links the invoice to the clinical encounter that generated the charges.',
    `admission_source_code` STRING COMMENT 'Code indicating the source of the admission for facility claims. Examples: 1=Non-Healthcare Facility, 2=Clinic, 4=Transfer from Hospital, 5=Transfer from SNF, 7=Emergency Room.. Valid values are `^[0-9A-Z]{1,2}$`',
    `admission_type_code` STRING COMMENT 'Single-digit code indicating the priority of the admission for facility claims. 1=Emergency, 2=Urgent, 3=Elective, 4=Newborn, 5=Trauma, 9=Information Not Available.. Valid values are `1|2|3|4|5|9`',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The maximum amount the payer will reimburse for the services on this invoice based on the contracted rate or fee schedule. Total charges minus contractual adjustment.',
    `appeal_date` DATE COMMENT 'The date an appeal was submitted to the payer for a denied or underpaid claim. Tracks the start of the appeals process in denial management workflow.',
    `appeal_status` STRING COMMENT 'Current status of the appeal process for a denied claim. Tracks whether an appeal has been filed and the outcome of the appeal.. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied|appeal_partially_approved`',
    `bad_debt_amount` DECIMAL(18,2) COMMENT 'The dollar amount written off as bad debt. Represents uncollectible patient responsibility that is removed from accounts receivable and recorded as bad debt expense.',
    `bad_debt_date` DATE COMMENT 'The date the outstanding balance was written off as bad debt after exhausting collection efforts. Represents the date the account was deemed uncollectible.',
    `bill_type_code` STRING COMMENT 'Three-digit code on UB-04 facility claims indicating the type of facility, type of care, and billing sequence. First digit = facility type, second digit = care type, third digit = billing sequence.. Valid values are `^[0-9]{3}$`',
    `claim_control_number` STRING COMMENT 'Unique identifier assigned by the payer to track the claim through adjudication. Also known as Document Control Number (DCN) or Internal Control Number (ICN). Returned on ERA/EOB.',
    `clearinghouse_name` STRING COMMENT 'The name of the claims clearinghouse used to transmit the claim to the payer, if applicable. Clearinghouses validate, format, and route claims to multiple payers.',
    `collection_status` STRING COMMENT 'Current status of collection efforts for outstanding patient balances. Tracks aging and escalation of unpaid patient responsibility amounts. [ENUM-REF-CANDIDATE: current|past_due_30|past_due_60|past_due_90|past_due_120|in_collections|bad_debt|write_off — 8 candidates stripped; promote to reference product]',
    `contractual_adjustment` DECIMAL(18,2) COMMENT 'The write-off amount representing the difference between billed charges and the contracted reimbursement rate with the payer. Reflects negotiated discounts per payer contracts.',
    `covered_charges` DECIMAL(18,2) COMMENT 'The portion of total charges that are covered by the patients insurance plan. Represents charges eligible for payer reimbursement under the coverage terms.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this invoice record was first created in the revenue cycle system. Audit trail for record creation.',
    `invoice_date` DATE COMMENT 'The date the invoice was generated and finalized for submission. Represents the formal billing document creation date.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason the claim was denied or rejected by the payer. Used for denial management and appeals. Examples: CO-16=Claim lacks information, PR-1=Deductible.',
    `denial_reason_description` STRING COMMENT 'Human-readable description of the denial reason provided by the payer. Provides additional context beyond the denial reason code for revenue cycle staff.',
    `discharge_status_code` STRING COMMENT 'Two-digit code indicating the patient status at discharge for facility claims. Examples: 01=Home, 02=Transfer to Short-Term Hospital, 03=SNF, 07=Left AMA, 20=Expired, 30=Still Patient.. Valid values are `^[0-9]{2}$`',
    `drg_code` STRING COMMENT 'Three-digit code representing the DRG assignment for facility inpatient claims. Used by Medicare and other payers for prospective payment system reimbursement. Assigned by 3M grouper software.. Valid values are `^[0-9]{3}$`',
    `drg_weight` DECIMAL(18,2) COMMENT 'Relative weight assigned to the DRG code reflecting the expected resource consumption for this case. Used to calculate Medicare reimbursement by multiplying the base rate by the DRG weight.',
    `form_type` STRING COMMENT 'The standardized claim form type used for this invoice. CMS-1500 for professional billing, UB-04 for facility billing, ADA-2012 for dental, NCPDP for pharmacy.. Valid values are `CMS-1500|UB-04|ADA-2012|NCPDP`',
    `insurance_payment` DECIMAL(18,2) COMMENT 'The total amount paid by the insurance payer(s) toward this invoice. Sum of all insurance payments posted from Electronic Remittance Advice (ERA) or manual payment posting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time this invoice record was last modified. Audit trail for tracking changes to the invoice throughout its lifecycle.',
    `non_covered_charges` DECIMAL(18,2) COMMENT 'The portion of total charges that are not covered by the patients insurance plan. Represents charges that are patient responsibility or not eligible for payer reimbursement.',
    `number` STRING COMMENT 'Externally-known unique business identifier for the invoice. Used for patient communication, payer correspondence, and revenue cycle tracking. Human-readable invoice reference number.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'The remaining unpaid balance on this invoice after all payments and adjustments. Represents the current amount due from all responsible parties.',
    `patient_payment` DECIMAL(18,2) COMMENT 'The total amount paid by the patient toward this invoice. Sum of all patient payments including copays collected at time of service and subsequent patient payments.',
    `patient_responsibility` DECIMAL(18,2) COMMENT 'The total amount the patient is responsible to pay, including deductibles, copayments, coinsurance, and non-covered charges. Calculated after insurance adjudication.',
    `place_of_service_code` STRING COMMENT 'Two-digit code on CMS-1500 professional claims identifying the location where services were rendered. Examples: 11=Office, 21=Inpatient Hospital, 22=Outpatient Hospital, 23=Emergency Room.. Valid values are `^[0-9]{2}$`',
    `revenue_code` STRING COMMENT 'Four-digit code on UB-04 facility claims identifying the specific accommodation, ancillary service, or billing calculation related to the charge. Examples: 0110=Room & Board Private, 0450=Emergency Room, 0636=Drugs.. Valid values are `^[0-9]{4}$`',
    `service_from_date` DATE COMMENT 'The start date of the service period covered by this invoice. For single-day encounters, equals service_through_date. For multi-day stays, represents admission or first service date.',
    `service_through_date` DATE COMMENT 'The end date of the service period covered by this invoice. For single-day encounters, equals service_from_date. For multi-day stays, represents discharge or last service date.',
    `statement_date` DATE COMMENT 'The date a patient statement was generated and sent for this invoice. Tracks patient billing communication in the revenue cycle.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the revenue cycle management workflow. Tracks the invoice from creation through final disposition. [ENUM-REF-CANDIDATE: draft|ready_to_bill|submitted|accepted|rejected|paid|partially_paid|denied|appealed|voided|cancelled — 11 candidates stripped; promote to reference product]',
    `submission_date` DATE COMMENT 'The date the invoice was submitted to the payer as a claim. Represents when the billing document was transmitted electronically or mailed to the insurance company.',
    `submission_method` STRING COMMENT 'The method used to submit the claim to the payer. Electronic 837 transactions are the standard for HIPAA-compliant electronic claims submission.. Valid values are `electronic_837|paper_mail|clearinghouse|direct_payer_portal`',
    `total_charges` DECIMAL(18,2) COMMENT 'The total gross charges for all services on this invoice before any adjustments, discounts, or payments. Sum of all charge line items from the Charge Description Master (CDM).',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the type of services billed. Professional invoices use CMS-1500 form for physician services; facility invoices use UB-04 form for hospital services.. Valid values are `professional|facility|institutional|ancillary|durable_medical_equipment|home_health`',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Professional or facility bill generated for a patient encounter or episode of care. Represents the formal billing document (CMS-1500 for professional billing, UB-04 for facility billing) sent to a payer or patient. Owns bill type (professional/facility), form type (CMS-1500/UB-04), total charges, covered charges, non-covered charges, bill status (draft, ready, submitted, accepted, rejected, paid, denied), bill date, from/through service dates, admission type, discharge status, payer assignment, and billing provider NPI. SSOT for the billing document lifecycle in Epic Resolute PB/HB. The primary entity linking charge capture to claim submission.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for this product.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Invoice line items reference CDM entries for procedure/service definitions. Same pattern as charge → cdm_entry. FK allows retrieval of CDM metadata for billing and reporting. Cardinality: N invoice li',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Invoice lines for pharmacy services must reference drug master to populate accurate NDC codes on insurance claims (CMS and commercial payer requirement). Critical for claim adjudication, pricing valid',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Invoice lines may use HCPCS codes for supplies, DME, and ancillary services. FK enables validation, supports ASC/OPPS payment determination, and ensures accurate reimbursement for non-physician servic',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header. Links this line item to the professional or facility invoice (CMS-1500 or UB-04).',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Invoice lines require validated diagnosis codes for claims submission and adjudication. Diagnosis_pointer references position; FK to actual ICD code enables medical necessity validation, LCD/NCD compl',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Invoice lines bill procedures using CPT codes. Existing procedure_code is denormalized string; FK enables validation against current CPT reference, supports NCCI edits, modifier validation, and accura',
    `adjudicated_timestamp` TIMESTAMP COMMENT 'Date and time when the payer completed adjudication of this line item.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the payer will reimburse for this service based on the contract or fee schedule. May be less than the charge amount.',
    `authorization_number` STRING COMMENT 'Authorization or referral number obtained from the payer prior to service. Required for certain procedures and services.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Total charge amount for this line item before any adjustments. Represents the providers standard charge from the Charge Description Master (CDM).',
    `claim_adjustment_group_code` STRING COMMENT 'High-level category code for claim adjustments (CO=Contractual Obligation, PR=Patient Responsibility, OA=Other Adjustment, PI=Payer Initiated, CR=Correction/Reversal).. Valid values are `^(CO|CR|OA|PI|PR)$`',
    `claim_adjustment_reason_code` STRING COMMENT 'Specific reason code explaining why the claim line was adjusted. Used in conjunction with the adjustment group code.',
    `contractual_adjustment_amount` DECIMAL(18,2) COMMENT 'Write-off amount representing the difference between the charge amount and the allowed amount per payer contract terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was first created in the system.',
    `denial_reason_code` STRING COMMENT 'Code indicating why the line item was denied by the payer. Used for denial management and appeals.',
    `denial_reason_description` STRING COMMENT 'Human-readable description of why the line item was denied. Derived from the denial reason code.',
    `diagnosis_pointer` STRING COMMENT 'Letter(s) indicating which diagnosis code(s) from the invoice header justify this service. Maps to ICD-10 diagnosis codes on the claim (A-L for up to 12 diagnoses).. Valid values are `^[A-L](,[A-L])*$`',
    `drg_weight` DECIMAL(18,2) COMMENT 'Relative weight assigned to this line item for DRG-based reimbursement. Used in inpatient facility billing to calculate payment.',
    `drug_quantity` DECIMAL(18,2) COMMENT 'Quantity of drug administered or dispensed. Used in conjunction with NDC code for pharmaceutical billing.',
    `drug_unit_of_measure` STRING COMMENT 'Two-character code indicating the unit of measure for the drug quantity (e.g., ML=milliliters, GR=grams, UN=units).. Valid values are `^[A-Z]{2}$`',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the order of line items on the claim form.',
    `line_status` STRING COMMENT 'Current processing status of this invoice line item in the revenue cycle workflow. [ENUM-REF-CANDIDATE: pending|submitted|adjudicated|paid|denied|appealed|voided — 7 candidates stripped; promote to reference product]',
    `modifier_1` STRING COMMENT 'Primary two-character CPT or HCPCS modifier code. Provides additional information about the service performed (e.g., bilateral procedure, assistant surgeon).. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_2` STRING COMMENT 'Secondary two-character CPT or HCPCS modifier code. Provides additional information about the service performed.. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_3` STRING COMMENT 'Tertiary two-character CPT or HCPCS modifier code. Provides additional information about the service performed.. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_4` STRING COMMENT 'Quaternary two-character CPT or HCPCS modifier code. Provides additional information about the service performed.. Valid values are `^[0-9A-Z]{2}$`',
    `ndc_code` STRING COMMENT 'Eleven-digit National Drug Code for pharmaceutical products. Required when billing for medications or drugs.. Valid values are `^[0-9]{11}$`',
    `paid_amount` DECIMAL(18,2) COMMENT 'Actual amount paid by the payer for this line item. May differ from allowed amount due to deductibles, coinsurance, or denials.',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time when payment was received from the payer for this line item.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Amount the patient is responsible for paying. Includes deductible, coinsurance, and copayment amounts.',
    `place_of_service_code` STRING COMMENT 'Two-digit code identifying where the service was performed (e.g., 11=Office, 21=Inpatient Hospital, 22=Outpatient Hospital, 23=Emergency Department).. Valid values are `^[0-9]{2}$`',
    `procedure_description` STRING COMMENT 'Human-readable description of the procedure or service performed. Derived from the CPT/HCPCS code.',
    `remittance_advice_remark_code` STRING COMMENT 'Supplemental code providing additional information about claim processing. Used alongside adjustment reason codes.',
    `rendering_provider_npi` STRING COMMENT 'Ten-digit National Provider Identifier (NPI) of the provider who performed the service. Required for claim submission.. Valid values are `^[0-9]{10}$`',
    `revenue_code` STRING COMMENT 'Four-digit revenue code used on facility claims (UB-04) to classify the type of service or accommodation. Not used on professional claims (CMS-1500).. Valid values are `^[0-9]{4}$`',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'Malpractice component of the Relative Value Unit (RVU) for this procedure. Represents professional liability insurance costs.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'Practice expense component of the Relative Value Unit (RVU) for this procedure. Represents overhead costs.',
    `rvu_work` DECIMAL(18,2) COMMENT 'Work component of the Relative Value Unit (RVU) for this procedure. Represents physician effort and time.',
    `service_date` DATE COMMENT 'Date the service or procedure was performed. Used for claim adjudication and timely filing requirements.',
    `service_from_date` DATE COMMENT 'Start date of the service period for multi-day services. Used when a service spans multiple dates.',
    `service_location_code` STRING COMMENT 'Internal code identifying the specific department or location where the service was performed within the facility.',
    `service_to_date` DATE COMMENT 'End date of the service period for multi-day services. Used when a service spans multiple dates.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when this line item was submitted to the payer as part of a claim.',
    `units` DECIMAL(18,2) COMMENT 'Number of units of service provided. May represent quantity, time units (e.g., 15-minute increments), or number of procedures performed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was last modified.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line item on a professional or facility invoice, representing a single procedure, service, or revenue code billed to a payer. Owns line number, CPT/HCPCS code, revenue code, ICD-10 diagnosis pointer, units, charge amount, allowed amount, modifier codes, rendering provider NPI, place of service, and line status. Supports both CMS-1500 and UB-04 line-level detail.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` (
    `coding_assignment_id` BIGINT COMMENT 'Unique identifier for the coding assignment record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Coding errors discovered during compliance audits (RAC, MAC, internal coding audits) must link to specific visit coding assignments for remediation, coder education, and tracking recurrence. Essential',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: DRG assignments must be attributed to the facility for IPPS submissions to CMS, quality measure reporting (Hospital Compare), and facility-level case mix index calculation. Required for Medicare reimb',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Quality reporting and claims submission: coded diagnoses/procedures from coding_assignment populate CDA documents for IQR, PQRS, and claims. Tracking which CDA document contains each coding assignment',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Coding assignments determine DRG, diagnosis, and procedure codes that populate claims. Claim submission workflows depend on finalized coding. Audits and denials often require tracing back to original ',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Coding assignments determine DRG for inpatient reimbursement. Existing drg_code is denormalized string; FK enables lookup of current relative weights, GMLOS, outlier thresholds, and accurate expected ',
    `employee_id` BIGINT COMMENT 'Reference to the certified medical coder who performed the coding assignment.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim associated with this coding assignment, if applicable.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Coding assignments assign principal diagnosis codes for DRG grouping and reimbursement. Existing principal_diagnosis_code is denormalized string; FK enables validation, supports DRG logic, ensures bil',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Coding assignments assign principal procedure codes for DRG grouping. Existing principal_procedure_code is denormalized string; FK enables validation, supports surgical DRG logic, and ensures accurate',
    `visit_id` BIGINT COMMENT 'Reference to the encounter or visit for which this coding assignment was performed.',
    `admission_source_code` STRING COMMENT 'The UB-04 admission source code indicating where the patient was located prior to admission (e.g., emergency department, physician referral, transfer from another facility).',
    `admission_type_code` STRING COMMENT 'The UB-04 admission type code indicating the priority of the admission (e.g., emergency, urgent, elective, newborn).',
    `arithmetic_mean_los` DECIMAL(18,2) COMMENT 'The arithmetic mean length of stay in days for the assigned DRG, used as an alternative benchmark for expected resource utilization.',
    `assignment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the coding assignment was created or last updated in the system.',
    `audit_flag` BOOLEAN COMMENT 'Indicates whether this coding assignment has been flagged for audit or quality review due to complexity, high reimbursement, or random selection.',
    `cdi_drg_impact_amount` DECIMAL(18,2) COMMENT 'The financial impact in USD of the DRG change resulting from the CDI query, calculated as the difference in expected reimbursement between the original and revised DRG.',
    `cdi_physician_response` STRING COMMENT 'The providers response to the CDI query: agree (accepted suggestion), disagree (rejected), no response (unanswered), clarified (provided additional detail), or deferred (escalated).. Valid values are `agree|disagree|no_response|clarified|deferred`',
    `cdi_query_date` DATE COMMENT 'The date on which the CDI query was issued to the provider.',
    `cdi_query_topic` STRING COMMENT 'The clinical topic or condition that was the subject of the CDI query (e.g., sepsis, malnutrition, heart failure specificity).',
    `cdi_query_type` STRING COMMENT 'The type of CDI query issued: compliant (neutral), leading (suggests answer), non-leading (open), multiple choice, or open-ended.. Valid values are `compliant|leading|non-leading|multiple_choice|open_ended`',
    `cdi_response_date` DATE COMMENT 'The date on which the provider responded to the CDI query.',
    `cdi_response_deadline` DATE COMMENT 'The deadline date by which the provider is expected to respond to the CDI query.',
    `cdi_resulting_code_change` STRING COMMENT 'The ICD-10 or CPT code that was added, modified, or removed as a result of the CDI query response.',
    `coding_accuracy_score` DECIMAL(18,2) COMMENT 'A quality score (0-100) representing the accuracy of the coding assignment, typically assigned during coding audits or quality reviews.',
    `coding_date` DATE COMMENT 'The date on which the coding assignment was completed and finalized by the coder.',
    `coding_method` STRING COMMENT 'The method by which the coding assignment was performed: manual (human coder only), automated (AI/NLP engine), computer-assisted (coder with CAC tool), or hybrid.. Valid values are `manual|automated|computer-assisted|hybrid`',
    `coding_status` STRING COMMENT 'The current lifecycle status of the coding assignment: draft, pending review, approved, final, amended, or cancelled.. Valid values are `draft|pending_review|approved|final|amended|cancelled`',
    `complication_comorbidity_flag` BOOLEAN COMMENT 'Indicates whether the encounter includes a diagnosis that qualifies as a complication or comorbidity (CC) affecting DRG assignment and reimbursement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this coding assignment record was first created in the system.',
    `discharge_disposition_code` STRING COMMENT 'The UB-04 discharge disposition code indicating the patients destination or status at discharge (e.g., home, SNF, expired).',
    `expected_reimbursement_amount` DECIMAL(18,2) COMMENT 'The expected reimbursement amount in USD for this DRG assignment based on the DRG weight and the applicable base rate.',
    `geometric_mean_los` DECIMAL(18,2) COMMENT 'The geometric mean length of stay in days for the assigned DRG, used as a benchmark for expected resource utilization.',
    `grouper_version` STRING COMMENT 'The version identifier of the DRG grouper software used to assign the DRG code (e.g., 3M HIS v40.0, CMS Grouper FY2024).',
    `hcpcs_codes` STRING COMMENT 'Comma-separated list of HCPCS Level II codes representing supplies, equipment, drugs, and other services not covered by CPT codes.',
    `major_complication_comorbidity_flag` BOOLEAN COMMENT 'Indicates whether the encounter includes a diagnosis that qualifies as a major complication or comorbidity (MCC) affecting DRG assignment and reimbursement.',
    `mdc_code` STRING COMMENT 'The Major Diagnostic Category code representing the principal body system or disease etiology involved in the encounter.. Valid values are `^(MDC )?(0[0-9]|1[0-9]|2[0-5])$`',
    `mdc_description` STRING COMMENT 'Full text description of the Major Diagnostic Category.',
    `outlier_threshold_amount` DECIMAL(18,2) COMMENT 'The cost threshold amount above which the case qualifies for outlier payment adjustment due to extraordinarily high costs.',
    `present_on_admission_indicators` STRING COMMENT 'Comma-separated list of POA indicator codes (Y, N, U, W, or 1) corresponding to each diagnosis code, indicating whether the condition was present at the time of admission.',
    `secondary_diagnosis_codes` STRING COMMENT 'Comma-separated list of ICD-10-CM secondary diagnosis codes representing coexisting conditions that affect patient care, treatment, or length of stay.',
    `secondary_procedure_codes` STRING COMMENT 'Comma-separated list of ICD-10-PCS or CPT secondary procedure codes representing additional procedures performed during the encounter.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this coding assignment record was last modified in the system.',
    CONSTRAINT pk_coding_assignment PRIMARY KEY(`coding_assignment_id`)
) COMMENT 'Clinical coding record associating ICD-10 diagnosis codes, CPT procedure codes, DRG assignments, HCPCS codes, and CDI query workflows to a specific encounter or invoice. Owns principal and secondary diagnoses, principal and secondary procedures, DRG code, DRG description, DRG type (MS-DRG, APR-DRG), DRG weight, MDC (Major Diagnostic Category), geometric/arithmetic mean LOS, outlier threshold, expected reimbursement, grouper version, assignment date, coder ID, coding method (auto/manual), coding date, and CDI query data (query type — compliant/leading/non-leading, query topic, query date, response deadline, response date, physician response — agree/disagree/no response, resulting code change, DRG impact amount). Managed via 3M HIS DRG grouper, 3M CDI, and Epic HIM module. SSOT for all coded encounter data, DRG assignment, and CDI query tracking — there are no separate DRG or CDI entities. Supports CMI (Case Mix Index) reporting, DRG-based reimbursement calculation, and CDI program performance measurement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment record.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Insurance payments are made under specific coverage. Payment already has payer_id, but coverage is the patient-specific coverage instance. FK links payment to coverage for insurance payments. Cardinal',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Payment reconciliation requires facility-level attribution for multi-site health systems to match remittances to the correct entity, support facility-specific cash flow analysis, and enable accurate r',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: ERA reconciliation: payments are created from inbound 835 ERA messages. Linking payment records to the source message_log enables reconciliation, reprocessing failed ERAs, and auditing payment posting',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for the payment, if different from the patient.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or account balance against which this payment is applied.',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: Payment notification workflow: significant payments (e.g., large patient payments, insurance settlements) trigger Direct messages to care coordinators or referring providers for care coordination. Tra',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or third-party organization making the payment.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Insurance payments must link to the specific coverage policy under which payment was remitted for EOB reconciliation, contract rate verification, and coordination of benefits processing. Essential for',
    `ar_transaction_id` BIGINT COMMENT 'The unique transaction identifier provided by the payment processor or gateway for electronic payments (credit card, EFT). Used for reconciliation and dispute resolution.',
    `employee_id` BIGINT COMMENT 'The identifier of the user or system account that posted the payment to the revenue cycle management system.',
    `payment_era_transaction_ar_transaction_id` BIGINT COMMENT 'The transaction identifier from the Electronic Remittance Advice (ERA) 835 file received from the insurance payer, linking this payment to the payers remittance details.',
    `payment_last_modified_by_user_employee_id` BIGINT COMMENT 'The identifier of the user or system account that last modified the payment record.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of the payment transaction.',
    `payment_patient_mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - payment already has this FK per the listing; verified present. Correction: skipping.',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Payments made as part of a payment plan should link to the plan. FK allows tracking which payments are plan installments vs. ad-hoc payments. Cardinality: N payments : 1 payment plan (one plan receive',
    `remittance_id` BIGINT COMMENT 'Foreign key linking to claim.remittance. Business justification: Payments are posted from remittance advices (835 transactions). Cash application, payment reconciliation, and bank deposit matching require linking payments to the remittance that authorized them. Ess',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this payment, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'The total monetary amount of the payment received, in US dollars (USD). This is the gross payment before any adjustments or allocations.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been applied or allocated to specific charges or account balances, in US dollars (USD).',
    `batch_number` STRING COMMENT 'The identifier of the payment batch or deposit batch in which this payment was grouped for processing and reconciliation.',
    `payment_category` STRING COMMENT 'The financial category or classification of the payment based on patient responsibility and insurance coverage: copay, coinsurance, deductible, full payment, or partial payment.. Valid values are `copay|coinsurance|deductible|full_payment|partial_payment`',
    `channel` STRING COMMENT 'The interface or channel through which the payment was received: web portal, mobile app, mail, in-person at facility, phone, or lockbox service.. Valid values are `web_portal|mobile_app|mail|in_person|phone|lockbox`',
    `check_number` STRING COMMENT 'The check number for payments made by check. Null for non-check payment methods.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `credit_card_last_four` STRING COMMENT 'The last four digits of the credit or debit card number used for the payment, stored for reference and reconciliation purposes. Full card numbers are never stored per PCI DSS compliance.. Valid values are `^[0-9]{4}$`',
    `credit_card_type` STRING COMMENT 'The type or brand of credit or debit card used for the payment: Visa, MasterCard, American Express, Discover, or other. Null for non-card payment methods.. Valid values are `visa|mastercard|amex|discover|other`',
    `payment_date` DATE COMMENT 'The date on which the payment was made or received by the healthcare organization. This is the business event date for the payment transaction.',
    `deposit_date` DATE COMMENT 'The date on which the payment was deposited into the healthcare organizations bank account or financial system.',
    `eft_trace_number` STRING COMMENT 'The trace or reference number for Electronic Funds Transfer (EFT) payments, used for reconciliation and tracking. Null for non-EFT payment methods.',
    `era_file_reference` STRING COMMENT 'The identifier of the ERA 835 file from which this payment record was extracted, used for audit and reconciliation purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was last modified or updated in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `lockbox_number` STRING COMMENT 'The identifier of the lockbox service or location through which the payment was received, if applicable. Null for non-lockbox payments.',
    `method` STRING COMMENT 'The financial instrument or mechanism used to make the payment: Electronic Funds Transfer (EFT), check, credit card, debit card, cash, or wire transfer.. Valid values are `eft|check|credit_card|debit_card|cash|wire_transfer`',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment, including special instructions, reconciliation notes, or explanations for exceptions.',
    `number` STRING COMMENT 'Business-facing unique identifier or reference number for the payment transaction, used for tracking and reconciliation.',
    `posting_date` DATE COMMENT 'The date on which the payment was posted or recorded in the revenue cycle management system and applied to patient or payer accounts.',
    `posting_status` STRING COMMENT 'The status of the payment posting and application process: unposted (not yet recorded), posted (recorded but not applied), partially applied (some amount applied), or fully applied (entire amount allocated).. Valid values are `unposted|posted|partially_applied|fully_applied`',
    `refund_amount` DECIMAL(18,2) COMMENT 'The amount of this payment that has been refunded to the payer or patient, in US dollars (USD). Null if no refund has been issued.',
    `refund_date` DATE COMMENT 'The date on which the refund was issued to the payer or patient. Null if no refund has been issued.',
    `refund_flag` BOOLEAN COMMENT 'Indicates whether a refund has been issued for this payment. True if refunded, False otherwise.',
    `refund_reason` STRING COMMENT 'The business reason or explanation for issuing the refund, such as overpayment, duplicate payment, or service cancellation. Null if no refund has been issued.',
    `reversal_date` DATE COMMENT 'The date on which the payment was reversed or cancelled. Null if the payment has not been reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this payment has been reversed or cancelled. True if reversed, False otherwise.',
    `reversal_reason` STRING COMMENT 'The business reason or explanation for reversing the payment, such as duplicate payment, incorrect amount, or payer request. Null if the payment has not been reversed.',
    `source` STRING COMMENT 'The origin or source of the payment: insurance payer, patient self-pay, guarantor, third-party, government program, or charity care.. Valid values are `insurance|patient|guarantor|third_party|government|charity`',
    `payment_status` STRING COMMENT 'The current lifecycle status of the payment: pending (received but not yet posted), posted (recorded in system), applied (allocated to charges), reversed (payment reversed), refunded (payment returned to payer), or voided (payment cancelled).. Valid values are `pending|posted|applied|reversed|refunded|voided`',
    `payment_type` STRING COMMENT 'The classification or category of the payment: standard (regular payment against charges), prepayment (payment before service), overpayment (excess payment requiring refund), adjustment (correction or write-off), or settlement (negotiated payment).. Valid values are `standard|prepayment|overpayment|adjustment|settlement`',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unapplied or unallocated to specific charges, held as credit on the account, in US dollars (USD).',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of every payment received from a payer or patient against an invoice or account balance. Owns payment source (insurance/patient/guarantor), payment method (EFT, check, credit card, cash), payment amount, payment date, check/EFT number, ERA transaction ID, deposit date, posting date, posting status, and applied balance. SSOT for payment posting in Epic Resolute PB/HB and Cerner Revenue Cycle.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the financial adjustment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this adjustment record in the system.',
    `adjustment_employee_id` BIGINT COMMENT 'Reference to the user or authority who approved the adjustment, required for high-value or sensitive adjustments.',
    `adjustment_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this adjustment record.',
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Billing adjustments (contractual, denials, write-offs) must create offsetting AR transactions for accurate revenue reporting, GAAP compliance, allowance for doubtful accounts, and financial statement ',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Adjustments resulting from audit findings (RAC overpayment determinations, MAC medical necessity denials, internal compliance audit corrections) must trace to the specific finding for regulatory repor',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Contractual adjustments are coverage-specific (based on payer contract rates for specific plans). FK links adjustment to the coverage under which the contractual adjustment was calculated. Cardinality',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Contractual adjustments and write-offs must be tracked by facility for financial reporting, payer contract compliance audits, and revenue integrity analysis. Essential for understanding facility-speci',
    `charity_care_application_id` BIGINT COMMENT 'Foreign key linking to billing.charity_care_application. Business justification: Charity care adjustments are based on approved financial assistance applications. FK links adjustment to the authoritative charity care application record. Cardinality: N adjustments : 1 application (',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Adjustments frequently result from claim adjudication outcomes—payer denials, contractual adjustments, or underpayments. Revenue integrity and denial management workflows require linking adjustments t',
    `collection_account_id` BIGINT COMMENT 'Foreign key linking to billing.collection_account. Business justification: Adjustments related to collection activities (e.g., collection fees, recovery adjustments) link to the collection account. FK provides context for collection-related adjustments. Cardinality: N adjust',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Adjustments reference procedure codes when correcting billing errors or disputing payment variances. Existing cpt_code is denormalized string; FK enables validation, supports contractual adjustment ca',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Adjustments reference DRG codes when disputing inpatient payment variances or DRG downgrades. Existing drg_code is denormalized string; FK enables lookup of expected payment, supports DRG validation a',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: ERA adjustment reconciliation: adjustments (contractual, denial) are posted from 835 ERA messages. Linking adjustments to source message_log enables reconciliation, dispute resolution, and auditing ad',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Contractual adjustments are coverage-specific and must reference the exact insurance coverage policy to apply correct contract rates, validate allowable amounts, and maintain audit trails for payer co',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim to which this adjustment applies.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose account is being adjusted.',
    `original_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment record that this transaction reverses, if this is a reversal adjustment.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or guarantor associated with this adjustment, if applicable.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Adjustments may reference diagnosis codes when disputing medical necessity denials or coding-related payment variances. FK enables validation of diagnosis-driven adjustment reasons and supports appeal',
    `rac_audit_id` BIGINT COMMENT 'Identifier for the RAC audit or recoupment action that triggered this adjustment, used for tracking and appeal management.',
    `restriction_request_id` BIGINT COMMENT 'Foreign key linking to consent.consent_restriction_request. Business justification: Patient-imposed restrictions on PHI disclosure (e.g., self-pay for specific services, restrict billing to insurance) trigger contractual adjustments when services cannot be billed to restricted partie',
    `provider_sanction_id` BIGINT COMMENT 'Foreign key linking to provider.sanction. Business justification: Billing adjustments and write-offs are triggered by provider sanctions (OIG/SAM exclusions, state license suspensions, Medicare revocations). Adjustment records must reference sanction_id to document ',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this adjustment.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the adjustment applied to the account balance. Positive values indicate reductions in patient or payer liability; negative values indicate increases.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is subject to an active appeal or dispute process. True if under appeal, False otherwise.',
    `approval_date` DATE COMMENT 'The date on which the adjustment was formally approved by the authorizing authority.',
    `authorization_code` STRING COMMENT 'Approval or authorization code assigned when the adjustment was authorized, used for audit trail and compliance.',
    `bad_debt_referral_date` DATE COMMENT 'The date the account was referred to collections or classified as bad debt, relevant for bad debt write-off adjustments.',
    `adjustment_category` STRING COMMENT 'Broader grouping of adjustments for financial reporting and variance analysis (contractual vs. non-contractual, write-off vs. discount).. Valid values are `contractual|non_contractual|write_off|charity|discount|recoupment`',
    `contract_rate` DECIMAL(18,2) COMMENT 'The contracted reimbursement rate or allowed amount that drove the contractual adjustment, used for rate variance analysis.',
    `contractual_payer_name` STRING COMMENT 'Name of the insurance payer or contract under which a contractual adjustment was applied, used for variance analysis and contract performance tracking.',
    `cost_center_code` STRING COMMENT 'Cost center or department code associated with the adjustment, used for internal financial allocation and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this adjustment record was first created in the system.',
    `adjustment_date` DATE COMMENT 'The business date on which the adjustment was applied to the account, used for financial period assignment and reporting.',
    `era_trace_number` STRING COMMENT 'Trace or reference number from the payers Electronic Remittance Advice (ERA) or Explanation of Benefits (EOB) that corresponds to this adjustment.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this adjustment is posted for financial reporting and accounting purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this adjustment record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, justification, or documentation for the adjustment.',
    `number` STRING COMMENT 'Business-facing unique identifier or control number for the adjustment transaction, used for tracking and reconciliation.',
    `posting_date` DATE COMMENT 'The date the adjustment transaction was posted to the general ledger or financial system, which may differ from the adjustment date.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the adjustment, aligned with payer remittance advice codes or internal reason code sets.',
    `reason_description` STRING COMMENT 'Human-readable explanation of the reason for the adjustment, providing additional context beyond the reason code.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the adjustment has been reconciled with payer remittance advice (ERA/EOB) or internal financial records.. Valid values are `unreconciled|reconciled|disputed|pending_review`',
    `revenue_code` STRING COMMENT 'Standard revenue code (UB-04 revenue code) associated with the charge or service line to which this adjustment applies.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a reversal of a previous adjustment transaction. True if reversal, False otherwise.',
    `reversal_reason` STRING COMMENT 'Explanation of why the original adjustment was reversed, required for audit and compliance purposes.',
    `service_date` DATE COMMENT 'The date of service to which this adjustment applies, relevant for period-specific adjustments and reconciliation.',
    `source` STRING COMMENT 'Indicates the origin or trigger of the adjustment (manual entry, automated contract adjustment, ERA posting, audit finding, etc.). [ENUM-REF-CANDIDATE: manual|automated|era_posting|contract_adjustment|patient_request|payer_request|audit|other — 8 candidates stripped; promote to reference product]',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment transaction, indicating whether it is pending approval, posted, reversed, or reconciled.. Valid values are `pending|posted|approved|reversed|voided|reconciled`',
    `adjustment_type` STRING COMMENT 'High-level classification of the adjustment indicating the nature of the balance modification (contractual write-down, bad debt write-off, charity care, etc.). [ENUM-REF-CANDIDATE: contractual|administrative|bad_debt|charity_care|small_balance|courtesy_discount|recoupment|refund|other — 9 candidates stripped; promote to reference product]',
    `write_off_classification` STRING COMMENT 'Specific classification for write-off adjustments, distinguishing between bad debt, charity care, small balance write-offs, RAC recoupments, and other categories.. Valid values are `bad_debt|charity_care|small_balance|rac_recoupment|administrative|other`',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Financial adjustment applied to a charge, invoice line, or patient account balance. Encompasses ALL balance modifications in the revenue cycle: contractual adjustments (write-downs to payer-contracted rates), administrative adjustments, bad debt write-offs, charity care write-offs, small balance write-offs, RAC recoupments, courtesy discounts, and all other permanent or reversible balance modifications. Owns adjustment type, adjustment category (contractual/non-contractual/write-off/charity), adjustment reason code, adjustment amount, adjustment date, authorization/approval code, approving authority, posting status, charity care program reference, write-off classification (bad debt/charity/small balance/RAC), write-off reason, reversal flag, and reconciliation status. SSOT for ALL balance modifications including write-offs — there is no separate write-off entity. Critical for net revenue calculation, contractual variance analysis, bad debt reporting, charity care tracking, and RCM financial reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`patient_account` (
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient financial account. Primary key for the patient account entity.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Patient accounts in revenue cycle map to AR accounts in finance for aging analysis, collection tracking, financial reporting, and reconciliation. This is the master link between billing system and gen',
    `care_site_id` BIGINT COMMENT 'Reference to the primary healthcare facility where services associated with this account were rendered.',
    `charity_care_application_id` BIGINT COMMENT 'Foreign key linking to billing.charity_care_application. Business justification: Patient accounts with approved financial assistance link to the charity care application. FK provides access to detailed application data (household_income, fpl_percentage, approval_status, effective_',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for payment of this account. May be the patient or another party.',
    `mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record.mpi_record_id — Patient financial accounts must link to the patient master for statement generation, collections, and financial counseling workflows.',
    `vendor_id` BIGINT COMMENT 'Reference to the external collection agency currently assigned to recover the outstanding balance on this account.',
    `account_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance owed on this account after all payments, adjustments, and write-offs have been applied.',
    `account_closed_date` DATE COMMENT 'Date when this patient financial account was closed due to zero balance, write-off, or administrative closure.',
    `account_number` STRING COMMENT 'Externally-known unique account number assigned to this patient financial account for billing and collections purposes.',
    `account_opened_date` DATE COMMENT 'Date when this patient financial account was first established in the billing system.',
    `account_status` STRING COMMENT 'Current lifecycle status of the patient account in the revenue cycle management workflow.. Valid values are `open|closed|collections|bad_debt|charity|pending`',
    `account_type` STRING COMMENT 'Classification of the account based on primary payment responsibility and payer relationship. [ENUM-REF-CANDIDATE: self_pay|insured|charity_care|medicaid|medicare|workers_compensation|third_party_liability — 7 candidates stripped; promote to reference product]',
    `aging_bucket` STRING COMMENT 'Classification of account receivable age based on days outstanding since last statement or service date, used for collections prioritization.. Valid values are `current|30_days|60_days|90_days|120_plus_days`',
    `approved_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount approved for this account under the financial assistance program, applied to eligible charges.',
    `bad_debt_amount` DECIMAL(18,2) COMMENT 'Dollar amount written off as uncollectible bad debt for this account.',
    `bad_debt_flag` BOOLEAN COMMENT 'Indicator of whether this account has been classified as uncollectible bad debt for financial reporting purposes.',
    `bad_debt_write_off_date` DATE COMMENT 'Date when the outstanding balance on this account was written off as uncollectible bad debt.',
    `collection_agency_name` STRING COMMENT 'Name of the external collection agency currently handling this account.',
    `collection_recall_date` DATE COMMENT 'Date when this account was recalled from the external collection agency back to internal management.',
    `collection_recall_reason` STRING COMMENT 'Business reason for recalling the account from external collections, such as payment arrangement, dispute resolution, or financial assistance approval.',
    `collection_referral_date` DATE COMMENT 'Date when this account was referred to an external collection agency for recovery of outstanding balance.',
    `collection_status` STRING COMMENT 'Current state of the account within the collections workflow, indicating whether it has been referred to external collections and the outcome.. Valid values are `not_in_collections|referred|active|recalled|resolved|legal_action`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this patient account record was first created in the database.',
    `days_outstanding` STRING COMMENT 'Number of days since the first unpaid charge on this account, used to calculate aging and collection priority.',
    `family_size` STRING COMMENT 'Number of individuals in the household used to calculate Federal Poverty Level (FPL) percentage for financial assistance eligibility.',
    `financial_assistance_application_date` DATE COMMENT 'Date when the patient or guarantor submitted an application for charity care or financial assistance for this account.',
    `financial_assistance_approval_status` STRING COMMENT 'Final determination status of the financial assistance application for this account.. Valid values are `pending|approved|denied|expired|revoked`',
    `financial_assistance_effective_date` DATE COMMENT 'Date when the approved financial assistance discount becomes effective for charges on this account.',
    `financial_assistance_eligibility` STRING COMMENT 'Current determination status of the patient or guarantor eligibility for charity care or financial assistance programs.. Valid values are `not_evaluated|eligible|ineligible|pending|approved|denied`',
    `financial_assistance_expiration_date` DATE COMMENT 'Date when the approved financial assistance eligibility expires and must be re-evaluated.',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of the Federal Poverty Level based on household income and family size, used to determine financial assistance eligibility tier.',
    `household_income` DECIMAL(18,2) COMMENT 'Total annual household income reported by the patient or guarantor for financial assistance eligibility determination.',
    `insurance_balance` DECIMAL(18,2) COMMENT 'Portion of the account balance that is the responsibility of insurance payers.',
    `irs_501r_compliance_flag` BOOLEAN COMMENT 'Indicator of whether all IRS 501(r) requirements have been met for this account, including financial assistance screening and extraordinary collection action restrictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this patient account record was most recently updated.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the most recent payment received and posted to this account.',
    `last_payment_date` DATE COMMENT 'Date when the most recent payment was posted to this account from any source (patient, insurance, or third party).',
    `last_statement_date` DATE COMMENT 'Date when the most recent patient billing statement was generated and sent for this account.',
    `original_balance` DECIMAL(18,2) COMMENT 'Initial total charges assigned to this account before any payments or adjustments.',
    `patient_balance` DECIMAL(18,2) COMMENT 'Portion of the account balance that is the direct financial responsibility of the patient or guarantor.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicator of whether the patient or guarantor has an active payment plan arrangement for this account.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Total dollar amount successfully recovered by the collection agency on this account to date.',
    `referred_balance` DECIMAL(18,2) COMMENT 'Dollar amount of the outstanding balance that was referred to the collection agency at the time of referral.',
    `total_adjustments` DECIMAL(18,2) COMMENT 'Cumulative sum of all contractual adjustments, write-offs, and other balance reductions applied to this account.',
    `total_payments` DECIMAL(18,2) COMMENT 'Cumulative sum of all payments received on this account from all sources since account inception.',
    CONSTRAINT pk_patient_account PRIMARY KEY(`patient_account_id`)
) COMMENT 'Financial account representing a patients or guarantors billing relationship with the healthcare organization, encompassing the full financial lifecycle from initial balance through collections resolution and financial assistance determination. Owns account number, guarantor ID, account type (self-pay, insured, charity), account balance, last statement date, last payment date, account aging bucket (current, 30, 60, 90, 120+ days), financial assistance eligibility, collection status, collection referral date, collection agency name/ID, referred balance, recovered amount, collection recall date, recall reason, bad debt flag, bad debt write-off date, collection agency performance metrics, charity care/financial assistance application data (application date, program type, household income, family size, FPL percentage, supporting documentation status, approval status, approved discount percentage, effective period), and IRS 501(r) compliance tracking. SSOT for patient financial responsibility, collections lifecycle, and financial assistance determinations. Distinct from the clinical patient record owned by the patient domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`statement` (
    `statement_id` BIGINT COMMENT 'Unique identifier for the patient billing statement. Primary key.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor or patient responsible for payment of this statement.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom services were rendered and billed on this statement.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Patient billing statements are generated FOR patient accounts. Statement is the periodic communication of account status to the guarantor. FK links statement to the authoritative patient account recor',
    `payment_plan_id` BIGINT COMMENT 'Reference to an active payment plan or financial assistance arrangement associated with this statement.',
    `employee_id` BIGINT COMMENT 'The system user or process identifier that created this statement record.',
    `statement_last_modified_by_user_employee_id` BIGINT COMMENT 'The system user or process identifier that last modified this statement record.',
    `adjustments_applied` DECIMAL(18,2) COMMENT 'Total adjustments (credits, write-offs, contractual adjustments) applied during the current statement cycle.',
    `aging_bucket` STRING COMMENT 'The aging category of the outstanding balance based on the number of days since the original service date or first statement.. Valid values are `current|30_days|60_days|90_days|120_plus_days`',
    `billing_address_line_1` STRING COMMENT 'The first line of the guarantor or patient billing address to which the statement was sent.',
    `billing_address_line_2` STRING COMMENT 'The second line of the guarantor or patient billing address (apartment, suite, unit number).',
    `billing_city` STRING COMMENT 'The city of the guarantor or patient billing address.',
    `billing_country_code` STRING COMMENT 'The three-letter ISO country code of the guarantor or patient billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal code or ZIP code of the guarantor or patient billing address.',
    `billing_state` STRING COMMENT 'The state or province of the guarantor or patient billing address.',
    `collection_status` STRING COMMENT 'The current collection status indicating whether the account is in collections, legal action, or bad debt.. Valid values are `none|pending|active|legal|bad_debt|write_off`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this statement record was first created in the system.',
    `current_charges` DECIMAL(18,2) COMMENT 'New charges added during the current statement cycle that are included in this statement.',
    `cycle` STRING COMMENT 'The billing cycle or period identifier for this statement (e.g., monthly cycle, weekly cycle, ad-hoc).',
    `statement_date` DATE COMMENT 'The date the statement was generated and issued to the guarantor or patient.',
    `delivery_method` STRING COMMENT 'The method or channel used to deliver the statement to the guarantor or patient.. Valid values are `mail|email|portal|sms|fax`',
    `delivery_status` STRING COMMENT 'The current delivery status indicating whether the statement successfully reached the guarantor or patient.. Valid values are `pending|sent|delivered|failed|returned|bounced`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time when the statement was delivered or sent to the guarantor or patient.',
    `email_address` STRING COMMENT 'The email address to which electronic statements or notifications were sent.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `financial_assistance_flag` BOOLEAN COMMENT 'Indicates whether the guarantor or patient has been approved for financial assistance or charity care that applies to this statement.',
    `insurance_pending` DECIMAL(18,2) COMMENT 'Amount currently pending adjudication or payment from insurance payers, not yet reflected in patient responsibility.',
    `language_preference` STRING COMMENT 'The two-letter ISO language code indicating the preferred language for statement communication.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this statement record was last updated or modified.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The amount of the most recent payment received from the guarantor or patient.',
    `last_payment_date` DATE COMMENT 'The date of the most recent payment received from the guarantor or patient on this account.',
    `message` STRING COMMENT 'Custom message or note printed on the statement for the guarantor or patient (e.g., payment reminders, financial assistance information).',
    `minimum_payment_due` DECIMAL(18,2) COMMENT 'The minimum payment amount requested from the guarantor or patient for this statement cycle.',
    `number` STRING COMMENT 'Externally-known unique statement number printed on the billing statement and used for patient reference and payment tracking.',
    `payment_due_date` DATE COMMENT 'The date by which payment is requested or expected from the guarantor or patient.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the guarantor or patient is enrolled in a payment plan for the balance on this statement.',
    `payments_received` DECIMAL(18,2) COMMENT 'Total payments received from the guarantor or patient during the current statement cycle.',
    `phone_number` STRING COMMENT 'The contact phone number of the guarantor or patient for statement inquiries and follow-up.',
    `previous_balance` DECIMAL(18,2) COMMENT 'The outstanding balance carried forward from the prior statement cycle before current charges and payments.',
    `returned_mail_date` DATE COMMENT 'The date when a mailed statement was returned as undeliverable.',
    `returned_mail_flag` BOOLEAN COMMENT 'Indicates whether a mailed paper statement was returned as undeliverable by the postal service.',
    `returned_mail_reason` STRING COMMENT 'The reason provided by the postal service for returning the statement (e.g., address unknown, moved, refused).',
    `statement_status` STRING COMMENT 'Current lifecycle status of the statement indicating its processing and delivery state. [ENUM-REF-CANDIDATE: generated|sent|delivered|returned|paid|partial_paid|outstanding — 7 candidates stripped; promote to reference product]',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether statement generation and delivery has been suppressed for this account due to patient request, legal hold, or other reason.',
    `suppression_reason` STRING COMMENT 'The reason why statement delivery was suppressed (e.g., patient request, deceased, legal hold, bankruptcy).',
    `total_balance_due` DECIMAL(18,2) COMMENT 'The total outstanding balance owed by the guarantor or patient as of the statement date, including all charges, adjustments, and prior payments.',
    `statement_type` STRING COMMENT 'The format or medium of the statement delivery (paper mailed, electronic via portal, email, SMS notification).. Valid values are `paper|electronic|portal|email|sms`',
    CONSTRAINT pk_statement PRIMARY KEY(`statement_id`)
) COMMENT 'Patient billing statement generated and sent to a guarantor or patient for outstanding balances. Owns statement number, statement date, statement type (paper/electronic), total balance due, minimum payment due, due date, statement cycle, delivery method, delivery status, and returned mail flag. Tracks the full patient statement lifecycle from generation through delivery and response.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`collection_account` (
    `collection_account_id` BIGINT COMMENT 'Unique identifier for the collection account record. Primary key.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Collection accounts must link to AR accounts for tracking recovered amounts, write-offs, bad debt expense, and financial statement impact when accounts are referred to external agencies. Required for ',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Bad debt must be attributed to the originating facility for financial statement preparation (allowance for doubtful accounts by entity), collection agency coordination, and facility-level bad debt rat',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for the outstanding balance referred to collections.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim associated with this collection account.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose account has been referred to collections.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Collection accounts are created when patient accounts are referred to collections for bad debt recovery. FK links collection record to the originating patient account. Cardinality: N collection accoun',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this collection account record.',
    `vendor_id` BIGINT COMMENT 'Reference to the external collection agency assigned to this account, if applicable.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this collection account.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied to the collection account, including settlements, discounts, or contractual adjustments negotiated during collections.',
    `aging_days` STRING COMMENT 'Number of days the account has been in collections, calculated from the referral date to the current date or closed date.',
    `closed_date` DATE COMMENT 'Date when the collection account was closed, either due to full recovery, write-off, settlement, or recall.',
    `collection_agency_name` STRING COMMENT 'Name of the collection agency or internal collections department handling this account.',
    `collection_fee_amount` DECIMAL(18,2) COMMENT 'Fees charged by the collection agency for their services, which may be passed to the patient or absorbed by the organization.',
    `collection_notes` STRING COMMENT 'Free-text notes documenting collection activities, patient communications, special circumstances, or other relevant information.',
    `collection_status` STRING COMMENT 'Current lifecycle status of the collection account indicating its position in the collections workflow. [ENUM-REF-CANDIDATE: referred|active|in_progress|payment_plan|settled|recovered|recalled|written_off|closed — 9 candidates stripped; promote to reference product]',
    `collection_type` STRING COMMENT 'Classification of the collection effort indicating whether it is handled internally, by an external agency, or through legal action.. Valid values are `internal|external|legal|pre_collection|bad_debt`',
    `contact_attempt_count` STRING COMMENT 'Total number of contact attempts made to the patient or guarantor since the account was referred to collections.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this collection account (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `interest_amount` DECIMAL(18,2) COMMENT 'Total interest charges accrued on the outstanding balance during the collections period, if applicable per state regulations.',
    `judgment_amount` DECIMAL(18,2) COMMENT 'Court-ordered judgment amount awarded in favor of the organization, if legal action resulted in a judgment.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact attempt or communication with the patient or guarantor regarding this collection account.',
    `last_contact_method` STRING COMMENT 'Method used for the most recent contact attempt with the patient or guarantor.. Valid values are `phone|mail|email|sms|in_person|portal`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection account record was last modified or updated.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received on this collection account.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received on this collection account.',
    `legal_action_date` DATE COMMENT 'Date when legal action was initiated on this collection account, if applicable.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether legal action (lawsuit, judgment, garnishment) has been initiated or taken on this collection account.',
    `monthly_payment_amount` DECIMAL(18,2) COMMENT 'Agreed-upon monthly payment amount for the payment plan, if applicable.',
    `number` STRING COMMENT 'Externally-known unique identifier assigned to this collection account by the collection agency or internal collections department.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current remaining balance owed after applying any recovered amounts, adjustments, or write-offs.',
    `payment_plan_end_date` DATE COMMENT 'Scheduled end date for the payment plan arrangement, if applicable.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the patient or guarantor has entered into a payment plan arrangement with the collection agency.',
    `payment_plan_start_date` DATE COMMENT 'Date when the payment plan arrangement became effective, if applicable.',
    `principal_amount` DECIMAL(18,2) COMMENT 'Original principal balance owed, excluding interest, fees, or adjustments applied during the collections process.',
    `recall_date` DATE COMMENT 'Date when the account was recalled from the collection agency back to the organization, if applicable.',
    `recall_reason` STRING COMMENT 'Business reason for recalling the account from collections, such as patient dispute, billing error discovered, or payment received directly.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Total amount successfully recovered from the patient or guarantor through the collections process.',
    `referral_date` DATE COMMENT 'Date when the account was referred to collections. This is the principal business event timestamp for this transaction.',
    `referral_reason` STRING COMMENT 'Business reason or justification for referring this account to collections, such as non-payment after multiple statements or patient unresponsiveness.',
    `referred_balance` DECIMAL(18,2) COMMENT 'Total outstanding balance amount referred to collections at the time of referral. Represents the gross amount owed.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Agreed-upon settlement amount paid to resolve the collection account for less than the full balance, if applicable.',
    `settlement_date` DATE COMMENT 'Date when a settlement agreement was reached with the patient or guarantor, if applicable.',
    `settlement_flag` BOOLEAN COMMENT 'Indicates whether the collection account was settled for less than the full amount owed through negotiation.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as bad debt when the account is deemed uncollectible and closed.',
    `write_off_date` DATE COMMENT 'Date when the outstanding balance was written off as bad debt and the account was closed as uncollectible.',
    `write_off_reason` STRING COMMENT 'Business reason or justification for writing off the balance as bad debt, such as patient bankruptcy, deceased patient, or account deemed uncollectible.',
    CONSTRAINT pk_collection_account PRIMARY KEY(`collection_account_id`)
) COMMENT 'Record of a patient account referred to internal or external collections for bad debt recovery. Owns referral date, collection agency name, collection agency ID, referred balance, recovered amount, collection status, recall date, recall reason, and bad debt write-off date. Tracks the collections lifecycle from referral through recovery or final write-off. Supports bad debt reporting and collection agency performance management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` (
    `billing_coverage_id` BIGINT COMMENT 'Unique identifier for the insurance coverage record. Primary key for the coverage entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created this coverage record. Used for audit trail and accountability.',
    `billing_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that most recently modified this coverage record. Used for audit trail and accountability.',
    `mpi_record_id` BIGINT COMMENT 'Unique member identifier assigned by the insurance payer to the patient for this coverage. Used for claims submission and eligibility verification.',
    `billing_patient_mpi_record_id` BIGINT COMMENT 'Identifier of the patient who holds this insurance coverage. Links to the patient master record.',
    `fhir_resource_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_resource_log. Business justification: Real-time eligibility verification: coverage records are verified via FHIR Coverage/$eligibility operations. Linking coverage to the fhir_resource_log that performed verification enables audit trails,',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Patient coverage records must link to applicable formulary for real-time benefit checks at point of prescription. Enables determination of covered drugs, tier placement, prior authorization requiremen',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.provider_group. Business justification: Group practices enroll with payers as billing entities. Coverage records need provider_group_id to identify which group practice the member is enrolled under for group-based billing, capitation paymen',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Coverage records store denormalized plan_name and plan_type. Proper FK to health_plan enables eligibility verification, benefit lookups, accumulator tracking, and formulary checks. Revenue cycle syste',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Payers contract with organizational providers (hospitals, health systems) for network participation. Coverage records must track which org_provider the members plan is associated with to determine ne',
    `patient_coverage_id` BIGINT COMMENT 'FK to SSOT owner patient.patient_coverage for the coverage entity.',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer organization providing this coverage. Links to the payer master record.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary subscriber (policyholder) for this coverage. May differ from member_id if patient is a dependent.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Payer coverage policies often mandate specific vendor contracts for high-cost implants and devices (e.g., "covered only if using contracted vendor"). Required for prior authorization, coverage determi',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this coverage is currently active and eligible for claims submission. Derived from coverage_status and verification results. True if coverage is active.',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether this coverage requires prior authorization for certain services. True if authorization workflows must be followed.',
    `bin_number` STRING COMMENT 'Bank Identification Number used for pharmacy benefit claims routing. Six-digit number identifying the pharmacy benefit manager or payer for prescription drug coverage.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered service costs the patient is responsible for after the deductible is met. Expressed as a percentage (e.g., 20.00 for 20% coinsurance).',
    `coordination_of_benefits_order` STRING COMMENT 'Priority order for this coverage when patient has multiple insurance plans. Primary coverage is billed first, secondary and tertiary follow COB rules.. Valid values are `Primary|Secondary|Tertiary`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the patient must pay at the time of service for covered services under this plan. Varies by service type.',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the insurance coverage record. Active indicates coverage is in force and eligible for claims.. Valid values are `Active|Inactive|Suspended|Terminated|Pending`',
    `coverage_type` STRING COMMENT 'Category of healthcare services covered by this insurance plan. A patient may have multiple coverage records for different service types.. Valid values are `Medical|Dental|Vision|Pharmacy|Behavioral Health|Long-Term Care`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage record was first created in the system. Represents the initial capture of this coverage information.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Total annual deductible amount the patient must pay out-of-pocket before insurance begins covering costs under this plan.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'Amount of the annual deductible that has been satisfied by the patient as of the most recent eligibility verification. Updated through real-time and batch eligibility checks.',
    `effective_date` DATE COMMENT 'Date when the insurance coverage becomes active and benefits are available. Start of the benefit period.',
    `eligibility_verification_count` STRING COMMENT 'Total number of eligibility verification transactions performed for this coverage record. Includes real-time, batch, and manual verifications.',
    `employer_name` STRING COMMENT 'Name of the employer or organization sponsoring this insurance coverage. Applicable for employer-sponsored group health plans.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage record was most recently updated. Tracks the latest change to any field in the record.',
    `last_verification_date` DATE COMMENT 'Date when eligibility for this coverage was most recently verified with the payer. Updated through real-time 270/271 transactions, manual verification, or batch processes.',
    `last_verification_method` STRING COMMENT 'Method used for the most recent eligibility verification. Real-Time 270/271 indicates automated EDI transaction, Manual indicates phone or fax verification, Batch indicates scheduled bulk verification, Portal indicates payer web portal lookup.. Valid values are `Real-Time 270/271|Manual|Batch|Portal`',
    `last_verification_status` STRING COMMENT 'Result status of the most recent eligibility verification attempt. Verified Active indicates coverage is confirmed and active. Verification Failed indicates payer did not confirm coverage.. Valid values are `Verified Active|Verified Inactive|Verification Failed|Pending`',
    `network_status` STRING COMMENT 'Indicates whether this coverage applies to in-network providers, out-of-network providers, or both. Affects reimbursement rates and patient cost-sharing.. Valid values are `In-Network|Out-of-Network|Both`',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum total amount the patient must pay out-of-pocket in a benefit period before insurance covers 100% of covered services.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'Amount of the out-of-pocket maximum that has been satisfied by the patient as of the most recent eligibility verification. Updated through real-time and batch eligibility checks.',
    `payer_response_code` STRING COMMENT 'Response code returned by the payer during the most recent eligibility verification. Indicates coverage status, limitations, or error conditions per HIPAA 271 transaction standards.',
    `payer_response_message` STRING COMMENT 'Human-readable message returned by the payer during the most recent eligibility verification. Provides additional context for the response code.',
    `pcn_number` STRING COMMENT 'Processor Control Number used in conjunction with BIN for pharmacy claims routing. Identifies specific benefit plan or processing rules within the payer system.',
    `plan_year_end_date` DATE COMMENT 'End date of the plan year for this coverage. Marks the end of the benefit period before deductibles and out-of-pocket maximums reset.',
    `plan_year_start_date` DATE COMMENT 'Start date of the plan year for this coverage. Deductibles and out-of-pocket maximums typically reset on this date annually.',
    `policy_number` STRING COMMENT 'Unique policy identifier assigned by the insurance payer. May be the same as member_id or a separate contract identifier.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether this coverage requires a referral from a Primary Care Physician (PCP) for specialist visits. Common in HMO plans.',
    `rx_group_number` STRING COMMENT 'Group number specific to pharmacy benefits. May differ from the medical group_number for plans with separate pharmacy benefit managers.',
    `source_system_code` STRING COMMENT 'Unique identifier for this coverage record in the source operational system. Used for data lineage and reconciliation.',
    `subscriber_relationship` STRING COMMENT 'Relationship of the patient to the primary subscriber (policyholder). Determines dependent status and coverage rules.. Valid values are `Self|Spouse|Child|Other`',
    `termination_date` DATE COMMENT 'Date when the insurance coverage ends and benefits are no longer available. Null for open-ended active coverage.',
    `verification_source_system` STRING COMMENT 'Name of the system or clearinghouse used to perform the most recent eligibility verification (e.g., Change Healthcare, Availity, Epic Resolute, Cerner Revenue Cycle).',
    CONSTRAINT pk_billing_coverage PRIMARY KEY(`billing_coverage_id`)
) COMMENT 'Insurance coverage record linking a patient to a specific payer plan for a defined benefit period, including the complete history of real-time and batch eligibility verification transactions. Owns payer ID, plan name, plan type (HMO, PPO, POS, Medicare, Medicaid), member ID, group number, subscriber ID, subscriber relationship, coverage effective/termination dates, coordination of benefits (COB) order (primary/secondary/tertiary), copay amount, deductible amount, out-of-pocket maximum, and eligibility verification events (verification date, verification method — real-time 270/271, manual, batch — payer response status, coverage active flag, deductible met amount, out-of-pocket met amount, copay amount returned, verification source system). SSOT for patient insurance eligibility, coverage verification, benefit details, and all eligibility verification transactions — there is no separate eligibility check entity. Supports front-end revenue cycle eligibility workflows and reduces claim denials due to eligibility issues.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique identifier for the write-off record. Primary key.',
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Write-offs must post to AR transactions for bad debt expense recognition, allowance for doubtful accounts adjustment, financial statement accuracy, and regulatory reporting (e.g., charity care, bad de',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Write-offs resulting from compliance audit findings (unallowable charges, medical necessity failures, billing compliance violations) must reference the finding for regulatory reporting, trend analysis',
    `charity_care_application_id` BIGINT COMMENT 'Foreign key linking to billing.charity_care_application. Business justification: Charity care write-offs are based on approved financial assistance applications. Same pattern as adjustment → charity_care_application. FK links write-off to the authoritative application. Cardinality',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Write-offs often follow claim denials or partial payments where recovery is deemed uneconomical. Bad debt reporting, charity care tracking, and revenue cycle KPIs require linking write-offs to the cla',
    `collection_account_id` BIGINT COMMENT 'Foreign key linking to billing.collection_account. Business justification: Bad debt write-offs often result from failed collection efforts. FK links write-off to the collection account record. Cardinality: N write-offs : 1 collection account (one collection account can resul',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Write-offs reference procedure codes for financial reporting and variance analysis. Existing cpt_code is denormalized string; FK enables procedure-level write-off analysis, supports revenue cycle KPIs',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Write-offs reference DRG codes for inpatient financial analysis. Existing drg_code is denormalized string; FK enables DRG-level write-off analysis, supports case mix variance reporting, and identifies',
    `financial_assistance_id` BIGINT COMMENT 'Foreign key linking to patient.financial_assistance. Business justification: Write-offs resulting from approved financial assistance must reference the specific assistance application for IRS 501(r) compliance reporting, community benefit tracking, and regulatory audits. Requi',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for the account balance being written off.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim from which this balance was written off.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose account balance is being written off.',
    `original_write_off_id` BIGINT COMMENT 'Reference to the original write-off record if this is a reversal or correction entry, creating an audit trail.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer associated with this write-off, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the user or manager who authorized this write-off, for audit trail and accountability.',
    `rac_audit_id` BIGINT COMMENT 'Reference to the RAC audit case or finding that resulted in this recoupment write-off, if applicable.',
    `tertiary_write_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this write-off record, for audit trail and accountability.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this write-off.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the balance permanently written off from the patient account or invoice, expressed in US dollars (USD). This is the principal amount forgiven or deemed uncollectible.',
    `appeal_date` DATE COMMENT 'The date on which an appeal was filed to contest or reverse this write-off.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether this write-off is subject to an active appeal or dispute process. True if under appeal, False otherwise.',
    `appeal_status` STRING COMMENT 'Current status of the appeal process: pending (under review), approved (write-off reversed), denied (write-off upheld), or withdrawn (appeal abandoned).. Valid values are `pending|approved|denied|withdrawn`',
    `approval_date` DATE COMMENT 'The date on which the write-off was formally approved by the authorizing user or manager.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this write-off requires managerial or executive approval based on amount thresholds or policy rules. True if approval is required, False otherwise.',
    `bad_debt_referral_date` DATE COMMENT 'The date on which the account was referred to a collection agency or written off as bad debt, marking the transition from active collection to write-off.',
    `write_off_category` STRING COMMENT 'Broader categorization of the write-off for financial reporting and analytics: patient responsibility (self-pay), insurance denial (payer refusal), uncompensated care (charity or bad debt), policy adjustment (internal policy), or audit adjustment (external audit finding).. Valid values are `patient_responsibility|insurance_denial|uncompensated_care|policy_adjustment|audit_adjustment`',
    `cost_center_code` STRING COMMENT 'The cost center or department code associated with this write-off for internal financial tracking and allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this write-off record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `write_off_date` DATE COMMENT 'The business date on which the write-off was officially recorded and the balance was removed from active accounts receivable.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the original balance as part of the charity care or financial assistance program. For example, 100.00 represents a full write-off, 50.00 represents a 50% discount.',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'The patient or guarantor household income expressed as a percentage of the Federal Poverty Level, used to determine charity care eligibility. For example, 150.00 represents 150% of FPL.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this write-off is posted for financial reporting, such as bad debt expense or charity care.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this write-off record was last updated or modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `notes` STRING COMMENT 'Free-text notes providing additional context, justification, or documentation for this write-off, used for audit and compliance purposes.',
    `number` STRING COMMENT 'Business-facing unique identifier or control number for this write-off transaction, used for tracking and audit purposes.',
    `original_balance` DECIMAL(18,2) COMMENT 'The original outstanding balance on the account or invoice before the write-off was applied, providing context for the write-off magnitude.',
    `posting_date` DATE COMMENT 'The date on which the write-off was posted to the general ledger and financial reporting systems.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the write-off, aligned with internal revenue cycle coding standards or external regulatory codes.',
    `reason_description` STRING COMMENT 'Detailed textual explanation of why the balance was written off, providing context for audit and compliance review.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'The balance remaining on the account or invoice after this write-off is applied. May be zero if the write-off clears the account.',
    `revenue_code` STRING COMMENT 'The UB-04 revenue code associated with the original charges being written off, providing service line detail.',
    `reversal_date` DATE COMMENT 'The date on which this write-off was reversed, restoring the balance to the account.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this write-off has been reversed or undone. True if reversed, False if still active.',
    `reversal_reason` STRING COMMENT 'Explanation of why the write-off was reversed, such as Patient payment received or Insurance appeal successful.',
    `service_date` DATE COMMENT 'The date of service or encounter for which the charges were originally incurred, providing historical context for the write-off.',
    `write_off_status` STRING COMMENT 'Current lifecycle status of the write-off: pending (awaiting approval), approved (authorized but not yet posted), posted (applied to account), reversed (undone), or under review (being audited or appealed).. Valid values are `pending|approved|posted|reversed|under_review`',
    `write_off_type` STRING COMMENT 'Classification of the write-off by its nature: bad debt (uncollectible patient balance), charity care (financial assistance), small balance (below collection threshold), administrative (system correction), RAC recoupment (Recovery Audit Contractor adjustment), or contractual dispute (payer disagreement).. Valid values are `bad_debt|charity_care|small_balance|administrative|rac_recoupment|contractual_dispute`',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Record of a balance permanently written off from a patient account or invoice, including bad debt write-offs, charity care write-offs, small balance write-offs, and RAC (Recovery Audit Contractor) recoupments. Owns write-off type, write-off reason, write-off amount, write-off date, approving authority, charity care program reference, and reversal flag. Distinct from contractual adjustments (which are expected) — write-offs represent unrecoverable or forgiven balances.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan. Primary key.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor who is financially responsible for this payment plan.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the primary party responsible for this payment plan.',
    `patient_account_id` BIGINT COMMENT 'Reference to the patient account for which this payment plan was established.',
    `employee_id` BIGINT COMMENT 'Reference to the user or staff member who approved the payment plan, typically a financial counselor, billing manager, or revenue cycle specialist.',
    `tertiary_payment_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system process that most recently modified the payment plan record.',
    `actual_completion_date` DATE COMMENT 'Actual date when the payment plan was completed, either through full payment or early payoff. Null if plan is still active or was cancelled/defaulted.',
    `agreement_signed_date` DATE COMMENT 'Date when the payment plan agreement was signed by the patient or guarantor.',
    `agreement_signed_flag` BOOLEAN COMMENT 'Indicates whether the patient or guarantor has signed the payment plan agreement. True means a signed agreement is on file, false means signature is pending or not required.',
    `approval_date` DATE COMMENT 'Date when the payment plan was reviewed and approved by authorized staff.',
    `auto_pay_flag` BOOLEAN COMMENT 'Indicates whether automatic recurring payments are enabled for this payment plan. True means installments are automatically charged to the stored payment method on the due date, false means manual payment is required.',
    `cancellation_date` DATE COMMENT 'Date when the payment plan was cancelled by either the patient or the healthcare organization.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the payment plan was cancelled, including patient request, non-compliance, account paid in full, or administrative reasons.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment plan record was first created in the system. Represents the audit trail for record creation.',
    `default_date` DATE COMMENT 'Date when the payment plan was declared in default due to missed payments exceeding the grace period.',
    `default_reason` STRING COMMENT 'Explanation of why the payment plan defaulted, such as consecutive missed payments, insufficient funds, or patient non-response.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial payment made at the time of plan enrollment, if required. This amount is applied to the balance before installments begin. Expressed in USD.',
    `effective_end_date` DATE COMMENT 'Scheduled date when the payment plan is expected to be completed based on the original terms. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the payment plan becomes active and the first installment is due. This is the binding start date of the agreement.',
    `enrollment_channel` STRING COMMENT 'Channel through which the patient or guarantor enrolled in the payment plan. Patient portal indicates online self-service enrollment, phone indicates enrollment via call center, in-person indicates enrollment at a facility registration or billing desk, mail indicates paper application, email indicates enrollment via email correspondence, and mobile app indicates enrollment through a mobile application.. Valid values are `patient_portal|phone|in_person|mail|email|mobile_app`',
    `enrollment_date` DATE COMMENT 'Date when the patient or guarantor enrolled in the payment plan.',
    `finance_charge_amount` DECIMAL(18,2) COMMENT 'Total finance charges or interest applied to the payment plan over its lifetime. Zero for interest-free plans. Expressed in USD.',
    `financial_assistance_program_code` STRING COMMENT 'Code identifying the financial assistance or charity care program under which this payment plan was approved, if applicable. Links to the organizations financial assistance policy and eligibility criteria.',
    `grace_period_days` STRING COMMENT 'Number of days after the installment due date during which a late payment can be made without penalty or default.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Fixed amount due for each scheduled installment payment. Expressed in USD.',
    `installment_frequency` STRING COMMENT 'Frequency at which installment payments are scheduled. Weekly indicates every 7 days, biweekly every 14 days, monthly on the same day each month, quarterly every 3 months, and custom indicates a non-standard schedule.. Valid values are `weekly|biweekly|monthly|quarterly|custom`',
    `installments_paid` STRING COMMENT 'Count of installment payments that have been successfully received and posted to date.',
    `installments_remaining` STRING COMMENT 'Count of installment payments still outstanding to complete the payment plan.',
    `interest_rate_percentage` DECIMAL(18,2) COMMENT 'Annual percentage rate (APR) applied to the payment plan balance, if applicable. Zero for interest-free plans. Expressed as a percentage (e.g., 5.00 for 5%).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment plan record was most recently updated. Represents the audit trail for record modification.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent installment payment received. Expressed in USD.',
    `last_payment_date` DATE COMMENT 'Date when the most recent installment payment was received and posted.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Standard late fee charged for each missed or late installment payment, as defined in the payment plan agreement. Expressed in USD.',
    `missed_payments_count` STRING COMMENT 'Total number of installment payments that were missed or not received by the due date during the life of the payment plan.',
    `next_payment_due_date` DATE COMMENT 'Date when the next scheduled installment payment is due. Null if plan is completed, cancelled, or defaulted.',
    `notes` STRING COMMENT 'Free-text notes and comments related to the payment plan, including special arrangements, patient circumstances, or administrative instructions.',
    `number_of_installments` STRING COMMENT 'Total number of scheduled installment payments required to complete the payment plan.',
    `original_balance_amount` DECIMAL(18,2) COMMENT 'Total outstanding patient balance at the time the payment plan was established. This is the starting principal amount before any plan payments are applied. Expressed in USD.',
    `payment_method` STRING COMMENT 'Primary payment instrument used for installment payments. Credit card and debit card indicate card-based payments, ACH (Automated Clearing House) indicates electronic bank transfer, check indicates paper check, cash indicates in-person cash payment, and money order indicates certified payment instrument.. Valid values are `credit_card|debit_card|ach|check|cash|money_order`',
    `plan_number` STRING COMMENT 'Externally visible unique business identifier for the payment plan, used in patient communications and statements.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the payment plan. Pending indicates awaiting approval or first payment, active indicates plan is in good standing with payments being made, completed indicates all installments paid in full, defaulted indicates missed payments beyond grace period, cancelled indicates plan was terminated by patient or organization, suspended indicates temporarily paused by mutual agreement.. Valid values are `pending|active|completed|defaulted|cancelled|suspended`',
    `plan_type` STRING COMMENT 'Classification of the payment plan based on terms and eligibility criteria. Standard plans follow default terms, interest-free plans waive interest charges, hardship plans are for patients with demonstrated financial need, extended plans have longer durations, short-term plans are for smaller balances, and custom plans have negotiated terms.. Valid values are `standard|interest_free|hardship|extended|short_term|custom`',
    `remaining_balance_amount` DECIMAL(18,2) COMMENT 'Current outstanding balance on the payment plan after all payments to date have been applied. Expressed in USD.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative sum of all payments received and applied to this payment plan to date, including down payment and all installments. Expressed in USD.',
    `total_plan_amount` DECIMAL(18,2) COMMENT 'Total amount to be paid under the payment plan, including any interest, fees, or finance charges. May equal original balance for interest-free plans. Expressed in USD.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Structured installment payment arrangement established between the healthcare organization and a patient or guarantor for an outstanding balance. Owns plan type (standard, interest-free, hardship), total plan amount, installment amount, installment frequency, plan start date, plan end date, number of installments, installments paid, remaining balance, plan status (active, completed, defaulted, cancelled), and enrollment channel. Supports patient financial engagement and self-pay collections.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` (
    `rac_audit_id` BIGINT COMMENT 'Unique identifier for the RAC audit record. Primary key for the rac_audit product.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: RAC audits target specific Medicare provider numbers (facilities). Tracking the facility is essential for audit response coordination, corrective action plan implementation, and monitoring facility-sp',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: RAC audits are compliance audits conducted by Recovery Audit Contractors. Linking to compliance.audit enables unified audit finding tracking, corrective action plan management, and regulatory reportin',
    `invoice_id` BIGINT COMMENT 'Foreign key reference to the invoice or claim that was subject to audit review.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key reference to the patient whose care or billing was audited.',
    `payer_id` BIGINT COMMENT 'Foreign key reference to the insurance payer or government program that initiated or sponsored the audit (e.g., Medicare, Medicaid, commercial payer).',
    `employee_id` BIGINT COMMENT 'Internal user ID of the compliance officer, revenue cycle analyst, or HIM professional assigned to manage the audit response and resolution.',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: RAC audit response workflow: audits request clinical documentation, which is submitted as CDA documents. Tracking which CDA document was submitted in response to each audit enables audit management, r',
    `tertiary_rac_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the individual who last modified this audit record.',
    `visit_id` BIGINT COMMENT 'Foreign key reference to the patient visit or encounter associated with the audited claim or billing record.',
    `appeal_decision_date` DATE COMMENT 'Date the appeal decision was issued by the reviewing authority (MAC, QIC, ALJ, Appeals Council, or Federal Court).',
    `appeal_filed_date` DATE COMMENT 'Date the organization filed an appeal of the audit findings. Typically must be within 120 days of determination letter for Medicare RAC audits.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the organization filed an appeal of the audit findings. True if appeal was filed, False if no appeal.',
    `appeal_level` STRING COMMENT 'Current level in the Medicare appeals process. Redetermination (Level 1), Reconsideration by QIC (Level 2), ALJ Hearing (Level 3), Medicare Appeals Council Review (Level 4), Federal Court (Level 5).. Valid values are `redetermination|reconsideration|alj_hearing|mac_review|federal_court`',
    `appeal_outcome_amount` DECIMAL(18,2) COMMENT 'Final monetary amount after appeal resolution. May differ from original finding_amount if appeal was partially or fully favorable.',
    `appeal_status` STRING COMMENT 'Current status or outcome of the appeal. Pending (under review), upheld (original finding affirmed), overturned (finding reversed), partially favorable (partial reversal), withdrawn, or dismissed.. Valid values are `pending|upheld|overturned|partially_favorable|withdrawn|dismissed`',
    `audit_notes` STRING COMMENT 'Free-text notes documenting audit details, correspondence with auditor, internal review findings, and resolution activities.',
    `audit_number` STRING COMMENT 'External audit reference number assigned by the auditing contractor or agency. Business identifier for tracking and correspondence.',
    `audit_period_end_date` DATE COMMENT 'Ending date of the service period under audit review. Defines the temporal scope of claims and billing records subject to audit.',
    `audit_period_start_date` DATE COMMENT 'Beginning date of the service period under audit review. Defines the temporal scope of claims and billing records subject to audit.',
    `audit_request_date` DATE COMMENT 'Date the audit request or Additional Documentation Request (ADR) was received by the organization. Principal business event timestamp for the audit lifecycle.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Tracks progression from initial request through resolution and closure. [ENUM-REF-CANDIDATE: requested|in_progress|findings_issued|appeal_filed|appeal_pending|resolved|closed — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit program. RAC (Recovery Audit Contractor), MAC (Medicare Administrative Contractor), OIG (Office of Inspector General), ZPIC (Zone Program Integrity Contractor), UPIC (Unified Program Integrity Contractor), internal compliance, payer audit, state Medicaid, or quality review. [ENUM-REF-CANDIDATE: rac|mac|oig|zpic|upic|internal_compliance|payer_audit|state_medicaid|quality_review — 9 candidates stripped; promote to reference product]',
    `compliance_resolution_status` STRING COMMENT 'Status of internal compliance remediation activities in response to audit findings. Tracks corrective action plan development, implementation, and validation.. Valid values are `open|corrective_action_plan_submitted|corrective_action_implemented|validated|closed`',
    `contractor_jurisdiction` STRING COMMENT 'Geographic or organizational jurisdiction of the auditing contractor (e.g., Region A, Region B, statewide, national).',
    `contractor_name` STRING COMMENT 'Name of the auditing organization or contractor conducting the audit (e.g., Cotiviti, Performant, HMS, or internal compliance department).',
    `corrective_action_description` STRING COMMENT 'Narrative description of corrective actions taken to remediate audit findings and prevent recurrence (e.g., staff training, policy updates, system enhancements, coding review process changes).',
    `corrective_action_plan_date` DATE COMMENT 'Date the organization submitted or finalized a corrective action plan to address systemic issues identified in the audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system. Audit trail for record creation.',
    `extrapolation_flag` BOOLEAN COMMENT 'Indicates whether the auditor applied statistical extrapolation to project findings from a sample to a larger population of claims. True if extrapolation was used, False otherwise.',
    `extrapolation_sample_size` STRING COMMENT 'Number of claims in the statistical sample used for extrapolation, if extrapolation_flag is True.',
    `extrapolation_universe_size` STRING COMMENT 'Total number of claims in the population to which sample findings were extrapolated, if extrapolation_flag is True.',
    `finding_amount` DECIMAL(18,2) COMMENT 'Total monetary amount identified in the audit finding. Positive for overpayments (amounts owed to payer), negative for underpayments (amounts owed to provider).',
    `finding_type` STRING COMMENT 'Classification of the audit finding. Overpayment (provider must refund), underpayment (provider owed additional payment), no finding (claim upheld), documentation deficiency, coding error, medical necessity denial, or coverage denial. [ENUM-REF-CANDIDATE: overpayment|underpayment|no_finding|documentation_deficiency|coding_error|medical_necessity|coverage_denial — 7 candidates stripped; promote to reference product]',
    `findings_issued_date` DATE COMMENT 'Date the auditor issued formal findings, determination letter, or demand letter communicating audit results.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest charges applied to overpayment amounts per statutory requirements. Calculated from date of overpayment to date of recoupment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last updated. Audit trail for record modification.',
    `overpayment_amount` DECIMAL(18,2) COMMENT 'Amount determined to have been overpaid to the provider and subject to recoupment. Subset of finding_amount when finding_type is overpayment.',
    `records_requested_count` STRING COMMENT 'Number of medical records, claims, or billing documents requested by the auditor for review.',
    `records_submitted_count` STRING COMMENT 'Number of medical records, claims, or billing documents actually submitted to the auditor in response to the request.',
    `recoupment_amount` DECIMAL(18,2) COMMENT 'Actual amount recouped or offset from future payments by the payer. May differ from overpayment_amount if partial recoupment, payment plan, or appeal adjustments occurred.',
    `recoupment_date` DATE COMMENT 'Date the payer initiated recoupment or offset of the overpayment amount from provider payments.',
    `recoupment_method` STRING COMMENT 'Method by which the overpayment was recovered. Offset (deducted from future payments), direct payment (check or EFT), installment plan (extended payment agreement), settlement (negotiated amount), or waived.. Valid values are `offset|direct_payment|installment_plan|settlement|waived`',
    `response_due_date` DATE COMMENT 'Deadline by which the organization must submit requested documentation to the auditor. Typically 45 days from ADR receipt for RAC audits.',
    `response_submitted_date` DATE COMMENT 'Date the organization submitted the requested documentation to the auditor.',
    `underpayment_amount` DECIMAL(18,2) COMMENT 'Amount determined to have been underpaid to the provider and subject to additional reimbursement. Subset of finding_amount when finding_type is underpayment.',
    CONSTRAINT pk_rac_audit PRIMARY KEY(`rac_audit_id`)
) COMMENT 'Post-payment audit record tracking CMS-initiated, payer-initiated, or internal audits of submitted claims and billing records. Covers RAC (Recovery Audit Contractor), MAC (Medicare Administrative Contractor), OIG (Office of Inspector General), ZPIC (Zone Program Integrity Contractor), and internal compliance audits. Owns audit type, audit contractor name, audit request date, records requested, audit period, findings type (overpayment, underpayment, no finding), finding amount, appeal filed flag, appeal level, appeal outcome, recoupment amount, recoupment date, and compliance resolution status. SSOT for post-payment audit management, compliance tracking, and audit response workflow in the billing domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` (
    `charity_care_application_id` BIGINT COMMENT 'Unique identifier for the charity care application. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the authorized user who approved the charity care application.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Financial assistance programs must reference governing policies for eligibility determination, discount schedules, and IRS 501(r) compliance. Required for regulatory audits, presumptive eligibility do',
    `guarantor_id` BIGINT COMMENT 'Identifier of the guarantor responsible for the account associated with this application.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient submitting the financial assistance application.',
    `patient_identity_match_id` BIGINT COMMENT 'Foreign key linking to interoperability.patient_identity_match. Business justification: Financial assistance via HIE: charity care applications submitted through patient portals or HIE require patient identity matching to link external applications to internal MPI records. Tracking which',
    `primary_charity_employee_id` BIGINT COMMENT 'Identifier of the financial counselor or staff member who reviewed and processed the application.',
    `tertiary_charity_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the charity care application record.',
    `visit_id` BIGINT COMMENT 'Identifier of the visit or encounter for which financial assistance is requested. May be null for prospective applications.',
    `appeal_date` DATE COMMENT 'Date the patient submitted an appeal of the denied charity care application.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether the patient has filed an appeal of a denied charity care application.',
    `appeal_status` STRING COMMENT 'Current status of the charity care application appeal process.. Valid values are `pending|approved|denied|withdrawn`',
    `application_date` DATE COMMENT 'Date the charity care application was submitted by the patient or guarantor.',
    `application_method` STRING COMMENT 'Method by which the charity care application was submitted (online portal, paper form, phone interview, in-person, mail, fax).. Valid values are `online_portal|paper_form|phone|in_person|mail|fax`',
    `application_number` STRING COMMENT 'Externally-visible unique application number assigned to this charity care request for tracking and reference purposes.',
    `application_source` STRING COMMENT 'Source or origin of the charity care application (patient-initiated, staff-initiated during screening, automated presumptive eligibility, third-party referral).. Valid values are `patient_initiated|staff_initiated|screening_tool|presumptive_eligibility|third_party`',
    `application_status` STRING COMMENT 'Current lifecycle status of the charity care application in the review and approval workflow. [ENUM-REF-CANDIDATE: pending|under_review|approved|denied|withdrawn|expired|incomplete — 7 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date the charity care application was approved by the financial counselor or review committee.',
    `approval_status` STRING COMMENT 'Final approval decision for the charity care application after review and documentation verification.. Valid values are `pending|approved|denied|conditional`',
    `approved_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount approved for the patients account charges under the financial assistance program. 100% indicates full charity care.',
    `coverage_period_months` STRING COMMENT 'Number of months for which the approved financial assistance is valid before requiring renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the charity care application record was first created in the system.',
    `denial_date` DATE COMMENT 'Date the charity care application was denied.',
    `denial_reason` STRING COMMENT 'Reason for denial of the charity care application (e.g., income exceeds threshold, incomplete documentation, failure to respond).',
    `documentation_status` STRING COMMENT 'Status of supporting documentation (income verification, tax returns, pay stubs, etc.) required for the application review process.. Valid values are `not_submitted|submitted|verified|incomplete|rejected`',
    `documentation_type` STRING COMMENT 'Type of supporting documentation provided (e.g., tax return, pay stub, unemployment statement, social security statement, bank statement).',
    `effective_date` DATE COMMENT 'Date from which the approved financial assistance discount becomes effective and can be applied to patient charges.',
    `expiration_date` DATE COMMENT 'Date on which the approved financial assistance eligibility expires and requires re-application or re-verification.',
    `family_size` STRING COMMENT 'Number of individuals in the applicants household, used in conjunction with household income to calculate Federal Poverty Level (FPL) percentage.',
    `fap_notification_date` DATE COMMENT 'Date the patient was notified of the availability of the Financial Assistance Policy (FAP) as required by IRS 501(r).',
    `fpl_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of the Federal Poverty Level based on household income and family size, used to determine eligibility tier for financial assistance.',
    `household_income` DECIMAL(18,2) COMMENT 'Total annual household income reported by the applicant, used to determine eligibility for financial assistance programs.',
    `irs_501r_compliance_flag` BOOLEAN COMMENT 'Indicates whether this charity care application and its processing comply with IRS 501(r) community benefit requirements for tax-exempt hospitals.',
    `language_preference` STRING COMMENT 'Preferred language for application materials and communication with the patient (e.g., English, Spanish, Chinese).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the charity care application record was last modified or updated.',
    `medicaid_application_date` DATE COMMENT 'Date the patient submitted their Medicaid application, if applicable.',
    `medicaid_pending_flag` BOOLEAN COMMENT 'Indicates whether the patient has a pending Medicaid application at the time of charity care application submission.',
    `notes` STRING COMMENT 'Free-text notes and comments from financial counselors or reviewers regarding the application, documentation, or special circumstances.',
    `plain_language_summary_provided_flag` BOOLEAN COMMENT 'Indicates whether the patient was provided with a plain language summary of the Financial Assistance Policy as required by IRS 501(r).',
    `presumptive_eligibility_basis` STRING COMMENT 'Basis for granting presumptive eligibility (e.g., SNAP enrollment, Medicaid pending, homelessness, state assistance program participation).',
    `presumptive_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the patient was granted presumptive eligibility for charity care based on participation in other assistance programs (SNAP, WIC, Medicaid pending, homelessness) without full income documentation.',
    `program_type` STRING COMMENT 'Type of financial assistance program for which the patient is applying (full charity care, partial charity, sliding scale discount, Medicaid presumptive eligibility, or other assistance).. Valid values are `full_charity|partial_charity|sliding_scale|medicaid_presumptive|emergency_medicaid|prompt_pay_discount`',
    `screening_score` DECIMAL(18,2) COMMENT 'Automated financial screening score calculated from initial patient information to predict eligibility for financial assistance.',
    CONSTRAINT pk_charity_care_application PRIMARY KEY(`charity_care_application_id`)
) COMMENT 'Financial assistance application submitted by a patient requesting charity care, sliding-scale discounts, or other financial assistance programs. Owns application date, program type (full charity, partial charity, sliding scale, Medicaid presumptive eligibility), household income, family size, federal poverty level percentage, supporting documentation status, approval status, approved discount percentage, approval date, and effective period. Supports compliance with IRS 501(r) community benefit requirements and EMTALA financial screening obligations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`refund` (
    `refund_id` BIGINT COMMENT 'Unique identifier for the refund transaction. Primary key for the refund product.',
    `ar_transaction_id` BIGINT COMMENT 'External transaction identifier from the payment processor or banking system for the refund transaction.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: CMS requires quarterly credit balance reporting by provider (facility). Refunds must be tracked by facility for regulatory compliance, financial reconciliation, and audit trails. Essential for Medicar',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Refunds result from claim overpayments identified during remittance processing or post-payment audits. CMS credit balance reporting and payer refund workflows require linking refunds to the claims tha',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who is the recipient of the refund.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor or financially responsible party receiving the refund.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim associated with the original payment being refunded.',
    `original_refund_id` BIGINT COMMENT 'Self-referencing FK on refund (original_refund_id)',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer receiving the refund if the refund is issued to an insurance company.',
    `payment_id` BIGINT COMMENT 'Reference to the original payment transaction that is being refunded.',
    `rac_audit_id` BIGINT COMMENT 'Reference to the RAC audit that mandated or triggered this refund, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created the refund record in the system.',
    `refund_employee_id` BIGINT COMMENT 'Reference to the user or role who approved the refund transaction, used for audit trail and accountability.',
    `refund_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the refund record in the system.',
    `refund_voided_by_user_employee_id` BIGINT COMMENT 'Reference to the user who voided or cancelled the refund, used for audit trail purposes.',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with the original payment being refunded.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount being refunded to the recipient. Represents the gross refund value before any adjustments.',
    `approval_date` DATE COMMENT 'The date when the refund was officially approved by the authorized approver.',
    `refund_category` STRING COMMENT 'High-level classification of the refund reason category for reporting and analytics purposes.. Valid values are `overpayment|duplicate|credit_balance|rac_ordered|patient_request|payer_request`',
    `check_number` STRING COMMENT 'The check number if the refund was issued via paper check, used for reconciliation and tracking.',
    `cleared_date` DATE COMMENT 'The date when the refund payment cleared the bank or payment processor and was successfully received by the recipient.',
    `cms_credit_balance_report_flag` BOOLEAN COMMENT 'Boolean indicator showing whether this refund must be reported on the CMS credit balance report for Medicare compliance.',
    `cms_report_date` DATE COMMENT 'The date when this refund was reported to CMS as part of credit balance reporting requirements.',
    `cost_center_code` STRING COMMENT 'Cost center or department code associated with the refund for internal financial tracking and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the refund record was first created in the system.',
    `credit_card_last_four` STRING COMMENT 'Last four digits of the credit card number if the refund was issued as a credit card reversal, used for identification without exposing full card number.. Valid values are `^[0-9]{4}$`',
    `credit_card_type` STRING COMMENT 'The type or brand of credit card if the refund was issued as a credit card reversal.. Valid values are `visa|mastercard|amex|discover|other`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund amount (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `disbursement_date` DATE COMMENT 'The date when the refund payment was actually issued or disbursed to the recipient.',
    `eft_trace_number` STRING COMMENT 'The trace or confirmation number for electronic funds transfer refunds, used for payment tracking and reconciliation.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the refund transaction is posted for financial accounting purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the refund record was last updated or modified in the system.',
    `method` STRING COMMENT 'The payment instrument or mechanism used to disburse the refund (e.g., check, electronic funds transfer, credit card reversal).. Valid values are `check|eft|wire|credit_card_reversal|cash|offset`',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context or details about the refund transaction.',
    `number` STRING COMMENT 'Externally visible unique business identifier for the refund transaction, used for tracking and reconciliation.',
    `original_payment_amount` DECIMAL(18,2) COMMENT 'The amount of the original payment transaction that is being refunded, used for reconciliation and audit purposes.',
    `payee_address_line_1` STRING COMMENT 'First line of the mailing address where the refund is sent.',
    `payee_address_line_2` STRING COMMENT 'Second line of the mailing address where the refund is sent (suite, apartment, etc.).',
    `payee_city` STRING COMMENT 'City name for the refund payee mailing address.',
    `payee_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the refund payee mailing address.. Valid values are `^[A-Z]{3}$`',
    `payee_name` STRING COMMENT 'The name of the individual or organization receiving the refund, as it appears on the refund instrument.',
    `payee_postal_code` STRING COMMENT 'Postal or ZIP code for the refund payee mailing address.',
    `payee_state` STRING COMMENT 'Two-letter state or province code for the refund payee mailing address.. Valid values are `^[A-Z]{2}$`',
    `reason_code` STRING COMMENT 'Standardized code representing the specific reason for issuing the refund.',
    `reason_description` STRING COMMENT 'Detailed textual explanation of the reason for issuing the refund, providing context beyond the reason code.',
    `reconciliation_date` DATE COMMENT 'The date when the refund was reconciled with bank statements and financial records.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the refund has been successfully reconciled with bank statements and financial records.. Valid values are `pending|reconciled|unreconciled|exception`',
    `request_date` DATE COMMENT 'The date when the refund was initially requested or identified as necessary.',
    `refund_status` STRING COMMENT 'Current lifecycle status of the refund transaction indicating its progression through the refund workflow. [ENUM-REF-CANDIDATE: requested|pending_approval|approved|issued|cleared|voided|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `refund_type` STRING COMMENT 'Classification of the refund recipient type indicating whether the refund is issued to a patient, guarantor, insurance payer, or vendor.. Valid values are `patient|guarantor|payer|vendor`',
    `void_date` DATE COMMENT 'The date when the refund was voided or cancelled.',
    `void_flag` BOOLEAN COMMENT 'Boolean indicator showing whether the refund has been voided or cancelled after issuance.',
    `void_reason` STRING COMMENT 'Explanation of why the refund was voided or cancelled after issuance.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Record of a refund issued to a patient, guarantor, or insurance payer for overpayments, duplicate payments, or credit balances. Owns refund type (patient/payer), refund reason (overpayment, duplicate, credit balance, RAC-ordered), refund amount, original payment reference, refund method (check, EFT, credit card reversal), refund request date, approval date, approval authority, disbursement date, check/EFT number, refund status (requested, approved, issued, cleared, voided), and reconciliation status. SSOT for all outbound payment disbursements in the revenue cycle. Critical for credit balance management, CMS credit balance reporting (Medicare), and financial reconciliation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` (
    `invoice_coverage_billing_id` BIGINT COMMENT 'Primary key for the invoice_coverage_billing association',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to the insurance coverage to which this invoice is being billed',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to the invoice being submitted for payment',
    `adjudication_date` DATE COMMENT 'The date this payer completed adjudication and issued payment or denial for this invoice. Received from remittance advice (835).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The amount this specific payer determined as allowable for this invoice based on their contract or fee schedule. Returned in the remittance advice (835).',
    `check_eft_number` STRING COMMENT 'The check number or electronic funds transfer trace number for the payment received from this payer for this invoice.',
    `claim_filing_indicator_code` STRING COMMENT 'Two-character code indicating the type of insurance plan for this specific claim submission (e.g., MA=Medicare Part A, MB=Medicare Part B, MC=Medicaid, 09=Self Pay, 11=Other Non-Federal Programs).',
    `claim_status` STRING COMMENT 'The current lifecycle status of this specific claim submission to this payer. Tracks the claim through submission, adjudication, payment, and potential appeal.',
    `clearinghouse_trace_number` STRING COMMENT 'Unique identifier assigned by the clearinghouse for this specific claim submission. Used for claim status inquiries (276/277) and troubleshooting.',
    `contractual_adjustment` DECIMAL(18,2) COMMENT 'The write-off amount for this specific payer representing the difference between submitted charges and allowed amount per contract terms.',
    `coordination_of_benefits_order` STRING COMMENT 'The sequence in which this coverage is billed for this invoice in the COB waterfall. Primary is billed first, secondary after primary adjudication, tertiary after secondary.',
    `coverage_status_at_billing` STRING COMMENT 'The eligibility status of the coverage at the time this invoice was submitted to this payer. Captures point-in-time status for audit and denial management.',
    `denial_reason_code` STRING COMMENT 'The reason code provided by this payer if the claim was denied or partially denied. Used for denial management and appeal workflows.',
    `denial_reason_description` STRING COMMENT 'Human-readable description of why this payer denied or partially denied this claim. Supports denial management and staff training.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The actual amount paid by this specific payer for this invoice. Posted from remittance advice (835) or manual payment posting.',
    `patient_responsibility` DECIMAL(18,2) COMMENT 'The amount this specific payer determined the patient is responsible for (copay, coinsurance, deductible) for this invoice. Used to calculate patient statements.',
    `payer_claim_control_number` STRING COMMENT 'Unique identifier assigned by this payer for this claim submission. Returned in acknowledgment (999/277) and used in all correspondence with the payer.',
    `remittance_advice_number` STRING COMMENT 'The 835 remittance advice transaction number that contained the payment or denial information for this claim submission.',
    `submission_date` DATE COMMENT 'The date this invoice was submitted to this specific payer. Used for timely filing tracking and aging reports.',
    `submitted_amount` DECIMAL(18,2) COMMENT 'The total charge amount submitted to this specific payer for this invoice. May differ from invoice total_charges based on COB order and prior payer payments.',
    CONSTRAINT pk_invoice_coverage_billing PRIMARY KEY(`invoice_coverage_billing_id`)
) COMMENT 'This association product represents the claim submission event between an invoice and a specific insurance coverage in the coordination of benefits (COB) sequence. It captures the billing lifecycle for each payer in the COB order (primary, secondary, tertiary). Each record links one invoice to one coverage with submission-specific attributes including amounts billed, allowed, paid, patient responsibility, adjudication dates, and claim status. This is the operational record of each claim filing required by CMS and payer regulations for multi-coverage scenarios.. Existence Justification: In healthcare billing, a single invoice is routinely submitted to multiple insurance coverages in sequence (primary, secondary, tertiary) as mandated by Coordination of Benefits (COB) regulations. Each submission is a distinct operational event with its own amounts, dates, claim status, payer control numbers, and adjudication outcomes. Conversely, a single coverage receives claims from many different invoices over time. This is not an analytical correlation—it is an actively managed business process with regulatory requirements, tracked lifecycle states, and dedicated staff (claims specialists) who monitor submission status, handle denials, and manage appeals for each invoice-coverage pairing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` (
    `billing_network_participation_id` BIGINT COMMENT 'Primary key for billing_network_participation',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to the insurance coverage record representing the payer plan in this network relationship',
    `billing_insurance_network_participation_id` BIGINT COMMENT 'FK to SSOT owner insurance.insurance_network_participation for the network_participation entity.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to the care delivery site participating in this payer network',
    `insurance_network_participation_id` BIGINT COMMENT 'Unique identifier for this payer-facility network participation record. Primary key.',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether this payer requires prior authorization for services delivered at this specific care site. Authorization requirements vary by payer-facility contract terms. Moved from coverage product where it was incorrectly stored as a plan-level attribute rather than a payer-facility relationship attribute.',
    `contract_status` STRING COMMENT 'Current lifecycle status of this payer-facility network participation contract. Active indicates contract is in force and network benefits apply.',
    `contract_type` STRING COMMENT 'Classification of the network participation contract type. Determines scope of services covered and patient access rules.',
    `contracted_rate_schedule` STRING COMMENT 'Reference to the fee schedule or rate table governing reimbursement for services provided at this care site under this payer contract. Different payer-facility contracts have different negotiated rate schedules.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this network participation record was initially created in the system.',
    `effective_date` DATE COMMENT 'Date when this payer-facility network participation contract becomes effective. Determines when in-network benefits and contracted rates apply. This is the contract effective date, distinct from the patient coverage effective date stored in the coverage product.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this network participation record was last modified. Used for change tracking and audit purposes.',
    `network_status` STRING COMMENT 'Indicates whether this care site is in-network, out-of-network, or has partial network status for this specific payer plan. Determines patient cost-sharing and reimbursement rates. Moved from coverage product where it was incorrectly stored as a coverage-level attribute rather than a payer-facility relationship attribute.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether this payer requires a PCP referral for services at this specific care site. Referral requirements vary by payer-facility contract and service type. Moved from coverage product where it was incorrectly stored as a plan-level attribute rather than a payer-facility relationship attribute.',
    `termination_date` DATE COMMENT 'Date when this payer-facility network participation contract terminates. Null indicates an active ongoing contract. This is the contract termination date, distinct from the patient coverage termination date stored in the coverage product.',
    `tier_level` STRING COMMENT 'Tier designation for this care site within the payers tiered network structure. Affects patient cost-sharing levels. Null if payer does not use tiered networks.',
    CONSTRAINT pk_billing_network_participation PRIMARY KEY(`billing_network_participation_id`)
) COMMENT 'This association product represents the contractual network participation relationship between insurance coverage plans and care delivery sites. It captures payer-facility network contracts that determine whether a care site is in-network or out-of-network for a specific payer plan, along with authorization requirements, referral rules, and contract effective periods. Each record links one coverage (representing a payer plan) to one care site with contract terms that exist only in the context of this payer-facility network relationship. This is the operational SSOT for network status determination during patient registration, eligibility verification, and claims adjudication workflows.. Existence Justification: In healthcare revenue cycle operations, payer organizations establish network contracts with multiple care delivery sites across an integrated delivery network, and each care site participates in network agreements with multiple payers. Network participation is an actively managed contractual relationship with specific terms (in-network status, authorization requirements, contracted rates, effective dates) that vary by each unique payer-facility pair. Revenue cycle staff query network participation during patient registration to determine coverage implications, and contract management teams maintain these relationships as payers and facilities negotiate, renew, or terminate network agreements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` (
    `study_service_coverage_id` BIGINT COMMENT 'Unique identifier for this study-service coverage record. Primary key.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to the CDM entry representing the billable service or supply item',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to the research study for which this billing rule applies',
    `billing_notes` STRING COMMENT 'Free-text notes documenting special billing instructions, coverage rationale, or protocol-specific guidance for this service within this study. Used by billing staff during charge review.',
    `coverage_determination` STRING COMMENT 'Indicates who is responsible for payment of this service within the context of this research study. Determines billing routing and payer assignment for charges incurred during study participation.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this coverage record was created in the system.',
    `effective_date` DATE COMMENT 'The date on which this coverage determination and billing rule becomes effective for this study-service combination. Supports protocol amendments that change billing policies mid-study.',
    `expiration_date` DATE COMMENT 'The date on which this coverage determination expires or was superseded by a protocol amendment. Null if currently active. Maintains billing rule version history for audit and compliance.',
    `last_updated_by` STRING COMMENT 'User ID of the person who last modified this coverage determination record.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this coverage record was last modified.',
    `reimbursement_rate` DECIMAL(18,2) COMMENT 'The negotiated reimbursement rate for this CDM item within this specific research study. May differ from the standard CDM charge amount based on sponsor agreements or institutional research billing policies.',
    `sponsor_approval_date` DATE COMMENT 'Date on which the study sponsor approved this billing arrangement for this service. Required for sponsor-funded studies to document financial agreement.',
    `standard_of_care_flag` BOOLEAN COMMENT 'Indicates whether this service is considered standard of care (billable to insurance) versus research-only (billable to sponsor or not billable) within the context of this study protocol.',
    `created_by` STRING COMMENT 'User ID of the person who created this coverage determination record.',
    CONSTRAINT pk_study_service_coverage PRIMARY KEY(`study_service_coverage_id`)
) COMMENT 'This association product represents the coverage determination and billing rules between CDM entries and research studies. It captures study-specific billing policies, reimbursement rates, and coverage determinations for each billable service used in a research protocol. Each record links one CDM entry to one research study with attributes that define whether the service is billed as research versus standard-of-care, the negotiated reimbursement rate for that study, and the effective period for those billing rules.. Existence Justification: In healthcare research operations, a single billable service (CDM entry) such as an MRI scan or lab test is routinely used across multiple research studies, and each research study requires multiple billable services as defined in its protocol. The billing treatment of each service varies by study based on sponsor agreements, protocol design, and standard-of-care determinations. Healthcare billing operations must maintain study-specific coverage rules, reimbursement rates, and effective dates for each service-study combination to ensure compliant charge routing and accurate claims submission.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` (
    `site_cdm_pricing_id` BIGINT COMMENT 'Unique identifier for this site-specific CDM pricing configuration record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to the care site where this CDM pricing configuration applies',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to the CDM entry being priced at this care site',
    `employee_id` BIGINT COMMENT 'Identifier of the revenue cycle user who last updated this site-specific pricing configuration.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this CDM item is active and available for charge capture at this specific care site. A CDM entry may be active at some sites but inactive at others based on service capability.',
    `effective_date` DATE COMMENT 'Date on which this site-specific CDM pricing configuration becomes effective. Supports site-specific pricing changes and rollouts.',
    `expiration_date` DATE COMMENT 'Date on which this site-specific CDM pricing configuration expires. Supports time-bound pricing agreements and service line changes.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this site-specific CDM pricing configuration was last modified. Supports audit and change tracking.',
    `payer_contract_reference` STRING COMMENT 'Reference to the payer contract or pricing agreement that drives the site-specific pricing for this CDM item at this care site.',
    `site_cost_amount` DECIMAL(18,2) COMMENT 'Estimated cost to provide this service or supply at this specific care site, which may vary due to local labor costs, supply chain agreements, or operational efficiency.',
    `site_specific_price` DECIMAL(18,2) COMMENT 'The charge amount for this CDM item at this specific care site, which may differ from the standard CDM charge_amount due to site-specific cost structures, payer contracts, or market conditions.',
    `site_specific_revenue_code` STRING COMMENT 'Four-digit UB-04 revenue code that may vary by site due to different service delivery models or billing requirements at this care site.',
    CONSTRAINT pk_site_cdm_pricing PRIMARY KEY(`site_cdm_pricing_id`)
) COMMENT 'This association product represents the site-specific pricing and activation configuration between CDM entries and care sites. It captures the operational reality that charge master items are priced, activated, and configured differently across facilities within an integrated delivery network due to varying payer contracts, state regulations, cost structures, and service capabilities. Each record links one CDM entry to one care site with site-specific pricing, revenue coding, and activation status that exist only in the context of that facilitys charge capture operations.. Existence Justification: In integrated delivery networks (IDNs), CDM entries are configured with site-specific pricing, revenue codes, and activation status across multiple care sites due to varying payer contracts, state regulations, cost structures, and service capabilities. Revenue cycle teams actively manage these site-specific configurations as operational business records, adjusting prices and activation status based on local market conditions, contract negotiations, and service line changes. This is not an analytical correlation but an operational configuration that humans create, update, and query.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` (
    `invoice_material_line_id` BIGINT COMMENT 'Unique surrogate key for each invoice line item record. Primary key for the association.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to the parent invoice record. Each line item belongs to exactly one invoice.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the supply item being billed. References the material master record for item identification and attributes.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'The payer-approved reimbursement amount for this line item based on contract terms. May be less than line_amount due to contractual adjustments.',
    `denial_reason_code` STRING COMMENT 'Payer-provided reason code if this line item was denied or rejected. Used for denial management and resubmission workflows.',
    `hcpcs_code` STRING COMMENT 'Healthcare Common Procedure Coding System (HCPCS) code for the supply item. Used for reimbursement and regulatory reporting. May be Level I (CPT) or Level II (national codes).',
    `line_amount` DECIMAL(18,2) COMMENT 'The total charge amount for this line item, calculated as quantity_billed × unit_price. Contributes to the invoice total_charges.',
    `line_number` BIGINT COMMENT 'Sequential line number within the parent invoice. Used for ordering and referencing specific line items on the claim form.',
    `line_status` STRING COMMENT 'Status of this individual line item in the billing workflow. Examples: draft, ready, submitted, accepted, rejected, denied, paid. Allows line-level tracking independent of invoice status.',
    `modifier_codes` STRING COMMENT 'Two-character CPT/HCPCS modifier codes appended to the procedure or supply code to provide additional information about the service. Multiple modifiers separated by commas. Examples: LT=Left side, RT=Right side, 59=Distinct procedural service.',
    `ndc_code` STRING COMMENT 'National Drug Code for pharmaceutical supply items billed on this line. Required for drug billing under many payer contracts. Denormalized from material_master for claim submission convenience.',
    `ndc_quantity` DECIMAL(18,2) COMMENT 'Quantity in NDC units (e.g., milliliters, grams) for pharmaceutical items. May differ from quantity_billed if billing unit differs from NDC unit.',
    `ndc_unit_of_measure` STRING COMMENT 'Unit of measure for NDC quantity. Examples: ML=milliliters, GR=grams, UN=units. Required for drug billing.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The actual amount paid by the payer for this line item. May differ from allowed_amount due to deductibles, copays, or coinsurance.',
    `quantity_billed` DECIMAL(18,2) COMMENT 'The quantity of the supply item billed on this line. Represents units consumed or implanted during the service period. Critical for reimbursement calculation.',
    `revenue_code` STRING COMMENT 'Four-digit UB-04 revenue code indicating the type of service or accommodation for this line item. Examples: 0272=Medical/Surgical Supplies, 0278=Implants, 0636=Drugs. Required for facility billing.',
    `service_date` DATE COMMENT 'The specific date this supply item was used or implanted. May differ from the invoice service_from_date/service_through_date for multi-day encounters. Required for accurate claim adjudication.',
    `udi` STRING COMMENT 'FDA-mandated Unique Device Identifier for implantable devices billed on this line. Required for implant tracking and adverse event reporting. Denormalized from material_master for regulatory compliance.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit for this supply item on this specific invoice line. May differ from catalog price based on contract terms, patient type, or service context.',
    CONSTRAINT pk_invoice_material_line PRIMARY KEY(`invoice_material_line_id`)
) COMMENT 'This association product represents the line-level billing detail between an invoice and a supply item. It captures the specific quantity, pricing, and revenue coding for each supply item billed on a healthcare invoice. Each record links one invoice to one material master item with attributes that exist only in the context of this billing relationship. This is the operational record created during charge capture and claim submission processes.. Existence Justification: In healthcare billing operations, a single invoice routinely bills for multiple supply items (sutures, implants, drugs, prosthetics) used during a patient encounter, and each supply item appears on many invoices across different patients and encounters. The business actively manages these line items as operational records during charge capture, claim scrubbing, and submission workflows. Revenue cycle staff create, review, edit, and resubmit these line-level billing records as part of daily operations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_original_charge_id` FOREIGN KEY (`original_charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_charity_care_application_id` FOREIGN KEY (`charity_care_application_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charity_care_application`(`charity_care_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_collection_account_id` FOREIGN KEY (`collection_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`collection_account`(`collection_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_rac_audit_id` FOREIGN KEY (`rac_audit_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`rac_audit`(`rac_audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_charity_care_application_id` FOREIGN KEY (`charity_care_application_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charity_care_application`(`charity_care_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_charity_care_application_id` FOREIGN KEY (`charity_care_application_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charity_care_application`(`charity_care_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_collection_account_id` FOREIGN KEY (`collection_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`collection_account`(`collection_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_original_write_off_id` FOREIGN KEY (`original_write_off_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`write_off`(`write_off_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_rac_audit_id` FOREIGN KEY (`rac_audit_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`rac_audit`(`rac_audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_original_refund_id` FOREIGN KEY (`original_refund_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`refund`(`refund_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_rac_audit_id` FOREIGN KEY (`rac_audit_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`rac_audit`(`rac_audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ADD CONSTRAINT `fk_billing_invoice_coverage_billing_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ADD CONSTRAINT `fk_billing_invoice_coverage_billing_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ADD CONSTRAINT `fk_billing_billing_network_participation_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ADD CONSTRAINT `fk_billing_study_service_coverage_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ADD CONSTRAINT `fk_billing_invoice_material_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_fk_count_review' = 'exceeds_max_25');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `case_cart_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Capture - Case Cart Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_ordering_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Voided By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `original_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Original Charge Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `correction_reason` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `expected_reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `gross_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hold_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `implant_flag` SET TAGS ('dbx_business_glossary_term' = 'Implant Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Billable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_corrected` SET TAGS ('dbx_business_glossary_term' = 'Corrected Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_patient_responsible` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsible Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Voided Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Charge Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Charge Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Quantity Used from Cart');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `released_date` SET TAGS ('dbx_business_glossary_term' = 'Released Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_end_time` SET TAGS ('dbx_business_glossary_term' = 'Service End Time');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Start Time');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'professional|facility|ancillary|pharmacy|supply|accommodation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `waste_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('dbx_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Description Master (CDM) Entry Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `apc_code` SET TAGS ('dbx_business_glossary_term' = 'Ambulatory Payment Classification (APC) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `apc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `bundled_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundled Payment Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Description Master (CDM) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description Master (CDM) Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_capture_method` SET TAGS ('dbx_business_glossary_term' = 'Charge Capture Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_capture_method` SET TAGS ('dbx_value_regex' = 'manual|interface|order_driven|implant_log|supply_chain|pharmacy');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `default_quantity` SET TAGS ('dbx_business_glossary_term' = 'Default Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Item Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `last_price_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `price_transparency_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Transparency Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `requires_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `revenue_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Malpractice Component');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Practice Expense Component');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Component');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `type_of_bill_code` SET TAGS ('dbx_business_glossary_term' = 'Type of Bill (TOB) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `type_of_bill_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'claims_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('dbx_business_glossary_term' = 'Fhir Resource Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `primary_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `provider_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `tertiary_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Payer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{1,2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `admission_type_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Type Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `admission_type_code` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|9');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied|appeal_partially_approved');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bad_debt_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Write-Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bad_debt_date` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bill_type_code` SET TAGS ('dbx_business_glossary_term' = 'Bill Type Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `bill_type_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Control Number (CCN)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `contractual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `covered_charges` SET TAGS ('dbx_business_glossary_term' = 'Covered Charges Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Status Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `form_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Form Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `form_type` SET TAGS ('dbx_value_regex' = 'CMS-1500|UB-04|ADA-2012|NCPDP');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_payment` SET TAGS ('dbx_business_glossary_term' = 'Insurance Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `non_covered_charges` SET TAGS ('dbx_business_glossary_term' = 'Non-Covered Charges Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_payment` SET TAGS ('dbx_business_glossary_term' = 'Patient Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `revenue_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `service_through_date` SET TAGS ('dbx_business_glossary_term' = 'Service Through Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `statement_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic_837|paper_mail|clearinghouse|direct_payer_portal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `total_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Charges Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'professional|facility|institutional|ancillary|durable_medical_equipment|home_health');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'claims_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `adjudicated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudicated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `claim_adjustment_group_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Group Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `claim_adjustment_group_code` SET TAGS ('dbx_value_regex' = '^(CO|CR|OA|PI|PR)$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `claim_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code (CARC)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `contractual_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_value_regex' = '^[A-L](,[A-L])*$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_quantity` SET TAGS ('dbx_business_glossary_term' = 'Drug Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `remittance_advice_remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code (RARC)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Malpractice Component');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Practice Expense Component');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Component');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_location_code` SET TAGS ('dbx_business_glossary_term' = 'Service Location Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `units` SET TAGS ('dbx_business_glossary_term' = 'Service Units');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('dbx_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coding Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coder ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `admission_source_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Source Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `admission_type_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Type Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `arithmetic_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Arithmetic Mean Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_drg_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Diagnosis-Related Group (DRG) Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_drg_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_physician_response` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Physician Response');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_physician_response` SET TAGS ('dbx_value_regex' = 'agree|disagree|no_response|clarified|deferred');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_date` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_topic` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Topic');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Query Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_query_type` SET TAGS ('dbx_value_regex' = 'compliant|leading|non-leading|multiple_choice|open_ended');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_date` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Response Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Response Deadline');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cdi_resulting_code_change` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Improvement (CDI) Resulting Code Change');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Coding Accuracy Score');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_date` SET TAGS ('dbx_business_glossary_term' = 'Coding Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_method` SET TAGS ('dbx_business_glossary_term' = 'Coding Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_method` SET TAGS ('dbx_value_regex' = 'manual|automated|computer-assisted|hybrid');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_status` SET TAGS ('dbx_business_glossary_term' = 'Coding Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|final|amended|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `complication_comorbidity_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication or Comorbidity (CC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `discharge_disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `expected_reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `expected_reimbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Geometric Mean Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `grouper_version` SET TAGS ('dbx_business_glossary_term' = 'Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `hcpcs_codes` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Common Procedure Coding System (HCPCS) Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `major_complication_comorbidity_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Complication or Comorbidity (MCC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `mdc_code` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category (MDC) Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `mdc_code` SET TAGS ('dbx_value_regex' = '^(MDC )?(0[0-9]|1[0-9]|2[0-5])$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `mdc_description` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category (MDC) Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `outlier_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Outlier Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `present_on_admission_indicators` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission (POA) Indicators');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Secondary Diagnosis Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('dbx_business_glossary_term' = 'Secondary Procedure Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Era Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_era_transaction_ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Remittance Advice (ERA) Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_category` SET TAGS ('dbx_business_glossary_term' = 'Payment Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_category` SET TAGS ('dbx_value_regex' = 'copay|coinsurance|deductible|full_payment|partial_payment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|mail|in_person|phone|lockbox');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Last Four Digits');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Funds Transfer (EFT) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `era_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Remittance Advice (ERA) File Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `lockbox_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'eft|check|credit_card|debit_card|cash|wire_transfer');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'unposted|posted|partially_applied|fully_applied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'insurance|patient|guarantor|third_party|government|charity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|applied|reversed|refunded|voided');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|prepayment|overpayment|adjustment|settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Transaction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `charity_care_application_id` SET TAGS ('dbx_business_glossary_term' = 'Charity Care Application Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `collection_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Era Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `rac_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `restriction_request_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Restriction Request Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `provider_sanction_id` SET TAGS ('dbx_business_glossary_term' = 'Sanction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `appeal_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `bad_debt_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_value_regex' = 'contractual|non_contractual|write_off|charity|discount|recoupment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contract_rate` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `contractual_payer_name` SET TAGS ('dbx_business_glossary_term' = 'Contractual Payer Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `era_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Remittance Advice (ERA) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `era_trace_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|disputed|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|approved|reversed|voided|reconciled');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `write_off_classification` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Classification');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `write_off_classification` SET TAGS ('dbx_value_regex' = 'bad_debt|charity_care|small_balance|rac_recoupment|administrative|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('dbx_subdomain' = 'patient_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `charity_care_application_id` SET TAGS ('dbx_business_glossary_term' = 'Charity Care Application Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Patient Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_balance` SET TAGS ('dbx_business_glossary_term' = 'Account Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_balance` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'open|closed|collections|bad_debt|charity|pending');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|30_days|60_days|90_days|120_plus_days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `approved_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Approved Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `approved_discount_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_flag` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `bad_debt_write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_recall_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Recall Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Collection Recall Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_in_collections|referred|active|recalled|resolved|legal_action');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `family_size` SET TAGS ('dbx_business_glossary_term' = 'Family Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_application_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Application Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|expired|revoked');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_eligibility` SET TAGS ('dbx_value_regex' = 'not_evaluated|eligible|ineligible|pending|approved|denied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `financial_assistance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `household_income` SET TAGS ('dbx_business_glossary_term' = 'Household Income');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `household_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `insurance_balance` SET TAGS ('dbx_business_glossary_term' = 'Insurance Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `irs_501r_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'IRS 501(r) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `original_balance` SET TAGS ('dbx_business_glossary_term' = 'Original Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_balance` SET TAGS ('dbx_business_glossary_term' = 'Patient Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `referred_balance` SET TAGS ('dbx_business_glossary_term' = 'Referred Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `total_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `total_payments` SET TAGS ('dbx_business_glossary_term' = 'Total Payments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('dbx_subdomain' = 'patient_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_last_modified_by_user_employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `adjustments_applied` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Applied');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|30_days|60_days|90_days|120_plus_days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'none|pending|active|legal|bad_debt|write_off');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `current_charges` SET TAGS ('dbx_business_glossary_term' = 'Current Charges');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `cycle` SET TAGS ('dbx_business_glossary_term' = 'Statement Cycle');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|email|portal|sms|fax');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|sent|delivered|failed|returned|bounced');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `financial_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `insurance_pending` SET TAGS ('dbx_business_glossary_term' = 'Insurance Pending Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `message` SET TAGS ('dbx_business_glossary_term' = 'Statement Message');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `message` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `minimum_payment_due` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Due');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `payments_received` SET TAGS ('dbx_business_glossary_term' = 'Payments Received');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `previous_balance` SET TAGS ('dbx_business_glossary_term' = 'Previous Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_date` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_flag` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `returned_mail_reason` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `total_balance_due` SET TAGS ('dbx_business_glossary_term' = 'Total Balance Due');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'paper|electronic|portal|email|sms');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('dbx_subdomain' = 'patient_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Account Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Collection Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `collection_type` SET TAGS ('dbx_value_regex' = 'internal|external|legal|pre_collection|bad_debt');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `contact_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Contact Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `judgment_amount` SET TAGS ('dbx_business_glossary_term' = 'Judgment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_value_regex' = 'phone|mail|email|sms|in_person|portal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `legal_action_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `monthly_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Collection Account Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `payment_plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `payment_plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `referral_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `referred_balance` SET TAGS ('dbx_business_glossary_term' = 'Referred Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('dbx_subdomain' = 'claims_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_patient_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Fhir Resource Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Coverage Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('dbx_value_regex' = 'Primary|Secondary|Tertiary');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Terminated|Pending');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'Medical|Dental|Vision|Pharmacy|Behavioral Health|Long-Term Care');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `coverage_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `eligibility_verification_count` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employer_name` SET TAGS ('dbx_business_glossary_term' = 'Employer Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `employer_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Eligibility Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Last Eligibility Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_method` SET TAGS ('dbx_value_regex' = 'Real-Time 270/271|Manual|Batch|Portal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Last Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `last_verification_status` SET TAGS ('dbx_value_regex' = 'Verified Active|Verified Inactive|Verification Failed|Pending');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'In-Network|Out-of-Network|Both');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `payer_response_code` SET TAGS ('dbx_business_glossary_term' = 'Payer Response Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `payer_response_message` SET TAGS ('dbx_business_glossary_term' = 'Payer Response Message');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `payer_response_message` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Processor Control Number (PCN)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `plan_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `plan_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `rx_group_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Group Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_value_regex' = 'Self|Spouse|Child|Other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `subscriber_relationship` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `verification_source_system` SET TAGS ('dbx_business_glossary_term' = 'Verification Source System');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Transaction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `charity_care_application_id` SET TAGS ('dbx_business_glossary_term' = 'Charity Care Application Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `collection_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `financial_assistance_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `original_write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Original Write-Off Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `rac_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `tertiary_write_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `tertiary_write_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `tertiary_write_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `appeal_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `bad_debt_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Referral Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_category` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_category` SET TAGS ('dbx_value_regex' = 'patient_responsibility|insurance_denial|uncompensated_care|policy_adjustment|audit_adjustment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `original_balance` SET TAGS ('dbx_business_glossary_term' = 'Original Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending|approved|posted|reversed|under_review');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_value_regex' = 'bad_debt|charity_care|small_balance|administrative|rac_recoupment|contractual_dispute');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'patient_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `tertiary_payment_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `tertiary_payment_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `tertiary_payment_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `agreement_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `auto_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `default_date` SET TAGS ('dbx_business_glossary_term' = 'Default Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `default_reason` SET TAGS ('dbx_business_glossary_term' = 'Default Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'patient_portal|phone|in_person|mail|email|mobile_app');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `finance_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Finance Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `financial_assistance_program_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Program Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Installment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|custom');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installments_paid` SET TAGS ('dbx_business_glossary_term' = 'Installments Paid');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `installments_remaining` SET TAGS ('dbx_business_glossary_term' = 'Installments Remaining');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `missed_payments_count` SET TAGS ('dbx_business_glossary_term' = 'Missed Payments Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `next_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `original_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|ach|check|cash|money_order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|defaulted|cancelled|suspended');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'standard|interest_free|hardship|extended|short_term|custom');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `remaining_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `total_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Plan Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `rac_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Response Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `tertiary_rac_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `tertiary_rac_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `tertiary_rac_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_level` SET TAGS ('dbx_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_level` SET TAGS ('dbx_value_regex' = 'redetermination|reconsideration|alj_hearing|mac_review|federal_court');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_outcome_amount` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|partially_favorable|withdrawn|dismissed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_request_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Request Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `compliance_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `compliance_resolution_status` SET TAGS ('dbx_value_regex' = 'open|corrective_action_plan_submitted|corrective_action_implemented|validated|closed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Contractor Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Contractor Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `corrective_action_plan_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `extrapolation_flag` SET TAGS ('dbx_business_glossary_term' = 'Extrapolation Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `extrapolation_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Extrapolation Sample Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `extrapolation_universe_size` SET TAGS ('dbx_business_glossary_term' = 'Extrapolation Universe Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `finding_amount` SET TAGS ('dbx_business_glossary_term' = 'Finding Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `findings_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Findings Issued Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `records_requested_count` SET TAGS ('dbx_business_glossary_term' = 'Records Requested Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `records_submitted_count` SET TAGS ('dbx_business_glossary_term' = 'Records Submitted Count');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `recoupment_date` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `recoupment_method` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `recoupment_method` SET TAGS ('dbx_value_regex' = 'offset|direct_payment|installment_plan|settlement|waived');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `underpayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Underpayment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('dbx_subdomain' = 'patient_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `charity_care_application_id` SET TAGS ('dbx_business_glossary_term' = 'Charity Care Application ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `patient_identity_match_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identity Match Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `primary_charity_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `primary_charity_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `primary_charity_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `tertiary_charity_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `tertiary_charity_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `tertiary_charity_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `appeal_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_method` SET TAGS ('dbx_business_glossary_term' = 'Application Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|in_person|mail|fax');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Application Source');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_source` SET TAGS ('dbx_value_regex' = 'patient_initiated|staff_initiated|screening_tool|presumptive_eligibility|third_party');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|conditional');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approved_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Approved Discount Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `approved_discount_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `coverage_period_months` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Months');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `coverage_period_months` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `documentation_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|verified|incomplete|rejected');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `family_size` SET TAGS ('dbx_business_glossary_term' = 'Family Size');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `fap_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assistance Policy (FAP) Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Poverty Level (FPL) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `fpl_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `household_income` SET TAGS ('dbx_business_glossary_term' = 'Household Income');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `household_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `household_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `irs_501r_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'IRS 501(r) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `medicaid_application_date` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Application Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `medicaid_application_date` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `medicaid_pending_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Pending Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `medicaid_pending_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Application Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `plain_language_summary_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Plain Language Summary Provided Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `plain_language_summary_provided_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `presumptive_eligibility_basis` SET TAGS ('dbx_business_glossary_term' = 'Presumptive Eligibility Basis');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `presumptive_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Presumptive Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'full_charity|partial_charity|sliding_scale|medicaid_presumptive|emergency_medicaid|prompt_pay_discount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `screening_score` SET TAGS ('dbx_business_glossary_term' = 'Screening Score');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `original_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Original Refund Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `original_refund_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `rac_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Audit Contractor (RAC) Audit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_voided_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Voided By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_voided_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_voided_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_category` SET TAGS ('dbx_business_glossary_term' = 'Refund Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_category` SET TAGS ('dbx_value_regex' = 'overpayment|duplicate|credit_balance|rac_ordered|patient_request|payer_request');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Cleared Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cms_credit_balance_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Credit Balance Report Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cms_report_date` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Report Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Last Four Digits');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Disbursement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Funds Transfer (EFT) Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'check|eft|wire|credit_card_reversal|cash|offset');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Refund Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `original_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Payee Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Payee Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('dbx_business_glossary_term' = 'Payee City');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('dbx_business_glossary_term' = 'Payee Country Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Payee Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_state` SET TAGS ('dbx_business_glossary_term' = 'Payee State');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payee_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|unreconciled|exception');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Request Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'patient|guarantor|payer|vendor');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `void_flag` SET TAGS ('dbx_business_glossary_term' = 'Void Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('dbx_subdomain' = 'claims_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('dbx_association_edges' = 'billing.invoice,billing.coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `invoice_coverage_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Coverage Billing - Invoice Coverage Billing Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `invoice_coverage_billing_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Coverage Billing - Coverage Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Coverage Billing - Invoice Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `adjudication_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjudication Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `check_eft_number` SET TAGS ('dbx_business_glossary_term' = 'Check or EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `claim_filing_indicator_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Filing Indicator Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `contractual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Contractual Adjustment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Order');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `coverage_status_at_billing` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status at Billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `coverage_status_at_billing` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `patient_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `remittance_advice_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `submitted_amount` SET TAGS ('dbx_business_glossary_term' = 'Submitted Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('dbx_subdomain' = 'claims_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('dbx_association_edges' = 'billing.coverage,facility.care_site');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `billing_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'billing_network_participation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `billing_network_participation_id` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation - Coverage Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation - Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `insurance_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Network Contract Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `contracted_rate_schedule` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Schedule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Level');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('dbx_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('dbx_association_edges' = 'billing.cdm_entry,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `study_service_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Study Service Coverage Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `study_service_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Study Service Coverage - Cdm Entry Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Service Coverage - Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `billing_notes` SET TAGS ('dbx_business_glossary_term' = 'Study Service Billing Notes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_business_glossary_term' = 'Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated By');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `reimbursement_rate` SET TAGS ('dbx_business_glossary_term' = 'Study-Specific Reimbursement Rate');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `sponsor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `standard_of_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Standard of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('dbx_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('dbx_association_edges' = 'billing.cdm_entry,facility.care_site');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_cdm_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Site CDM Pricing Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Cdm Pricing - Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Site Cdm Pricing - Cdm Entry Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Activation Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Site Configuration Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Site Configuration Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `payer_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Reference');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Site-Specific Cost');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_specific_price` SET TAGS ('dbx_business_glossary_term' = 'Site-Specific Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_specific_revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Site-Specific Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` SET TAGS ('dbx_subdomain' = 'claims_invoicing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` SET TAGS ('dbx_association_edges' = 'billing.invoice,supply.material_master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `invoice_material_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item - Invoice Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item - Material Master Id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `modifier_codes` SET TAGS ('dbx_business_glossary_term' = 'Modifier Codes');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `ndc_quantity` SET TAGS ('dbx_business_glossary_term' = 'NDC Quantity');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `ndc_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'NDC Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `quantity_billed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Billed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_material_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
