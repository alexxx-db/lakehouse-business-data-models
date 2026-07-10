-- Schema for Domain: billing | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-10 16:21:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`billing` COMMENT 'SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charge` (
    `charge_id` BIGINT COMMENT 'Unique identifier for the charge record. Primary key for the charge entity. System-generated surrogate key used to uniquely identify each billable charge transaction in the revenue cycle management system.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Charges are captured with knowledge of which insurance coverage will be billed. FK links charge to the specific patient-payer-plan coverage instance. Cardinality: N charges : 1 coverage. No columns re',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Every billable charge references a CDM (Charge Description Master) entry for pricing, coding, and revenue classification. CDM is the authoritative catalog. FK allows retrieval of cdm_description, reve',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider who performed or supervised the billable service. Used for professional billing and National Provider Identifier (NPI) reporting.',
    `charge_ordering_provider_clinician_id` BIGINT COMMENT 'Reference to the provider who ordered the service or procedure. Required for certain claim types and medical necessity validation.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Charges use CPT codes for procedure billing. Existing cpt_code column is denormalized string; FK enables validation against current CPT reference, RVU lookup, and NCCI edit checking required for clean',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Charge capture reconciliation: pharmacy drug charges are triggered by dispense events. Revenue cycle teams reconcile charges against dispense events daily to ensure every dispensed drug is billed. A d',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Medication charges require drug master reference for NDC validation, formulary compliance, and accurate revenue capture. Essential for charge audits, coding accuracy, and payer claim submission where ',
    `guarantor_id` BIGINT COMMENT 'Reference to the party financially responsible for the charge. May be the patient or another individual/entity.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Charges use HCPCS codes for supplies, DME, and non-physician services billing. Existing hcpcs_code column is denormalized string; FK enables validation, pricing lookup, and coverage determination requ',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Charges must reference the specific patient insurance coverage active at service time for accurate claim submission, adjudication, and coordination of benefits. Critical for revenue cycle operations a',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: A charge is the raw billable event that gets grouped onto an invoice during the billing cycle. In Epic Resolute RCM, charges are posted and then rolled up to professional or facility invoices. This FK',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: CMS requires LOINC codes on lab/diagnostic charges for Medicare/Medicaid billing compliance. Lab charge capture must reference the specific LOINC-coded test ordered. A healthcare billing expert would ',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received the billable service or supply. Links charge to the patient master record.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Charges for implantable devices, supplies, and drugs require direct material master linkage for accurate billing, cost accounting, UDI tracking, NDC billing compliance, and revenue cycle analytics. Es',
    `original_charge_id` BIGINT COMMENT 'Reference to the original charge record that this charge corrects. Used to maintain audit trail when charges are corrected rather than voided.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Every charge in the revenue cycle is associated with a patient financial account (patient_account). The patient_account is the SSOT for the patients billing relationship and balance. Linking charge.p',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Charges require validated diagnosis codes for medical necessity determination, claims adjudication, and compliance. Diagnosis_pointer references position in diagnosis list; need FK to actual ICD code ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Facility charges (UB-04 claims) are billed under the rendering org_provider (hospital/facility). Revenue code assignment, facility fee billing, and CMS cost report charge allocation require knowing th',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Charge capture requires the specific service location for place-of-service code validation, site-of-service differential reimbursement (facility vs. non-facility), and CMS claim submission. Role prefi',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Charges require specialty attribution for RVU-based physician fee schedule lookups (specialty-specific conversion factors), network adequacy reporting by specialty, prior authorization rules (specialt',
    `charge_category` STRING COMMENT 'High-level grouping of the charge for financial reporting and analytics. Examples include surgical services, diagnostic imaging, laboratory, pharmacy, room and board.',
    `charge_status` STRING COMMENT 'Current lifecycle status of the charge in the revenue cycle. Indicates whether the charge is awaiting review, posted to account, submitted on claim, paid by payer, or voided/corrected. [ENUM-REF-CANDIDATE: pending|posted|billed|paid|adjusted|voided|corrected|on_hold|denied — 9 candidates stripped; promote to reference product]',
    `charge_type` STRING COMMENT 'Classification of the charge based on billing type. Determines claim form (CMS-1500 vs UB-04), revenue recognition rules, and reporting category.. Valid values are `professional|facility|ancillary|pharmacy|supply|accommodation`',
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
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: CDM drug charge master maintenance: CDM entries for drug charges reference the pharmacy drug master for formulary status, HCPCS/NDC validation, and pricing. Charge description master teams link drug C',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: CDM entries map to HCPCS codes for supplies and DME pricing. Existing hcpcs_code is denormalized string; FK enables automated pricing updates, ensures valid codes, and supports charge master maintenan',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: The CDM maps lab/diagnostic service items to LOINC codes per CMS and HIPAA lab reporting requirements. CDM maintenance teams must associate each lab CDM entry with its LOINC identifier for interoperab',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: CDM entries for chargeable supplies, drugs, and implants must link to material master to maintain pricing consistency, automate charge capture, support supply cost vs. charge analysis, and enable char',
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
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.billing_coverage. Business justification: An invoice is submitted to a specific payer under a specific insurance coverage record (billing_coverage). The billing_coverage is the SSOT for the patients insurance eligibility and benefit period u',
    `clinician_id` BIGINT COMMENT 'Reference to the provider or organization submitting the bill. Holds the National Provider Identifier (NPI) for the billing entity on the claim form.',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to patient.demographics. Business justification: Claims submission workflow: invoices are transmitted as CDA documents (e.g., CMS-1500, UB-04 electronic equivalents) to payers and HIEs for adjudication. Tracking which CDA document represents each in',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Inpatient invoices are reimbursed under MS-DRG grouping; the invoice must reference the authoritative DRG record for reimbursement calculation, case mix reporting, and CMS cost report submission. drg_',
    `eligibility_check_id` BIGINT COMMENT 'Foreign key linking to patient.eligibility_check. Business justification: When claims are denied for eligibility reasons, billing staff must trace the invoice back to the eligibility verification performed at time of service. This link supports denial root-cause analysis, a',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Invoices are submitted under a group billing NPI for group practice claims (CMS-1500/UB-04). Group-level financial performance reporting, payer contract management, and ERA remittance reconciliation r',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for payment of this invoice. May be the patient or another party who has accepted financial responsibility.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Invoices are submitted to a specific payer under a specific insurance coverage record. Billing staff require this direct link for claim submission, denial management, EOB matching, and payer-specific ',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Place of service on claims must reference specific provider location for accurate reimbursement (facility vs non-facility rates differ significantly), network validation (location-specific contracts),',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received services and is responsible for or associated with this invoice. Primary party for billing purposes.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Institutional claims (UB-04 forms) are billed by organizational providers. Invoice must reference org_provider_id to identify the billing facility for hospital inpatient/outpatient claims, validate NP',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: An invoice (professional CMS-1500 or facility UB-04 bill) is generated against a patient financial account. The patient_account is the aggregation point for all financial activity. Linking invoice.pat',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Hospital UB-04 billing requires admission source, type-of-bill, financial class, and discharge disposition from the originating registration event. Billing coders and revenue cycle staff directly refe',
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
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason the claim was denied or rejected by the payer. Used for denial management and appeals. Examples: CO-16=Claim lacks information, PR-1=Deductible.',
    `denial_reason_description` STRING COMMENT 'Human-readable description of the denial reason provided by the payer. Provides additional context beyond the denial reason code for revenue cycle staff.',
    `discharge_status_code` STRING COMMENT 'Two-digit code indicating the patient status at discharge for facility claims. Examples: 01=Home, 02=Transfer to Short-Term Hospital, 03=SNF, 07=Left AMA, 20=Expired, 30=Still Patient.. Valid values are `^[0-9]{2}$`',
    `drg_weight` DECIMAL(18,2) COMMENT 'Relative weight assigned to the DRG code reflecting the expected resource consumption for this case. Used to calculate Medicare reimbursement by multiplying the base rate by the DRG weight.',
    `form_type` STRING COMMENT 'The standardized claim form type used for this invoice. CMS-1500 for professional billing, UB-04 for facility billing, ADA-2012 for dental, NCPDP for pharmacy.. Valid values are `CMS-1500|UB-04|ADA-2012|NCPDP`',
    `insurance_payment` DECIMAL(18,2) COMMENT 'The total amount paid by the insurance payer(s) toward this invoice. Sum of all insurance payments posted from Electronic Remittance Advice (ERA) or manual payment posting.',
    `invoice_date` DATE COMMENT 'The date the invoice was generated and finalized for submission. Represents the formal billing document creation date.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the revenue cycle management workflow. Tracks the invoice from creation through final disposition. [ENUM-REF-CANDIDATE: draft|ready_to_bill|submitted|accepted|rejected|paid|partially_paid|denied|appealed|voided|cancelled — 11 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the type of services billed. Professional invoices use CMS-1500 form for physician services; facility invoices use UB-04 form for hospital services.. Valid values are `professional|facility|institutional|ancillary|durable_medical_equipment|home_health`',
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
    `submission_date` DATE COMMENT 'The date the invoice was submitted to the payer as a claim. Represents when the billing document was transmitted electronically or mailed to the insurance company.',
    `submission_method` STRING COMMENT 'The method used to submit the claim to the payer. Electronic 837 transactions are the standard for HIPAA-compliant electronic claims submission.. Valid values are `electronic_837|paper_mail|clearinghouse|direct_payer_portal`',
    `total_charges` DECIMAL(18,2) COMMENT 'The total gross charges for all services on this invoice before any adjustments, discounts, or payments. Sum of all charge line items from the Charge Description Master (CDM).',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Professional or facility bill generated for a patient encounter or episode of care. Represents the formal billing document (CMS-1500 for professional billing, UB-04 for facility billing) sent to a payer or patient. Owns bill type (professional/facility), form type (CMS-1500/UB-04), total charges, covered charges, non-covered charges, bill status (draft, ready, submitted, accepted, rejected, paid, denied), bill date, from/through service dates, admission type, discharge status, payer assignment, and billing provider NPI. SSOT for the billing document lifecycle in Epic Resolute PB/HB. The primary entity linking charge capture to claim submission.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for this product.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Invoice line items reference CDM entries for procedure/service definitions. Same pattern as charge → cdm_entry. FK allows retrieval of CDM metadata for billing and reporting. Cardinality: N invoice li',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: An invoice_line is the billed representation of a charge on a professional or facility invoice. The invoice_line is derived FROM a charge — it is the child record. Adding invoice_line.charge_id → bill',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Pharmacy drug invoice line audit: each drug line item on a claim/invoice must be traceable to the specific dispense event for audit, compliance, and payer dispute resolution. Revenue cycle and pharmac',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Invoice lines for pharmacy services must reference drug master to populate accurate NDC codes on insurance claims (CMS and commercial payer requirement). Critical for claim adjudication, pricing valid',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Invoice lines may use HCPCS codes for supplies, DME, and ancillary services. FK enables validation, supports ASC/OPPS payment determination, and ensures accurate reimbursement for non-physician servic',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header. Links this line item to the professional or facility invoice (CMS-1500 or UB-04).',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Lab claim lines submitted to payers must include LOINC codes per HIPAA 5010 and CMS lab billing rules. Linking invoice_line to reference.loinc_code enables lab claim validation, payer adjudication sup',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: CMS requires NDC codes on drug claim lines for Medicaid rebate processing and 340B compliance. invoice_line.ndc_code is a denormalized plain attribute; a proper FK to reference.ndc_drug enables drug p',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Invoice lines require validated diagnosis codes for claims submission and adjudication. Diagnosis_pointer references position; FK to actual ICD code enables medical necessity validation, LCD/NCD compl',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Invoice lines bill procedures using CPT codes. Existing procedure_code is denormalized string; FK enables validation against current CPT reference, supports NCCI edits, modifier validation, and accura',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Each invoice line item represents a billed procedure. Revenue integrity and charge capture reconciliation require tracing invoice lines to the originating clinical procedure event. Supports underbilli',
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
    `clinician_id` BIGINT COMMENT 'Reference to the certified medical coder who performed the coding assignment.',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to patient.demographics. Business justification: Quality reporting and claims submission: coded diagnoses/procedures from coding_assignment populate CDA documents for IQR, PQRS, and claims. Tracking which CDA document contains each coding assignment',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Coding assignments determine DRG for inpatient reimbursement. Existing drg_code is denormalized string; FK enables lookup of current relative weights, GMLOS, outlier thresholds, and accurate expected ',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim associated with this coding assignment, if applicable.',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.note. Business justification: CDI workflows explicitly tie coding assignments to the discharge summary or H&P note that supports the DRG. coding_assignment has cdi_query_date and cdi_physician_response fields that are triggered by',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Inpatient DRG coding assignments are performed for specific hospital facilities. Facility-level case mix index (CMI) reporting, CMS cost report preparation, and coding accuracy audits by facility requ',
    `pathology_report_id` BIGINT COMMENT 'Foreign key linking to laboratory.pathology_report. Business justification: Pathology reports are primary inputs to ICD/DRG coding assignments — final diagnosis, histologic type, TNM stage, and cancer registry flags directly drive principal diagnosis coding. CDI teams and cod',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Coding assignments assign principal diagnosis codes for DRG grouping and reimbursement. Existing principal_diagnosis_code is denormalized string; FK enables validation, supports DRG logic, ensures bil',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Coding assignments assign principal procedure codes for DRG grouping. Existing principal_procedure_code is denormalized string; FK enables validation, supports surgical DRG logic, and ensures accurate',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Coding compliance and POA (Present on Admission) indicator validation require coders to link their principal diagnosis assignment directly to the clinical visit_diagnosis record. coding_assignment.pri',
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
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this coding assignment record was last modified in the system.',
    CONSTRAINT pk_coding_assignment PRIMARY KEY(`coding_assignment_id`)
) COMMENT 'Clinical coding record associating ICD-10 diagnosis codes, CPT procedure codes, DRG assignments, HCPCS codes, and CDI query workflows to a specific encounter or invoice. Owns principal and secondary diagnoses, principal and secondary procedures, DRG code, DRG description, DRG type (MS-DRG, APR-DRG), DRG weight, MDC (Major Diagnostic Category), geometric/arithmetic mean LOS, outlier threshold, expected reimbursement, grouper version, assignment date, coder ID, coding method (auto/manual), coding date, and CDI query data (query type — compliant/leading/non-leading, query topic, query date, response deadline, response date, physician response — agree/disagree/no response, resulting code change, DRG impact amount). Managed via 3M HIS DRG grouper, 3M CDI, and Epic HIM module. SSOT for all coded encounter data, DRG assignment, and CDI query tracking — there are no separate DRG or CDI entities. Supports CMI (Case Mix Index) reporting, DRG-based reimbursement calculation, and CDI program performance measurement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment record.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Insurance payments are made under specific coverage. Payment already has payer_id, but coverage is the patient-specific coverage instance. FK links payment to coverage for insurance payments. Cardinal',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for the payment, if different from the patient.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or account balance against which this payment is applied.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Payments made as part of a payment plan should link to the plan. FK allows tracking which payments are plan installments vs. ad-hoc payments. Cardinality: N payments : 1 payment plan (one plan receive',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Insurance payments must link to the specific coverage policy under which payment was remitted for EOB reconciliation, contract rate verification, and coordination of benefits processing. Essential for',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who is the subject of the payment transaction.',
    `remittance_id` BIGINT COMMENT 'Foreign key linking to claim.remittance. Business justification: Payments are posted from remittance advices (835 transactions). Cash application, payment reconciliation, and bank deposit matching require linking payments to the remittance that authorized them. Ess',
    `rx_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_claim. Business justification: Pharmacy remittance posting: payer payments for pharmacy claims are applied against specific rx_claim records via ERA/EOB. Pharmacy billing teams post payments to rx_claims daily. A domain expert woul',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: ERA reconciliation: payments are created from inbound 835 ERA messages. Linking payment records to the source message_log enables reconciliation, reprocessing failed ERAs, and auditing payment posting',
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
    `deposit_date` DATE COMMENT 'The date on which the payment was deposited into the healthcare organizations bank account or financial system.',
    `eft_trace_number` STRING COMMENT 'The trace or reference number for Electronic Funds Transfer (EFT) payments, used for reconciliation and tracking. Null for non-EFT payment methods.',
    `era_file_reference` STRING COMMENT 'The identifier of the ERA 835 file from which this payment record was extracted, used for audit and reconciliation purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was last modified or updated in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `lockbox_number` STRING COMMENT 'The identifier of the lockbox service or location through which the payment was received, if applicable. Null for non-lockbox payments.',
    `method` STRING COMMENT 'The financial instrument or mechanism used to make the payment: Electronic Funds Transfer (EFT), check, credit card, debit card, cash, or wire transfer.. Valid values are `eft|check|credit_card|debit_card|cash|wire_transfer`',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment, including special instructions, reconciliation notes, or explanations for exceptions.',
    `number` STRING COMMENT 'Business-facing unique identifier or reference number for the payment transaction, used for tracking and reconciliation.',
    `payment_date` DATE COMMENT 'The date on which the payment was made or received by the healthcare organization. This is the business event date for the payment transaction.',
    `payment_status` STRING COMMENT 'The current lifecycle status of the payment: pending (received but not yet posted), posted (recorded in system), applied (allocated to charges), reversed (payment reversed), refunded (payment returned to payer), or voided (payment cancelled).. Valid values are `pending|posted|applied|reversed|refunded|voided`',
    `payment_type` STRING COMMENT 'The classification or category of the payment: standard (regular payment against charges), prepayment (payment before service), overpayment (excess payment requiring refund), adjustment (correction or write-off), or settlement (negotiated payment).. Valid values are `standard|prepayment|overpayment|adjustment|settlement`',
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
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unapplied or unallocated to specific charges, held as credit on the account, in US dollars (USD).',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of every payment received from a payer or patient against an invoice or account balance. Owns payment source (insurance/patient/guarantor), payment method (EFT, check, credit card, cash), payment amount, payment date, check/EFT number, ERA transaction ID, deposit date, posting date, posting status, and applied balance. SSOT for payment posting in Epic Resolute PB/HB and Cerner Revenue Cycle.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the financial adjustment record. Primary key.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.coverage. Business justification: Contractual adjustments are coverage-specific (based on payer contract rates for specific plans). FK links adjustment to the coverage under which the contractual adjustment was calculated. Cardinality',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: In Epic Resolute and standard RCM workflows, adjustments can be applied directly to charges (charge-level write-offs, charge corrections, contractual adjustments before invoicing). Adding adjustment.c',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Adjustments frequently result from claim adjudication outcomes—payer denials, contractual adjustments, or underpayments. Revenue integrity and denial management workflows require linking adjustments t',
    `clinician_id` BIGINT COMMENT 'Reference to the user who created this adjustment record in the system.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Adjustments reference procedure codes when correcting billing errors or disputing payment variances. Existing cpt_code is denormalized string; FK enables validation, supports contractual adjustment ca',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.claim_denial. Business justification: Write-offs and contractual adjustments are directly created as a result of specific claim denials. Linking adjustment to claim_denial enables denial-driven write-off tracking, root cause analysis of f',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: Pharmacy claim adjustment processing: adjustments for drug returns, quantity corrections, or prior auth denials must reference the originating dispense event. Pharmacy billing teams and auditors requi',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Adjustments reference DRG codes when disputing inpatient payment variances or DRG downgrades. Existing drg_code is denormalized string; FK enables lookup of expected payment, supports DRG validation a',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to patient.guarantor. Business justification: Charity care adjustments are based on approved financial assistance applications. FK links adjustment to the authoritative charity care application record. Cardinality: N adjustments : 1 application (',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Contractual adjustments and payer denials are frequently tied to specific HCPCS-coded services (DME, drugs, ambulance). Linking adjustment to reference.hcpcs_code enables HCPCS-level denial analysis, ',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Contractual adjustments are coverage-specific and must reference the exact insurance coverage policy to apply correct contract rates, validate allowable amounts, and maintain audit trails for payer co',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or claim to which this adjustment applies.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Financial adjustments in RCM are frequently applied at the invoice line level — contractual adjustments, denial write-offs, and ERA-driven adjustments are posted per service line. The adjustment alrea',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose account is being adjusted.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: 340B drug pricing adjustments, Medicaid rebate adjustments, and pharmacy claim write-offs require NDC-level reference. Linking adjustment to reference.ndc_drug enables 340B compliance auditing, drug-s',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.sanction. Business justification: Billing adjustments and write-offs are triggered by provider sanctions (OIG/SAM exclusions, state license suspensions, Medicare revocations). Adjustment records must reference sanction_id to document ',
    `original_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment record that this transaction reverses, if this is a reversal adjustment.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.collection_account. Business justification: Adjustments related to collection activities (e.g., collection fees, recovery adjustments) link to the collection account. FK provides context for collection-related adjustments. Cardinality: N adjust',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Adjustments may reference diagnosis codes when disputing medical necessity denials or coding-related payment variances. FK enables validation of diagnosis-driven adjustment reasons and supports appeal',
    `remittance_id` BIGINT COMMENT 'Foreign key linking to claim.remittance. Business justification: Contractual adjustments in revenue cycle are directly driven by ERA/835 remittance advice. Linking adjustment to remittance enables direct tracing of which remittance posting created which contractual',
    `rx_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_claim. Business justification: Pharmacy ERA/EOB adjustment posting: when a payer adjusts a pharmacy claim (contractual write-off, denial, COB), the adjustment must reference the specific rx_claim. This is a standard pharmacy revenu',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: ERA adjustment reconciliation: adjustments (contractual, denial) are posted from 835 ERA messages. Linking adjustments to source message_log enables reconciliation, dispute resolution, and auditing ad',
    `visit_id` BIGINT COMMENT 'Reference to the patient visit or encounter associated with this adjustment.',
    `adjustment_date` DATE COMMENT 'The business date on which the adjustment was applied to the account, used for financial period assignment and reporting.',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment transaction, indicating whether it is pending approval, posted, reversed, or reconciled.. Valid values are `pending|posted|approved|reversed|voided|reconciled`',
    `adjustment_type` STRING COMMENT 'High-level classification of the adjustment indicating the nature of the balance modification (contractual write-down, bad debt write-off, charity care, etc.). [ENUM-REF-CANDIDATE: contractual|administrative|bad_debt|charity_care|small_balance|courtesy_discount|recoupment|refund|other — 9 candidates stripped; promote to reference product]',
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
    `write_off_classification` STRING COMMENT 'Specific classification for write-off adjustments, distinguishing between bad debt, charity care, small balance write-offs, RAC recoupments, and other categories.. Valid values are `bad_debt|charity_care|small_balance|rac_recoupment|administrative|other`',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Financial adjustment applied to a charge, invoice line, or patient account balance. Encompasses ALL balance modifications in the revenue cycle: contractual adjustments (write-downs to payer-contracted rates), administrative adjustments, bad debt write-offs, charity care write-offs, small balance write-offs, RAC recoupments, courtesy discounts, and all other permanent or reversible balance modifications. Owns adjustment type, adjustment category (contractual/non-contractual/write-off/charity), adjustment reason code, adjustment amount, adjustment date, authorization/approval code, approving authority, posting status, charity care program reference, write-off classification (bad debt/charity/small balance/RAC), write-off reason, reversal flag, and reconciliation status. SSOT for ALL balance modifications including write-offs — there is no separate write-off entity. Critical for net revenue calculation, contractual variance analysis, bad debt reporting, charity care tracking, and RCM financial reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`patient_account` (
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient financial account. Primary key for the patient account entity.',
    `guarantor_id` BIGINT COMMENT 'Reference to the guarantor responsible for payment of this account. May be the patient or another party.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Patient accounts are opened at a specific facility (org_provider). Facility-level AR aging, bad debt reporting, IRS 501(r) financial assistance compliance, and site-level revenue cycle performance das',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: AR follow-up and insurance balance management workflows require patient accounts to be directly associated with the responsible insurance coverage. Revenue cycle teams use this link for insurance agin',
    `mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record.mpi_record_id — Patient financial accounts must link to the patient master for statement generation, collections, and financial counseling workflows.',
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
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Patient statements are issued from a specific facility with facility branding, return address, and 501(r)-compliant financial assistance language. Regulatory compliance and facility-level statement vo',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Patient billing statements are generated FOR patient accounts. Statement is the periodic communication of account status to the guarantor. FK links statement to the authoritative patient account recor',
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
    `statement_date` DATE COMMENT 'The date the statement was generated and issued to the guarantor or patient.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the statement indicating its processing and delivery state. [ENUM-REF-CANDIDATE: generated|sent|delivered|returned|paid|partial_paid|outstanding — 7 candidates stripped; promote to reference product]',
    `statement_type` STRING COMMENT 'The format or medium of the statement delivery (paper mailed, electronic via portal, email, SMS notification).. Valid values are `paper|electronic|portal|email|sms`',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether statement generation and delivery has been suppressed for this account due to patient request, legal hold, or other reason.',
    `suppression_reason` STRING COMMENT 'The reason why statement delivery was suppressed (e.g., patient request, deceased, legal hold, bankruptcy).',
    `total_balance_due` DECIMAL(18,2) COMMENT 'The total outstanding balance owed by the guarantor or patient as of the statement date, including all charges, adjustments, and prior payments.',
    CONSTRAINT pk_statement PRIMARY KEY(`statement_id`)
) COMMENT 'Patient billing statement generated and sent to a guarantor or patient for outstanding balances. Owns statement number, statement date, statement type (paper/electronic), total balance due, minimum payment due, due date, statement cycle, delivery method, delivery status, and returned mail flag. Tracks the full patient statement lifecycle from generation through delivery and response.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` (
    `billing_coverage_id` BIGINT COMMENT 'Unique identifier for the insurance coverage record. Primary key for the coverage entity.',
    `mpi_record_id` BIGINT COMMENT 'Unique member identifier assigned by the insurance payer to the patient for this coverage. Used for claims submission and eligibility verification.',
    `billing_patient_mpi_record_id` BIGINT COMMENT 'Identifier of the patient who holds this insurance coverage. Links to the patient master record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the user or system process that created this coverage record. Used for audit trail and accountability.',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Billing coverage records are populated from real-time eligibility verification results. Linking billing_coverage to the eligibility check that validated it supports eligibility-driven coverage setup a',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Patient coverage records must link to applicable formulary for real-time benefit checks at point of prescription. Enables determination of covered drugs, tier placement, prior authorization requiremen',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Payers contract with organizational providers (hospitals, health systems) for network participation. Coverage records must track which org_provider the members plan is associated with to determine ne',
    `patient_coverage_id` BIGINT COMMENT 'FK to SSOT owner patient.patient_coverage for the coverage entity.',
    `payer_enrollment_id` BIGINT COMMENT 'Foreign key linking to provider.provider_payer_enrollment. Business justification: Revenue cycle teams reconcile billing coverage eligibility against the authoritative payer enrollment record. A billing_coverage record must reference the provider_payer_enrollment that authorized in-',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_original_charge_id` FOREIGN KEY (`original_charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_original_adjustment_id` FOREIGN KEY (`original_adjustment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_ordering_provider_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `original_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Original Charge Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'professional|facility|ancillary|pharmacy|supply|accommodation');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `waste_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste Indicator');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Description Master (CDM) Entry Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `eligibility_check_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Status Code');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `discharge_status_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Weight');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `form_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Form Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `form_type` SET TAGS ('dbx_value_regex' = 'CMS-1500|UB-04|ADA-2012|NCPDP');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `insurance_payment` SET TAGS ('dbx_business_glossary_term' = 'Insurance Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'professional|facility|institutional|ancillary|durable_medical_equipment|home_health');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic_837|paper_mail|clearinghouse|direct_payer_portal');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `total_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Charges Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coding_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coding Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Coder ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_business_glossary_term' = 'Pathology Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Rx Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Era Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_pii_category' = 'person_data');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|applied|reversed|refunded|voided');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|prepayment|overpayment|adjustment|settlement');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Charity Care Application Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Sanction Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `original_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Rx Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Era Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|approved|reversed|voided|reconciled');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `write_off_classification` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Classification');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `write_off_classification` SET TAGS ('dbx_value_regex' = 'bad_debt|charity_care|small_balance|rac_recoupment|administrative|other');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Patient Mpi Record Id');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
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
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'paper|electronic|portal|email|sms');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `total_balance_due` SET TAGS ('dbx_business_glossary_term' = 'Total Balance Due');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `billing_patient_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `patient_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `payer_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Payer Enrollment Id (Foreign Key)');
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
