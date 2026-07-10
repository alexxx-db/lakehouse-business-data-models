-- Schema for Domain: billing | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`billing` COMMENT 'SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charge` (
    `charge_id` BIGINT COMMENT 'Primary key for charge',
    `bed_id` BIGINT COMMENT 'FK to bed where service was rendered',
    `billing_coverage_id` BIGINT COMMENT 'FK to billing coverage',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `case_cart_id` BIGINT COMMENT 'FK to surgical case cart',
    `cdm_entry_id` BIGINT COMMENT 'FK to charge description master entry',
    `claim_id` BIGINT COMMENT 'FK to claim',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `drug_master_id` BIGINT COMMENT 'FK to drug master',
    `employee_id` BIGINT COMMENT 'FK to employee who created charge',
    `fulfillment_id` BIGINT COMMENT 'FK to order fulfillment',
    `guarantor_id` BIGINT COMMENT 'FK to guarantor',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code',
    `material_master_id` BIGINT COMMENT 'FK to material master',
    `mpi_record_id` BIGINT COMMENT 'FK to patient MPI record',
    `original_charge_id` BIGINT COMMENT 'FK to original charge if this is a correction',
    `clinician_id` BIGINT COMMENT 'FK to rendering clinician',
    `icd_code_id` BIGINT COMMENT 'FK to primary diagnosis ICD code',
    `room_id` BIGINT COMMENT 'FK to room',
    `specialty_id` BIGINT COMMENT 'FK to provider specialty',
    `treatment_consent_id` BIGINT COMMENT 'FK to treatment consent',
    `unit_id` BIGINT COMMENT 'FK to unit',
    `visit_id` BIGINT COMMENT 'FK to visit',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing charge record.',
    `charge_category` STRING COMMENT 'Category of charge',
    `charge_number` STRING COMMENT 'Unique charge number',
    `charge_status` STRING COMMENT 'Status of charge',
    `charge_type` STRING COMMENT 'Type of charge',
    `charge_code` STRING COMMENT 'The charge code value classifying the billing charge record.',
    `correction_reason` STRING COMMENT 'Reason for charge correction',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when charge was created',
    `diagnosis_pointer` STRING COMMENT 'Diagnosis pointer for claim',
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
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code',
    `material_master_id` BIGINT COMMENT 'FK to material master',
    `employee_id` BIGINT COMMENT 'FK to CDM owner employee',
    `org_unit_id` BIGINT COMMENT 'FK to org unit',
    `active_flag` BOOLEAN COMMENT 'Flag indicating if CDM entry is active',
    `apc_code` STRING COMMENT 'Ambulatory Payment Classification code',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing cdm entry record.',
    `bundled_payment_flag` BOOLEAN COMMENT 'Flag indicating bundled payment',
    `cdm_code` STRING COMMENT 'Charge description master code',
    `cdm_description` STRING COMMENT 'The cdm description of the billing cdm entry record.',
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
    `ndc_code` STRING COMMENT 'National Drug Code',
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
    `cdm_entry_status` STRING COMMENT 'The cdm entry status value classifying the billing cdm entry record.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line within the billing invoice line record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing invoice line record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing invoice line record.',
    `invoice_line_status` STRING COMMENT 'The invoice line status value classifying the billing invoice line record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing invoice line record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing invoice line record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing invoice line record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing invoice line record.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Billing domain product: invoice_line';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` (
    `coding_assignment_id` BIGINT COMMENT 'Unique identifier for the coding assignment within the billing coding assignment record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing coding assignment record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing coding assignment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing coding assignment record.',
    `coding_assignment_status` STRING COMMENT 'The coding assignment status value classifying the billing coding assignment record.',
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
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan within the billing payment record.',
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
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing adjustment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing adjustment record.',
    `adjustment_status` STRING COMMENT 'The adjustment status value classifying the billing adjustment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing adjustment record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing adjustment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing adjustment record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing adjustment record.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Billing domain product: adjustment';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`patient_account` (
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient account within the billing patient account record.',
    `statement_id` BIGINT COMMENT 'Unique identifier for the statement within the billing patient account record.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`collection_account` (
    `collection_account_id` BIGINT COMMENT 'Unique identifier for the collection account within the billing collection account record.',
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient account within the billing collection account record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing collection account record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing collection account record.',
    `collection_account_status` STRING COMMENT 'The collection account status value classifying the billing collection account record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing collection account record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing collection account record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing collection account record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing collection account record.',
    CONSTRAINT pk_collection_account PRIMARY KEY(`collection_account_id`)
) COMMENT 'Billing domain product: collection_account';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` (
    `billing_coverage_id` BIGINT COMMENT 'Unique identifier for the billing coverage within the billing billing coverage record.',
    `patient_coverage_id` BIGINT COMMENT 'Unique identifier for the patient coverage within the billing billing coverage record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing billing coverage record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing billing coverage record.',
    `ssot_reference` STRING COMMENT 'The ssot reference of the billing billing coverage record.',
    `billing_coverage_status` STRING COMMENT 'The billing coverage status value classifying the billing billing coverage record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing billing coverage record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing billing coverage record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing billing coverage record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing billing coverage record.',
    CONSTRAINT pk_billing_coverage PRIMARY KEY(`billing_coverage_id`)
) COMMENT 'Billing domain product: billing_coverage';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique identifier for the write off within the billing write off record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing write off record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing write off record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing write off record.',
    `write_off_status` STRING COMMENT 'The write off status value classifying the billing write off record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing write off record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing write off record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing write off record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing write off record.',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Billing domain product: write_off';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan within the billing payment plan record.',
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment within the billing payment plan record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing payment plan record.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` (
    `rac_audit_id` BIGINT COMMENT 'Unique identifier for the rac audit within the billing rac audit record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing rac audit record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing rac audit record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing rac audit record.',
    `rac_audit_status` STRING COMMENT 'The rac audit status value classifying the billing rac audit record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing rac audit record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing rac audit record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing rac audit record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing rac audit record.',
    CONSTRAINT pk_rac_audit PRIMARY KEY(`rac_audit_id`)
) COMMENT 'Billing domain product: rac_audit';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` (
    `charity_care_application_id` BIGINT COMMENT 'Unique identifier for the charity care application within the billing charity care application record.',
    `patient_account_id` BIGINT COMMENT 'Unique identifier for the patient account within the billing charity care application record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing charity care application record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing charity care application record.',
    `charity_care_application_status` STRING COMMENT 'The charity care application status value classifying the billing charity care application record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing charity care application record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing charity care application record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing charity care application record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing charity care application record.',
    CONSTRAINT pk_charity_care_application PRIMARY KEY(`charity_care_application_id`)
) COMMENT 'Billing domain product: charity_care_application';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`refund` (
    `refund_id` BIGINT COMMENT 'Unique identifier for the refund within the billing refund record.',
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment payment within the billing refund record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing refund record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing refund record.',
    `refund_status` STRING COMMENT 'The refund status value classifying the billing refund record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing refund record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing refund record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing refund record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing refund record.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Billing domain product: refund';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` (
    `invoice_coverage_billing_id` BIGINT COMMENT 'Unique identifier for the invoice coverage billing within the billing invoice coverage billing record.',
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice within the billing invoice coverage billing record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing invoice coverage billing record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing invoice coverage billing record.',
    `invoice_coverage_billing_status` STRING COMMENT 'The invoice coverage billing status value classifying the billing invoice coverage billing record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing invoice coverage billing record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing invoice coverage billing record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing invoice coverage billing record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing invoice coverage billing record.',
    CONSTRAINT pk_invoice_coverage_billing PRIMARY KEY(`invoice_coverage_billing_id`)
) COMMENT 'Billing domain product: invoice_coverage_billing';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` (
    `invoice_line_item_id` BIGINT COMMENT 'Unique identifier for the invoice line item within the billing invoice line item record.',
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line within the billing invoice line item record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing invoice line item record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing invoice line item record.',
    `invoice_line_item_status` STRING COMMENT 'The invoice line item status value classifying the billing invoice line item record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing invoice line item record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing invoice line item record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing invoice line item record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing invoice line item record.',
    CONSTRAINT pk_invoice_line_item PRIMARY KEY(`invoice_line_item_id`)
) COMMENT 'Billing domain product: invoice_line_item';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` (
    `study_service_coverage_id` BIGINT COMMENT 'Unique identifier for the study service coverage within the billing study service coverage record.',
    `charge_id` BIGINT COMMENT 'Unique identifier for the charge within the billing study service coverage record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing study service coverage record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing study service coverage record.',
    `study_service_coverage_status` STRING COMMENT 'The study service coverage status value classifying the billing study service coverage record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing study service coverage record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing study service coverage record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing study service coverage record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing study service coverage record.',
    CONSTRAINT pk_study_service_coverage PRIMARY KEY(`study_service_coverage_id`)
) COMMENT 'Billing domain product: study_service_coverage';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` (
    `site_cdm_pricing_id` BIGINT COMMENT 'Unique identifier for the site cdm pricing within the billing site cdm pricing record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the billing site cdm pricing record.',
    `cdm_entry_id` BIGINT COMMENT 'Unique identifier for the cdm entry within the billing site cdm pricing record.',
    `fee_schedule_id` BIGINT COMMENT 'Fee schedule used for this pricing',
    `payer_contract_id` BIGINT COMMENT 'Payer contract governing this pricing',
    `payer_id` BIGINT COMMENT 'Payer for which this pricing applies',
    `employee_id` BIGINT COMMENT 'Employee who approved the site-specific pricing.',
    `site_employee_id` BIGINT COMMENT 'Unique identifier for the site employee within the billing site cdm pricing record.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the billing site cdm pricing record.',
    `approval_date` DATE COMMENT 'Date when the site-specific pricing was approved.',
    `approval_required_flag` BOOLEAN COMMENT 'Whether pricing requires approval before use',
    `approval_status` STRING COMMENT 'Approval status of the site-specific pricing (e.g., pending, approved, rejected).',
    `approved_by` STRING COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing site cdm pricing record.',
    `cms_price_transparency_code` STRING COMMENT 'CMS price transparency standard charge code',
    `contract_price` DECIMAL(18,2) COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing record was created.',
    `currency_code` STRING COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `de_identified_price_flag` BOOLEAN COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Discount percentage from standard price',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the billing site cdm pricing record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the billing site cdm pricing record.',
    `extra_attr_1` STRING COMMENT 'The extra attr 1 of the billing site cdm pricing record.',
    `extra_attr_2` STRING COMMENT 'The extra attr 2 of the billing site cdm pricing record.',
    `extra_attr_3` STRING COMMENT 'The extra attr 3 of the billing site cdm pricing record.',
    `extra_attr_4` STRING COMMENT 'The extra attr 4 of the billing site cdm pricing record.',
    `extra_attr_5` STRING COMMENT 'The extra attr 5 of the billing site cdm pricing record.',
    `gross_charge_amount` DECIMAL(18,2) COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp capturing the last updated date associated with the billing site cdm pricing record.',
    `list_price` DECIMAL(18,2) COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Percentage markup applied over cost to derive the site price.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'The maximum charge amount of the billing site cdm pricing record.',
    `maximum_price` DECIMAL(18,2) COMMENT 'Maximum allowable price',
    `medicaid_price` DECIMAL(18,2) COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `medicare_price` DECIMAL(18,2) COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'The minimum charge amount of the billing site cdm pricing record.',
    `minimum_price` DECIMAL(18,2) COMMENT 'Minimum allowable price',
    `negotiated_rate_amount` DECIMAL(18,2) COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `price_effective_date` DATE COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `price_end_date` DATE COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `price_source` STRING COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `price_transparency_flag` BOOLEAN COMMENT 'Whether price is included in price transparency file',
    `pricing_effective_note` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `pricing_method` STRING COMMENT 'Method used to determine price (fee schedule, cost-plus, negotiated, DRG)',
    `pricing_methodology` STRING COMMENT 'Method used to determine the site-specific price (e.g., cost-plus, market-based, fee schedule).',
    `pricing_notes` STRING COMMENT 'Notes about pricing rationale or special conditions',
    `pricing_tier` STRING COMMENT 'Pricing tier classification',
    `review_cycle_days` STRING COMMENT 'Added to expand thin product with domain-appropriate detail.',
    `self_pay_price` DECIMAL(18,2) COMMENT 'Added to expand thin product billing.site_cdm_pricing',
    `site_cost_amount` DECIMAL(18,2) COMMENT 'The site cost amount of the billing site cdm pricing record.',
    `site_specific_price` DECIMAL(18,2) COMMENT 'The site specific price of the billing site cdm pricing record.',
    `site_specific_revenue_code` STRING COMMENT 'The site specific revenue code value classifying the billing site cdm pricing record.',
    `site_cdm_pricing_status` STRING COMMENT 'The site cdm pricing status value classifying the billing site cdm pricing record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing site cdm pricing record.',
    `vibe_expanded_flag` BOOLEAN COMMENT 'Flag added by VIBE batch to expand thin product attribute set.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing site cdm pricing record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing site cdm pricing record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing site cdm pricing record.',
    `volume_tier` STRING COMMENT 'Volume-based pricing tier applicable to this site.',
    CONSTRAINT pk_site_cdm_pricing PRIMARY KEY(`site_cdm_pricing_id`)
) COMMENT 'Billing domain product: site_cdm_pricing';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` (
    `billing_network_participation_id` BIGINT COMMENT 'Unique identifier for the billing network participation within the billing billing network participation record.',
    `charge_id` BIGINT COMMENT 'The charge fk of the billing billing network participation record.',
    `billing_domain_marker` STRING COMMENT 'The billing domain marker of the billing billing network participation record.',
    `consolidated_target` STRING COMMENT 'The consolidated target of the billing billing network participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the billing billing network participation record.',
    `participant_type` STRING COMMENT 'participant_type=billing',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: insurance.network_participation (consolidated network_participation participant_type=billing)',
    `ssot_consolidation_note` STRING COMMENT 'The ssot consolidation note of the billing billing network participation record.',
    `billing_network_participation_status` STRING COMMENT 'The billing network participation status value classifying the billing billing network participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the billing billing network participation record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the billing billing network participation record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the billing billing network participation record.',
    `vibe_structure_marker` STRING COMMENT 'The vibe structure marker of the billing billing network participation record.',
    CONSTRAINT pk_billing_network_participation PRIMARY KEY(`billing_network_participation_id`)
) COMMENT 'DEPRECATED - consolidate into insurance.network_participation (participant_type=billing). Retained for backward compatibility. Consolidated into insurance.network_participation (participant_type=billing).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_original_charge_id` FOREIGN KEY (`original_charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_statement_id` FOREIGN KEY (`statement_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`statement`(`statement_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ADD CONSTRAINT `fk_billing_invoice_coverage_billing_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ADD CONSTRAINT `fk_billing_invoice_line_item_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ADD CONSTRAINT `fk_billing_study_service_coverage_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ADD CONSTRAINT `fk_billing_billing_network_participation_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`billing` SET TAGS ('pii_domain' = 'billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_subdomain' = 'invoice_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_subdomain' = 'invoice_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `invoice_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `invoice_id` SET TAGS ('pii_source_table' = 'billing.coding_assignment');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`coding_assignment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `charge_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`adjustment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('pii_subdomain' = 'account_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `statement_id` SET TAGS ('pii_relationship' = 'fk_generated');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `statement_id` SET TAGS ('pii_source_table' = 'patient_account');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`patient_account` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('pii_subdomain' = 'invoice_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('pii_relationship' = 'fk_generated');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `patient_account_id` SET TAGS ('pii_source_table' = 'statement');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`statement` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_subdomain' = 'account_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `patient_account_id` SET TAGS ('pii_relationship' = 'fk');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `patient_account_id` SET TAGS ('pii_source_attribute' = 'patient_account_id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`collection_account` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_subdomain' = 'invoice_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_domain' = 'billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot_canonical' = 'patient.patient_coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot_primary' = 'patient.patient_coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_consolidated_into' = 'patient.patient_coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_canonical' = 'patient.patient_coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot_duplicate_of' = 'patient.patient_coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` SET TAGS ('pii_duplicate_of' = 'patient.patient_coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `invoice_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`write_off` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `payment_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `invoice_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`payment_plan` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`rac_audit` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_subdomain' = 'account_collections');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charity_care_application` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payment_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `payment_id` SET TAGS ('pii_source_attribute' = 'payment_payment_id');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`refund` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_subdomain' = 'invoice_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_association_edges' = 'billing.invoice,billing.coverage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_coverage_billing` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_subdomain' = 'invoice_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_association_edges' = 'billing.invoice,supply.material_master');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `invoice_line_id` SET TAGS ('pii_relationship' = 'fk');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `invoice_line_id` SET TAGS ('pii_fix' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`invoice_line_item` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_subdomain' = 'invoice_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_association_edges' = 'billing.cdm_entry,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `charge_id` SET TAGS ('pii_relationship' = 'fk_siloed_fix');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`study_service_coverage` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_subdomain' = 'charge_capture');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_association_edges' = 'billing.cdm_entry,facility.care_site');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `site_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `markup_percentage` SET TAGS ('pii_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `pricing_methodology` SET TAGS ('pii_business_glossary_term' = 'Pricing Methodology');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ALTER COLUMN `volume_tier` SET TAGS ('pii_business_glossary_term' = 'Volume Tier');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_subdomain' = 'invoice_billing');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_ssot_role' = 'alias');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_ssot_canonical' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_ssot_consolidated_into' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_deprecated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_consolidated_into' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_ssot' = 'deprecated');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` SET TAGS ('pii_ssot_target' = 'insurance.network_participation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `charge_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `charge_id` SET TAGS ('pii_created_by' = 'siloed_table_remediation');
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_network_participation` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
