-- Metric views for domain: billing | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice-level KPIs tracking billed revenue, charge composition, and billing volume across customer accounts, billing cycles, and service types. Used by Finance and Revenue Management to monitor billing performance and revenue trends."
  source: "`vibe_water_utilities_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., Draft, Issued, Paid, Disputed, Void) — primary filter for revenue reporting."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice (e.g., Regular, Final, Estimated, Supplemental) — used to segment billing volume by type."
    - name: "billing_period_start_date"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month bucket of the billing period start date — enables monthly revenue trend analysis."
    - name: "billing_period_end_date"
      expr: DATE_TRUNC('month', billing_period_end_date)
      comment: "Month bucket of the billing period end date — used for period-over-period revenue comparisons."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was generated — supports billing cycle cadence analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the invoice payment is due — used for cash flow forecasting."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the invoice was delivered to the customer (e.g., Paper, Email, Portal) — used to track paperless adoption."
    - name: "generation_method"
      expr: generation_method
      comment: "How the invoice was generated (e.g., Automated, Manual, Estimated) — used to monitor billing automation rates."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether the invoice is based on an estimated read — used to track estimated billing exposure."
    - name: "is_final"
      expr: is_final
      comment: "Flag indicating whether this is a final bill (account closure) — used to monitor churn and service terminations."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating the invoice is under dispute — used to quantify disputed revenue at risk."
    - name: "rate_schedule_code"
      expr: rate_schedule_code
      comment: "Rate schedule applied to the invoice — enables revenue analysis by rate class."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice — used for multi-currency revenue reporting."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued — baseline volume metric for billing throughput monitoring."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Sum of all invoice amounts due — primary revenue billed metric used in financial reporting and revenue forecasting."
    - name: "total_water_charge"
      expr: SUM(CAST(water_charge_amount AS DOUBLE))
      comment: "Total water service charges billed — used to track water revenue contribution to total billed revenue."
    - name: "total_wastewater_charge"
      expr: SUM(CAST(wastewater_charge_amount AS DOUBLE))
      comment: "Total wastewater service charges billed — used to track wastewater revenue contribution."
    - name: "total_stormwater_charge"
      expr: SUM(CAST(stormwater_charge_amount AS DOUBLE))
      comment: "Total stormwater charges billed — used to monitor stormwater fee revenue and compliance with stormwater funding requirements."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts billed — used for tax liability reporting and regulatory compliance."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed on invoices — indicator of collection performance and customer payment behavior."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to invoices — used to monitor billing correction volume and revenue leakage."
    - name: "total_other_charges"
      expr: SUM(CAST(other_charges_amount AS DOUBLE))
      comment: "Total miscellaneous charges billed — used to track non-standard revenue items."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice amount per billing event — used to benchmark billing levels and detect anomalies in billing amounts."
    - name: "total_water_consumption_volume"
      expr: SUM(CAST(water_consumption_volume AS DOUBLE))
      comment: "Total billed water consumption volume — used to reconcile billed volume against production and identify non-revenue water."
    - name: "avg_water_consumption_volume"
      expr: AVG(CAST(water_consumption_volume AS DOUBLE))
      comment: "Average billed water consumption per invoice — used to benchmark per-account usage and detect outliers."
    - name: "total_wastewater_volume"
      expr: SUM(CAST(wastewater_volume AS DOUBLE))
      comment: "Total billed wastewater volume — used to reconcile wastewater charges against flow measurements."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute — used to monitor billing quality and customer satisfaction risk."
    - name: "estimated_invoice_count"
      expr: COUNT(CASE WHEN is_estimated = TRUE THEN 1 END)
      comment: "Number of invoices based on estimated reads — used to track meter read quality and estimated billing exposure."
    - name: "final_bill_count"
      expr: COUNT(CASE WHEN is_final = TRUE THEN 1 END)
      comment: "Number of final bills issued — proxy for customer churn and service termination rate."
    - name: "distinct_customer_accounts_billed"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts billed — used to track billing coverage and active account base."
    - name: "avg_previous_balance"
      expr: AVG(CAST(previous_balance_amount AS DOUBLE))
      comment: "Average prior balance carried forward on invoices — indicator of collection effectiveness and aging receivables."
    - name: "total_previous_balance"
      expr: SUM(CAST(previous_balance_amount AS DOUBLE))
      comment: "Total prior balances carried forward — used to assess outstanding receivables and collection risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment-level KPIs tracking cash collection performance, payment channel mix, NSF events, and reversal rates. Used by Finance and Collections to monitor cash flow, payment behavior, and collection efficiency."
  source: "`vibe_water_utilities_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Posted, Reversed, NSF, Pending) — primary filter for cash collection analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of payment (e.g., Regular, Prepayment, Overpayment) — used to segment payment volume by type."
    - name: "payment_method"
      expr: method
      comment: "Payment method used (e.g., Check, ACH, Credit Card, Cash) — used to analyze payment channel adoption and processing costs."
    - name: "payment_channel"
      expr: channel
      comment: "Channel through which payment was received (e.g., Online, IVR, Walk-in, Lockbox) — used to optimize payment channel strategy."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month the payment was made — enables monthly cash collection trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the payment was posted to the ledger — used for cash flow and revenue recognition timing analysis."
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Flag indicating autopay enrollment — used to track autopay adoption and its impact on collection rates."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating a recurring payment arrangement — used to monitor recurring payment program performance."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Flag indicating a non-sufficient funds (NSF) return — used to track payment failure rates and associated fee revenue."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — used for multi-currency cash reporting."
    - name: "card_type"
      expr: card_type
      comment: "Type of payment card used (e.g., Visa, Mastercard) — used to analyze card processing fee exposure."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions — baseline volume metric for payment processing monitoring."
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash collected from all payments — primary cash collection KPI used in daily treasury and monthly financial reporting."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices — used to reconcile cash receipts against outstanding receivables."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment balance — indicator of cash application backlog and potential revenue recognition delays."
    - name: "total_nsf_fee_amount"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees assessed — used to track returned payment fee revenue and customer payment reliability."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction — used to benchmark payment behavior and detect anomalies."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Number of NSF (returned) payments — used to monitor payment failure rates and collection risk."
    - name: "autopay_payment_count"
      expr: COUNT(CASE WHEN is_auto_pay = TRUE THEN 1 END)
      comment: "Number of payments made via autopay — used to track autopay program adoption and its impact on collection efficiency."
    - name: "distinct_customer_accounts_paying"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts making payments — used to measure payment participation rate against billed accounts."
    - name: "reversal_payment_count"
      expr: COUNT(CASE WHEN reversed_by_payment_id IS NOT NULL THEN 1 END)
      comment: "Number of payments that have been reversed — used to monitor payment reversal rates and associated revenue risk."
    - name: "unapplied_payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of collected cash that remains unapplied to invoices — used to monitor cash application efficiency and identify AR reconciliation issues."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment KPIs tracking revenue corrections, leak allowances, dispute-driven credits, and regulatory adjustments. Used by Revenue Management and Compliance to monitor billing accuracy and revenue leakage."
  source: "`vibe_water_utilities_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of billing adjustment (e.g., Leak Credit, Rate Error, Meter Error, Regulatory) — primary dimension for adjustment root cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., Pending, Approved, Applied, Reversed) — used to track adjustment lifecycle."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the adjustment — used to categorize and trend adjustment causes for process improvement."
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge being adjusted (e.g., Water, Wastewater, Stormwater) — used to attribute revenue corrections by service type."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the adjustment — used to segment adjustment impact by service line."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month of the billing period being adjusted — used to attribute corrections to the originating billing period."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the adjustment became effective — used for revenue impact timing analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Flag indicating whether the adjustment required supervisory approval — used to monitor approval workflow compliance."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating this adjustment is a reversal of a prior adjustment — used to track net adjustment activity."
    - name: "leak_allowance_flag"
      expr: leak_allowance_flag
      comment: "Flag indicating a leak allowance credit — used to monitor leak credit program utilization and cost."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating the adjustment is driven by regulatory compliance requirements — used to track mandated revenue corrections."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating the adjustment is tax-exempt — used for tax liability reconciliation."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of billing adjustments issued — baseline volume metric for billing correction monitoring."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Net total dollar value of all billing adjustments — primary revenue leakage KPI used by Finance to quantify billing corrections."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average dollar value per adjustment — used to benchmark adjustment magnitude and detect unusually large corrections."
    - name: "total_consumption_volume_adjusted"
      expr: SUM(CAST(consumption_volume_adjusted AS DOUBLE))
      comment: "Total consumption volume adjusted across all billing corrections — used to reconcile billed vs. actual consumption and assess NRW impact."
    - name: "leak_allowance_adjustment_count"
      expr: COUNT(CASE WHEN leak_allowance_flag = TRUE THEN 1 END)
      comment: "Number of leak allowance credits issued — used to monitor leak credit program utilization and associated revenue impact."
    - name: "leak_allowance_total_amount"
      expr: SUM(CASE WHEN leak_allowance_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total dollar value of leak allowance credits — used to quantify the financial cost of the leak credit program."
    - name: "regulatory_adjustment_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of adjustments driven by regulatory compliance — used to track mandated billing corrections and associated compliance costs."
    - name: "reversal_adjustment_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of adjustment reversals — used to monitor billing correction quality and rework rates."
    - name: "pending_approval_adjustment_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE AND adjustment_status = 'Pending' THEN 1 END)
      comment: "Number of adjustments awaiting approval — used to monitor approval workflow backlog and SLA compliance."
    - name: "distinct_accounts_adjusted"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts receiving billing adjustments — used to assess the breadth of billing correction impact."
    - name: "avg_approval_threshold_amount"
      expr: AVG(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Average approval threshold amount configured for adjustments — used to review and calibrate approval authority levels."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio KPIs tracking account health, aging receivables, collection status, and financial exposure. Used by Finance, Collections, and Customer Service leadership to manage the receivables portfolio and collection strategy."
  source: "`vibe_water_utilities_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g., Active, Closed, Suspended, Disconnected) — primary dimension for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., Residential, Commercial, Industrial) — used to segment financial exposure by customer class."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the account (e.g., Current, Delinquent, Collections, Write-off) — primary dimension for collections portfolio management."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency at which the account is billed (e.g., Monthly, Bi-monthly, Quarterly) — used to analyze billing cycle distribution."
    - name: "autopay_enrolled"
      expr: autopay_enrolled
      comment: "Flag indicating autopay enrollment — used to segment accounts by payment automation and correlate with collection performance."
    - name: "budget_billing_enrolled"
      expr: budget_billing_enrolled
      comment: "Flag indicating budget billing enrollment — used to track budget billing program adoption and its impact on payment predictability."
    - name: "paperless_billing"
      expr: paperless_billing
      comment: "Flag indicating paperless billing enrollment — used to track digital billing adoption and associated cost savings."
    - name: "payment_plan_active"
      expr: payment_plan_active
      comment: "Flag indicating an active payment plan — used to monitor payment plan portfolio and associated collection risk."
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Flag indicating tax-exempt status — used for tax liability reporting and compliance."
    - name: "last_bill_date_month"
      expr: DATE_TRUNC('month', last_bill_date)
      comment: "Month of the most recent bill — used to identify accounts that may have missed a billing cycle."
    - name: "opened_date_year"
      expr: DATE_TRUNC('year', opened_date)
      comment: "Year the account was opened — used for account vintage analysis and cohort-based collection performance."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the account — used to segment collection risk and set credit limits."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms assigned to the account — used to analyze terms distribution and their impact on DSO."
  measures:
    - name: "total_billing_accounts"
      expr: COUNT(1)
      comment: "Total number of billing accounts — baseline portfolio size metric used in executive reporting."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all billing accounts — primary accounts receivable KPI used in financial reporting."
    - name: "total_past_due_amount"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past-due balance across all accounts — key collections KPI used to assess delinquency exposure and prioritize collection efforts."
    - name: "total_aging_current"
      expr: SUM(CAST(aging_current AS DOUBLE))
      comment: "Total current (0-30 day) receivables — used in aging analysis to assess the health of the receivables portfolio."
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_30_days AS DOUBLE))
      comment: "Total 30-day aged receivables — used in aging bucket analysis to identify early-stage delinquency."
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_60_days AS DOUBLE))
      comment: "Total 60-day aged receivables — used to identify accounts approaching collections escalation thresholds."
    - name: "total_aging_90_days"
      expr: SUM(CAST(aging_90_days AS DOUBLE))
      comment: "Total 90-day aged receivables — used to identify accounts at high risk of write-off."
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_over_90_days AS DOUBLE))
      comment: "Total receivables aged over 90 days — primary write-off risk indicator used by Collections leadership."
    - name: "total_deposit_on_file"
      expr: SUM(CAST(deposit_on_file AS DOUBLE))
      comment: "Total customer deposits held — used to assess deposit liability and offset against delinquent balances."
    - name: "total_payment_plan_balance"
      expr: SUM(CAST(payment_plan_balance AS DOUBLE))
      comment: "Total balance enrolled in payment plans — used to monitor payment plan portfolio size and associated collection risk."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per billing account — used to benchmark account-level receivables and detect outliers."
    - name: "delinquent_account_count"
      expr: COUNT(CASE WHEN past_due_amount > 0 THEN 1 END)
      comment: "Number of accounts with a past-due balance — used to track delinquency rate and collection workload."
    - name: "autopay_enrolled_count"
      expr: COUNT(CASE WHEN autopay_enrolled = TRUE THEN 1 END)
      comment: "Number of accounts enrolled in autopay — used to track autopay adoption rate and its correlation with on-time payment performance."
    - name: "payment_plan_active_count"
      expr: COUNT(CASE WHEN payment_plan_active = TRUE THEN 1 END)
      comment: "Number of accounts with an active payment plan — used to monitor payment plan program utilization."
    - name: "past_due_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN past_due_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of billing accounts with a past-due balance — executive-level delinquency rate KPI used in quarterly financial reviews."
    - name: "total_late_fee_assessed"
      expr: SUM(CAST(late_fee_assessed AS DOUBLE))
      comment: "Total late fees assessed across all accounts — used to track late fee revenue and monitor collection policy effectiveness."
    - name: "total_reconnection_fee"
      expr: SUM(CAST(reconnection_fee AS DOUBLE))
      comment: "Total reconnection fees assessed — used to track disconnection/reconnection activity and associated fee revenue."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off KPIs tracking bad debt volume, recovery rates, and collection agency referrals. Used by Finance and Collections leadership to monitor credit loss exposure, evaluate collection effectiveness, and manage bad debt reserves."
  source: "`vibe_water_utilities_v1`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of the write-off (e.g., Approved, Recovered, Reversed) — primary dimension for write-off portfolio management."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the write-off (e.g., Bankruptcy, Skip, Hardship) — used to analyze write-off root causes and inform credit policy."
    - name: "revenue_class"
      expr: revenue_class
      comment: "Revenue class of the written-off balance (e.g., Water, Wastewater, Stormwater) — used to attribute bad debt by service type."
    - name: "write_off_date_month"
      expr: DATE_TRUNC('month', write_off_date)
      comment: "Month the write-off was recorded — enables monthly bad debt trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the write-off — used for annual bad debt reporting and budget variance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the write-off — used for period-level bad debt accrual and reserve analysis."
    - name: "collection_agency_referral_indicator"
      expr: collection_agency_referral_indicator
      comment: "Flag indicating referral to a collection agency — used to track collection agency utilization and recovery performance."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating the write-off was reversed — used to monitor write-off reversal rates and recovery activity."
  measures:
    - name: "total_write_offs"
      expr: COUNT(1)
      comment: "Total number of write-off events — baseline volume metric for bad debt monitoring."
    - name: "total_write_off_amount"
      expr: SUM(CAST(total_write_off_amount AS DOUBLE))
      comment: "Total dollar value written off — primary bad debt KPI used in financial reporting and credit loss reserve calculations."
    - name: "total_water_write_off"
      expr: SUM(CAST(water_charge_amount AS DOUBLE))
      comment: "Total water charge amounts written off — used to attribute bad debt to water service revenue."
    - name: "total_wastewater_write_off"
      expr: SUM(CAST(wastewater_charge_amount AS DOUBLE))
      comment: "Total wastewater charge amounts written off — used to attribute bad debt to wastewater service revenue."
    - name: "total_stormwater_write_off"
      expr: SUM(CAST(stormwater_charge_amount AS DOUBLE))
      comment: "Total stormwater charge amounts written off — used to attribute bad debt to stormwater fee revenue."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from previously written-off accounts — used to measure collection agency and recovery program effectiveness."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(total_write_off_amount AS DOUBLE))
      comment: "Average write-off amount per event — used to benchmark write-off magnitude and detect unusually large bad debt events."
    - name: "collection_agency_referral_count"
      expr: COUNT(CASE WHEN collection_agency_referral_indicator = TRUE THEN 1 END)
      comment: "Number of write-offs referred to collection agencies — used to monitor collection agency utilization and associated recovery rates."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_write_off_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of written-off balances subsequently recovered — key collection effectiveness KPI used to evaluate bad debt recovery programs."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts included in write-offs — used to track penalty revenue at risk from bad debt."
    - name: "reversal_write_off_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of write-offs that were subsequently reversed — used to monitor write-off quality and recovery-driven reversals."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute KPIs tracking dispute volume, resolution performance, SLA compliance, and financial exposure. Used by Customer Service and Revenue Management to monitor billing quality, customer satisfaction, and dispute resolution efficiency."
  source: "`vibe_water_utilities_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., Open, Under Investigation, Resolved, Escalated) — primary dimension for dispute pipeline management."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of billing dispute (e.g., High Bill, Meter Error, Rate Error, Service Quality) — used to categorize dispute root causes."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g., Credit Issued, No Action, Meter Test, Rate Correction) — used to analyze resolution patterns."
    - name: "channel"
      expr: channel
      comment: "Channel through which the dispute was filed (e.g., Phone, Web, Walk-in, Regulatory) — used to analyze dispute intake patterns."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the dispute — used to monitor high-priority dispute handling and SLA compliance."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating the dispute exceeded its SLA resolution target — primary dimension for service quality monitoring."
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Flag indicating the dispute was escalated to a regulatory body (e.g., PUC) — used to monitor regulatory complaint exposure."
    - name: "dispute_date_month"
      expr: DATE_TRUNC('month', dispute_date)
      comment: "Month the dispute was filed — enables monthly dispute volume trend analysis."
    - name: "resolution_date_month"
      expr: DATE_TRUNC('month', resolution_date)
      comment: "Month the dispute was resolved — used to track resolution throughput and backlog trends."
    - name: "leak_adjustment_approved_flag"
      expr: leak_adjustment_approved_flag
      comment: "Flag indicating a leak adjustment was approved as part of dispute resolution — used to track leak credit program utilization via disputes."
    - name: "meter_test_requested_flag"
      expr: meter_test_requested_flag
      comment: "Flag indicating a meter test was requested as part of the dispute — used to track meter accuracy investigation rates."
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of billing disputes filed — baseline volume metric for billing quality and customer satisfaction monitoring."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total dollar value of amounts under dispute — primary revenue-at-risk KPI used by Finance and Customer Service leadership."
    - name: "total_credit_issued_amount"
      expr: SUM(CAST(credit_issued_amount AS DOUBLE))
      comment: "Total credits issued to resolve disputes — used to quantify the financial cost of billing disputes and inform billing quality improvement."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case — used to benchmark dispute magnitude and detect high-value dispute patterns."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes that breached their SLA resolution target — used to monitor customer service quality and regulatory compliance."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes exceeding SLA resolution targets — executive-level service quality KPI used in customer satisfaction reporting."
    - name: "regulatory_escalation_count"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 END)
      comment: "Number of disputes escalated to regulatory bodies — used to monitor regulatory complaint exposure and associated compliance risk."
    - name: "meter_test_requested_count"
      expr: COUNT(CASE WHEN meter_test_requested_flag = TRUE THEN 1 END)
      comment: "Number of disputes triggering a meter accuracy test — used to track meter quality investigation rates and associated operational costs."
    - name: "leak_adjustment_approved_count"
      expr: COUNT(CASE WHEN leak_adjustment_approved_flag = TRUE THEN 1 END)
      comment: "Number of disputes resulting in an approved leak adjustment — used to monitor leak credit program utilization through the dispute channel."
    - name: "total_leak_adjustment_gallons"
      expr: SUM(CAST(leak_adjustment_gallons AS DOUBLE))
      comment: "Total consumption volume credited via leak adjustments in disputes — used to quantify NRW impact attributed to customer-side leaks."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'Open' THEN 1 END)
      comment: "Number of currently open disputes — used to monitor dispute backlog and resource allocation for resolution teams."
    - name: "distinct_accounts_with_disputes"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts with disputes — used to assess the breadth of billing quality issues across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_delinquency_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delinquency notice KPIs tracking collection escalation activity, legal action exposure, and notice effectiveness. Used by Collections and Finance leadership to manage the delinquency pipeline and evaluate collection policy effectiveness."
  source: "`vibe_water_utilities_v1`.`billing`.`delinquency_notice`"
  dimensions:
    - name: "delinquency_notice_status"
      expr: delinquency_notice_status
      comment: "Current status of the delinquency notice (e.g., Issued, Paid, Escalated, Legal) — primary dimension for collection pipeline management."
    - name: "notice_type"
      expr: notice_type
      comment: "Type of delinquency notice (e.g., First Notice, Final Notice, Disconnection Warning) — used to analyze escalation stage distribution."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the delinquency (e.g., Level 1, Level 2, Legal) — used to monitor collection escalation pipeline."
    - name: "legal_action_flag"
      expr: legal_action_flag
      comment: "Flag indicating legal action has been initiated — used to track legal collection activity and associated costs."
    - name: "collection_agency_flag"
      expr: collection_agency_flag
      comment: "Flag indicating referral to a collection agency — used to monitor collection agency utilization."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating the delinquency is under dispute — used to identify contested collection actions."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the delinquent amount is due — used for cash flow forecasting from collection activity."
    - name: "generated_date_month"
      expr: DATE_TRUNC('month', generated_timestamp)
      comment: "Month the notice was generated — enables monthly delinquency notice volume trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the delinquent amount — used for multi-currency collections reporting."
  measures:
    - name: "total_delinquency_notices"
      expr: COUNT(1)
      comment: "Total number of delinquency notices issued — baseline volume metric for collection activity monitoring."
    - name: "total_amount_due"
      expr: SUM(CAST(amount_due AS DOUBLE))
      comment: "Total delinquent amount across all notices — primary collections exposure KPI used in financial risk reporting."
    - name: "total_due_including_penalties"
      expr: SUM(CAST(total_due AS DOUBLE))
      comment: "Total amount due including penalties across all delinquency notices — used to assess full collection exposure."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts assessed on delinquent accounts — used to track penalty revenue and evaluate penalty policy effectiveness."
    - name: "avg_amount_due"
      expr: AVG(CAST(amount_due AS DOUBLE))
      comment: "Average delinquent amount per notice — used to benchmark delinquency magnitude and segment collection strategy."
    - name: "legal_action_count"
      expr: COUNT(CASE WHEN legal_action_flag = TRUE THEN 1 END)
      comment: "Number of delinquency cases escalated to legal action — used to monitor legal collection activity and associated costs."
    - name: "collection_agency_referral_count"
      expr: COUNT(CASE WHEN collection_agency_flag = TRUE THEN 1 END)
      comment: "Number of delinquency cases referred to collection agencies — used to track collection agency utilization and program costs."
    - name: "disputed_delinquency_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of delinquency notices under dispute — used to identify contested collection actions that may require resolution before escalation."
    - name: "distinct_accounts_delinquent"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts with delinquency notices — used to measure delinquency rate across the account portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition KPIs tracking recognized, deferred, accrued, and unbilled revenue by period, service type, and revenue class. Used by Finance and Accounting to ensure GAAP/GASB revenue recognition compliance and monitor revenue timing."
  source: "`vibe_water_utilities_v1`.`billing`.`revenue_recognition_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of revenue recognition event (e.g., Recognition, Deferral, Accrual, Reversal) — primary dimension for revenue accounting analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the revenue recognition event (e.g., Pending, Posted, Reversed) — used to monitor recognition pipeline."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Revenue recognition status (e.g., Recognized, Deferred, Accrued, Unbilled) — primary dimension for revenue timing analysis."
    - name: "revenue_class"
      expr: revenue_class
      comment: "Revenue class (e.g., Water, Wastewater, Stormwater, Miscellaneous) — used to segment recognized revenue by service type."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the revenue event — used to attribute revenue to specific utility services."
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge being recognized (e.g., Volumetric, Fixed, Surcharge) — used to analyze revenue composition."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the revenue recognition event — used for annual revenue reporting and budget variance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the revenue recognition event — used for period-level revenue accrual and reconciliation."
    - name: "recognition_date_month"
      expr: DATE_TRUNC('month', recognition_date)
      comment: "Month revenue was recognized — enables monthly revenue trend analysis and period-over-period comparisons."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the event was posted to the general ledger — used for GL reconciliation and period close analysis."
    - name: "regulatory_reporting_category"
      expr: regulatory_reporting_category
      comment: "Regulatory reporting category for the revenue — used to segment revenue for FERC, state PUC, or other regulatory filings."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating this is a revenue reversal event — used to monitor revenue correction activity."
    - name: "adjustment_indicator"
      expr: adjustment_indicator
      comment: "Flag indicating this event is an adjustment to prior recognized revenue — used to track revenue restatement activity."
  measures:
    - name: "total_revenue_events"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events — baseline volume metric for revenue accounting activity monitoring."
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognized in the period — primary revenue KPI used in financial statements and regulatory rate filings."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total deferred revenue balance — used to monitor revenue timing and GAAP/GASB deferred revenue liability."
    - name: "total_accrued_revenue"
      expr: SUM(CAST(accrued_revenue_amount AS DOUBLE))
      comment: "Total accrued (unbilled earned) revenue — used to ensure complete revenue recognition for services rendered but not yet billed."
    - name: "total_unbilled_revenue"
      expr: SUM(CAST(unbilled_revenue_amount AS DOUBLE))
      comment: "Total unbilled revenue — used to track revenue earned but not yet invoiced, critical for period-end close accuracy."
    - name: "total_revenue_amount"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total gross revenue amount across all recognition events — used as the top-line revenue figure in financial reporting."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount processed through revenue recognition — used to reconcile billing transactions to recognized revenue."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between expected and recognized revenue — used to identify revenue recognition discrepancies requiring investigation."
    - name: "total_consumption_volume"
      expr: SUM(CAST(consumption_volume AS DOUBLE))
      comment: "Total consumption volume associated with recognized revenue — used to reconcile revenue per unit and validate rate application."
    - name: "avg_recognized_revenue_per_event"
      expr: AVG(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Average recognized revenue per event — used to benchmark revenue event magnitude and detect anomalies."
    - name: "reversal_event_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of revenue reversal events — used to monitor revenue restatement activity and accounting correction rates."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_assistance_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assistance program enrollment KPIs tracking program participation, benefit utilization, arrearage forgiveness, and income eligibility. Used by Customer Service and Finance leadership to monitor affordability program performance and regulatory compliance."
  source: "`vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the assistance enrollment (e.g., Active, Pending, Terminated, Expired) — primary dimension for program portfolio management."
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of assistance benefit (e.g., Discount, Arrearage Forgiveness, LIHEAP, CAP) — used to segment program utilization by benefit type."
    - name: "eligibility_basis"
      expr: eligibility_basis
      comment: "Basis for eligibility determination (e.g., Income, Categorical, Disability) — used to analyze enrollment by eligibility pathway."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment was completed (e.g., Online, Phone, In-person, Partner Agency) — used to optimize enrollment outreach."
    - name: "income_verification_status"
      expr: income_verification_status
      comment: "Status of income verification for the enrollment — used to monitor compliance with eligibility verification requirements."
    - name: "auto_recertification_eligible"
      expr: auto_recertification_eligible
      comment: "Flag indicating eligibility for automatic recertification — used to track auto-recertification program adoption."
    - name: "special_needs_indicator"
      expr: special_needs_indicator
      comment: "Flag indicating the customer has special needs (e.g., medical baseline, life support) — used to ensure appropriate service protections."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment — enables monthly enrollment trend analysis and program growth tracking."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the enrollment became effective — used for annual program participation reporting."
    - name: "categorical_program_name"
      expr: categorical_program_name
      comment: "Name of the categorical assistance program (e.g., SNAP, Medicaid) — used to analyze enrollment by qualifying program."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of assistance program enrollments — baseline metric for affordability program reach and participation."
    - name: "total_monthly_credit_amount"
      expr: SUM(CAST(monthly_credit_amount AS DOUBLE))
      comment: "Total monthly credit amount across all active enrollments — used to project monthly program cost and budget impact."
    - name: "total_current_year_benefit_amount"
      expr: SUM(CAST(current_year_benefit_amount AS DOUBLE))
      comment: "Total benefits disbursed in the current year — used to track program expenditure against annual budget."
    - name: "total_cumulative_benefit_amount"
      expr: SUM(CAST(cumulative_benefit_amount AS DOUBLE))
      comment: "Total lifetime benefits disbursed across all enrollments — used to assess total program investment and long-term affordability impact."
    - name: "total_arrearage_forgiveness_balance"
      expr: SUM(CAST(arrearage_forgiveness_balance AS DOUBLE))
      comment: "Total arrearage forgiveness balance outstanding — used to monitor arrearage forgiveness program liability and collection risk offset."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across enrolled accounts — used to benchmark program generosity and compare against rate case assumptions."
    - name: "avg_annual_household_income"
      expr: AVG(CAST(annual_household_income AS DOUBLE))
      comment: "Average annual household income of enrolled customers — used to assess program targeting effectiveness and income eligibility thresholds."
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average federal poverty level percentage of enrolled customers — used to monitor program income targeting and regulatory compliance."
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Number of currently active assistance enrollments — used to track program participation rate and affordability program reach."
    - name: "distinct_accounts_enrolled"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts enrolled in assistance programs — used to measure program penetration across the customer base."
    - name: "avg_annual_benefit_cap"
      expr: AVG(CAST(annual_benefit_cap AS DOUBLE))
      comment: "Average annual benefit cap per enrollment — used to assess program design and ensure caps align with customer need."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing cycle KPIs tracking billing throughput, financial totals by cycle, and cycle performance. Used by Billing Operations to monitor cycle execution, revenue totals, and billing schedule adherence."
  source: "`vibe_water_utilities_v1`.`billing`.`billing_cycle`"
  dimensions:
    - name: "billing_cycle_status"
      expr: billing_cycle_status
      comment: "Current status of the billing cycle (e.g., Open, Processing, Closed, Cancelled) — primary dimension for cycle pipeline management."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of billing cycle (e.g., Regular, Final, Supplemental) — used to segment cycle activity by type."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of the billing cycle (e.g., Monthly, Bi-monthly, Quarterly) — used to analyze billing cadence distribution."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Month the billing period starts — enables monthly billing cycle trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month payment is due for the cycle — used for cash flow forecasting."
    - name: "late_fee_applied"
      expr: late_fee_applied
      comment: "Flag indicating late fees were applied in this cycle — used to monitor late fee assessment rates."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the billing cycle — used to track cycle-level collection performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing cycle — used for multi-currency billing reporting."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory associated with the billing cycle — used to segment billing performance by geographic territory."
  measures:
    - name: "total_billing_cycles"
      expr: COUNT(1)
      comment: "Total number of billing cycles — baseline volume metric for billing operations throughput monitoring."
    - name: "total_cycle_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total billed amount across all billing cycles — used to track aggregate billing volume by cycle period."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after discounts — used to track net revenue by billing cycle."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts billed across cycles — used for tax liability reporting by billing period."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across billing cycles — used to monitor discount program cost and rate schedule compliance."
    - name: "avg_cycle_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average billed amount per billing cycle — used to benchmark cycle-level billing volume and detect anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_rate_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate tier KPIs tracking tiered rate structure configuration, consumption thresholds, and rate levels. Used by Rate Design and Regulatory Affairs to monitor rate tier structure, conservation pricing effectiveness, and rate schedule compliance."
  source: "`vibe_water_utilities_v1`.`billing`.`rate_tier`"
  dimensions:
    - name: "rate_tier_status"
      expr: rate_tier_status
      comment: "Current status of the rate tier (e.g., Active, Superseded, Draft) — used to filter for currently effective rate tiers."
    - name: "tier_type"
      expr: tier_type
      comment: "Type of rate tier (e.g., Inclining Block, Declining Block, Flat, Seasonal) — used to analyze rate structure design across schedules."
    - name: "tier_code"
      expr: tier_code
      comment: "Code identifying the tier within a rate schedule — used to compare tier configurations across rate schedules."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for consumption thresholds (e.g., CCF, Gallons, HCF) — used to ensure consistent rate comparison."
    - name: "surcharge_applicable"
      expr: surcharge_applicable
      comment: "Flag indicating a surcharge applies at this tier — used to track surcharge tier prevalence across rate schedules."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating this tier is tax-exempt — used for tax liability analysis by rate tier."
    - name: "effective_from_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the rate tier became effective — used to track rate tier changes over time."
    - name: "billing_rate_schedule_id"
      expr: billing_rate_schedule_id
      comment: "Rate schedule this tier belongs to — used to group and compare tiers within a rate schedule."
  measures:
    - name: "total_rate_tiers"
      expr: COUNT(1)
      comment: "Total number of rate tiers defined — used to monitor rate structure complexity across all rate schedules."
    - name: "avg_rate_per_unit"
      expr: AVG(CAST(rate_per_unit AS DOUBLE))
      comment: "Average rate per unit across all tiers — used to benchmark pricing levels and compare against cost-of-service studies."
    - name: "avg_fixed_charge"
      expr: AVG(CAST(fixed_charge AS DOUBLE))
      comment: "Average fixed charge component across rate tiers — used to analyze fixed vs. variable revenue balance in rate design."
    - name: "avg_consumption_max"
      expr: AVG(CAST(consumption_max AS DOUBLE))
      comment: "Average upper consumption threshold across tiers — used to assess tier boundary design and conservation pricing effectiveness."
    - name: "avg_surcharge_amount"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average surcharge amount across applicable tiers — used to monitor surcharge levels and their revenue contribution."
    - name: "distinct_rate_schedules_with_tiers"
      expr: COUNT(DISTINCT billing_rate_schedule_id)
      comment: "Number of distinct rate schedules that have defined tiers — used to track rate schedule completeness and tiered pricing adoption."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan KPIs tracking plan enrollment, balance management, installment performance, and plan completion rates. Used by Collections and Customer Service to monitor payment arrangement effectiveness and delinquency resolution."
  source: "`vibe_water_utilities_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g., Active, Broken, Completed, Cancelled) — primary dimension for plan portfolio management."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (e.g., Standard, Hardship, LIHEAP, Arrearage) — used to segment plan performance by program type."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g., Monthly, Bi-weekly, Weekly) — used to analyze payment arrangement structures."
    - name: "liheap_eligible"
      expr: liheap_eligible
      comment: "Flag indicating LIHEAP eligibility — used to track LIHEAP-linked payment plan enrollment."
    - name: "plan_start_date_month"
      expr: DATE_TRUNC('month', plan_start_date)
      comment: "Month the payment plan started — enables monthly plan enrollment trend analysis."
    - name: "plan_end_date_month"
      expr: DATE_TRUNC('month', plan_end_date)
      comment: "Month the payment plan is scheduled to end — used for plan maturity and completion forecasting."
  measures:
    - name: "total_payment_plans"
      expr: COUNT(1)
      comment: "Total number of payment plans — baseline volume metric for payment arrangement program monitoring."
    - name: "total_enrolled_balance"
      expr: SUM(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Total balance enrolled in payment plans — primary KPI for payment plan portfolio size and associated collection risk."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total outstanding balance remaining on active payment plans — used to track payment plan collection progress."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at plan enrollment — used to assess upfront collection from payment plan customers."
    - name: "avg_installment_amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average monthly installment amount per plan — used to benchmark payment plan affordability and design."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active payment plans — used to monitor active payment arrangement portfolio."
    - name: "broken_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Broken' THEN 1 END)
      comment: "Number of broken payment plans — used to monitor plan default rates and evaluate plan design effectiveness."
    - name: "completed_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Completed' THEN 1 END)
      comment: "Number of successfully completed payment plans — used to measure payment plan success rate."
    - name: "plan_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN plan_status IN ('Completed', 'Broken') THEN 1 END), 0), 2)
      comment: "Percentage of closed payment plans that were successfully completed vs. broken — key collections effectiveness KPI used to evaluate payment arrangement program performance."
    - name: "distinct_accounts_on_plans"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts with payment plans — used to measure payment plan program reach across the delinquent portfolio."
$$;