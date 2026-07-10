-- Metric views for domain: billing | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge capture KPIs for revenue cycle: gross charges, expected reimbursement, void/correction leakage, and billable yield by service dimensions. Single-table view over billing.charge."
  source: "`vibe_healthcare_v1`.`billing`.`charge`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Category of the charge (e.g., professional, facility, supply) for revenue mix analysis."
    - name: "charge_status"
      expr: charge_status
      comment: "Lifecycle status of the charge used to segment posted vs held vs voided charges."
    - name: "charge_type"
      expr: charge_type
      comment: "Type classification of the charge for grouping revenue streams."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code associated with the charge for departmental revenue reporting."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code indicating where the service was rendered."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Service month bucket for trending charge volume and revenue over time."
  measures:
    - name: "Charge Count"
      expr: COUNT(1)
      comment: "Total number of charge records; baseline volume for revenue cycle throughput."
    - name: "Total Gross Charges"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Sum of gross charge amounts; top-line billed revenue steering total charge capture."
    - name: "Total Expected Reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Sum of expected reimbursement; forecasts realizable revenue after contractual adjustments."
    - name: "Avg Unit Price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per charge; monitors pricing consistency across services."
    - name: "Total Charge Quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Sum of charge quantities; volume driver for utilization analysis."
    - name: "Voided Charge Count"
      expr: SUM(CASE WHEN is_voided = TRUE THEN 1 ELSE 0 END)
      comment: "Count of voided charges; flags revenue leakage and charge capture rework."
    - name: "Corrected Charge Count"
      expr: SUM(CASE WHEN is_corrected = TRUE THEN 1 ELSE 0 END)
      comment: "Count of corrected charges; indicates coding/capture accuracy issues to investigate."
    - name: "Implant Charge Count"
      expr: SUM(CASE WHEN implant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of implant-flagged charges; high-cost supply items requiring margin oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice/claim financial performance: total charges, allowed, payments, contractual adjustments, and outstanding balance for AR and denial steering."
  source: "`vibe_healthcare_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice lifecycle status for segmenting open vs paid vs denied invoices."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., institutional vs professional) for billing mix analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status indicating recoverability of the outstanding balance."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code for root-cause analysis of denied claims."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month bucket for trending billing and AR performance."
  measures:
    - name: "Invoice Count"
      expr: COUNT(1)
      comment: "Total number of invoices; baseline billing throughput volume."
    - name: "Total Charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Sum of total billed charges across invoices; gross billed revenue."
    - name: "Total Allowed Amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Sum of payer-allowed amounts; net contracted revenue expectation."
    - name: "Total Insurance Payment"
      expr: SUM(CAST(insurance_payment AS DOUBLE))
      comment: "Sum of insurance payments received; primary revenue realization."
    - name: "Total Patient Payment"
      expr: SUM(CAST(patient_payment AS DOUBLE))
      comment: "Sum of patient payments; patient-responsibility collections performance."
    - name: "Total Contractual Adjustment"
      expr: SUM(CAST(contractual_adjustment AS DOUBLE))
      comment: "Sum of contractual adjustments; measures negotiated write-downs from gross charges."
    - name: "Total Outstanding Balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Sum of outstanding balances; total open AR requiring collection action."
    - name: "Total Bad Debt Amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Sum of bad debt amounts; uncollectible exposure impacting net revenue."
    - name: "Total Patient Responsibility"
      expr: SUM(CAST(patient_responsibility AS DOUBLE))
      comment: "Sum of patient responsibility amounts; self-pay collection risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment posting and cash performance: applied vs unapplied cash, refunds, reversals, and payment mix by method and channel."
  source: "`vibe_healthcare_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_category"
      expr: payment_category
      comment: "Category of payment (e.g., insurance, patient) for cash source mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Posting status of the payment for segmenting posted vs pending cash."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment for grouping cash inflows."
    - name: "method"
      expr: method
      comment: "Payment method (check, EFT, card) for channel efficiency analysis."
    - name: "channel"
      expr: channel
      comment: "Payment channel used to remit funds for channel performance monitoring."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment month bucket for cash flow trending."
  measures:
    - name: "Payment Count"
      expr: COUNT(1)
      comment: "Total number of payment transactions; baseline cash posting volume."
    - name: "Total Payment Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of payment amounts; total cash collected steering revenue realization."
    - name: "Total Applied Amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Sum of applied payment amounts; cash successfully matched to invoices."
    - name: "Total Unapplied Amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Sum of unapplied cash; posting backlog requiring reconciliation action."
    - name: "Total Refund Amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Sum of refund amounts; overpayment returns impacting net cash."
    - name: "Refund Count"
      expr: SUM(CASE WHEN refund_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of refund-flagged payments; monitors refund frequency and process cost."
    - name: "Reversal Count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed payments; flags posting errors and rework."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment and write-down analytics: contractual and other adjustments, appeals, and reversals impacting net revenue."
  source: "`vibe_healthcare_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Category of adjustment for revenue-impact classification."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (contractual, write-off, etc.) for net-revenue analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment for lifecycle segmentation."
    - name: "reason_code"
      expr: reason_code
      comment: "Adjustment reason code for root-cause revenue leakage analysis."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Adjustment month bucket for trending net-revenue adjustments."
  measures:
    - name: "Adjustment Count"
      expr: COUNT(1)
      comment: "Total number of adjustment records; baseline adjustment volume."
    - name: "Total Adjustment Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of adjustment amounts; total revenue reductions steering net revenue."
    - name: "Total Contract Rate"
      expr: SUM(CAST(contract_rate AS DOUBLE))
      comment: "Sum of contract rates on adjustments; contracted-rate exposure reference."
    - name: "Appeal Count"
      expr: SUM(CASE WHEN appeal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of appealed adjustments; recovery opportunity pipeline."
    - name: "Reversal Count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed adjustments; indicates adjustment error/rework rate."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off analytics: uncollectible and charity write-offs, appeals, and recovery to steer bad-debt reduction."
  source: "`vibe_healthcare_v1`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_category"
      expr: write_off_category
      comment: "Category of write-off for revenue-loss classification."
    - name: "write_off_type"
      expr: write_off_type
      comment: "Type of write-off (bad debt, charity, contractual) for loss driver analysis."
    - name: "write_off_status"
      expr: write_off_status
      comment: "Status of the write-off for lifecycle segmentation."
    - name: "reason_code"
      expr: reason_code
      comment: "Write-off reason code for root-cause analysis."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Write-off month bucket for trending revenue loss."
  measures:
    - name: "Write Off Count"
      expr: COUNT(1)
      comment: "Total number of write-off records; baseline loss event volume."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of write-off amounts; total revenue written off steering bad-debt management."
    - name: "Total Original Balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Sum of original balances written off; gross exposure before write-off."
    - name: "Total Remaining Balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Sum of remaining balances; residual recoverable amount after write-off."
    - name: "Avg Discount Percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied; measures write-off generosity/policy adherence."
    - name: "Appeal Count"
      expr: SUM(CASE WHEN appeal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of appealed write-offs; recovery pipeline for previously written-off balances."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_patient_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient account and self-pay AR health: balances, aging, bad debt, and financial assistance impact on collections."
  source: "`vibe_healthcare_v1`.`billing`.`patient_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Account status for segmenting active vs closed vs collection accounts."
    - name: "account_type"
      expr: account_type
      comment: "Account type for guarantor/self-pay segmentation."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for AR aging distribution and collection prioritization."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status indicating recoverability of the account balance."
    - name: "financial_assistance_eligibility"
      expr: financial_assistance_eligibility
      comment: "Financial assistance eligibility for charity/uncompensated care analysis."
  measures:
    - name: "Account Count"
      expr: COUNT(1)
      comment: "Total number of patient accounts; baseline self-pay AR population."
    - name: "Total Account Balance"
      expr: SUM(CAST(account_balance AS DOUBLE))
      comment: "Sum of account balances; total open patient AR steering collections."
    - name: "Total Patient Balance"
      expr: SUM(CAST(patient_balance AS DOUBLE))
      comment: "Sum of patient-responsible balances; self-pay collection exposure."
    - name: "Total Insurance Balance"
      expr: SUM(CAST(insurance_balance AS DOUBLE))
      comment: "Sum of insurance-pending balances; payer AR awaiting adjudication."
    - name: "Total Bad Debt Amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Sum of bad debt amounts on accounts; uncollectible self-pay exposure."
    - name: "Total Payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Sum of total payments on accounts; realized patient collections."
    - name: "Total Recovered Amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Sum of recovered amounts; collection agency and recovery effectiveness."
    - name: "Bad Debt Account Count"
      expr: SUM(CASE WHEN bad_debt_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts flagged as bad debt; portfolio risk concentration."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_collection_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections performance: referred balances, recovery, settlements, and legal action for third-party collection oversight."
  source: "`vibe_healthcare_v1`.`billing`.`collection_account`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Status of the collection account for lifecycle segmentation."
    - name: "collection_type"
      expr: collection_type
      comment: "Type of collection (agency, legal, internal) for channel analysis."
    - name: "collection_agency_name"
      expr: collection_agency_name
      comment: "Collection agency handling the account for vendor performance comparison."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Referral month bucket for trending collection referrals."
  measures:
    - name: "Collection Account Count"
      expr: COUNT(1)
      comment: "Total number of collection accounts; baseline collections workload."
    - name: "Total Referred Balance"
      expr: SUM(CAST(referred_balance AS DOUBLE))
      comment: "Sum of balances referred to collections; total placement value."
    - name: "Total Outstanding Balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Sum of outstanding balances in collections; open recovery exposure."
    - name: "Total Recovered Amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Sum of recovered amounts; collection effectiveness driving net recovery."
    - name: "Total Settlement Amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Sum of settlement amounts; negotiated recovery outcomes."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Sum of write-offs from collections; unrecoverable placements."
    - name: "Legal Action Count"
      expr: SUM(CASE WHEN legal_action_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts in legal action; escalation intensity and cost driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient payment plan performance: plan balances, installments, defaults, and cancellations for self-pay financing programs."
  source: "`vibe_healthcare_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Payment plan status for active vs defaulted vs completed segmentation."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan for financing program analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the plan was enrolled for acquisition analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Enrollment month bucket for trending plan adoption."
  measures:
    - name: "Payment Plan Count"
      expr: COUNT(1)
      comment: "Total number of payment plans; baseline financing program adoption."
    - name: "Total Plan Amount"
      expr: SUM(CAST(total_plan_amount AS DOUBLE))
      comment: "Sum of total plan amounts; total financed patient balances."
    - name: "Total Paid Amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Sum of amounts paid under plans; realized installment collections."
    - name: "Total Remaining Balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Sum of remaining plan balances; open financed exposure."
    - name: "Avg Installment Amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average installment amount; affordability and plan structure monitoring."
    - name: "Defaulted Plan Count"
      expr: SUM(CASE WHEN default_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of plans with a default date; default rate driver for program risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charity_care_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charity care / financial assistance program KPIs: application volume, approvals, discounts, and 501r compliance for community benefit reporting."
  source: "`vibe_healthcare_v1`.`billing`.`charity_care_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Application status for pipeline and approval-rate analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval decision status for outcome segmentation."
    - name: "program_type"
      expr: program_type
      comment: "Financial assistance program type for community benefit classification."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Application month bucket for trending assistance demand."
  measures:
    - name: "Application Count"
      expr: COUNT(1)
      comment: "Total number of charity care applications; assistance demand baseline."
    - name: "Total Household Income"
      expr: SUM(CAST(household_income AS DOUBLE))
      comment: "Sum of reported household incomes; supports means-testing distribution analysis."
    - name: "Avg Approved Discount Percentage"
      expr: AVG(CAST(approved_discount_percentage AS DOUBLE))
      comment: "Average approved discount percentage; charity generosity and uncompensated care driver."
    - name: "Avg FPL Percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average federal poverty level percentage of applicants; eligibility profile monitoring."
    - name: "Presumptive Eligibility Count"
      expr: SUM(CASE WHEN presumptive_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of presumptively eligible applications; fast-track assistance volume."
    - name: "501r Compliant Count"
      expr: SUM(CASE WHEN irs_501r_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of 501r-compliant applications; nonprofit regulatory compliance rate."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_rac_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RAC/recovery audit exposure: findings, overpayments, recoupments, and appeal outcomes for compliance and revenue-integrity steering."
  source: "`vibe_healthcare_v1`.`billing`.`rac_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status for lifecycle segmentation of RAC cases."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RAC audit for risk-area analysis."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Appeal status for tracking recovery of contested findings."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding for root-cause revenue-integrity analysis."
    - name: "audit_request_month"
      expr: DATE_TRUNC('MONTH', audit_request_date)
      comment: "Audit request month bucket for trending audit activity."
  measures:
    - name: "RAC Audit Count"
      expr: COUNT(1)
      comment: "Total number of RAC audits; audit exposure workload baseline."
    - name: "Total Finding Amount"
      expr: SUM(CAST(finding_amount AS DOUBLE))
      comment: "Sum of audit finding amounts; total revenue-integrity exposure."
    - name: "Total Overpayment Amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Sum of overpayment amounts identified; repayment exposure."
    - name: "Total Recoupment Amount"
      expr: SUM(CAST(recoupment_amount AS DOUBLE))
      comment: "Sum of recouped amounts; realized clawbacks reducing net revenue."
    - name: "Total Appeal Outcome Amount"
      expr: SUM(CAST(appeal_outcome_amount AS DOUBLE))
      comment: "Sum of appeal outcome amounts; recovered revenue from successful appeals."
    - name: "Appeal Filed Count"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits with appeals filed; contest activity and recovery pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_coding_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical coding quality and CDI impact: coding accuracy, DRG financial impact, and complication/comorbidity capture for revenue integrity."
  source: "`vibe_healthcare_v1`.`billing`.`coding_assignment`"
  dimensions:
    - name: "coding_status"
      expr: coding_status
      comment: "Coding assignment status for workflow segmentation."
    - name: "coding_method"
      expr: coding_method
      comment: "Coding method used (manual, computer-assisted) for productivity analysis."
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major diagnostic category code for casemix analysis."
    - name: "coding_month"
      expr: DATE_TRUNC('MONTH', coding_date)
      comment: "Coding month bucket for trending coding throughput."
  measures:
    - name: "Coding Assignment Count"
      expr: COUNT(1)
      comment: "Total number of coding assignments; coding workload baseline."
    - name: "Avg Coding Accuracy Score"
      expr: AVG(CAST(coding_accuracy_score AS DOUBLE))
      comment: "Average coding accuracy score; quality KPI driving audit and training decisions."
    - name: "Total CDI DRG Impact Amount"
      expr: SUM(CAST(cdi_drg_impact_amount AS DOUBLE))
      comment: "Sum of CDI-driven DRG financial impact; revenue captured through documentation improvement."
    - name: "Total Expected Reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Sum of expected reimbursement from coded cases; casemix revenue expectation."
    - name: "Avg Arithmetic Mean LOS"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay; efficiency and DRG benchmarking."
    - name: "CC Flagged Count"
      expr: SUM(CASE WHEN complication_comorbidity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with complication/comorbidity capture; DRG upgrade and revenue-integrity driver."
    - name: "MCC Flagged Count"
      expr: SUM(CASE WHEN major_complication_comorbidity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with major complication/comorbidity; high-acuity revenue capture indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund and credit-balance management: refund volume, CMS credit-balance reporting compliance, and void/reversal activity."
  source: "`vibe_healthcare_v1`.`billing`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Refund status for lifecycle and processing-time analysis."
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund for driver analysis (overpayment, duplicate payment)."
    - name: "refund_category"
      expr: refund_category
      comment: "Category of refund for classification and reporting."
    - name: "reason_code"
      expr: reason_code
      comment: "Refund reason code for root-cause analysis of overpayments."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Refund request month bucket for trending refund activity."
  measures:
    - name: "Refund Count"
      expr: COUNT(1)
      comment: "Total number of refunds; refund processing workload baseline."
    - name: "Total Refund Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of refund amounts; total cash returned impacting net collections."
    - name: "Total Original Payment Amount"
      expr: SUM(CAST(original_payment_amount AS DOUBLE))
      comment: "Sum of original payment amounts underlying refunds; overpayment scale reference."
    - name: "CMS Credit Balance Report Count"
      expr: SUM(CASE WHEN cms_credit_balance_report_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of refunds reported on CMS credit balance reports; regulatory compliance tracking."
    - name: "Voided Refund Count"
      expr: SUM(CASE WHEN void_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of voided refunds; process error and rework indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient statement operations: statement volume, balances billed, delivery/returned-mail performance, and suppression for patient-billing efficiency."
  source: "`vibe_healthcare_v1`.`billing`.`statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Statement status for lifecycle segmentation."
    - name: "statement_type"
      expr: statement_type
      comment: "Type of statement for billing-cycle classification."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (paper, electronic) for cost and reach analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status for tracking successful patient outreach."
    - name: "statement_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Statement month bucket for trending statement cycles."
  measures:
    - name: "Statement Count"
      expr: COUNT(1)
      comment: "Total number of statements; patient-billing outreach volume baseline."
    - name: "Total Balance Due"
      expr: SUM(CAST(total_balance_due AS DOUBLE))
      comment: "Sum of balances due on statements; total patient-facing AR billed."
    - name: "Total Current Charges"
      expr: SUM(CAST(current_charges AS DOUBLE))
      comment: "Sum of current-period charges billed; new statement charge volume."
    - name: "Total Payments Received"
      expr: SUM(CAST(payments_received AS DOUBLE))
      comment: "Sum of payments received against statements; statement-driven collection performance."
    - name: "Returned Mail Count"
      expr: SUM(CASE WHEN returned_mail_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of statements with returned mail; address-quality and reach problem indicator."
    - name: "Suppressed Statement Count"
      expr: SUM(CASE WHEN suppression_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of suppressed statements; monitors billing-hold and suppression policy usage."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_cdm_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargemaster (CDM) pricing and cost analytics: charge vs cost, RVU-based valuation, and price-transparency compliance."
  source: "`vibe_healthcare_v1`.`billing`.`cdm_entry`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "CDM charge category for chargemaster mix analysis."
    - name: "item_type"
      expr: item_type
      comment: "Item type of the CDM entry for grouping billable items."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code mapped to the CDM entry for departmental pricing analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for departmental cost/charge alignment."
  measures:
    - name: "CDM Entry Count"
      expr: COUNT(1)
      comment: "Total number of CDM entries; chargemaster size and maintenance scope."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Sum of CDM charge amounts; gross chargemaster valuation reference."
    - name: "Total Cost Amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Sum of CDM cost amounts; cost basis for margin analysis."
    - name: "Avg Charge Amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per CDM item; pricing-level benchmark."
    - name: "Avg RVU Work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVU per CDM item; resource-intensity benchmark."
    - name: "Price Transparency Count"
      expr: SUM(CASE WHEN price_transparency_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of price-transparency-flagged items; CMS transparency compliance coverage."
    - name: "Active CDM Count"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active CDM entries; live chargemaster maintenance scope."
$$;