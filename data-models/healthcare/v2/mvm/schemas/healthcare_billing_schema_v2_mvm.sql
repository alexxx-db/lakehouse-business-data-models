-- Schema for Domain: billing | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`billing` COMMENT 'SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charge` (
    `charge_id` BIGINT COMMENT 'Primary key for charge',
    `bed_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.bed_assignment. Business justification: Daily room and board charges (revenue code 010x) are generated per bed_assignment record in inpatient billing. Charge reconciliation for accommodation charges, occupancy-based billing audits, and CMS ',
    `blood_bank_unit_id` BIGINT COMMENT 'Foreign key linking to laboratory.blood_bank_unit. Business justification: Blood product charge reconciliation: each issued blood bank unit generates a unit-level charge. Linking charge to blood_bank_unit enables blood product billing audits, verifies every transfused unit i',
    `cdm_entry_id` BIGINT COMMENT 'FK to charge description master entry',
    `claim_id` BIGINT COMMENT 'FK to claim',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Medical necessity validation and claim submission require linking each charge line to the supporting diagnosis. The existing diagnosis_pointer is a denormalized reference; replacing it with a proper',
    `drug_master_id` BIGINT COMMENT 'FK to drug master',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Revenue cycle expected reimbursement calculation requires matching each charges procedure code, modifier, and place-of-service to the contracted fee_schedule_line rate. This drives automated contract',
    `guarantor_id` BIGINT COMMENT 'FK to guarantor',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: In RCM, a charge is the billable unit that is ultimately placed on an invoice for submission to a payer or patient. Adding charge.invoice_id -> billing.invoice.invoice_id establishes the direct link b',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Charge posting requires confirming active member enrollment on the service date to determine the correct payer and patient responsibility. Eligibility-at-time-of-service is a named revenue cycle proce',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Hospital facility billing (UB-04) requires identifying the rendering org_provider on each charge. Revenue cycle reconciliation, facility-level charge audits, and CMS price transparency reporting all d',
    `original_charge_id` BIGINT COMMENT 'FK to original charge if this is a correction',
    `clinician_id` BIGINT COMMENT 'FK to rendering clinician',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Charge posting workflows must validate whether the billed procedure requires prior authorization per the applicable prior_auth_rule. Missing auth is the leading cause of claim denials; this link enabl',
    `specialty_id` BIGINT COMMENT 'FK to provider specialty',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Charge capture in healthcare directly traces each billable charge to the specific procedure performed. Revenue integrity, charge reconciliation, and CPT-to-charge audits all require this direct FK. Wi',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing charge record.',
    `charge_category` STRING COMMENT 'Category of charge',
    `charge_number` STRING COMMENT 'Unique charge number',
    `charge_status` STRING COMMENT 'Status of charge',
    `charge_type` STRING COMMENT 'Type of charge',
    `charge_code` STRING COMMENT 'The charge code value classifying the billing charge record.',
    `correction_reason` STRING COMMENT 'Reason for charge correction',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when charge was created',
    `drug_unit_of_measure` STRING COMMENT 'Unit of measure for drug',
    `expected_reimbursement_amount` DECIMAL(18,2) COMMENT 'The expected reimbursement amount of the billing charge record.',
    `gross_charge_amount` DECIMAL(18,2) COMMENT 'The gross charge amount of the billing charge record.',
    `hold_date` DATE COMMENT 'Date charge was placed on hold',
    `hold_reason` STRING COMMENT 'Reason charge is on hold',
    `implant_flag` BOOLEAN COMMENT 'Flag indicating implant charge',
    `is_billable` BOOLEAN COMMENT 'Flag indicating if charge is billable',
    `is_corrected` BOOLEAN COMMENT 'Flag indicating if charge was corrected',
    `is_patient_responsible` BOOLEAN COMMENT 'Flag indicating patient responsibility',
    `is_voided` BOOLEAN COMMENT 'Flag indicating if charge was voided',
    `modifier_1` STRING COMMENT 'First procedure modifier',
    `modifier_2` STRING COMMENT 'Second procedure modifier',
    `modifier_3` STRING COMMENT 'Third procedure modifier',
    `modifier_4` STRING COMMENT 'Fourth procedure modifier',
    `ndc_code` STRING COMMENT 'National Drug Code',
    `place_of_service_code` STRING COMMENT 'The place of service code value classifying the billing charge record.',
    `posting_date` DATE COMMENT 'Date charge was posted',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of service or item',
    `quantity_used` DECIMAL(18,2) COMMENT 'The quantity used of the billing charge record.',
    `released_date` DATE COMMENT 'Date charge was released',
    `revenue_code` STRING COMMENT 'The revenue code value classifying the billing charge record.',
    `service_date` DATE COMMENT 'Date of service',
    `service_end_time` TIMESTAMP COMMENT 'Service end timestamp',
    `service_start_time` TIMESTAMP COMMENT 'Service start timestamp',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price of the billing charge record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when charge was last updated',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing charge record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing charge record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing charge record.',
    `void_date` DATE COMMENT 'Date charge was voided',
    `void_reason` STRING COMMENT 'Reason charge was voided',
    `waste_flag` BOOLEAN COMMENT 'Flag indicating drug waste',
    CONSTRAINT pk_charge PRIMARY KEY(`charge_id`)
) COMMENT 'Individual billable charge for services, procedures, supplies, or medications';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` (
    `cdm_entry_id` BIGINT COMMENT 'Primary key for CDM entry',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Chargemaster management maps CDM entries to contracted fee schedule lines for expected reimbursement calculation and price transparency reporting. This is a standard revenue integrity process; CDM-to-',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Chargemaster entries are facility-specific. CMS price transparency rules require each org_provider to publish its own CDM. CDM management, facility-level pricing audits, and revenue code mapping all r',
    `active_flag` BOOLEAN COMMENT 'Flag indicating if CDM entry is active',
    `apc_code` STRING COMMENT 'Ambulatory Payment Classification code',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing cdm entry record.',
    `bundled_payment_flag` BOOLEAN COMMENT 'Flag indicating bundled payment',
    `cdm_code` STRING COMMENT 'Charge description master code',
    `cdm_description` STRING COMMENT 'The cdm description of the billing cdm entry record.',
    `cdm_entry_status` STRING COMMENT 'The cdm entry status value classifying the billing cdm entry record.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Standard charge amount',
    `charge_capture_method` STRING COMMENT 'Method of charge capture',
    `charge_category` STRING COMMENT 'The charge category of the billing cdm entry record.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The cost amount of the billing cdm entry record.',
    `cost_center_code` STRING COMMENT 'The cost center code value classifying the billing cdm entry record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when CDM entry was created',
    `default_quantity` DECIMAL(18,2) COMMENT 'The default quantity of the billing cdm entry record.',
    `drg_weight` DECIMAL(18,2) COMMENT 'The drg weight of the billing cdm entry record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the billing cdm entry record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the billing cdm entry record.',
    `gl_account_code` STRING COMMENT 'General ledger account code',
    `item_type` STRING COMMENT 'The item type value classifying the billing cdm entry record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the billing cdm entry record.',
    `last_price_update_date` DATE COMMENT 'Timestamp capturing the last price update date associated with the billing cdm entry record.',
    `modifier_1` STRING COMMENT 'First modifier',
    `modifier_2` STRING COMMENT 'Second modifier',
    `notes` STRING COMMENT 'The notes of the billing cdm entry record.',
    `place_of_service_code` STRING COMMENT 'The place of service code value classifying the billing cdm entry record.',
    `price_transparency_flag` BOOLEAN COMMENT 'The price transparency flag of the billing cdm entry record.',
    `quality_measure_flag` BOOLEAN COMMENT 'The quality measure flag of the billing cdm entry record.',
    `requires_authorization_flag` BOOLEAN COMMENT 'The requires authorization flag of the billing cdm entry record.',
    `revenue_code` STRING COMMENT 'The revenue code value classifying the billing cdm entry record.',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'The rvu malpractice of the billing cdm entry record.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'The rvu practice expense of the billing cdm entry record.',
    `rvu_work` DECIMAL(18,2) COMMENT 'The rvu work of the billing cdm entry record.',
    `short_description` STRING COMMENT 'The short description of the billing cdm entry record.',
    `taxable_flag` BOOLEAN COMMENT 'The taxable flag of the billing cdm entry record.',
    `type_of_bill_code` STRING COMMENT 'The type of bill code value classifying the billing cdm entry record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the billing cdm entry record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing cdm entry record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing cdm entry record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing cdm entry record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing cdm entry record.',
    CONSTRAINT pk_cdm_entry PRIMARY KEY(`cdm_entry_id`)
) COMMENT 'Charge Description Master entry defining billable items and their standard prices';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing invoice record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Facility invoices (UB-04) are issued by a specific org_provider. Facility-level revenue reporting, payer contract reconciliation, cost center accounting, and Medicare cost report preparation all requi',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: An invoice in healthcare RCM belongs to a patient account — the financial account that tracks all billing activity for a patient/guarantor. The patient_account is the hub entity for all billing activi',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Invoices are submitted to specific payers for reimbursement. AR aging reports, remittance reconciliation, and payer-level collections performance all require payer attribution on the invoice. This is ',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Professional fee invoices (CMS-1500) are attributed to a specific rendering clinician. Clinician-level revenue reporting, payer remittance reconciliation, 1099 tax reporting, and MIPS payment adjustme',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: In hospital billing, an invoice (UB-04/facility bill) is generated for a specific visit/encounter. Revenue cycle reporting, visit-level financial reconciliation, and accounts receivable aging all requ',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing invoice record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing invoice record.',
    `invoice_status` STRING COMMENT 'The invoice status value classifying the billing invoice record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing invoice record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing invoice record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing invoice record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing invoice record.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Billing domain product: invoice';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` (
    `coding_assignment_id` BIGINT COMMENT 'Unique identifier for the coding assignment within the billing coding assignment record.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Clinical coding workflow assigns ICD/DRG codes to a specific claim for billing. Linking coding_assignment directly to claim enables coding audit trails, compliance reporting (RAC audits), and coder pr',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Medical coding assignments are attributed to the rendering clinician for professional fee billing (CMS-1500). Coding quality audits, E&M compliance reviews, and RADV audit responses require linking ea',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: HIM coding validation requires checking that assigned procedure and diagnosis codes are covered under the applicable coverage_policy before claim submission. This is a standard clinical documentation ',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: HIM/CDI coding workflow: coders assign ICD-10 diagnosis codes to clinical diagnoses for billing. A coding_assignment must reference the specific diagnosis being coded to support coding audits, query w',
    `discharge_summary_id` BIGINT COMMENT 'Foreign key linking to encounter.discharge_summary. Business justification: HIM coders perform coding_assignment by reviewing the discharge_summary as the primary source document. Coding productivity tracking, query response workflows, and coding accuracy audits (PEPPER, RAC)',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: Coding assignments directly produce or validate DRG assignments in inpatient billing. CDI and HIM workflows require tracing which coding_assignment resulted in a specific drg_assignment for MS-DRG rei',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing coding assignment record.',
    `pathology_report_id` BIGINT COMMENT 'Foreign key linking to laboratory.pathology_report. Business justification: Pathology professional component coding: medical coders assign ICD-10/CPT codes directly from pathology reports for physician professional billing. This link supports pathology coding workflows, cance',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Coding workflows must flag procedure codes that require prior authorization per prior_auth_rule before claim submission. This denial prevention step is a named HIM and revenue cycle process; missing a',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: HIM procedure coding workflow: coders assign CPT/ICD-10-PCS codes to procedure events for billing. coding_assignment must reference the procedure_event being coded to support surgical coding audits, O',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Revenue cycle coding is always performed against a specific visit/encounter. HIM coders open a coding_assignment per visit to assign ICD/CPT codes for claim submission. Every healthcare billing system',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing coding assignment record.',
    `coding_assignment_status` STRING COMMENT 'The coding assignment status value classifying the billing coding assignment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing coding assignment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing coding assignment record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing coding assignment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing coding assignment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing coding assignment record.',
    CONSTRAINT pk_coding_assignment PRIMARY KEY(`coding_assignment_id`)
) COMMENT 'Billing domain product: coding_assignment';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment within the billing payment record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing payment record.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: ERA/remittance processing requires identifying which payer remitted each payment. Payer-level payment reconciliation, underpayment tracking, and cash posting workflows all depend on payer attribution ',
    `remittance_id` BIGINT COMMENT 'Foreign key linking to claim.remittance. Business justification: ERA cash posting process creates a billing payment record sourced from a payer remittance. Linking payment to its originating remittance is required for payment-to-remittance reconciliation, audit tra',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing payment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing payment record.',
    `payment_status` STRING COMMENT 'The payment status value classifying the billing payment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing payment record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing payment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing payment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing payment record.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Billing domain product: payment';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the adjustment within the billing adjustment record.',
    `charge_id` BIGINT COMMENT 'Unique identifier for the charge within the billing adjustment record.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Non-covered service adjustments and medical necessity denials are driven by specific coverage policies. Linking adjustment to coverage_policy enables denial root-cause analysis by policy, supports app',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: Denial write-off process creates a billing adjustment when a denied claim is written off. Linking adjustment to the originating denial is required for denial write-off reporting, bad debt tracking, an',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Contractual adjustments are calculated as billed charge minus the contracted fee_schedule_line rate. This link enables automated contractual write-off calculation, contract variance reporting, and und',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Adjustments (contractual adjustments, write-offs, ERA/EOB-driven adjustments) are posted against invoices in the revenue cycle. While adjustment already links to charge (for charge-level adjustments),',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Contractual adjustments and denial write-offs are payer-driven. Payer-level write-off reporting, denial management dashboards, and contract performance analysis all require payer attribution on each a',
    `remittance_line_id` BIGINT COMMENT 'Foreign key linking to claim.remittance_line. Business justification: Contractual adjustments in billing are driven by CARC codes on remittance lines. The ERA posting process creates a billing adjustment for each remittance line adjustment. This link is required for var',
    `adjustment_status` STRING COMMENT 'The adjustment status value classifying the billing adjustment record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing adjustment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing adjustment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing adjustment record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing adjustment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing adjustment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing adjustment record.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Billing domain product: adjustment';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`patient_account` (
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient account within the billing patient account record.',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to patient.guarantor. Business justification: A patient account is financially owned by a guarantor — the responsible party for balance, statements, and collections. Revenue cycle operations (collections, payment plans, financial counseling) requ',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Patient account management, AR aging, charity care eligibility, and collections workflows all require linking a billing account to a specific patient identity. Revenue cycle staff look up accounts by ',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to insurance.subscriber. Business justification: Patient account setup requires linking to the insurance subscriber to determine coverage, coordination of benefits order, and patient financial responsibility. This is a standard patient access and bi',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing patient account record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing patient account record.',
    `patient_account_status` STRING COMMENT 'The patient account status value classifying the billing patient account record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing patient account record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing patient account record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing patient account record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing patient account record.',
    CONSTRAINT pk_patient_account PRIMARY KEY(`patient_account_id`)
) COMMENT 'Billing domain product: patient_account';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`statement` (
    `statement_id` BIGINT COMMENT 'Unique identifier for the statement within the billing statement record.',
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient account within the billing statement record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing statement record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing statement record.',
    `statement_status` STRING COMMENT 'The statement status value classifying the billing statement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing statement record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing statement record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing statement record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing statement record.',
    CONSTRAINT pk_statement PRIMARY KEY(`statement_id`)
) COMMENT 'Billing domain product: statement';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan within the billing payment plan record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing payment plan record.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: A payment plan is established for a patient account to manage outstanding balances over time. The payment_plan must be associated with the patient_account that owns the debt being paid down. Currently',
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment within the billing payment plan record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing payment plan record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing payment plan record.',
    `payment_plan_status` STRING COMMENT 'The payment plan status value classifying the billing payment plan record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing payment plan record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing payment plan record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing payment plan record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing payment plan record.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Billing domain product: payment_plan';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_original_charge_id` FOREIGN KEY (`original_charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment`(`payment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `bed_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `blood_bank_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Blood Bank Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('dbx_subdomain' = 'revenue_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Coding Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `discharge_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Summary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `pathology_report_id` SET TAGS ('dbx_business_glossary_term' = 'Pathology Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `charge_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `remittance_line_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_relationship' = 'fk_generated');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `invoice_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_id` SET TAGS ('dbx_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
