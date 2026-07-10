-- Metric views for domain: billing | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:17:39

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core billing invoice metrics tracking revenue, reimbursement, patient responsibility, and claim performance across payers, providers, and service periods."
  source: "`vibe_healthcare_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., submitted, paid, denied, appealed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., professional, institutional, pharmacy)"
    - name: "bill_type_code"
      expr: bill_type_code
      comment: "UB-04 bill type code indicating facility type and care type"
    - name: "form_type"
      expr: form_type
      comment: "Claim form type (e.g., CMS-1500, UB-04)"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code where care was delivered"
    - name: "admission_type_code"
      expr: admission_type_code
      comment: "Type of admission (e.g., emergency, elective, urgent)"
    - name: "discharge_status_code"
      expr: discharge_status_code
      comment: "Patient discharge disposition code"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed for this invoice"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status for outstanding balances"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Primary reason code for claim denial"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit claim (e.g., EDI, paper, portal)"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice date"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date"
    - name: "service_year"
      expr: YEAR(service_from_date)
      comment: "Year of service start date"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Month of service start date"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total gross charges billed across all invoices"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total amount allowed by payers after contractual adjustments"
    - name: "total_insurance_payment"
      expr: SUM(CAST(insurance_payment AS DOUBLE))
      comment: "Total payments received from insurance payers"
    - name: "total_patient_payment"
      expr: SUM(CAST(patient_payment AS DOUBLE))
      comment: "Total payments received from patients"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility AS DOUBLE))
      comment: "Total amount patients are responsible for (copay, coinsurance, deductible)"
    - name: "total_contractual_adjustment"
      expr: SUM(CAST(contractual_adjustment AS DOUBLE))
      comment: "Total contractual write-offs per payer agreements"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance remaining on invoices"
    - name: "total_bad_debt_amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total amount written off as bad debt"
    - name: "total_covered_charges"
      expr: SUM(CAST(covered_charges AS DOUBLE))
      comment: "Total charges deemed covered by payer"
    - name: "total_non_covered_charges"
      expr: SUM(CAST(non_covered_charges AS DOUBLE))
      comment: "Total charges deemed non-covered by payer"
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight indicating case mix complexity"
    - name: "distinct_patient_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients billed"
    - name: "distinct_provider_count"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Number of unique provider organizations billing"
    - name: "denied_invoice_count"
      expr: SUM(CASE WHEN denial_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices with denial reason codes"
    - name: "appealed_invoice_count"
      expr: SUM(CASE WHEN appeal_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices that have been appealed"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge-level metrics tracking service utilization, pricing, reimbursement expectations, and charge capture quality across services and providers."
  source: "`vibe_healthcare_v1`.`billing`.`charge`"
  dimensions:
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge (e.g., posted, billed, voided, held)"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (e.g., professional, facility, pharmacy)"
    - name: "category"
      expr: category
      comment: "Charge category grouping"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code where service was rendered"
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code for facility charges"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the charge is billable to payer or patient"
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the charge has been voided"
    - name: "is_corrected"
      expr: is_corrected
      comment: "Whether the charge is a correction of a prior charge"
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason charge is on hold and not released for billing"
    - name: "void_reason"
      expr: void_reason
      comment: "Reason charge was voided"
    - name: "implant_flag"
      expr: implant_flag
      comment: "Whether charge is for an implantable device"
    - name: "waste_flag"
      expr: waste_flag
      comment: "Whether charge represents drug waste"
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year of service date"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service date"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year charge was posted"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month charge was posted"
  measures:
    - name: "charge_count"
      expr: COUNT(1)
      comment: "Total number of charges"
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Total gross charges before adjustments"
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement based on contracts and fee schedules"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of services or items charged"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per charge"
    - name: "avg_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per charge"
    - name: "distinct_patient_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with charges"
    - name: "distinct_clinician_count"
      expr: COUNT(DISTINCT charge_clinician_id)
      comment: "Number of unique clinicians generating charges"
    - name: "distinct_service_location_count"
      expr: COUNT(DISTINCT service_provider_location_id)
      comment: "Number of unique service locations"
    - name: "billable_charge_count"
      expr: SUM(CASE WHEN is_billable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of charges marked as billable"
    - name: "voided_charge_count"
      expr: SUM(CASE WHEN is_voided = TRUE THEN 1 ELSE 0 END)
      comment: "Count of charges that have been voided"
    - name: "held_charge_count"
      expr: SUM(CASE WHEN hold_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of charges currently on hold"
    - name: "implant_charge_count"
      expr: SUM(CASE WHEN implant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of charges for implantable devices"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment metrics tracking cash collections, payment channels, refunds, and reconciliation performance across payer and patient sources."
  source: "`vibe_healthcare_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., insurance, patient, refund)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "method"
      expr: method
      comment: "Payment method (e.g., check, credit card, EFT, cash)"
    - name: "channel"
      expr: channel
      comment: "Payment channel (e.g., mail, online portal, in-person)"
    - name: "category"
      expr: category
      comment: "Payment category grouping"
    - name: "source"
      expr: source
      comment: "Source system or origin of payment"
    - name: "posting_status"
      expr: posting_status
      comment: "Whether payment has been posted to accounts"
    - name: "refund_flag"
      expr: refund_flag
      comment: "Whether this payment is a refund"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this payment has been reversed"
    - name: "credit_card_type"
      expr: credit_card_type
      comment: "Type of credit card used (e.g., Visa, MasterCard, Amex)"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment date"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year payment was posted"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month payment was posted"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount received"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to patient accounts"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total amount not yet applied to accounts"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to patients or payers"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "distinct_patient_count"
      expr: COUNT(DISTINCT payment_mpi_record_id)
      comment: "Number of unique patients making payments"
    - name: "distinct_guarantor_count"
      expr: COUNT(DISTINCT guarantor_id)
      comment: "Number of unique guarantors making payments"
    - name: "refund_payment_count"
      expr: SUM(CASE WHEN refund_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of refund transactions"
    - name: "reversed_payment_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed payment transactions"
    - name: "unapplied_payment_count"
      expr: SUM(CASE WHEN unapplied_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of payments with unapplied amounts"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_patient_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient account metrics tracking outstanding balances, aging, collections, financial assistance, and account health across the patient revenue cycle."
  source: "`vibe_healthcare_v1`.`billing`.`patient_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the patient account (e.g., active, closed, collections)"
    - name: "account_type"
      expr: account_type
      comment: "Type of patient account"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging category for outstanding balance (e.g., 0-30, 31-60, 61-90, 90+ days)"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status for account"
    - name: "bad_debt_flag"
      expr: bad_debt_flag
      comment: "Whether account has been written off as bad debt"
    - name: "payment_plan_flag"
      expr: payment_plan_flag
      comment: "Whether account is on a payment plan"
    - name: "financial_assistance_eligibility"
      expr: financial_assistance_eligibility
      comment: "Financial assistance eligibility status"
    - name: "financial_assistance_approval_status"
      expr: financial_assistance_approval_status
      comment: "Approval status of financial assistance application"
    - name: "irs_501r_compliance_flag"
      expr: irs_501r_compliance_flag
      comment: "Whether account meets IRS 501(r) compliance requirements for tax-exempt hospitals"
    - name: "collection_agency_name"
      expr: collection_agency_name
      comment: "Name of collection agency if account referred"
    - name: "account_opened_year"
      expr: YEAR(account_opened_date)
      comment: "Year account was opened"
    - name: "account_opened_month"
      expr: DATE_TRUNC('MONTH', account_opened_date)
      comment: "Month account was opened"
  measures:
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of patient accounts"
    - name: "total_account_balance"
      expr: SUM(CAST(account_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts"
    - name: "total_patient_balance"
      expr: SUM(CAST(patient_balance AS DOUBLE))
      comment: "Total patient-responsible balance"
    - name: "total_insurance_balance"
      expr: SUM(CAST(insurance_balance AS DOUBLE))
      comment: "Total insurance-responsible balance"
    - name: "total_original_balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Total original balance when accounts were opened"
    - name: "total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments received on accounts"
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustments applied to accounts"
    - name: "total_bad_debt_amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total amount written off as bad debt"
    - name: "total_referred_balance"
      expr: SUM(CAST(referred_balance AS DOUBLE))
      comment: "Total balance referred to collections"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered from collections"
    - name: "avg_account_balance"
      expr: AVG(CAST(account_balance AS DOUBLE))
      comment: "Average outstanding balance per account"
    - name: "avg_household_income"
      expr: AVG(CAST(household_income AS DOUBLE))
      comment: "Average household income for accounts with financial data"
    - name: "distinct_patient_count"
      expr: COUNT(DISTINCT primary_patient_mpi_record_id)
      comment: "Number of unique patients with accounts"
    - name: "distinct_guarantor_count"
      expr: COUNT(DISTINCT guarantor_id)
      comment: "Number of unique guarantors"
    - name: "bad_debt_account_count"
      expr: SUM(CASE WHEN bad_debt_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts written off as bad debt"
    - name: "payment_plan_account_count"
      expr: SUM(CASE WHEN payment_plan_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts on payment plans"
    - name: "collections_account_count"
      expr: SUM(CASE WHEN collection_agency_name IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of accounts referred to collections"
    - name: "financial_assistance_account_count"
      expr: SUM(CASE WHEN financial_assistance_approval_status IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of accounts with financial assistance applications"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment metrics tracking contractual write-offs, denials, appeals, bad debt, and revenue cycle adjustments by reason and payer."
  source: "`vibe_healthcare_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., contractual, denial, write-off, appeal)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "category"
      expr: category
      comment: "Adjustment category grouping"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment"
    - name: "reason_description"
      expr: reason_description
      comment: "Description of adjustment reason"
    - name: "write_off_classification"
      expr: write_off_classification
      comment: "Classification of write-off (e.g., contractual, bad debt, charity)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status with payer remittance"
    - name: "appeal_flag"
      expr: appeal_flag
      comment: "Whether adjustment is related to an appeal"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether adjustment is a reversal of prior adjustment"
    - name: "source"
      expr: source
      comment: "Source system or origin of adjustment"
    - name: "contractual_payer_name"
      expr: contractual_payer_name
      comment: "Payer name for contractual adjustments"
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code associated with adjustment"
    - name: "adjustment_year"
      expr: YEAR(adjustment_date)
      comment: "Year of adjustment date"
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month of adjustment date"
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year of service date"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service date"
  measures:
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total adjustment amount (positive or negative)"
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment amount per transaction"
    - name: "total_contract_rate"
      expr: SUM(CAST(contract_rate AS DOUBLE))
      comment: "Total contracted rate amounts"
    - name: "distinct_patient_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with adjustments"
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT contractual_payer_name)
      comment: "Number of unique payers with adjustments"
    - name: "appeal_adjustment_count"
      expr: SUM(CASE WHEN appeal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments related to appeals"
    - name: "reversal_adjustment_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustment reversals"
    - name: "bad_debt_adjustment_count"
      expr: SUM(CASE WHEN bad_debt_referral_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of adjustments referred to bad debt"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_coding_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding and DRG assignment metrics tracking coding accuracy, CDI impact, query response rates, and reimbursement optimization."
  source: "`vibe_healthcare_v1`.`billing`.`coding_assignment`"
  dimensions:
    - name: "coding_status"
      expr: coding_status
      comment: "Current status of coding assignment (e.g., pending, complete, audited)"
    - name: "coding_method"
      expr: coding_method
      comment: "Method used for coding (e.g., manual, CAC, hybrid)"
    - name: "audit_flag"
      expr: audit_flag
      comment: "Whether this coding assignment has been audited"
    - name: "cdi_query_type"
      expr: cdi_query_type
      comment: "Type of CDI query issued (e.g., clarification, specificity, clinical indicator)"
    - name: "cdi_physician_response"
      expr: cdi_physician_response
      comment: "Physician response to CDI query"
    - name: "major_complication_comorbidity_flag"
      expr: major_complication_comorbidity_flag
      comment: "Whether case has major complication or comorbidity (MCC)"
    - name: "complication_comorbidity_flag"
      expr: complication_comorbidity_flag
      comment: "Whether case has complication or comorbidity (CC)"
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major Diagnostic Category code"
    - name: "admission_type_code"
      expr: admission_type_code
      comment: "Type of admission"
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Patient discharge disposition"
    - name: "grouper_version"
      expr: grouper_version
      comment: "Version of DRG grouper software used"
    - name: "coding_year"
      expr: YEAR(coding_date)
      comment: "Year of coding completion"
    - name: "coding_month"
      expr: DATE_TRUNC('MONTH', coding_date)
      comment: "Month of coding completion"
  measures:
    - name: "coding_assignment_count"
      expr: COUNT(1)
      comment: "Total number of coding assignments"
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement based on DRG assignment"
    - name: "total_cdi_drg_impact"
      expr: SUM(CAST(cdi_drg_impact_amount AS DOUBLE))
      comment: "Total financial impact of CDI interventions on DRG assignment"
    - name: "avg_coding_accuracy_score"
      expr: AVG(CAST(coding_accuracy_score AS DOUBLE))
      comment: "Average coding accuracy score from audits"
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay for DRG"
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay for DRG"
    - name: "total_outlier_threshold_amount"
      expr: SUM(CAST(outlier_threshold_amount AS DOUBLE))
      comment: "Total outlier payment threshold amounts"
    - name: "distinct_drg_count"
      expr: COUNT(DISTINCT drg_id)
      comment: "Number of unique DRGs assigned"
    - name: "distinct_mdc_count"
      expr: COUNT(DISTINCT mdc_code)
      comment: "Number of unique Major Diagnostic Categories"
    - name: "cdi_query_count"
      expr: SUM(CASE WHEN cdi_query_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of CDI queries issued"
    - name: "cdi_response_count"
      expr: SUM(CASE WHEN cdi_response_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of CDI queries with physician responses"
    - name: "mcc_case_count"
      expr: SUM(CASE WHEN major_complication_comorbidity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with major complications or comorbidities"
    - name: "cc_case_count"
      expr: SUM(CASE WHEN complication_comorbidity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with complications or comorbidities"
    - name: "audited_case_count"
      expr: SUM(CASE WHEN audit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of coding assignments that have been audited"
$$;