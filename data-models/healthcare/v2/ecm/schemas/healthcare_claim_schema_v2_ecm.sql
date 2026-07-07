-- Schema for Domain: claim | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`claim` COMMENT 'Insurance claims processing and payer adjudication. Owns claim submission, claim status tracking, payer adjudication, remittance advice (ERA - Electronic Remittance Advice), EOB (Explanation of Benefits), denial management, appeals, prior authorization, eligibility verification, payer contract management, RAC audit responses, and coordination of benefits across HMO, PPO, POS, Medicare, and Medicaid payers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique identifier for the claim record.',
    `ar_account_id` BIGINT COMMENT 'Link to the AR account for revenue tracking.',
    `org_provider_id` BIGINT COMMENT 'Organization submitting the claim.',
    `care_site_id` BIGINT COMMENT 'Facility where service was rendered.',
    `clinical_order_id` BIGINT COMMENT 'Link to the originating clinical order.',
    `demographics_id` BIGINT COMMENT 'Link to patient demographic record.',
    `drg_id` BIGINT COMMENT 'Diagnosis Related Group assignment.',
    `guarantor_id` BIGINT COMMENT 'Financially responsible party.',
    `insurance_coverage_id` BIGINT COMMENT 'Patient insurance coverage record.',
    `payer_id` BIGINT COMMENT 'Insurance payer organization.',
    `referral_order_id` BIGINT COMMENT 'Link to referral order if applicable.',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered the service.',
    `journal_entry_id` BIGINT COMMENT 'Link to revenue journal entry.',
    `cost_center_id` BIGINT COMMENT 'Cost center for service.',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period of service.',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Date and time claim was adjudicated by payer.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustment amount applied to claim.',
    `admission_date` DATE COMMENT 'Date of admission for inpatient claims.',
    `appeal_filed_date` DATE COMMENT 'Date appeal was filed if applicable.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates if an appeal has been filed.',
    `authorization_number` STRING COMMENT 'Prior authorization number.',
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
    `principal_diagnosis_code` STRING COMMENT 'ICD-10 code for principal diagnosis.',
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
    `care_site_id` BIGINT COMMENT 'Facility where service was rendered.',
    `charge_id` BIGINT COMMENT 'Link to billing charge record.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `fulfillment_id` BIGINT COMMENT 'Link to order fulfillment.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS procedure code.',
    `material_master_id` BIGINT COMMENT 'Link to supply item if applicable.',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered the service.',
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
    `employee_id` BIGINT COMMENT 'Coder who assigned diagnosis.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code.',
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
    `diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code.',
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
    `care_site_id` BIGINT COMMENT 'Submitting facility.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Link to compliance submission if applicable.',
    `interface_channel_id` BIGINT COMMENT 'Interface channel used for submission.',
    `original_submission_id` BIGINT COMMENT 'Link to original submission if resubmission.',
    `payer_id` BIGINT COMMENT 'Payer receiving submission.',
    `org_provider_id` BIGINT COMMENT 'Organization submitting claim.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner (clearinghouse).',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique identifier for status history record.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `employee_id` BIGINT COMMENT 'Employee who updated status.',
    `appeal_indicator` BOOLEAN COMMENT 'Indicates if status change is related to appeal.',
    `check_or_eft_number` STRING COMMENT 'Check or EFT number if paid.',
    `clearinghouse_trace_number` STRING COMMENT 'The clearinghouse trace number of the claim status history record.',
    `coordination_of_benefits_sequence` STRING COMMENT 'The coordination of benefits sequence of the claim status history record.',
    `corrected_claim_indicator` BOOLEAN COMMENT 'Indicates if claim was corrected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `days_in_prior_status` STRING COMMENT 'Number of days in prior status.',
    `denial_category` STRING COMMENT 'Category of denial if applicable.',
    `effective_timestamp` TIMESTAMP COMMENT 'Timestamp when status became effective.',
    `is_final_status` BOOLEAN COMMENT 'Indicates if this is final status.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `notes` STRING COMMENT 'Additional notes.',
    `payer_claim_control_number` STRING COMMENT 'The payer claim control number of the claim status history record.',
    `payer_response_code` STRING COMMENT 'The payer response code value classifying the claim status history record.',
    `payer_response_description` STRING COMMENT 'Description of payer response.',
    `prior_status_code` STRING COMMENT 'Previous status code.',
    `remittance_date` DATE COMMENT 'Date of remittance.',
    `scope` STRING COMMENT 'The scope of the claim status history record.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates if SLA was met.',
    `ssot_reference` STRING COMMENT 'The ssot reference of the claim status history record.',
    `status_category` STRING COMMENT 'Category of status.',
    `status_code` STRING COMMENT 'The status code value classifying the claim status history record.',
    `status_description` STRING COMMENT 'Description of status.',
    `status_reason` STRING COMMENT 'Reason for status change.',
    `transaction_set_identifier` STRING COMMENT 'EDI transaction set identifier.',
    `triggered_by_process` STRING COMMENT 'Process that triggered status change.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim status history record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim status history record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    `void_indicator` BOOLEAN COMMENT 'Indicates if claim was voided.',
    `work_queue_assignment` STRING COMMENT 'The work queue assignment of the claim status history record.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'SSOT resolved: defer to order.order_status_history as the single source of truth for this concept. This table is a domain-specific extension/reference.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`remittance` (
    `remittance_id` BIGINT COMMENT 'Unique identifier for remittance.',
    `ar_transaction_id` BIGINT COMMENT 'Link to AR transaction.',
    `journal_entry_id` BIGINT COMMENT 'Link to cash receipt journal entry.',
    `employee_id` BIGINT COMMENT 'Employee who posted remittance.',
    `financial_entity_id` BIGINT COMMENT 'Financial entity receiving payment.',
    `message_log_id` BIGINT COMMENT 'Link to interface message log.',
    `payer_id` BIGINT COMMENT 'Payer issuing remittance.',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period of posting.',
    `cost_center_id` BIGINT COMMENT 'Cost center for revenue.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner (clearinghouse).',
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
    `payee_name` STRING COMMENT 'Name of payee.',
    `payee_npi` STRING COMMENT 'NPI of payee.',
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
    `journal_entry_line_id` BIGINT COMMENT 'Link to adjustment journal entry line.',
    `charge_id` BIGINT COMMENT 'Link to billing charge.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `employee_id` BIGINT COMMENT 'Employee who posted line.',
    `fee_schedule_id` BIGINT COMMENT 'Link to fee schedule.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS procedure code.',
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
    `ar_transaction_id` BIGINT COMMENT 'Link to AR transaction.',
    `audit_finding_id` BIGINT COMMENT 'Link to audit finding if applicable.',
    `care_site_id` BIGINT COMMENT 'Facility where service was rendered.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `cost_center_id` BIGINT COMMENT 'Cost center for service.',
    `coverage_policy_id` BIGINT COMMENT 'Link to coverage policy.',
    `employee_id` BIGINT COMMENT 'Employee managing denial.',
    `insurance_coverage_id` BIGINT COMMENT 'Patient insurance coverage.',
    `invoice_id` BIGINT COMMENT 'Link to invoice.',
    `payer_id` BIGINT COMMENT 'Payer who denied claim.',
    `clinician_id` BIGINT COMMENT 'Clinician who rendered service.',
    `quality_peer_review_id` BIGINT COMMENT 'Link to peer review if applicable.',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `journal_entry_id` BIGINT COMMENT 'Link to write-off journal entry.',
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
    `claim_line_number` STRING COMMENT 'Line number if line-level denial.',
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
    `corrective_action_plan_id` BIGINT COMMENT 'Link to corrective action plan if applicable.',
    `coverage_policy_id` BIGINT COMMENT 'Link to coverage policy.',
    `insurance_coverage_id` BIGINT COMMENT 'Patient insurance coverage.',
    `invoice_id` BIGINT COMMENT 'Link to invoice.',
    `payer_id` BIGINT COMMENT 'Payer receiving appeal.',
    `employee_id` BIGINT COMMENT 'Employee who created appeal.',
    `journal_entry_id` BIGINT COMMENT 'Link to recovery journal entry.',
    `tertiary_appeal_last_modified_by_user_employee_id` BIGINT COMMENT 'Employee who last modified appeal.',
    `appeal_number` STRING COMMENT 'Internal appeal tracking number.',
    `appeal_status` STRING COMMENT 'Status of appeal.',
    `appeal_type` STRING COMMENT 'Type of appeal (clinical, technical, etc.).',
    `clinical_rationale` STRING COMMENT 'Clinical rationale for appeal.',
    `coordination_of_benefits_issue_flag` BOOLEAN COMMENT 'Indicates if COB issue exists.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `deadline_date` DATE COMMENT 'Deadline for appeal submission.',
    `denial_reason_code` STRING COMMENT 'Code indicating reason for denial.',
    `denial_reason_description` STRING COMMENT 'Description of denial reason.',
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
    `supporting_documentation_references` STRING COMMENT 'References to supporting documentation.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim appeal record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim appeal record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Tracks claim appeals filed with payers to overturn denials.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` (
    `prior_authorization_id` BIGINT COMMENT 'Unique identifier for prior authorization.',
    `care_site_id` BIGINT COMMENT 'Facility where service will be rendered.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `org_provider_id` BIGINT COMMENT 'Facility organization.',
    `fhir_resource_log_id` BIGINT COMMENT 'Link to FHIR resource log.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code.',
    `order_authorization_id` BIGINT COMMENT 'Link to order authorization.',
    `patient_account_id` BIGINT COMMENT 'Patient account.',
    `payer_id` BIGINT COMMENT 'Payer issuing authorization.',
    `clinician_id` BIGINT COMMENT 'Clinician requesting authorization.',
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
    `clinical_indication_icd10_code` STRING COMMENT 'ICD-10 code for clinical indication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `decision_date` DATE COMMENT 'Date of authorization decision.',
    `denial_reason_code` STRING COMMENT 'Code indicating reason for denial.',
    `denial_reason_description` STRING COMMENT 'Description of denial reason.',
    `payer_type` STRING COMMENT 'Type of payer.',
    `peer_review_completed_date` DATE COMMENT 'Date peer review was completed.',
    `peer_review_required_flag` BOOLEAN COMMENT 'Indicates if peer review is required.',
    `rendering_provider_npi` STRING COMMENT 'NPI of rendering provider.',
    `requested_service_cpt_code` STRING COMMENT 'CPT code for requested service.',
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
    `clinician_id` BIGINT COMMENT 'Clinician requesting eligibility.',
    `mpi_record_id` BIGINT COMMENT 'Member MPI record.',
    `eligibility_mpi_record_id` BIGINT COMMENT 'Patient MPI record.',
    `employee_id` BIGINT COMMENT 'Employee who requested eligibility.',
    `fhir_resource_log_id` BIGINT COMMENT 'Link to FHIR resource log.',
    `interface_channel_id` BIGINT COMMENT 'Interface channel used.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the claim eligibility record.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner (clearinghouse).',
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
    `mpi_record_id` BIGINT COMMENT 'Patient MPI record.',
    `payer_id` BIGINT COMMENT 'Primary payer.',
    `health_plan_id` BIGINT COMMENT 'Secondary health plan.',
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
    `other_insurance_on_file_date` DATE COMMENT 'Date other insurance was filed.',
    `primary_adjustment_amount` DECIMAL(18,2) COMMENT 'Primary payer adjustment amount.',
    `primary_adjustment_reason_code` STRING COMMENT 'The primary adjustment reason code value classifying the claim cob record.',
    `primary_allowed_amount` DECIMAL(18,2) COMMENT 'Primary payer allowed amount.',
    `primary_billed_amount` DECIMAL(18,2) COMMENT 'Primary payer billed amount.',
    `primary_paid_amount` DECIMAL(18,2) COMMENT 'Primary payer paid amount.',
    `primary_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The primary patient responsibility amount of the claim cob record.',
    `secondary_adjustment_amount` DECIMAL(18,2) COMMENT 'Secondary payer adjustment amount.',
    `secondary_adjustment_reason_code` STRING COMMENT 'The secondary adjustment reason code value classifying the claim cob record.',
    `secondary_allowed_amount` DECIMAL(18,2) COMMENT 'Secondary payer allowed amount.',
    `secondary_billed_amount` DECIMAL(18,2) COMMENT 'Secondary payer billed amount.',
    `secondary_paid_amount` DECIMAL(18,2) COMMENT 'Secondary payer paid amount.',
    `secondary_patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The secondary patient responsibility amount of the claim cob record.',
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

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` (
    `authorization_service_id` BIGINT COMMENT 'Unique identifier for authorization service.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `org_provider_id` BIGINT COMMENT 'Facility organization.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the claim authorization service record.',
    `prior_authorization_id` BIGINT COMMENT 'Parent prior authorization.',
    `clinician_id` BIGINT COMMENT 'Rendering clinician.',
    `authorized_amount` DECIMAL(18,2) COMMENT 'The authorized amount of the claim authorization service record.',
    `authorized_units` DECIMAL(18,2) COMMENT 'The authorized units of the claim authorization service record.',
    `clinical_review_required` BOOLEAN COMMENT 'Indicates if clinical review is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `currency_code` STRING COMMENT 'ISO currency code.',
    `diagnosis_code` STRING COMMENT 'The diagnosis code value classifying the claim authorization service record.',
    `extension_count` STRING COMMENT 'Number of extensions.',
    `last_claim_date` DATE COMMENT 'Date of last claim.',
    `line_number` STRING COMMENT 'The line number of the claim authorization service record.',
    `modifier_1` STRING COMMENT 'First modifier.',
    `modifier_2` STRING COMMENT 'Second modifier.',
    `modifier_3` STRING COMMENT 'Third modifier.',
    `modifier_4` STRING COMMENT 'Fourth modifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `payer_authorization_number` STRING COMMENT 'The payer authorization number of the claim authorization service record.',
    `peer_review_completed` BOOLEAN COMMENT 'Indicates if peer review was completed.',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the claim authorization service record.',
    `service_from_date` DATE COMMENT 'Start date of service.',
    `service_setting` STRING COMMENT 'The service setting of the claim authorization service record.',
    `service_status` STRING COMMENT 'Status of service.',
    `service_to_date` DATE COMMENT 'End date of service.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the claim authorization service record.',
    `units_consumed` DECIMAL(18,2) COMMENT 'The units consumed of the claim authorization service record.',
    `units_remaining` DECIMAL(18,2) COMMENT 'The units remaining of the claim authorization service record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'The utilization percentage of the claim authorization service record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim authorization service record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim authorization service record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_authorization_service PRIMARY KEY(`authorization_service_id`)
) COMMENT 'Individual service lines within a prior authorization showing approved units and amounts.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`attachment` (
    `attachment_id` BIGINT COMMENT 'Unique identifier for attachment.',
    `behavioral_health_consent_id` BIGINT COMMENT 'Link to behavioral health consent.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the claim attachment record.',
    `cda_document_id` BIGINT COMMENT 'Link to CDA document.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `cpt_code_id` BIGINT COMMENT 'CPT procedure code.',
    `demographics_id` BIGINT COMMENT 'Patient demographics.',
    `employee_id` BIGINT COMMENT 'Employee who submitted attachment.',
    `org_provider_id` BIGINT COMMENT 'Facility organization.',
    `icd_code_id` BIGINT COMMENT 'ICD diagnosis code.',
    `interface_channel_id` BIGINT COMMENT 'Interface channel used.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the claim attachment record.',
    `primary_original_attachment_id` BIGINT COMMENT 'Link to original attachment if resubmission.',
    `clinician_id` BIGINT COMMENT 'Clinician.',
    `substance_use_consent_id` BIGINT COMMENT 'Link to substance use consent.',
    `trading_partner_id` BIGINT COMMENT 'Trading partner (clearinghouse).',
    `visit_id` BIGINT COMMENT 'Link to encounter visit.',
    `attachment_number` STRING COMMENT 'The attachment number of the claim attachment record.',
    `attachment_status` STRING COMMENT 'Status of attachment.',
    `attachment_type` STRING COMMENT 'Type of attachment.',
    `authorization_number` STRING COMMENT 'The authorization number of the claim attachment record.',
    `clearinghouse_transaction_number` STRING COMMENT 'The clearinghouse transaction number of the claim attachment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `diagnosis_code` STRING COMMENT 'The diagnosis code value classifying the claim attachment record.',
    `document_description` STRING COMMENT 'Description of document.',
    `document_format` STRING COMMENT 'Format of document.',
    `document_title` STRING COMMENT 'Title of document.',
    `edi_transaction_set` STRING COMMENT 'The edi transaction set of the claim attachment record.',
    `encryption_status` STRING COMMENT 'The encryption status value classifying the claim attachment record.',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes.',
    `medical_record_number` STRING COMMENT 'Patient MRN.',
    `notes` STRING COMMENT 'Additional notes.',
    `page_count` STRING COMMENT 'Number of pages.',
    `payer_attachment_control_number` STRING COMMENT 'The payer attachment control number of the claim attachment record.',
    `phi_indicator` BOOLEAN COMMENT 'Indicates if PHI is present.',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the claim attachment record.',
    `received_date` DATE COMMENT 'Date received.',
    `redaction_required` BOOLEAN COMMENT 'Indicates if redaction is required.',
    `rejection_reason_code` STRING COMMENT 'The rejection reason code value classifying the claim attachment record.',
    `rejection_reason_description` STRING COMMENT 'Description of rejection reason.',
    `request_date` DATE COMMENT 'Date of request.',
    `response_deadline_date` DATE COMMENT 'Deadline for response.',
    `resubmission_count` STRING COMMENT 'Number of resubmissions.',
    `service_from_date` DATE COMMENT 'Start date of service.',
    `service_to_date` DATE COMMENT 'End date of service.',
    `storage_location` STRING COMMENT 'The storage location of the claim attachment record.',
    `submission_date` DATE COMMENT 'Date of submission.',
    `submission_method` STRING COMMENT 'Method of submission.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp of submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim attachment record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim attachment record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_attachment PRIMARY KEY(`attachment_id`)
) COMMENT 'Tracks clinical documentation and attachments submitted with claims.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` (
    `study_attribution_id` BIGINT COMMENT 'Unique identifier for study attribution.',
    `claim_id` BIGINT COMMENT 'Parent claim record.',
    `research_study_id` BIGINT COMMENT 'Research study.',
    `attribution_amount` DECIMAL(18,2) COMMENT 'Amount attributed to study.',
    `attribution_rationale` STRING COMMENT 'Rationale for attribution.',
    `attribution_status` STRING COMMENT 'Status of attribution.',
    `billing_responsibility` STRING COMMENT 'Billing responsibility (sponsor, insurance, patient).',
    `coverage_determination_date` DATE COMMENT 'Date of coverage determination.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when record was created.',
    `last_modified_by` STRING COMMENT 'User who last modified record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of last modification.',
    `research_only_flag` BOOLEAN COMMENT 'Indicates if service is research-only.',
    `service_attribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of service attributed to study.',
    `sponsor_invoice_number` STRING COMMENT 'The sponsor invoice number of the claim study attribution record.',
    `standard_of_care_flag` BOOLEAN COMMENT 'Indicates if service is standard of care.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim study attribution record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim study attribution record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    `created_by` STRING COMMENT 'User who created record.',
    CONSTRAINT pk_study_attribution PRIMARY KEY(`study_attribution_id`)
) COMMENT 'Links claims to research studies for billing attribution and coverage analysis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` (
    `audit_sample_id` BIGINT COMMENT 'Unique identifier for audit sample.',
    `audit_id` BIGINT COMMENT 'Parent audit record.',
    `claim_id` BIGINT COMMENT 'Claim selected for audit.',
    `audit_scope_reason` STRING COMMENT 'Reason claim was selected for audit.',
    `claim_review_status` STRING COMMENT 'Status of claim review.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates if corrective action is required.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The financial impact amount of the claim audit sample record.',
    `finding_description` STRING COMMENT 'Description of finding.',
    `finding_severity` STRING COMMENT 'Severity of finding.',
    `review_completion_date` DATE COMMENT 'Date review was completed.',
    `review_start_date` DATE COMMENT 'Date review started.',
    `reviewer_name` STRING COMMENT 'Name of reviewer.',
    `sample_selection_method` STRING COMMENT 'Method of sample selection.',
    `sample_sequence_number` STRING COMMENT 'Sequence number of sample.',
    `selected_date` DATE COMMENT 'Date sample was selected.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the claim audit sample record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the claim audit sample record.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp added by VIBE mutation',
    `vibe_structure_marker` STRING COMMENT 'domains 1-11 enforcement marker',
    CONSTRAINT pk_audit_sample PRIMARY KEY(`audit_sample_id`)
) COMMENT 'Tracks claims selected for audit review including RAC, ZPIC, and internal audits.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_original_submission_id` FOREIGN KEY (`original_submission_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`submission`(`submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`line`(`line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_primary_original_attachment_id` FOREIGN KEY (`primary_original_attachment_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`attachment`(`attachment_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ADD CONSTRAINT `fk_claim_study_attribution_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ADD CONSTRAINT `fk_claim_audit_sample_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`claim` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_entity' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_pii' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `ar_account_id` SET TAGS ('pii_business_glossary_term' = 'Accounts Receivable Account');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `ar_account_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Billing Provider Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `org_provider_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Demographics');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `demographics_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `guarantor_id` SET TAGS ('pii_business_glossary_term' = 'Guarantor');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `guarantor_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referral_order_id` SET TAGS ('pii_business_glossary_term' = 'Referral Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referral_order_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Rendering Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Revenue Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Service Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Service Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjudication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `admission_date` SET TAGS ('pii_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `bill_type` SET TAGS ('pii_business_glossary_term' = 'Bill Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_number` SET TAGS ('pii_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `claim_type` SET TAGS ('pii_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `coordination_of_benefits_flag` SET TAGS ('pii_business_glossary_term' = 'COB Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `discharge_date` SET TAGS ('pii_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_grouper_version` SET TAGS ('pii_business_glossary_term' = 'DRG Grouper Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `drg_grouper_version` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `paid_timestamp` SET TAGS ('pii_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `payer_claim_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `primary_payer_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_business_glossary_term' = 'Principal Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `principal_procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `rac_audit_flag` SET TAGS ('pii_business_glossary_term' = 'RAC Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Referring Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `referring_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `source_system_claim_code` SET TAGS ('pii_business_glossary_term' = 'Source System Claim Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `submitted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `total_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_entity' = 'claim_line');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('pii_business_glossary_term' = 'Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `charge_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `fulfillment_id` SET TAGS ('pii_business_glossary_term' = 'Fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `fulfillment_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `material_master_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Rendering Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `adjudication_date` SET TAGS ('pii_business_glossary_term' = 'Adjudication Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('pii_business_glossary_term' = 'COB Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_3` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `diagnosis_pointer_4` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drg_weight` SET TAGS ('pii_business_glossary_term' = 'DRG Weight');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drg_weight` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drug_quantity` SET TAGS ('pii_business_glossary_term' = 'Drug Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `drug_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Drug Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('pii_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('pii_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Ordering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `ordering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `outlier_payment_amount` SET TAGS ('pii_business_glossary_term' = 'Outlier Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `paid_date` SET TAGS ('pii_business_glossary_term' = 'Paid Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('pii_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `remark_code` SET TAGS ('pii_business_glossary_term' = 'Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_description` SET TAGS ('pii_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `units_of_service` SET TAGS ('pii_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_entity' = 'claim_diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Link Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_link_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Visit Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `cdi_query_flag` SET TAGS ('pii_business_glossary_term' = 'CDI Query Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `chronic_condition_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_source` SET TAGS ('pii_business_glossary_term' = 'Coding Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `coding_timestamp` SET TAGS ('pii_business_glossary_term' = 'Coding Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `complication_flag` SET TAGS ('pii_business_glossary_term' = 'Complication Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `denial_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Denial Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Pointer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_pointer` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_sequence` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Version');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `diagnosis_version` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `drg_grouper_flag` SET TAGS ('pii_business_glossary_term' = 'DRG Grouper Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `drg_grouper_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `encounter_type` SET TAGS ('pii_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `hac_flag` SET TAGS ('pii_business_glossary_term' = 'HAC Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `poa_indicator` SET TAGS ('pii_business_glossary_term' = 'POA Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `quality_measure_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `rac_audit_risk_score` SET TAGS ('pii_business_glossary_term' = 'RAC Audit Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_entity' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Submission Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Regulatory Submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `original_submission_id` SET TAGS ('pii_business_glossary_term' = 'Original Submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `original_submission_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Submitter Organization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `org_provider_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `batch_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Claim Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `claim_filing_indicator_code` SET TAGS ('pii_business_glossary_term' = 'Claim Filing Indicator Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `clearinghouse_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `edi_transaction_set` SET TAGS ('pii_business_glossary_term' = 'EDI Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `is_timely_filed` SET TAGS ('pii_business_glossary_term' = 'Is Timely Filed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `payer_acknowledgment_number` SET TAGS ('pii_business_glossary_term' = 'Payer Acknowledgment Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `prior_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `rejection_reason_description` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_count` SET TAGS ('pii_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `resubmission_reason_code` SET TAGS ('pii_business_glossary_term' = 'Resubmission Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_number` SET TAGS ('pii_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_business_glossary_term' = 'Submitter Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_business_glossary_term' = 'Submitter Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Submitter Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_business_glossary_term' = 'Submitter Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `submitter_organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_business_glossary_term' = 'Timely Filing Deadline');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `timely_filing_deadline` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_control_number` SET TAGS ('pii_business_glossary_term' = 'Transmission Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_business_glossary_term' = 'Transmission File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `transmission_file_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_entity' = 'claim_status_history');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ssot_note' = 'Distinct domains; retain both');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ensure_no_attribute_overlap' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ssot_primary' = 'order.order_status_history');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ssot' = 'domain_specific');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ssot_pair' = 'claim.status_history');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_ssot_reference' = 'order.order_status_history');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` SET TAGS ('pii_duplicate_pair' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('pii_business_glossary_term' = 'Status History Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `appeal_indicator` SET TAGS ('pii_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `check_or_eft_number` SET TAGS ('pii_business_glossary_term' = 'Check or EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Trace Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `clearinghouse_trace_number` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `coordination_of_benefits_sequence` SET TAGS ('pii_business_glossary_term' = 'COB Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `corrected_claim_indicator` SET TAGS ('pii_business_glossary_term' = 'Corrected Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `days_in_prior_status` SET TAGS ('pii_business_glossary_term' = 'Days in Prior Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `denial_category` SET TAGS ('pii_business_glossary_term' = 'Denial Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `is_final_status` SET TAGS ('pii_business_glossary_term' = 'Is Final Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_claim_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_response_code` SET TAGS ('pii_business_glossary_term' = 'Payer Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `payer_response_description` SET TAGS ('pii_business_glossary_term' = 'Payer Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `prior_status_code` SET TAGS ('pii_business_glossary_term' = 'Prior Status Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `remittance_date` SET TAGS ('pii_business_glossary_term' = 'Remittance Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `sla_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'SLA Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_category` SET TAGS ('pii_business_glossary_term' = 'Status Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_code` SET TAGS ('pii_business_glossary_term' = 'Status Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_description` SET TAGS ('pii_business_glossary_term' = 'Status Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_business_glossary_term' = 'Transaction Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `transaction_set_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `triggered_by_process` SET TAGS ('pii_business_glossary_term' = 'Triggered By Process');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `void_indicator` SET TAGS ('pii_business_glossary_term' = 'Void Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ALTER COLUMN `work_queue_assignment` SET TAGS ('pii_business_glossary_term' = 'Work Queue Assignment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_entity' = 'remittance');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_id` SET TAGS ('pii_business_glossary_term' = 'Remittance Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'AR Transaction');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Cash Receipt Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Financial Entity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `message_log_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Posting Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Revenue Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `bank_account_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `check_eft_number` SET TAGS ('pii_business_glossary_term' = 'Check EFT Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `coverage_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `fiscal_period_date` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `group_control_number` SET TAGS ('pii_business_glossary_term' = 'Group Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `interchange_control_number` SET TAGS ('pii_business_glossary_term' = 'Interchange Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_business_glossary_term' = 'Payee Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_business_glossary_term' = 'Payee NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payee_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_claim_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Payer Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payer_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_amount` SET TAGS ('pii_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `payment_method_code` SET TAGS ('pii_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `production_date` SET TAGS ('pii_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Provider Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `provider_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Provider Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `receiver_identification` SET TAGS ('pii_business_glossary_term' = 'Receiver Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `remittance_status` SET TAGS ('pii_business_glossary_term' = 'Remittance Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `routing_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `sender_identification` SET TAGS ('pii_business_glossary_term' = 'Sender Identification');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_business_glossary_term' = 'Source File Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `source_file_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_claim_count` SET TAGS ('pii_business_glossary_term' = 'Total Claim Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `transaction_set_control_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Set Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('pii_entity' = 'remittance_line');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_line_id` SET TAGS ('pii_business_glossary_term' = 'Remittance Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_line_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Adjustment Journal Entry Line');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `charge_id` SET TAGS ('pii_business_glossary_term' = 'Charge');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `charge_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Fee Schedule');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_id` SET TAGS ('pii_business_glossary_term' = 'Line');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_contract_id` SET TAGS ('pii_business_glossary_term' = 'Payer Contract');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_contract_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_id` SET TAGS ('pii_business_glossary_term' = 'Remittance');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_date` SET TAGS ('pii_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_group_code` SET TAGS ('pii_business_glossary_term' = 'Adjustment Group Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_quantity` SET TAGS ('pii_business_glossary_term' = 'Adjustment Quantity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_source` SET TAGS ('pii_business_glossary_term' = 'Adjustment Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `adjustment_type` SET TAGS ('pii_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `balance_transfer_amount` SET TAGS ('pii_business_glossary_term' = 'Balance Transfer Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `claim_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Claim Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `coinsurance_amount` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `contractual_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Contractual Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `credit_balance_amount` SET TAGS ('pii_business_glossary_term' = 'Credit Balance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_payment_status` SET TAGS ('pii_business_glossary_term' = 'Line Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `line_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('pii_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `note` SET TAGS ('pii_business_glossary_term' = 'Note');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `paid_amount` SET TAGS ('pii_business_glossary_term' = 'Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `payer_claim_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Claim Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_3` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `procedure_modifier_4` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `recoupment_amount` SET TAGS ('pii_business_glossary_term' = 'Recoupment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `remittance_advice_remark_code` SET TAGS ('pii_business_glossary_term' = 'Remittance Advice Remark Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `revenue_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `service_line_number` SET TAGS ('pii_business_glossary_term' = 'Service Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `units_of_service` SET TAGS ('pii_business_glossary_term' = 'Units of Service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_entity' = 'denial');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('pii_business_glossary_term' = 'Denial Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_business_glossary_term' = 'AR Transaction');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `ar_transaction_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_business_glossary_term' = 'Audit Finding');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `audit_finding_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `cost_center_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Policy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `invoice_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `quality_peer_review_id` SET TAGS ('pii_business_glossary_term' = 'Quality Peer Review');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `quality_peer_review_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Write Off Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_level` SET TAGS ('pii_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `appeal_outcome_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `billed_amount` SET TAGS ('pii_business_glossary_term' = 'Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `carc_code` SET TAGS ('pii_business_glossary_term' = 'CARC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `carc_description` SET TAGS ('pii_business_glossary_term' = 'CARC Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_category` SET TAGS ('pii_business_glossary_term' = 'Denial Category');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `claim_line_number` SET TAGS ('pii_business_glossary_term' = 'Claim Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_date` SET TAGS ('pii_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_number` SET TAGS ('pii_business_glossary_term' = 'Denial Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('pii_business_glossary_term' = 'Denial Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `denied_amount` SET TAGS ('pii_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `is_preventable` SET TAGS ('pii_business_glossary_term' = 'Is Preventable');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `is_rac_audit` SET TAGS ('pii_business_glossary_term' = 'Is RAC Audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `medical_record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_business_glossary_term' = 'Patient Account Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `patient_account_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `rarc_code` SET TAGS ('pii_business_glossary_term' = 'RARC Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `rarc_description` SET TAGS ('pii_business_glossary_term' = 'RARC Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `reason_text` SET TAGS ('pii_business_glossary_term' = 'Reason Text');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `recovered_amount` SET TAGS ('pii_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `root_cause_code` SET TAGS ('pii_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `root_cause_description` SET TAGS ('pii_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Denial Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `write_off_amount` SET TAGS ('pii_business_glossary_term' = 'Write Off Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ALTER COLUMN `write_off_date` SET TAGS ('pii_business_glossary_term' = 'Write Off Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_entity' = 'appeal');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_business_glossary_term' = 'Coverage Policy');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coverage_policy_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `invoice_id` SET TAGS ('pii_business_glossary_term' = 'Invoice');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `invoice_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Created By User');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Recovery Journal Entry');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `tertiary_appeal_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Last Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `tertiary_appeal_last_modified_by_user_employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `tertiary_appeal_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `tertiary_appeal_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_number` SET TAGS ('pii_business_glossary_term' = 'Appeal Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('pii_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_business_glossary_term' = 'Clinical Rationale');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `clinical_rationale` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `coordination_of_benefits_issue_flag` SET TAGS ('pii_business_glossary_term' = 'COB Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `denied_amount` SET TAGS ('pii_business_glossary_term' = 'Denied Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `external_review_requested_flag` SET TAGS ('pii_business_glossary_term' = 'External Review Requested Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `appeal_level` SET TAGS ('pii_business_glossary_term' = 'Appeal Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `original_claim_amount` SET TAGS ('pii_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `outcome_code` SET TAGS ('pii_business_glossary_term' = 'Outcome Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `outcome_description` SET TAGS ('pii_business_glossary_term' = 'Outcome Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `overturn_amount` SET TAGS ('pii_business_glossary_term' = 'Overturn Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `payer_appeal_reference_number` SET TAGS ('pii_business_glossary_term' = 'Payer Appeal Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `peer_review_required_flag` SET TAGS ('pii_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `prior_authorization_issue_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Issue Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `priority_flag` SET TAGS ('pii_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `rac_audit_related_flag` SET TAGS ('pii_business_glossary_term' = 'RAC Audit Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `requested_amount` SET TAGS ('pii_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `service_type_code` SET TAGS ('pii_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation References');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `supporting_documentation_references` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_entity' = 'prior_authorization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Facility Organization Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `org_provider_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'FHIR Resource Log');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `order_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Order Authorization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `order_authorization_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('pii_business_glossary_term' = 'Patient Account');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `patient_account_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinician_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_decision_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_filed_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_end_date` SET TAGS ('pii_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_start_date` SET TAGS ('pii_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `approved_units` SET TAGS ('pii_business_glossary_term' = 'Approved Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_notes` SET TAGS ('pii_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_source` SET TAGS ('pii_business_glossary_term' = 'Authorization Source');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `authorization_status` SET TAGS ('pii_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_business_glossary_term' = 'Clinical Indication ICD10 Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `clinical_indication_icd10_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `payer_type` SET TAGS ('pii_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_completed_date` SET TAGS ('pii_business_glossary_term' = 'Peer Review Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `peer_review_required_flag` SET TAGS ('pii_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Rendering Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `rendering_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_service_cpt_code` SET TAGS ('pii_business_glossary_term' = 'Requested Service CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_service_cpt_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `requested_units` SET TAGS ('pii_business_glossary_term' = 'Requested Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_business_glossary_term' = 'Service Setting');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `service_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `units_consumed` SET TAGS ('pii_business_glossary_term' = 'Units Consumed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `urgency_level` SET TAGS ('pii_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_entity' = 'eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_id` SET TAGS ('pii_business_glossary_term' = 'Eligibility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Member MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `eligibility_mpi_record_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'FHIR Resource Log');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clearinghouse_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Clinical Trial Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `clinical_trial_eligibility_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coordination_of_benefits_order` SET TAGS ('pii_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `copay_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_effective_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_level` SET TAGS ('pii_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_termination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `coverage_type` SET TAGS ('pii_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_met_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `deductible_remaining_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Remaining Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `group_number` SET TAGS ('pii_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `network_status` SET TAGS ('pii_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('pii_business_glossary_term' = 'Out of Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `out_of_pocket_met_amount` SET TAGS ('pii_business_glossary_term' = 'Out of Pocket Met Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_business_glossary_term' = 'PCP Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_business_glossary_term' = 'PCP NPI');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `pcp_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `prior_authorization_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `referral_required` SET TAGS ('pii_business_glossary_term' = 'Referral Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_code` SET TAGS ('pii_business_glossary_term' = 'Response Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `response_description` SET TAGS ('pii_business_glossary_term' = 'Response Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verification Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Verification Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `verification_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Verification Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_entity' = 'coordination_of_benefits');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('pii_business_glossary_term' = 'COB Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'MPI Record');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Primary Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Secondary Plan Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_payer_id` SET TAGS ('pii_business_glossary_term' = 'Tertiary Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('pii_business_glossary_term' = 'Birthday Rule Applied');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `birthday_rule_applied` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('pii_business_glossary_term' = 'COB Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `crossover_claim_indicator` SET TAGS ('pii_business_glossary_term' = 'Crossover Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_date` SET TAGS ('pii_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `determination_method` SET TAGS ('pii_business_glossary_term' = 'Determination Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `duplicate_payment_prevention_flag` SET TAGS ('pii_business_glossary_term' = 'Duplicate Payment Prevention Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('pii_business_glossary_term' = 'Gender Rule Applied');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `gender_rule_applied` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `method` SET TAGS ('pii_business_glossary_term' = 'COB Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_indicator` SET TAGS ('pii_business_glossary_term' = 'MSP Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `msp_type_code` SET TAGS ('pii_business_glossary_term' = 'MSP Type Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `order_sequence` SET TAGS ('pii_business_glossary_term' = 'Order Sequence');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `other_insurance_on_file_date` SET TAGS ('pii_business_glossary_term' = 'Other Insurance On File Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Primary Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `primary_patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Primary Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_adjustment_reason_code` SET TAGS ('pii_business_glossary_term' = 'Secondary Adjustment Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_allowed_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Allowed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `secondary_patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Secondary Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_billed_amount` SET TAGS ('pii_business_glossary_term' = 'Tertiary Billed Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `tertiary_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Tertiary Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `total_patient_responsibility_amount` SET TAGS ('pii_business_glossary_term' = 'Total Patient Responsibility Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `verification_method` SET TAGS ('pii_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('pii_subdomain' = 'authorization_eligibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('pii_entity' = 'authorization_service');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorization_service_id` SET TAGS ('pii_business_glossary_term' = 'Authorization Service Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorization_service_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Facility Organization Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `org_provider_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Rendering Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorized_amount` SET TAGS ('pii_business_glossary_term' = 'Authorized Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `authorized_units` SET TAGS ('pii_business_glossary_term' = 'Authorized Units');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_business_glossary_term' = 'Clinical Review Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `clinical_review_required` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `extension_count` SET TAGS ('pii_business_glossary_term' = 'Extension Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `last_claim_date` SET TAGS ('pii_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_1` SET TAGS ('pii_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_2` SET TAGS ('pii_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_3` SET TAGS ('pii_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `modifier_4` SET TAGS ('pii_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `payer_authorization_number` SET TAGS ('pii_business_glossary_term' = 'Payer Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `peer_review_completed` SET TAGS ('pii_business_glossary_term' = 'Peer Review Completed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_business_glossary_term' = 'Service Setting');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_status` SET TAGS ('pii_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `units_consumed` SET TAGS ('pii_business_glossary_term' = 'Units Consumed');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `units_remaining` SET TAGS ('pii_business_glossary_term' = 'Units Remaining');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `utilization_percentage` SET TAGS ('pii_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_data_type' = 'Master');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_entity' = 'claim_attachment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_id` SET TAGS ('pii_business_glossary_term' = 'Attachment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_business_glossary_term' = 'Behavioral Health Consent');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `behavioral_health_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `care_site_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `cda_document_id` SET TAGS ('pii_business_glossary_term' = 'CDA Document');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `cda_document_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `demographics_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `employee_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Facility Organization Provider');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `org_provider_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `payer_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `primary_original_attachment_id` SET TAGS ('pii_business_glossary_term' = 'Original Attachment');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `primary_original_attachment_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider Clinician');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `clinician_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_business_glossary_term' = 'Substance Use Consent');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `substance_use_consent_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `visit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_number` SET TAGS ('pii_business_glossary_term' = 'Attachment Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_status` SET TAGS ('pii_business_glossary_term' = 'Attachment Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `attachment_type` SET TAGS ('pii_business_glossary_term' = 'Attachment Type');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `authorization_number` SET TAGS ('pii_business_glossary_term' = 'Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `clearinghouse_transaction_number` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `document_description` SET TAGS ('pii_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `document_format` SET TAGS ('pii_business_glossary_term' = 'Document Format');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `document_title` SET TAGS ('pii_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `edi_transaction_set` SET TAGS ('pii_business_glossary_term' = 'EDI Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `encryption_status` SET TAGS ('pii_business_glossary_term' = 'Encryption Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `file_size_bytes` SET TAGS ('pii_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `medical_record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `page_count` SET TAGS ('pii_business_glossary_term' = 'Page Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `payer_attachment_control_number` SET TAGS ('pii_business_glossary_term' = 'Payer Attachment Control Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `phi_indicator` SET TAGS ('pii_business_glossary_term' = 'PHI Indicator');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `received_date` SET TAGS ('pii_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `redaction_required` SET TAGS ('pii_business_glossary_term' = 'Redaction Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `rejection_reason_code` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `rejection_reason_description` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `response_deadline_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `resubmission_count` SET TAGS ('pii_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `service_from_date` SET TAGS ('pii_business_glossary_term' = 'Service From Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `service_to_date` SET TAGS ('pii_business_glossary_term' = 'Service To Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_subdomain' = 'claim_submission');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_association_edges' = 'claim.claim,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_entity' = 'study_attribution');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `study_attribution_id` SET TAGS ('pii_business_glossary_term' = 'Study Attribution Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `study_attribution_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `research_study_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_amount` SET TAGS ('pii_business_glossary_term' = 'Attribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_rationale` SET TAGS ('pii_business_glossary_term' = 'Attribution Rationale');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `attribution_status` SET TAGS ('pii_business_glossary_term' = 'Attribution Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `billing_responsibility` SET TAGS ('pii_business_glossary_term' = 'Billing Responsibility');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `coverage_determination_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `last_modified_date` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `research_only_flag` SET TAGS ('pii_business_glossary_term' = 'Research Only Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `service_attribution_percentage` SET TAGS ('pii_business_glossary_term' = 'Service Attribution Percentage');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `sponsor_invoice_number` SET TAGS ('pii_business_glossary_term' = 'Sponsor Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `standard_of_care_flag` SET TAGS ('pii_business_glossary_term' = 'Standard of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_subdomain' = 'payment_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_association_edges' = 'claim.claim,compliance.audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_entity' = 'audit_sample');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_domain' = 'claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_sample_id` SET TAGS ('pii_business_glossary_term' = 'Audit Sample Identifier');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_sample_id` SET TAGS ('pii_pk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_id` SET TAGS ('pii_business_glossary_term' = 'Audit');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `claim_id` SET TAGS ('pii_business_glossary_term' = 'Claim');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `claim_id` SET TAGS ('pii_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `audit_scope_reason` SET TAGS ('pii_business_glossary_term' = 'Audit Scope Reason');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `claim_review_status` SET TAGS ('pii_business_glossary_term' = 'Claim Review Status');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `financial_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `finding_severity` SET TAGS ('pii_business_glossary_term' = 'Finding Severity');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `review_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `reviewer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `sample_selection_method` SET TAGS ('pii_business_glossary_term' = 'Sample Selection Method');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `sample_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Sample Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `selected_date` SET TAGS ('pii_business_glossary_term' = 'Selected Date');
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
