-- Metric views for domain: billing | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial performance metrics tracking billed revenue, outstanding balances, discount impact, and payment status across the billing cycle. Used by Finance and Revenue Operations to monitor order-to-cash health."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., Draft, Sent, Paid, Void, Disputed) for pipeline segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the invoice for multi-currency revenue analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g., Net 30, Net 60) to analyze DSO by terms bucket."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of invoice issuance for trend and seasonality analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month the billing period begins, used to align revenue to service delivery period."
    - name: "proration_flag"
      expr: proration_flag
      comment: "Indicates whether the invoice includes prorated charges, useful for mid-cycle change analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, Credit Card, Wire) for payment mix analysis."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total gross amount billed across all invoices. Primary revenue throughput KPI for Finance leadership."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Sum of all unpaid invoice balances. Drives AR aging and collections prioritization."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected against invoices. Measures payment conversion effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across invoices. Monitors discount leakage and pricing discipline."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on invoices. Required for tax liability reporting and compliance."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-issuance adjustments applied to invoices. Signals billing accuracy issues when elevated."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing operations throughput."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice value. Tracks deal size trends and revenue concentration risk."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount collected. Core cash conversion efficiency KPI for CFO reporting."
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal. Measures pricing discipline and discount policy adherence."
    - name: "outstanding_rate"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(total_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount still outstanding. Key AR health indicator for collections teams."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection and cash application metrics tracking payment volumes, failure rates, and refund activity. Used by Treasury and Revenue Operations to manage cash flow and payment processing efficiency."
  source: "`vibe_media_broadcasting_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Pending, Settled, Failed, Reversed) for pipeline health monitoring."
    - name: "method_type"
      expr: method_type
      comment: "Payment method type (e.g., ACH, Credit Card, Check, Wire) for payment mix and cost analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment receipt for cash flow trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the payment for multi-currency cash management."
    - name: "is_autopay"
      expr: is_autopay
      comment: "Whether the payment was collected via autopay. Measures autopay adoption and its impact on collection rates."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether the payment is under dispute. Flags contested cash for AR risk management."
    - name: "gateway"
      expr: gateway
      comment: "Payment gateway used for processing. Enables gateway performance and cost benchmarking."
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received (e.g., Online, Phone, Mail) for channel mix analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross payment amount received. Primary cash inflow KPI for Treasury and CFO reporting."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices. Measures cash application completeness and AR clearance."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices. Elevated unapplied cash signals cash application backlog."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued against payments. Tracks refund liability and customer satisfaction issues."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed. Baseline volume metric for payment operations."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment transaction size. Tracks payment behavior and customer segment value."
    - name: "application_rate"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash applied to invoices. Measures cash application efficiency; low rates indicate AR processing delays."
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Refunds as a percentage of total payments. Elevated rates signal billing errors or customer dissatisfaction."
    - name: "disputed_payment_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of payments currently under dispute. Tracks dispute volume for risk and collections management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute resolution performance metrics tracking dispute volumes, financial exposure, resolution efficiency, and SLA compliance. Used by Revenue Operations and Finance to manage billing quality and customer satisfaction."
  source: "`vibe_media_broadcasting_v1`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., Open, In Review, Resolved, Escalated) for pipeline management."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of dispute (e.g., Billing Error, Service Issue, Pricing Dispute) for root cause analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation tier of the dispute. High escalation levels signal systemic billing quality issues."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification of the dispute. Drives process improvement and error reduction initiatives."
    - name: "priority"
      expr: priority
      comment: "Dispute priority level for workload management and SLA compliance tracking."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the dispute was opened for trend and seasonality analysis."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final outcome of resolved disputes (e.g., Credit Issued, Upheld, Partial Credit) for outcome mix analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the dispute breached its SLA resolution deadline. Key service quality indicator."
    - name: "disputing_party_type"
      expr: disputing_party_type
      comment: "Type of party raising the dispute (e.g., Advertiser, Subscriber, Partner) for segment-level analysis."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute. Primary risk exposure KPI for Finance and Revenue Operations leadership."
    - name: "total_credit_amount_issued"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credits issued to resolve disputes. Measures financial concession cost of billing errors."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised. Baseline volume metric for billing quality monitoring."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of currently open disputes. Tracks active AR risk exposure and collections workload."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes that breached their SLA resolution deadline. Drives SLA compliance improvement."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes breaching SLA. Key service quality KPI for operations leadership."
    - name: "credit_memo_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_memo_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes resulting in a credit memo. Measures billing error concession rate."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average financial value per dispute. Tracks dispute severity trends and financial risk concentration."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo issuance and financial impact metrics tracking credit volumes, recovery rates, and write-off exposure. Used by Finance and Revenue Operations to manage billing corrections and revenue leakage."
  source: "`vibe_media_broadcasting_v1`.`billing`.`credit_memo`"
  dimensions:
    - name: "credit_memo_status"
      expr: credit_memo_status
      comment: "Current status of the credit memo (e.g., Draft, Approved, Applied, Void) for pipeline management."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the credit memo issuance. Drives root cause analysis of billing errors and service failures."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the credit memo for multi-currency financial reporting."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the credit memo was issued for trend analysis of billing correction activity."
    - name: "bad_debt_write_off_flag"
      expr: bad_debt_write_off_flag
      comment: "Whether the credit memo is associated with a bad debt write-off. Flags credit memos with P&L impact."
    - name: "collection_agency_referral_flag"
      expr: collection_agency_referral_flag
      comment: "Whether the account was referred to a collection agency. Tracks escalation to external collections."
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total gross credit amount issued. Primary revenue leakage KPI for Finance and billing quality management."
    - name: "total_net_credit_amount"
      expr: SUM(CAST(net_credit_amount AS DOUBLE))
      comment: "Total net credit after tax adjustments. Measures actual P&L impact of billing corrections."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered after credit memo issuance. Measures collections effectiveness on credited balances."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of credit memos. Required for tax liability adjustment reporting."
    - name: "credit_memo_count"
      expr: COUNT(1)
      comment: "Total number of credit memos issued. Baseline volume metric for billing error frequency monitoring."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit memo value. Tracks severity of billing corrections and financial concession trends."
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of credited amounts subsequently recovered. Measures collections effectiveness on disputed balances."
    - name: "bad_debt_credit_count"
      expr: COUNT(CASE WHEN bad_debt_write_off_flag = TRUE THEN 1 END)
      comment: "Number of credit memos associated with bad debt write-offs. Tracks uncollectable revenue exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off metrics tracking financial loss from uncollectable receivables, recovery performance, and EBITDA impact. Used by CFO and Finance leadership to manage credit risk and bad debt provisioning."
  source: "`vibe_media_broadcasting_v1`.`billing`.`write_off`"
  dimensions:
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the write-off (e.g., Bankruptcy, Uncollectable, Fraud). Drives credit risk root cause analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the write-off for annual bad debt expense reporting and budget variance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the write-off for period-level P&L impact tracking."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Calendar month of write-off for trend analysis of bad debt activity."
    - name: "ebitda_impact_flag"
      expr: ebitda_impact_flag
      comment: "Whether the write-off has a direct EBITDA impact. Flags material write-offs for executive reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the write-off was subsequently reversed. Tracks write-off quality and accounting accuracy."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category of the written-off balance for segment-level bad debt analysis."
    - name: "aging_bucket_at_write_off"
      expr: aging_bucket_at_write_off
      comment: "AR aging bucket at the time of write-off. Informs credit policy and collection timing decisions."
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross amount written off as uncollectable. Primary bad debt expense KPI for CFO and Finance leadership."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered after write-off. Measures post-write-off collections effectiveness."
    - name: "total_original_invoice_amount"
      expr: SUM(CAST(original_invoice_amount AS DOUBLE))
      comment: "Total original invoice value of written-off accounts. Provides context for write-off severity relative to original billing."
    - name: "total_outstanding_at_write_off"
      expr: SUM(CAST(outstanding_balance_at_write_off AS DOUBLE))
      comment: "Total outstanding balance at the time of write-off. Measures actual AR exposure eliminated through write-off."
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-off events. Baseline volume metric for bad debt frequency monitoring."
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of written-off amounts subsequently recovered. Key collections effectiveness KPI for Finance."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per event. Tracks severity trends and informs bad debt provisioning models."
    - name: "ebitda_impacting_write_off_amount"
      expr: SUM(CASE WHEN ebitda_impact_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total write-off amount with direct EBITDA impact. Critical for earnings quality reporting and investor communications."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_revenue_recognition_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 revenue recognition metrics tracking deferred revenue balances, recognition progress, and schedule compliance. Used by Finance and Accounting leadership to manage revenue recognition accuracy and audit readiness."
  source: "`vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of the recognition schedule (e.g., Active, Completed, Suspended) for pipeline management."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (e.g., Straight-line, Usage-based, Milestone). Drives accounting policy compliance monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of underlying contract (e.g., Advertising, Subscription, Syndication) for revenue stream segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the recognition schedule. Unapproved schedules represent audit risk."
    - name: "recognition_start_month"
      expr: DATE_TRUNC('MONTH', recognition_start_date)
      comment: "Month recognition begins for cohort and vintage analysis of revenue schedules."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit associated with the recognition schedule for segment-level revenue reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency revenue recognition reporting."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contracted revenue value across all recognition schedules. Measures total revenue backlog under ASC 606."
    - name: "total_cumulative_recognized_amount"
      expr: SUM(CAST(cumulative_recognized_amount AS DOUBLE))
      comment: "Total revenue recognized to date across all schedules. Primary revenue recognition throughput KPI."
    - name: "total_deferred_revenue_balance"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue liability outstanding. Critical balance sheet KPI for Finance and external audit."
    - name: "total_current_period_recognized"
      expr: SUM(CAST(current_period_recognized_amount AS DOUBLE))
      comment: "Revenue recognized in the current period. Drives period-level P&L reporting and forecast accuracy."
    - name: "total_monthly_recognized_amount"
      expr: SUM(CAST(monthly_recognized_amount AS DOUBLE))
      comment: "Monthly recognized revenue across all active schedules. Used for run-rate revenue forecasting."
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Total number of active recognition schedules. Baseline volume metric for revenue recognition operations."
    - name: "recognition_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(cumulative_recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value recognized to date. Measures revenue recognition progress and schedule adherence."
    - name: "deferred_revenue_ratio"
      expr: ROUND(100.0 * SUM(CAST(deferred_revenue_balance AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0), 2)
      comment: "Deferred revenue as a percentage of total contract value. Tracks revenue recognition lag and balance sheet liability concentration."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_ad_billing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising billing order financial metrics tracking billed vs contracted amounts, makegood values, and payment status for ad sales revenue. Used by Ad Sales Finance and Revenue Operations to manage advertising order-to-cash."
  source: "`vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status of the ad order (e.g., Pending, Billed, Paid, Disputed) for pipeline management."
    - name: "affidavit_status"
      expr: affidavit_status
      comment: "Status of the affidavit confirming ad spots aired. Unverified affidavits block billing completion."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the billing order for multi-currency ad revenue reporting."
    - name: "rate_basis"
      expr: rate_basis
      comment: "Pricing basis for the ad order (e.g., CPM, GRP, Flat Rate) for yield and pricing analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the ad billing order. Used for DSO analysis by advertiser segment."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the ad order was placed for trend analysis of advertising revenue bookings."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the ad flight begins for revenue period alignment and pacing analysis."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount billed for ad orders. Primary advertising revenue billing KPI for Ad Sales Finance."
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted value of ad orders. Measures revenue backlog and booking performance."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid balance on ad billing orders. Tracks AR exposure from advertising clients."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total cash collected on ad billing orders. Measures advertising cash conversion performance."
    - name: "total_makegoods_value"
      expr: SUM(CAST(makegoods_value AS DOUBLE))
      comment: "Total value of makegoods issued on ad orders. Elevated makegood values signal delivery underperformance."
    - name: "ad_billing_order_count"
      expr: COUNT(1)
      comment: "Total number of ad billing orders. Baseline volume metric for advertising billing operations."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate across ad billing orders. Tracks pricing yield and rate card effectiveness."
    - name: "avg_grp_rate"
      expr: AVG(CAST(grp_rate AS DOUBLE))
      comment: "Average GRP rate across ad billing orders. Measures audience-based pricing efficiency."
    - name: "billing_vs_contracted_rate"
      expr: ROUND(100.0 * SUM(CAST(billed_amount AS DOUBLE)) / NULLIF(SUM(CAST(contracted_amount AS DOUBLE)), 0), 2)
      comment: "Billed amount as a percentage of contracted amount. Measures billing completeness and delivery fulfillment rate."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed advertising revenue collected. Core cash conversion KPI for Ad Sales Finance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_ad_billing_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising billing reconciliation metrics tracking delivery variances, dispute rates, and makegood activity. Used by Ad Sales Finance and Traffic Operations to ensure billing accuracy and resolve delivery discrepancies."
  source: "`vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation (e.g., Pending, In Progress, Completed, Disputed) for workflow management."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g., Affidavit, Makegood, Variance) for process segmentation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the reconciliation has an active dispute. Flags records requiring resolution attention."
    - name: "affidavit_verification_status"
      expr: affidavit_verification_status
      comment: "Status of affidavit verification for the reconciliation. Unverified affidavits block billing finalization."
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', reconciliation_date)
      comment: "Month of reconciliation completion for trend analysis of billing accuracy."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency reconciliation reporting."
  measures:
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted value being reconciled. Baseline for measuring delivery fulfillment."
    - name: "total_delivered_amount"
      expr: SUM(CAST(delivered_amount AS DOUBLE))
      comment: "Total value of advertising actually delivered. Measures delivery performance against contracted commitments."
    - name: "total_net_billable_amount"
      expr: SUM(CAST(net_billable_amount AS DOUBLE))
      comment: "Total net billable amount after reconciliation adjustments. Drives final invoice generation."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied during reconciliation. Elevated adjustments signal systematic delivery or billing issues."
    - name: "total_makegood_value"
      expr: SUM(CAST(makegood_value_amount AS DOUBLE))
      comment: "Total makegood value issued during reconciliation. Measures cost of delivery underperformance."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of reconciliation records. Baseline volume metric for billing operations throughput."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average delivery variance percentage across reconciliations. Key billing accuracy KPI for Traffic and Finance."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations with active disputes. Measures billing quality and client satisfaction."
    - name: "delivery_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(delivered_amount AS DOUBLE)) / NULLIF(SUM(CAST(contracted_amount AS DOUBLE)), 0), 2)
      comment: "Delivered amount as a percentage of contracted amount. Core advertising delivery performance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_subscription_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription billing metrics tracking recurring revenue, churn risk, payment performance, and promotional discount impact. Used by Subscriber Finance and Product leadership to manage subscription revenue health."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency subscription revenue reporting."
  measures:
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected from subscription invoices. Measures subscription cash conversion performance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on subscription invoices. Required for tax liability reporting."
    - name: "subscription_invoice_count"
      expr: COUNT(1)
      comment: "Total number of subscription invoices generated. Baseline volume metric for subscription billing operations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account health and financial position metrics tracking account balances, credit utilization, and dunning status. Used by Finance and Collections leadership to manage customer account risk and AR portfolio health."
  source: "`vibe_media_broadcasting_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g., Active, Suspended, Closed) for portfolio health segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., Advertiser, Subscriber, Partner) for segment-level financial analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level. High dunning levels indicate collections risk concentration."
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Invoice delivery method for digital adoption and operational cost analysis."
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Billing currency of the account for multi-currency AR portfolio analysis."
    - name: "auto_pay_enabled_flag"
      expr: auto_pay_enabled_flag
      comment: "Whether autopay is enabled. Autopay accounts typically have lower DSO and collection costs."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the account is tax-exempt. Required for tax compliance and revenue reporting."
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month the billing account was opened for cohort analysis of account aging and performance."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total outstanding balance across all billing accounts. Primary AR portfolio exposure KPI for Finance leadership."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all billing accounts. Measures credit risk exposure and policy adherence."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent payments across accounts. Tracks recent cash collection activity."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts. Baseline volume metric for customer base size."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of active billing accounts. Tracks active customer base for revenue capacity planning."
    - name: "autopay_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_pay_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts with autopay enabled. Higher autopay rates reduce DSO and collection costs."
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(current_balance_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "Current balance as a percentage of credit limit. Measures credit risk concentration across the AR portfolio."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance_amount AS DOUBLE))
      comment: "Average outstanding balance per billing account. Tracks account-level AR exposure trends."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund processing metrics tracking refund volumes, net refund amounts, chargeback activity, and processing efficiency. Used by Finance and Customer Operations to manage refund liability and payment processing quality."
  source: "`vibe_media_broadcasting_v1`.`billing`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (e.g., Pending, Processed, Settled, Failed) for pipeline management."
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (e.g., Full, Partial, Chargeback) for refund mix and liability analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund. Drives root cause analysis of billing errors and service failures."
    - name: "method"
      expr: method
      comment: "Refund method (e.g., Original Payment Method, Check, Credit) for operational cost analysis."
    - name: "is_chargeback_related"
      expr: is_chargeback_related
      comment: "Whether the refund is related to a chargeback. Chargeback-related refunds carry additional processing costs and risk."
    - name: "is_partial_refund"
      expr: is_partial_refund
      comment: "Whether the refund is partial. Partial refunds may indicate negotiated settlements."
    - name: "refund_month"
      expr: DATE_TRUNC('MONTH', processing_date)
      comment: "Month the refund was processed for trend analysis of refund activity."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the refund for multi-currency liability reporting."
  measures:
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross refund amount issued. Primary refund liability KPI for Finance and Customer Operations."
    - name: "total_net_refund_amount"
      expr: SUM(CAST(net_refund_amount AS DOUBLE))
      comment: "Total net refund amount after fees. Measures actual cash outflow from refund activity."
    - name: "total_refund_fee"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total fees incurred on refund processing. Tracks payment processing cost of refund activity."
    - name: "refund_count"
      expr: COUNT(1)
      comment: "Total number of refunds processed. Baseline volume metric for refund operations."
    - name: "chargeback_refund_count"
      expr: COUNT(CASE WHEN is_chargeback_related = TRUE THEN 1 END)
      comment: "Number of chargeback-related refunds. Elevated chargeback counts signal fraud risk or billing quality issues."
    - name: "chargeback_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_chargeback_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds that are chargeback-related. Key payment risk KPI; high rates trigger payment processor penalties."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction. Tracks refund severity trends and financial exposure per event."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_syndication_license_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Syndication license fee payment metrics tracking fee collection, withholding tax, and payment status for content licensing revenue. Used by Rights Finance and Business Affairs to manage syndication revenue and partner payment compliance."
  source: "`vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the syndication license fee (e.g., Pending, Paid, Overdue) for collections management."
    - name: "license_window_type"
      expr: license_window_type
      comment: "Type of license window (e.g., Exclusive, Non-exclusive, First-run) for revenue mix analysis."
    - name: "license_territory"
      expr: license_territory
      comment: "Geographic territory of the license for regional revenue analysis and rights management."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment schedule type (e.g., Lump Sum, Installment) for cash flow forecasting."
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Revenue recognition status for ASC 606 compliance monitoring of syndication revenue."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency syndication revenue reporting."
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', license_start_date)
      comment: "Month the license period begins for revenue cohort and vintage analysis."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the syndication deal for segment-level revenue attribution."
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total syndication license fee revenue. Primary content licensing revenue KPI for Rights Finance and Business Affairs."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after withholding tax. Measures actual cash received from syndication partners."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from syndication payments. Required for international tax compliance reporting."
    - name: "syndication_fee_count"
      expr: COUNT(1)
      comment: "Total number of syndication license fee records. Baseline volume metric for licensing operations."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average syndication license fee per record. Tracks deal size trends and licensing yield."
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate across syndication fees. Monitors international tax burden on licensing revenue."
    - name: "net_to_gross_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(fee_amount AS DOUBLE)), 0), 2)
      comment: "Net payment as a percentage of gross fee. Measures effective withholding tax burden on syndication revenue."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing product catalog metrics tracking product pricing, promotional mix, and revenue recognition configuration. Used by Product Finance and Pricing teams to manage product portfolio economics and billing system configuration."
  source: "`vibe_media_broadcasting_v1`.`billing`.`billing_product`"
  dimensions:
    - name: "billing_product_status"
      expr: billing_product_status
      comment: "Current status of the billing product (e.g., Active, Deprecated, Pending) for catalog health monitoring."
    - name: "product_type"
      expr: product_type
      comment: "Type of billing product (e.g., Subscription, Ad Spot, License) for revenue mix analysis."
    - name: "product_category"
      expr: product_category
      comment: "Product category for portfolio segmentation and pricing strategy analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (e.g., Monthly, Annual, One-time) for recurring vs. one-time revenue mix analysis."
    - name: "revenue_recognition_rule"
      expr: revenue_recognition_rule
      comment: "ASC 606 revenue recognition rule applied to the product. Ensures accounting policy compliance."
    - name: "is_bundled"
      expr: is_bundled
      comment: "Whether the product is part of a bundle. Bundle products require special revenue allocation treatment."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Whether the product is a promotional offering. Tracks promotional product mix and margin impact."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Whether the product is subject to tax. Required for tax liability calculation and compliance."
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the product was launched for product lifecycle and vintage analysis."
  measures:
    - name: "total_base_price"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Sum of base prices across billing products. Measures total catalog pricing value for portfolio analysis."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across billing products. Tracks pricing level trends and portfolio value positioning."
    - name: "product_count"
      expr: COUNT(1)
      comment: "Total number of billing products in the catalog. Baseline metric for product portfolio size management."
    - name: "active_product_count"
      expr: COUNT(CASE WHEN billing_product_status = 'Active' THEN 1 END)
      comment: "Number of active billing products. Tracks active catalog size for revenue capacity and complexity management."
    - name: "promotional_product_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_promotional = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of products that are promotional. High promotional mix may signal margin pressure."
    - name: "bundled_product_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bundled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of products that are bundled. Tracks bundle strategy adoption and revenue allocation complexity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_dunning_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning and collections effectiveness metrics tracking recovery rates, service suspension activity, and churn risk from delinquent accounts. Used by Collections and Finance leadership to optimize dunning strategy and minimize bad debt."
  source: "`vibe_media_broadcasting_v1`.`billing`.`dunning_event`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of dunning action taken (e.g., Email, SMS, Suspension, Write-off) for strategy effectiveness analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the dunning action (e.g., Payment Received, No Response, Escalated) for conversion analysis."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for dunning communication (e.g., Email, SMS, Phone) for channel effectiveness benchmarking."
    - name: "dunning_step_number"
      expr: dunning_step_number
      comment: "Step number in the dunning sequence. Higher steps indicate more severe delinquency."
    - name: "service_suspension_flag"
      expr: service_suspension_flag
      comment: "Whether service was suspended as part of the dunning action. Tracks suspension rate and churn risk."
    - name: "account_termination_flag"
      expr: account_termination_flag
      comment: "Whether the account was terminated during dunning. Measures churn resulting from collections activity."
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_timestamp)
      comment: "Month the dunning action was taken for trend analysis of collections activity."
  measures:
    - name: "total_amount_recovered"
      expr: SUM(CAST(amount_recovered AS DOUBLE))
      comment: "Total cash recovered through dunning actions. Primary collections effectiveness KPI for Finance leadership."
    - name: "total_account_balance_at_action"
      expr: SUM(CAST(account_balance_at_action AS DOUBLE))
      comment: "Total delinquent balance at the time of dunning action. Measures collections workload and AR risk exposure."
    - name: "dunning_event_count"
      expr: COUNT(1)
      comment: "Total number of dunning events executed. Baseline volume metric for collections operations."
    - name: "service_suspension_count"
      expr: COUNT(CASE WHEN service_suspension_flag = TRUE THEN 1 END)
      comment: "Number of dunning events resulting in service suspension. Tracks escalation rate and churn risk."
    - name: "account_termination_count"
      expr: COUNT(CASE WHEN account_termination_flag = TRUE THEN 1 END)
      comment: "Number of accounts terminated during dunning. Measures churn directly attributable to collections escalation."
    - name: "response_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dunning actions that received a customer response. Measures dunning communication effectiveness."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score at time of dunning action. Tracks risk profile of delinquent accounts."
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_recovered AS DOUBLE)) / NULLIF(SUM(CAST(account_balance_at_action AS DOUBLE)), 0), 2)
      comment: "Percentage of delinquent balance recovered through dunning. Core collections efficiency KPI for Finance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_tax_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax liability and compliance metrics tracking tax amounts, remittance status, and exemption rates. Used by Tax and Finance leadership to manage tax compliance, remittance obligations, and audit readiness."
  source: "`vibe_media_broadcasting_v1`.`billing`.`tax_record`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., Sales Tax, VAT, Withholding) for tax liability segmentation and compliance reporting."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category for detailed tax classification and jurisdiction reporting."
    - name: "tax_jurisdiction_name"
      expr: tax_jurisdiction_name
      comment: "Tax jurisdiction name for geographic tax liability analysis and nexus management."
    - name: "nexus_country"
      expr: nexus_country
      comment: "Country of tax nexus for international tax compliance and transfer pricing analysis."
    - name: "nexus_state_province"
      expr: nexus_state_province
      comment: "State or province of tax nexus for state-level tax liability and remittance tracking."
    - name: "remittance_status"
      expr: remittance_status
      comment: "Current remittance status (e.g., Pending, Remitted, Overdue) for tax payment compliance monitoring."
    - name: "tax_exemption_flag"
      expr: tax_exemption_flag
      comment: "Whether the transaction is tax-exempt. Tracks exemption rate and certificate compliance."
    - name: "reverse_charge_flag"
      expr: reverse_charge_flag
      comment: "Whether reverse charge VAT applies. Required for EU VAT compliance reporting."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the taxable transaction for period-level tax liability reporting."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across all tax records. Primary tax compliance KPI for Tax and Finance leadership."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable transaction value. Baseline for effective tax rate calculation and nexus analysis."
    - name: "tax_record_count"
      expr: COUNT(1)
      comment: "Total number of tax records. Baseline volume metric for tax compliance operations."
    - name: "effective_tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate across all taxable transactions. Measures actual tax burden vs. statutory rates for tax planning."
    - name: "tax_exemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tax_exemption_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are tax-exempt. Monitors exemption certificate compliance and revenue impact."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied across transactions. Tracks blended tax rate trends by jurisdiction and product mix."
    - name: "disputed_tax_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of tax records under dispute. Tracks tax dispute exposure and audit risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing line item financial metrics tracking line-level revenue, rate performance, and consumption patterns for content licensing. Used by Finance and Rights teams to manage content monetization and cost center allocation."
  source: "`vibe_media_broadcasting_v1`.`billing`.`billing_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the billing line (e.g., Active, Cancelled, Disputed) for revenue pipeline management."
    - name: "license_window_type"
      expr: license_window_type
      comment: "Type of license window (e.g., Exclusive, Non-exclusive) for revenue mix and rights utilization analysis."
    - name: "territory_code"
      expr: territory_code
      comment: "Geographic territory code for regional revenue attribution and rights compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency billing line reporting."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month the billing period begins for period-level revenue analysis."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total revenue from billing lines. Primary content licensing revenue KPI for Rights Finance."
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total units consumed across billing lines. Measures content utilization and consumption-based revenue drivers."
    - name: "billing_line_count"
      expr: COUNT(1)
      comment: "Total number of billing lines. Baseline volume metric for content licensing billing operations."
    - name: "avg_rate_per_unit"
      expr: AVG(CAST(rate_per_unit AS DOUBLE))
      comment: "Average rate per unit across billing lines. Tracks pricing yield for content licensing."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across billing lines. Monitors partner revenue share economics."
    - name: "avg_line_amount"
      expr: AVG(CAST(line_amount AS DOUBLE))
      comment: "Average billing line value. Tracks deal size trends for content licensing agreements."
$$;