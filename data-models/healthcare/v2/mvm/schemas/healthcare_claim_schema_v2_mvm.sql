-- Schema for Domain: claim | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`claim` COMMENT 'Insurance claims processing and payer adjudication. Owns claim submission, claim status tracking, payer adjudication, remittance advice (ERA - Electronic Remittance Advice), EOB (Explanation of Benefits), denial management, appeals, prior authorization, eligibility verification, payer contract management, RAC audit responses, and coordination of benefits across HMO, PPO, POS, Medicare, and Medicaid payers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique identifier for the claim record.',
    `org_provider_id` BIGINT COMMENT 'Organization submitting the claim.',
    `demographics_id` BIGINT COMMENT 'Link to patient demographic record.',
    `drg_assignment_id` BIGINT COMMENT 'Foreign key linking to encounter.drg_assignment. Business justification: Inpatient claim reimbursement is directly driven by the MS-DRG assignment. Revenue cycle and case management teams reconcile claim payment against the finalized DRG for outlier payment calculations, R',
    `guarantor_id` BIGINT COMMENT 'Financially responsible party.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Claims are adjudicated under a specific health plan determining benefit structure, cost-sharing, and CMS plan-level reporting. Revenue cycle analysts require claim-to-health-plan linkage for capitatio',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Lab Claim Reconciliation: laboratory claims are directly generated from lab orders. Billing and denial management teams must trace a claim back to its originating lab order to validate CPT codes, diag',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Claims are adjudicated against the members active enrollment record, which determines eligibility, benefit period, and coverage tier at time of service. Enrollment-based claim routing and eligibility',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Claims are adjudicated under a specific payer contract determining reimbursement method, timely filing limits, and dispute resolution procedures. Contract-level claim performance reporting and revenue',
    `payer_id` BIGINT COMMENT 'Insurance payer organization.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Revenue Cycle Management (RCM) coding validation and DRG assignment require linking the claim header to the authoritative clinical diagnosis record. Replaces denormalized principal_diagnosis_code text',
    `referral_order_id` BIGINT COMMENT 'Link to referral order if applicable.',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered the service.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Surgical revenue cycle management requires tracing each claim back to its originating surgical case for implant billing, OR utilization reporting, and CMS surgical billing compliance. A domain expert ',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Date and time claim was adjudicated by payer.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustment amount applied to claim.',
    `admission_date` DATE COMMENT 'Date of admission for inpatient claims.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed if applicable.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates if an appeal has been filed.',
    `bill_type` STRING COMMENT 'UB-04 bill type code.',
    `claim_number` STRING COMMENT 'Internal claim number.',
    `claim_status` STRING COMMENT 'Current status of claim (submitted, paid, denied, etc.).',
    `claim_type` STRING COMMENT 'Type of claim (professional, institutional, dental, etc.).',
    `coordination_of_benefits_flag` BOOLEAN COMMENT 'Indicates if coordination of benefits applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when claim record was created.',
    `currency_code` STRING COMMENT 'ISO currency code for claim amounts.',
    `denial_reason_code` STRING COMMENT 'Code indicating reason for denial if applicable.',
    `denial_reason_description` STRING COMMENT 'Description of denial reason.',
    `discharge_date` DATE COMMENT 'Date of discharge for inpatient claims.',
    `drg_grouper_version` STRING COMMENT 'Version of DRG grouper software used.',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time claim was paid.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Amount patient is responsible for.',
    `payer_claim_number` STRING COMMENT 'Payer-assigned claim control number.',
    `place_of_service_code` STRING COMMENT 'CMS place of service code.',
    `primary_payer_flag` BOOLEAN COMMENT 'Indicates if this is the primary payer.',
    `principal_procedure_code` STRING COMMENT 'ICD-10-PCS code for principal procedure.',
    `rac_audit_flag` BOOLEAN COMMENT 'Indicates if claim is subject to RAC audit.',
    `referring_provider_npi` STRING COMMENT 'NPI of referring provider.',
    `service_from_date` DATE COMMENT 'Start date of service period.',
    `service_to_date` DATE COMMENT 'End date of service period.',
    `source_system_claim_code` STRING COMMENT 'Claim identifier in source system.',
    `submission_method` STRING COMMENT 'Method of claim submission (EDI, paper, portal).',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time claim was submitted to payer.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Total amount allowed by payer.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed to payer.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by payer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim claim record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim claim record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Core claim record representing a request for payment from a payer for healthcare services rendered.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`line` (
    `line_id` BIGINT COMMENT 'Unique identifier for the claim line.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: Each claim line is adjudicated against a specific benefit (inpatient, outpatient, DME, etc.) determining allowed amount, cost-sharing, and authorization requirements. Benefit-level adjudication report',
    `charge_id` BIGINT COMMENT 'Link to billing charge record.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Each claim line is reimbursed per a specific fee schedule line (procedure code + modifier rate). This is the core contract pricing link for underpayment detection, payment variance analysis, and contr',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Individual claim lines (procedure codes) are subject to specific PA rules. Line-level PA compliance checking and denial prevention for missing/invalid authorizations require linking each service line ',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Charge capture and claim generation process links each billed claim line to the specific clinical procedure event performed. Required for revenue integrity reporting, RAC audit defense, and coding acc',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered the service.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Lab Charge Integrity Validation: each claim line for a lab service should reference the test catalog entry to validate that the billed procedure code matches an orderable, active test. Supports charge',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Charge capture reconciliation and underpayment analysis require matching each claim line to the originating visit procedure. Revenue integrity teams audit CPT codes, modifiers, and RVUs at the line-to',
    `adjudication_date` DATE COMMENT 'Date line was adjudicated.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment amount for this line.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Amount allowed by payer.',
    `authorization_number` STRING COMMENT 'Prior authorization number.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Amount billed to payer.',
    `coordination_of_benefits_indicator` STRING COMMENT 'The coordination of benefits indicator of the claim line record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when line was created.',
    `denial_reason_code` STRING COMMENT 'Code indicating reason for denial.',
    `diagnosis_pointer_1` STRING COMMENT 'Pointer to first diagnosis.',
    `diagnosis_pointer_2` STRING COMMENT 'Pointer to second diagnosis.',
    `diagnosis_pointer_3` STRING COMMENT 'Pointer to third diagnosis.',
    `diagnosis_pointer_4` STRING COMMENT 'Pointer to fourth diagnosis.',
    `drg_weight` DECIMAL(18,2) COMMENT 'DRG relative weight.',
    `drug_quantity` DECIMAL(18,2) COMMENT 'Quantity of drug administered.',
    `drug_unit_of_measure` STRING COMMENT 'Unit of measure for drug quantity.',
    `line_number` STRING COMMENT 'Sequential line number within claim.',
    `line_status` STRING COMMENT 'Status of claim line.',
    `modifier_1` STRING COMMENT 'First procedure modifier.',
    `modifier_2` STRING COMMENT 'Second procedure modifier.',
    `modifier_3` STRING COMMENT 'Third procedure modifier.',
    `modifier_4` STRING COMMENT 'Fourth procedure modifier.',
    `ndc_code` STRING COMMENT 'National Drug Code.',
    `ordering_provider_npi` STRING COMMENT 'NPI of ordering provider.',
    `outlier_payment_amount` DECIMAL(18,2) COMMENT 'The outlier payment amount of the claim line record.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by payer.',
    `paid_date` DATE COMMENT 'Date line was paid.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Amount patient is responsible for.',
    `place_of_service_code` STRING COMMENT 'CMS place of service code.',
    `procedure_code` STRING COMMENT 'Procedure code (CPT/HCPCS).',
    `remark_code` STRING COMMENT 'Remittance advice remark code.',
    `revenue_code` STRING COMMENT 'UB-04 revenue code.',
    `service_description` STRING COMMENT 'Description of service rendered.',
    `service_from_date` DATE COMMENT 'Start date of service.',
    `service_to_date` DATE COMMENT 'End date of service.',
    `units_of_service` DECIMAL(18,2) COMMENT 'Number of units of service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim line record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim line record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Individual service line within a claim, representing a single billable service or item.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` (
    `diagnosis_link_id` BIGINT COMMENT 'Unique identifier for diagnosis link.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Diagnosis codes are evaluated against coverage policies for medical necessity and coverage determination. CDI programs and denial prevention for diagnosis-based coverage exclusions require linking dia',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: CDI (Clinical Documentation Improvement) and coding workflows require diagnosis_link to trace back to the authoritative clinical diagnosis record. Enables denial management, coding validation, and qua',
    `visit_diagnosis_id` BIGINT COMMENT 'Link to encounter diagnosis.',
    `active_flag` BOOLEAN COMMENT 'Indicates if diagnosis is active.',
    `cdi_query_flag` BOOLEAN COMMENT 'Indicates if CDI query was issued.',
    `chronic_condition_flag` BOOLEAN COMMENT 'Indicates if diagnosis is chronic.',
    `coding_source` STRING COMMENT 'Source of coding (manual, CAC, etc.).',
    `coding_timestamp` TIMESTAMP COMMENT 'Timestamp when diagnosis was coded.',
    `complication_flag` BOOLEAN COMMENT 'Indicates if diagnosis is a complication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `denial_risk_flag` BOOLEAN COMMENT 'Indicates if diagnosis poses denial risk.',
    `diagnosis_category` STRING COMMENT 'Category of diagnosis.',
    `diagnosis_date` DATE COMMENT 'Date diagnosis was made.',
    `diagnosis_description` STRING COMMENT 'Description of diagnosis.',
    `diagnosis_pointer` STRING COMMENT 'Pointer used on claim lines.',
    `diagnosis_sequence` STRING COMMENT 'Sequence number of diagnosis.',
    `diagnosis_type` STRING COMMENT 'Type of diagnosis (principal, secondary, etc.).',
    `diagnosis_version` STRING COMMENT 'ICD version (ICD-10-CM, etc.).',
    `drg_grouper_flag` BOOLEAN COMMENT 'Indicates if diagnosis affects DRG.',
    `encounter_type` STRING COMMENT 'Type of encounter.',
    `hac_flag` BOOLEAN COMMENT 'Hospital-acquired condition flag.',
    `laterality` STRING COMMENT 'Laterality (left, right, bilateral).',
    `poa_indicator` STRING COMMENT 'Present on admission indicator.',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates if diagnosis is part of quality measure.',
    `rac_audit_risk_score` DECIMAL(18,2) COMMENT 'Risk score for RAC audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim diagnosis link record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim diagnosis link record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_diagnosis_link PRIMARY KEY(`diagnosis_link_id`)
) COMMENT 'Links diagnosis codes to claims for medical necessity and DRG grouping.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for submission.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Claims are submitted under a specific health plans EDI requirements, timely filing rules, and clearinghouse routing. Health plan linkage on submission supports timely filing compliance tracking and p',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Claim submission originates from a billable invoice in the revenue cycle. Linking submission to invoice enables tracking which invoice generated each claim submission, supports timely filing complianc',
    `original_submission_id` BIGINT COMMENT 'Link to original submission if resubmission.',
    `payer_id` BIGINT COMMENT 'Payer receiving submission.',
    `org_provider_id` BIGINT COMMENT 'Organization submitting claim.',
    `acknowledgment_date` DATE COMMENT 'Date acknowledgment received.',
    `acknowledgment_status` STRING COMMENT 'Status of acknowledgment.',
    `batch_number` STRING COMMENT 'Batch number for submission.',
    `batch_sequence_number` STRING COMMENT 'Sequence number within batch.',
    `claim_charge_amount` DECIMAL(18,2) COMMENT 'Total charge amount submitted.',
    `claim_filing_indicator_code` STRING COMMENT 'The claim filing indicator code value classifying the claim submission record.',
    `clearinghouse_transaction_number` STRING COMMENT 'The clearinghouse transaction number of the claim submission record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `edi_transaction_set` STRING COMMENT 'EDI transaction set (837P, 837I).',
    `error_code` STRING COMMENT 'Error code if submission failed.',
    `error_description` STRING COMMENT 'Description of error.',
    `is_timely_filed` BOOLEAN COMMENT 'Indicates if submission was timely.',
    `method` STRING COMMENT 'Method of submission (EDI, paper, portal).',
    `notes` STRING COMMENT 'Additional notes.',
    `payer_acknowledgment_number` STRING COMMENT 'The payer acknowledgment number of the claim submission record.',
    `prior_authorization_number` STRING COMMENT 'The prior authorization number of the claim submission record.',
    `rejection_reason_code` STRING COMMENT 'Code indicating reason for rejection.',
    `rejection_reason_description` STRING COMMENT 'Description of rejection reason.',
    `resubmission_count` STRING COMMENT 'Number of resubmissions.',
    `resubmission_reason_code` STRING COMMENT 'Reason code for resubmission.',
    `submission_date` DATE COMMENT 'Date of submission.',
    `submission_number` STRING COMMENT 'Internal submission number.',
    `submission_status` STRING COMMENT 'Status of submission.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp of submission.',
    `submission_type` STRING COMMENT 'Type of submission (original, corrected, void).',
    `submitter_contact_email` STRING COMMENT 'Email of submitter contact.',
    `submitter_contact_name` STRING COMMENT 'Name of submitter contact.',
    `submitter_contact_phone` STRING COMMENT 'Phone of submitter contact.',
    `submitter_organization_name` STRING COMMENT 'Name of submitting organization.',
    `timely_filing_deadline` DATE COMMENT 'Deadline for timely filing.',
    `transmission_control_number` STRING COMMENT 'EDI transmission control number.',
    `transmission_file_name` STRING COMMENT 'Name of transmission file.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim submission record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim submission record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Tracks claim submission events to payers including EDI transmission details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`remittance` (
    `remittance_id` BIGINT COMMENT 'Unique identifier for remittance.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: ERA/remittance reconciliation process requires linking payer remittance to the billing invoice being settled. Revenue cycle cash posting workflows depend on this link to apply remittance payments agai',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Payment reconciliation, lockbox posting, and revenue cycle analytics require linking remittance to payee organization. Converts denormalized payee_npi/payee_name to proper FK for payment variance anal',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to insurance.payer_contract. Business justification: Remittances are reconciled against payer contracts to detect aggregate underpayments and contractual adjustments. Contract-level remittance reporting and payer contract performance analysis require he',
    `payer_id` BIGINT COMMENT 'Payer issuing remittance.',
    `bank_account_number` STRING COMMENT 'Bank account number for payment.',
    `check_eft_number` STRING COMMENT 'Check or EFT number.',
    `coverage_period_end_date` DATE COMMENT 'End date of coverage period.',
    `coverage_period_start_date` DATE COMMENT 'Start date of coverage period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `fiscal_period_date` DATE COMMENT 'Timestamp capturing the fiscal period date associated with the claim remittance record.',
    `group_control_number` STRING COMMENT 'EDI group control number.',
    `interchange_control_number` STRING COMMENT 'EDI interchange control number.',
    `notes` STRING COMMENT 'Additional notes.',
    `payer_claim_control_number` STRING COMMENT 'The payer claim control number of the claim remittance record.',
    `payer_contact_email` STRING COMMENT 'Email of payer contact.',
    `payer_contact_name` STRING COMMENT 'Name of payer contact.',
    `payer_contact_phone` STRING COMMENT 'Phone of payer contact.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total payment amount.',
    `payment_date` DATE COMMENT 'Date of payment.',
    `payment_method_code` STRING COMMENT 'The payment method code value classifying the claim remittance record.',
    `posting_date` DATE COMMENT 'Date remittance was posted.',
    `production_date` DATE COMMENT 'Date remittance was produced.',
    `provider_adjustment_amount` DECIMAL(18,2) COMMENT 'Provider-level adjustment amount.',
    `provider_adjustment_reason_code` STRING COMMENT 'Reason code for provider adjustment.',
    `received_timestamp` TIMESTAMP COMMENT 'Timestamp when remittance was received.',
    `receiver_identification` STRING COMMENT 'EDI receiver identification.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation.',
    `remittance_status` STRING COMMENT 'Status of remittance.',
    `routing_number` STRING COMMENT 'Bank routing number.',
    `sender_identification` STRING COMMENT 'EDI sender identification.',
    `source_file_name` STRING COMMENT 'Name of source file.',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'The total adjustment amount of the claim remittance record.',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'The total allowed amount of the claim remittance record.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'The total billed amount of the claim remittance record.',
    `total_claim_count` STRING COMMENT 'Total number of claims in remittance.',
    `total_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The total patient responsibility amount of the claim remittance record.',
    `transaction_set_control_number` STRING COMMENT 'EDI transaction set control number.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim remittance record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim remittance record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_remittance PRIMARY KEY(`remittance_id`)
) COMMENT 'Electronic remittance advice (ERA) from payers detailing payment and adjustments.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` (
    `remittance_line_id` BIGINT COMMENT 'Unique identifier for remittance line.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: Remittance line adjustments (coinsurance, copay, deductible) map to specific benefit cost-sharing rules. Benefit-level payment variance analysis and cost-sharing accuracy audits in revenue integrity p',
    `charge_id` BIGINT COMMENT 'Link to billing charge.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `fee_schedule_id` BIGINT COMMENT 'Link to fee schedule.',
    `fee_schedule_line_id` BIGINT COMMENT 'Foreign key linking to insurance.fee_schedule_line. Business justification: Remittance line paid amounts are validated against the contracted fee schedule line rate for underpayment detection. Revenue integrity programs require line-level rate comparison; remittance_line alre',
    `line_id` BIGINT COMMENT 'Link to claim line.',
    `payer_contract_id` BIGINT COMMENT 'Link to payer contract.',
    `remittance_id` BIGINT COMMENT 'Parent remittance record.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment amount for line.',
    `adjustment_date` DATE COMMENT 'Date of adjustment.',
    `adjustment_group_code` STRING COMMENT 'Adjustment group code (CO, PR, OA, PI).',
    `adjustment_quantity` DECIMAL(18,2) COMMENT 'Quantity adjustment.',
    `adjustment_source` STRING COMMENT 'Source of adjustment.',
    `adjustment_type` STRING COMMENT 'Type of adjustment.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Amount allowed by payer.',
    `balance_transfer_amount` DECIMAL(18,2) COMMENT 'Amount transferred to patient balance.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Amount billed.',
    `claim_adjustment_reason_code` STRING COMMENT 'CARC code.',
    `coinsurance_amount` DECIMAL(18,2) COMMENT 'The coinsurance amount of the claim remittance line record.',
    `contractual_adjustment_amount` DECIMAL(18,2) COMMENT 'The contractual adjustment amount of the claim remittance line record.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The copay amount of the claim remittance line record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `credit_balance_amount` DECIMAL(18,2) COMMENT 'The credit balance amount of the claim remittance line record.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The deductible amount of the claim remittance line record.',
    `denial_reason_code` STRING COMMENT 'Code indicating reason for denial.',
    `gl_account_code` STRING COMMENT 'General ledger account code.',
    `line_payment_status` STRING COMMENT 'Payment status of line.',
    `line_sequence_number` STRING COMMENT 'Sequence number of line.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'The net revenue amount of the claim remittance line record.',
    `note` STRING COMMENT 'Additional notes.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Amount paid.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The patient responsibility amount of the claim remittance line record.',
    `payer_claim_control_number` STRING COMMENT 'The payer claim control number of the claim remittance line record.',
    `posting_date` DATE COMMENT 'Date line was posted.',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the claim remittance line record.',
    `procedure_modifier_1` STRING COMMENT 'First procedure modifier.',
    `procedure_modifier_2` STRING COMMENT 'Second procedure modifier.',
    `procedure_modifier_3` STRING COMMENT 'Third procedure modifier.',
    `procedure_modifier_4` STRING COMMENT 'Fourth procedure modifier.',
    `recoupment_amount` DECIMAL(18,2) COMMENT 'The recoupment amount of the claim remittance line record.',
    `remittance_advice_remark_code` STRING COMMENT 'RARC code.',
    `revenue_code` STRING COMMENT 'UB-04 revenue code.',
    `service_date` DATE COMMENT 'Date of service.',
    `service_line_number` STRING COMMENT 'The service line number of the claim remittance line record.',
    `units_of_service` DECIMAL(18,2) COMMENT 'The units of service of the claim remittance line record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Variance amount between billed and paid.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim remittance line record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim remittance line record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_remittance_line PRIMARY KEY(`remittance_line_id`)
) COMMENT 'Individual service line detail within an ERA showing payment and adjustment details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`denial` (
    `denial_id` BIGINT COMMENT 'Unique identifier for denial.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: Denials are frequently issued because a service is not covered under a specific benefit (exclusion, visit limit exceeded, non-covered service). Benefit-level denial analytics and appeals preparation r',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `coverage_policy_id` BIGINT COMMENT 'Link to coverage policy.',
    `insurance_coverage_id` BIGINT COMMENT 'Patient insurance coverage.',
    `invoice_id` BIGINT COMMENT 'Link to invoice.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Denials can occur at the claim line level (e.g., a specific procedure code is denied while others on the same claim are paid). The denial table currently stores claim_line_number as an INT, which is a',
    `payer_id` BIGINT COMMENT 'Payer who denied claim.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Denials frequently cite PA rule violations (missing auth, wrong procedure, expired auth). Linking denial to the specific prior_auth_rule violated supports denial root-cause analysis, prevention progra',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered service.',
    `report_id` BIGINT COMMENT 'Foreign key linking to radiology.report. Business justification: Radiology claim denials for medical necessity require direct reference to the finalized radiology report as supporting clinical documentation. Denial management teams attach the report to denial recor',
    `submission_id` BIGINT COMMENT 'Foreign key linking to claim.submission. Business justification: A denial is issued in response to a specific claim submission event. The denial table already has claim_id but lacks a direct link to the specific submission attempt that was denied. Adding submission',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Amount allowed by payer.',
    `appeal_deadline_date` DATE COMMENT 'Deadline for filing appeal.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed.',
    `appeal_level` STRING COMMENT 'Level of appeal (first, second, etc.).',
    `appeal_outcome` STRING COMMENT 'Outcome of appeal.',
    `appeal_outcome_date` DATE COMMENT 'Date of appeal outcome.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Amount billed.',
    `carc_code` STRING COMMENT 'Claim adjustment reason code.',
    `carc_description` STRING COMMENT 'Description of CARC code.',
    `denial_category` STRING COMMENT 'Category of denial.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `denial_date` DATE COMMENT 'Date of denial.',
    `denial_number` STRING COMMENT 'Internal denial tracking number.',
    `denial_type` STRING COMMENT 'Type of denial (technical, clinical, etc.).',
    `denied_amount` DECIMAL(18,2) COMMENT 'Amount denied.',
    `is_preventable` BOOLEAN COMMENT 'Indicates if denial was preventable.',
    `is_rac_audit` BOOLEAN COMMENT 'Indicates if denial is from RAC audit.',
    `medical_record_number` STRING COMMENT 'Patient MRN.',
    `notes` STRING COMMENT 'Additional notes.',
    `patient_account_number` STRING COMMENT 'The patient account number of the claim denial record.',
    `priority_level` STRING COMMENT 'Priority level for resolution.',
    `rarc_code` STRING COMMENT 'Remittance advice remark code.',
    `rarc_description` STRING COMMENT 'Description of RARC code.',
    `reason_text` STRING COMMENT 'Free text reason for denial.',
    `received_date` DATE COMMENT 'Date denial was received.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Amount recovered through appeal.',
    `resolution_status` STRING COMMENT 'Status of denial resolution.',
    `responsible_department` STRING COMMENT 'Department responsible for resolution.',
    `root_cause_code` STRING COMMENT 'The root cause code value classifying the claim denial record.',
    `root_cause_description` STRING COMMENT 'Description of root cause.',
    `service_date` DATE COMMENT 'Date of service.',
    `source` STRING COMMENT 'Source of denial (payer, internal, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim denial record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim denial record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off.',
    `write_off_date` DATE COMMENT 'Date of write-off.',
    CONSTRAINT pk_denial PRIMARY KEY(`denial_id`)
) COMMENT 'Tracks denied claims and denial management workflow including appeals.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`appeal` (
    `appeal_id` BIGINT COMMENT 'Unique identifier for appeal.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `coverage_policy_id` BIGINT COMMENT 'Link to coverage policy.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: An appeal is filed specifically to overturn a denial. Without a direct denial_id FK on appeal, the relationship between an appeal and the denial it contests can only be inferred through claim_id, whic',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Appeals are governed by health plan-specific procedures, timelines, and appeal rights (ACA internal appeal requirements, ERISA). Plan-level appeal outcome reporting and regulatory compliance tracking ',
    `insurance_coverage_id` BIGINT COMMENT 'Patient insurance coverage.',
    `invoice_id` BIGINT COMMENT 'Link to invoice.',
    `payer_id` BIGINT COMMENT 'Payer receiving appeal.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Appeals with prior_authorization_issue_flag=true contest specific PA rules. Linking appeal to prior_auth_rule supports appeal preparation, clinical rationale documentation, and overturn rate tracking ',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Appeals frequently involve prior authorization disputes — the payer may deny a claim citing lack of prior authorization, or may deny the prior auth itself, triggering an appeal. The appeal table has p',
    `report_id` BIGINT COMMENT 'Foreign key linking to radiology.report. Business justification: Radiology claim appeals require the finalized report as primary clinical evidence for medical necessity arguments. Appeal coordinators reference the radiologists findings and impression text directly',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.note. Business justification: Denial appeals management requires linking the specific clinical note submitted as medical record evidence to overturn a denial. Replaces free-text supporting_documentation_references. Standard in RCM',
    `appeal_number` STRING COMMENT 'Internal appeal tracking number.',
    `appeal_status` STRING COMMENT 'Status of appeal.',
    `appeal_type` STRING COMMENT 'Type of appeal (clinical, technical, etc.).',
    `clinical_rationale` STRING COMMENT 'Clinical rationale for appeal.',
    `coordination_of_benefits_issue_flag` BOOLEAN COMMENT 'Indicates if COB issue exists.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `deadline_date` DATE COMMENT 'Deadline for appeal submission.',
    `denied_amount` DECIMAL(18,2) COMMENT 'Amount denied.',
    `external_review_requested_flag` BOOLEAN COMMENT 'Indicates if external review was requested.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification.',
    `appeal_level` STRING COMMENT 'Level of appeal (first, second, external).',
    `notes` STRING COMMENT 'Additional notes.',
    `original_claim_amount` DECIMAL(18,2) COMMENT 'The original claim amount of the claim appeal record.',
    `outcome_code` STRING COMMENT 'The outcome code value classifying the claim appeal record.',
    `outcome_description` STRING COMMENT 'Description of outcome.',
    `overturn_amount` DECIMAL(18,2) COMMENT 'Amount overturned.',
    `payer_appeal_reference_number` STRING COMMENT 'The payer appeal reference number of the claim appeal record.',
    `peer_review_required_flag` BOOLEAN COMMENT 'Indicates if peer review is required.',
    `prior_authorization_issue_flag` BOOLEAN COMMENT 'Indicates if prior auth issue exists.',
    `priority_flag` BOOLEAN COMMENT 'Indicates if appeal is priority.',
    `rac_audit_related_flag` BOOLEAN COMMENT 'Indicates if appeal is RAC audit related.',
    `requested_amount` DECIMAL(18,2) COMMENT 'Amount requested in appeal.',
    `resolution_date` DATE COMMENT 'Date of resolution.',
    `service_from_date` DATE COMMENT 'Start date of service.',
    `service_to_date` DATE COMMENT 'End date of service.',
    `service_type_code` STRING COMMENT 'The service type code value classifying the claim appeal record.',
    `submission_date` DATE COMMENT 'Date appeal was submitted.',
    `submission_method` STRING COMMENT 'Method of submission.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim appeal record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim appeal record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Tracks claim appeals filed with payers to overturn denials.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` (
    `prior_authorization_id` BIGINT COMMENT 'Unique identifier for prior authorization.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Utilization management tracks authorized vs. performed procedures. Linking prior_authorization to the specific procedure_event enables authorization compliance reporting, over/under-utilization detect',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Utilization management requires linking prior authorization requests to the authoritative clinical diagnosis driving the medical necessity indication. Replaces denormalized clinical_indication_icd10_c',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: PA decisions are governed by coverage policies defining medical necessity criteria and clinical evidence standards. Linking PA to coverage_policy supports medical necessity review, clinical documentat',
    `org_provider_id` BIGINT COMMENT 'Facility organization.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: PA is issued under a specific health plans rules governing turnaround time standards, appeal rights, and PA requirements. Plan-level PA approval rate reporting and CMS No Surprises Act / Consolidated',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Prior authorization is submitted for a specific patient; CMS and payer regulations require patient identity on PA requests. Revenue cycle and utilization management workflows depend on linking PA reco',
    `patient_account_id` BIGINT COMMENT 'Patient account.',
    `payer_id` BIGINT COMMENT 'Payer issuing authorization.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: A prior authorization is evaluated against a specific payer PA rule defining clinical criteria, turnaround times, and documentation requirements. PA compliance auditing, denial prevention programs, an',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Referral orders frequently require separate prior authorization from payers. Managed care and utilization management workflows require linking the prior auth directly to the originating referral order',
    `clinician_id` BIGINT COMMENT 'Clinician requesting authorization.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Lab PA Service Validation: prior authorizations for lab services reference specific orderable tests. Linking PA to test_catalog allows PA coordinators to validate requested CPT codes against the labs',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `appeal_decision_date` DATE COMMENT 'Date of appeal decision.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates if appeal was filed.',
    `appeal_outcome` STRING COMMENT 'Outcome of appeal.',
    `approved_end_date` DATE COMMENT 'End date of approved period.',
    `approved_start_date` DATE COMMENT 'Start date of approved period.',
    `approved_units` DECIMAL(18,2) COMMENT 'Number of units approved.',
    `authorization_notes` STRING COMMENT 'Additional notes.',
    `authorization_number` STRING COMMENT 'The authorization number of the claim prior authorization record.',
    `authorization_source` STRING COMMENT 'Source of authorization.',
    `authorization_status` STRING COMMENT 'Status of authorization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `decision_date` DATE COMMENT 'Date of authorization decision.',
    `denial_reason_code` STRING COMMENT 'Code indicating reason for denial.',
    `denial_reason_description` STRING COMMENT 'Description of denial reason.',
    `payer_type` STRING COMMENT 'Type of payer.',
    `peer_review_completed_date` DATE COMMENT 'Date peer review was completed.',
    `peer_review_required_flag` BOOLEAN COMMENT 'Indicates if peer review is required.',
    `rendering_provider_npi` STRING COMMENT 'NPI of rendering provider.',
    `requested_units` DECIMAL(18,2) COMMENT 'Number of units requested.',
    `service_setting` STRING COMMENT 'Setting where service will be rendered.',
    `submission_date` DATE COMMENT 'Date authorization was submitted.',
    `units_consumed` DECIMAL(18,2) COMMENT 'Number of units consumed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `urgency_level` STRING COMMENT 'Urgency level of request.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim prior authorization record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim prior authorization record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_prior_authorization PRIMARY KEY(`prior_authorization_id`)
) COMMENT 'Tracks prior authorization requests and approvals required before service delivery.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`eligibility` (
    `eligibility_id` BIGINT COMMENT 'Unique identifier for eligibility record.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Eligibility verification is frequently performed in the context of a specific claim — either at pre-submission to confirm coverage before billing, or during adjudication to validate active coverage on',
    `clinician_id` BIGINT COMMENT 'Clinician requesting eligibility.',
    `mpi_record_id` BIGINT COMMENT 'Member MPI record.',
    `eligibility_mpi_record_id` BIGINT COMMENT 'Patient MPI record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Eligibility verification is performed against a specific health plan returning plan-specific benefit details (deductible, copay, OOP). Health plan linkage is essential for benefit display at point of ',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Eligibility checks are resolved against the members enrollment record to confirm active coverage, benefit period, and enrollment status. Real-time eligibility verification workflows and enrollment-el',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the claim eligibility record.',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `clearinghouse_name` STRING COMMENT 'Name of clearinghouse.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this eligibility check is related to clinical trial coverage analysis',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The coinsurance percentage of the claim eligibility record.',
    `coordination_of_benefits_order` STRING COMMENT 'The coordination of benefits order of the claim eligibility record.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The copay amount of the claim eligibility record.',
    `coverage_effective_date` DATE COMMENT 'Effective date of coverage.',
    `coverage_level` STRING COMMENT 'Level of coverage.',
    `coverage_status` STRING COMMENT 'Status of coverage.',
    `coverage_termination_date` DATE COMMENT 'Termination date of coverage.',
    `coverage_type` STRING COMMENT 'Type of coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The deductible amount of the claim eligibility record.',
    `deductible_met_amount` DECIMAL(18,2) COMMENT 'Amount of deductible met.',
    `deductible_remaining_amount` DECIMAL(18,2) COMMENT 'Remaining deductible amount.',
    `group_number` STRING COMMENT 'The group number of the claim eligibility record.',
    `network_status` STRING COMMENT 'Network status (in-network, out-of-network).',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'The out of pocket maximum of the claim eligibility record.',
    `out_of_pocket_met_amount` DECIMAL(18,2) COMMENT 'Amount of out-of-pocket met.',
    `pcp_name` STRING COMMENT 'Name of primary care provider.',
    `pcp_npi` STRING COMMENT 'NPI of primary care provider.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates if prior authorization is required.',
    `referral_required` BOOLEAN COMMENT 'Indicates if referral is required.',
    `rejection_reason` STRING COMMENT 'Reason for rejection.',
    `response_code` STRING COMMENT 'The response code value classifying the claim eligibility record.',
    `response_description` STRING COMMENT 'Description of response.',
    `service_date` DATE COMMENT 'Date of service.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `verification_date` DATE COMMENT 'Date of verification.',
    `verification_method` STRING COMMENT 'Method of verification.',
    `verification_request_timestamp` TIMESTAMP COMMENT 'Timestamp of verification request.',
    `verification_response_timestamp` TIMESTAMP COMMENT 'Timestamp of verification response.',
    `verification_status` STRING COMMENT 'Status of verification.',
    `verification_transaction_number` STRING COMMENT 'Transaction number for verification.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim eligibility record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim eligibility record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_eligibility PRIMARY KEY(`eligibility_id`)
) COMMENT 'Tracks real-time eligibility verification requests and responses from payers.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`cob` (
    `cob_id` BIGINT COMMENT 'Unique identifier for COB record.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: COB processing requires the secondary payers health plan to determine coordination order and secondary benefit calculation rules. Role-prefixed secondary_health_plan_id distinguishes from primary/t',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: COB determination requires the members enrollment record to validate dual-enrollment status, coverage order, and relationship_to_subscriber. Enrollment data is the authoritative source for COB order ',
    `mpi_record_id` BIGINT COMMENT 'Patient MPI record.',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: COB processing requires direct reference to the primary insurance coverage record to apply correct payment sequencing, deductible coordination, and MSP rules. COB adjudication workflows and CMS MSP co',
    `payer_id` BIGINT COMMENT 'Primary payer.',
    `tertiary_payer_id` BIGINT COMMENT 'Tertiary payer.',
    `birthday_rule_applied` BOOLEAN COMMENT 'Indicates if birthday rule was applied.',
    `cob_status` STRING COMMENT 'Status of COB.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `crossover_claim_indicator` BOOLEAN COMMENT 'Indicates if claim is crossover.',
    `determination_date` DATE COMMENT 'Date of COB determination.',
    `determination_method` STRING COMMENT 'Method of determination.',
    `duplicate_payment_prevention_flag` BOOLEAN COMMENT 'Indicates if duplicate payment prevention applies.',
    `gender_rule_applied` BOOLEAN COMMENT 'Indicates if gender rule was applied.',
    `method` STRING COMMENT 'Method of COB determination.',
    `msp_indicator` BOOLEAN COMMENT 'Medicare Secondary Payer indicator.',
    `msp_type_code` STRING COMMENT 'The msp type code value classifying the claim cob record.',
    `notes` STRING COMMENT 'Additional notes.',
    `order_sequence` STRING COMMENT 'Sequence order of payer.',
    `primary_adjustment_amount` DECIMAL(18,2) COMMENT 'Primary payer adjustment amount.',
    `primary_adjustment_reason_code` STRING COMMENT 'The primary adjustment reason code value classifying the claim cob record.',
    `primary_allowed_amount` DECIMAL(18,2) COMMENT 'Primary payer allowed amount.',
    `primary_billed_amount` DECIMAL(18,2) COMMENT 'Primary payer billed amount.',
    `primary_paid_amount` DECIMAL(18,2) COMMENT 'Primary payer paid amount.',
    `primary_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The primary patient responsibility amount of the claim cob record.',
    `tertiary_billed_amount` DECIMAL(18,2) COMMENT 'Tertiary payer billed amount.',
    `tertiary_paid_amount` DECIMAL(18,2) COMMENT 'Tertiary payer paid amount.',
    `total_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The total patient responsibility amount of the claim cob record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `verification_date` DATE COMMENT 'Date of verification.',
    `verification_method` STRING COMMENT 'Method of verification.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim cob record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim cob record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_cob PRIMARY KEY(`cob_id`)
) COMMENT 'Tracks coordination of benefits when patient has multiple insurance coverages.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_original_submission_id` FOREIGN KEY (`original_submission_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`submission`(`submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`submission`(`submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`denial`(`denial_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('dbx_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Assignment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjudication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `bill_type` SET TAGS ('dbx_business_glossary_term' = 'Bill Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `coordination_of_benefits_flag` SET TAGS ('dbx_business_glossary_term' = 'COB Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_grouper_version` SET TAGS ('dbx_business_glossary_term' = 'DRG Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_grouper_version` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `primary_payer_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Principal Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `rac_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'RAC Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Referring Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `source_system_claim_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Claim Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `charge_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `claim_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `adjudication_date` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('dbx_business_glossary_term' = 'COB Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drg_weight` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drug_quantity` SET TAGS ('dbx_business_glossary_term' = 'Drug Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `outlier_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Outlier Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Paid Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Link Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `claim_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `cdi_query_flag` SET TAGS ('dbx_business_glossary_term' = 'CDI Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_source` SET TAGS ('dbx_business_glossary_term' = 'Coding Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coding Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `complication_flag` SET TAGS ('dbx_business_glossary_term' = 'Complication Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `denial_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Denial Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `drg_grouper_flag` SET TAGS ('dbx_business_glossary_term' = 'DRG Grouper Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `drg_grouper_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `hac_flag` SET TAGS ('dbx_business_glossary_term' = 'HAC Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_business_glossary_term' = 'POA Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `rac_audit_risk_score` SET TAGS ('dbx_business_glossary_term' = 'RAC Audit Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `original_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `original_submission_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_filing_indicator_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Filing Indicator Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `clearinghouse_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'EDI Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `is_timely_filed` SET TAGS ('dbx_business_glossary_term' = 'Is Timely Filed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_acknowledgment_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Acknowledgment Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Deadline');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transmission Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `check_eft_number` SET TAGS ('dbx_business_glossary_term' = 'Check EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_date` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `group_control_number` SET TAGS ('dbx_business_glossary_term' = 'Group Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Provider Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `receiver_identification` SET TAGS ('dbx_business_glossary_term' = 'Receiver Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Remittance Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `sender_identification` SET TAGS ('dbx_business_glossary_term' = 'Sender Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_claim_count` SET TAGS ('dbx_business_glossary_term' = 'Total Claim Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `transaction_set_control_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_line_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_line_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `charge_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_group_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Group Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_source` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `balance_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Balance Transfer Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `contractual_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `credit_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Line Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Note');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_claim_control_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_advice_remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_line_number` SET TAGS ('dbx_business_glossary_term' = 'Service Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('dbx_subdomain' = 'appeal_management');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `claim_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `invoice_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_level` SET TAGS ('dbx_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `carc_code` SET TAGS ('dbx_business_glossary_term' = 'CARC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `carc_description` SET TAGS ('dbx_business_glossary_term' = 'CARC Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_category` SET TAGS ('dbx_business_glossary_term' = 'Denial Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_number` SET TAGS ('dbx_business_glossary_term' = 'Denial Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('dbx_business_glossary_term' = 'Denial Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denied_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `is_preventable` SET TAGS ('dbx_business_glossary_term' = 'Is Preventable');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `is_rac_audit` SET TAGS ('dbx_business_glossary_term' = 'Is RAC Audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `rarc_code` SET TAGS ('dbx_business_glossary_term' = 'RARC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `rarc_description` SET TAGS ('dbx_business_glossary_term' = 'RARC Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `reason_text` SET TAGS ('dbx_business_glossary_term' = 'Reason Text');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Denial Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write Off Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('dbx_subdomain' = 'appeal_management');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `claim_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `invoice_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coordination_of_benefits_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'COB Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denied_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `external_review_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'External Review Requested Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_level` SET TAGS ('dbx_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `original_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Outcome Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `overturn_amount` SET TAGS ('dbx_business_glossary_term' = 'Overturn Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_appeal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Appeal Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `peer_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `prior_authorization_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `rac_audit_related_flag` SET TAGS ('dbx_business_glossary_term' = 'RAC Audit Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_from_date` SET TAGS ('dbx_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_to_date` SET TAGS ('dbx_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('dbx_subdomain' = 'benefit_verification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Organization Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_units` SET TAGS ('dbx_business_glossary_term' = 'Approved Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_source` SET TAGS ('dbx_business_glossary_term' = 'Authorization Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_units` SET TAGS ('dbx_business_glossary_term' = 'Requested Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_business_glossary_term' = 'Service Setting');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `units_consumed` SET TAGS ('dbx_business_glossary_term' = 'Units Consumed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('dbx_subdomain' = 'benefit_verification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinician_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_mpi_record_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `visit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('dbx_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out of Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('dbx_business_glossary_term' = 'Out of Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_business_glossary_term' = 'PCP Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_business_glossary_term' = 'PCP NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_description` SET TAGS ('dbx_business_glossary_term' = 'Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('dbx_subdomain' = 'benefit_verification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('dbx_business_glossary_term' = 'COB Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `claim_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Secondary Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_payer_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Birthday Rule Applied');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('dbx_business_glossary_term' = 'COB Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `crossover_claim_indicator` SET TAGS ('dbx_business_glossary_term' = 'Crossover Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_method` SET TAGS ('dbx_business_glossary_term' = 'Determination Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `duplicate_payment_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Payment Prevention Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_business_glossary_term' = 'Gender Rule Applied');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('dbx_pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'COB Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_indicator` SET TAGS ('dbx_business_glossary_term' = 'MSP Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_type_code` SET TAGS ('dbx_business_glossary_term' = 'MSP Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `order_sequence` SET TAGS ('dbx_business_glossary_term' = 'Order Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
