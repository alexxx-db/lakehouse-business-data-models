-- Metric views for domain: billing | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice KPIs for AR health, collections, and revenue realization across the broadcaster billing portfolio."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Lifecycle status of the invoice (draft, issued, paid, void, disputed) for AR aging and collections analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice for multi-currency revenue reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (e.g. NET30) for collection performance segmentation."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of invoice issuance for trended billing volume."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Calendar month the invoice is due for cash-flow forecasting."
  measures:
    - name: "Total Invoiced Amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total billed amount due across invoices; headline revenue billing KPI for steering committees."
    - name: "Total Amount Paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected against invoices; drives collections performance review."
    - name: "Total Outstanding Balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total open AR balance; key liquidity and collections risk metric."
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed for compliance and remittance reconciliation."
    - name: "Total Discount Amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted; margin leakage indicator."
    - name: "Invoice Count"
      expr: COUNT(1)
      comment: "Number of invoices issued; billing throughput baseline."
    - name: "Average Invoice Value"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice size; pricing and account mix indicator."
    - name: "Distinct Billed Accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Distinct accounts billed; revenue concentration and active-customer measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing KPIs for cash collection velocity, gateway performance, and dispute exposure."
  source: "`vibe_media_broadcasting_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (settled, failed, reversed) for collection success analysis."
    - name: "method_type"
      expr: method_type
      comment: "Payment instrument type (card, ACH, check) for channel mix and fee optimization."
    - name: "gateway"
      expr: gateway
      comment: "Payment gateway used for processor performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency for multi-currency cash reporting."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash inflow trending."
  measures:
    - name: "Total Payment Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment value processed; headline cash collection KPI."
    - name: "Total Applied Amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Payment value applied to invoices; cash-application efficiency input."
    - name: "Total Unapplied Amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Unapplied cash sitting on accounts; operational backlog and risk metric."
    - name: "Total Refund Amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Refunds processed against payments; revenue leakage and customer-experience indicator."
    - name: "Payment Count"
      expr: COUNT(1)
      comment: "Number of payment transactions; processing throughput baseline."
    - name: "Disputed Payment Count"
      expr: COUNT(DISTINCT CASE WHEN is_disputed = TRUE THEN payment_id END)
      comment: "Count of disputed payments; chargeback and revenue-risk exposure."
    - name: "Average Payment Amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment size; helps detect collection pattern shifts."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio KPIs for credit exposure, AR balance, and account health."
  source: "`vibe_media_broadcasting_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Account lifecycle status (active, suspended, closed) for portfolio health."
    - name: "account_type"
      expr: account_type
      comment: "Account type (advertiser, subscriber, partner) for segment-level credit analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning stage indicating delinquency severity."
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Account billing currency for multi-currency exposure reporting."
  measures:
    - name: "Total Current Balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Aggregate open balance across accounts; portfolio-level AR exposure."
    - name: "Total Credit Limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total extended credit; credit-risk capacity metric."
    - name: "Account Count"
      expr: COUNT(1)
      comment: "Number of billing accounts; portfolio size baseline."
    - name: "Auto-Pay Enabled Accounts"
      expr: COUNT(DISTINCT CASE WHEN auto_pay_enabled_flag = TRUE THEN billing_account_id END)
      comment: "Accounts on auto-pay; collection automation and churn-risk reduction indicator."
    - name: "Average Current Balance"
      expr: AVG(CAST(current_balance_amount AS DOUBLE))
      comment: "Average open balance per account; concentration signal."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute KPIs for revenue-at-risk, SLA adherence, and dispute resolution effectiveness."
  source: "`vibe_media_broadcasting_v1`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status (open, resolved, escalated) for resolution pipeline tracking."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of dispute for root-cause analysis."
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Stated dispute reason for trend and prevention analysis."
    - name: "priority"
      expr: priority
      comment: "Dispute priority for SLA triage."
    - name: "filed_month"
      expr: DATE_TRUNC('MONTH', filed_date)
      comment: "Month the dispute was filed for inflow trending."
  measures:
    - name: "Total Disputed Amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total revenue under dispute; revenue-at-risk KPI for finance leadership."
    - name: "Total Credit Amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Credits issued to resolve disputes; revenue leakage from disputes."
    - name: "Dispute Count"
      expr: COUNT(1)
      comment: "Number of disputes filed; operational dispute volume."
    - name: "SLA Breach Count"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN billing_dispute_id END)
      comment: "Disputes that breached resolution SLA; service-quality and compliance metric."
    - name: "Credit Memo Issued Count"
      expr: COUNT(DISTINCT CASE WHEN credit_memo_issued_flag = TRUE THEN billing_dispute_id END)
      comment: "Disputes resolved via credit memo; settlement-mix indicator."
    - name: "Average Disputed Amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average dispute size; helps prioritize high-value cases."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off KPIs for bad-debt expense, recovery effectiveness, and EBITDA impact."
  source: "`vibe_media_broadcasting_v1`.`billing`.`write_off`"
  dimensions:
    - name: "reason_code"
      expr: reason_code
      comment: "Write-off reason for bad-debt root-cause analysis."
    - name: "aging_bucket_at_write_off"
      expr: aging_bucket_at_write_off
      comment: "AR aging bucket at write-off for delinquency pattern analysis."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category written off for product/segment loss attribution."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the write-off for period comparison."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month of write-off for bad-debt trending."
  measures:
    - name: "Total Write-Off Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total bad debt written off; direct hit to net revenue and EBITDA."
    - name: "Total Recovery Amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Amount recovered post write-off; collections effectiveness metric."
    - name: "Total Outstanding At Write-Off"
      expr: SUM(CAST(outstanding_balance_at_write_off AS DOUBLE))
      comment: "Outstanding balance at write-off time; loss severity baseline."
    - name: "Write-Off Count"
      expr: COUNT(1)
      comment: "Number of write-offs; bad-debt event volume."
    - name: "EBITDA Impacting Write-Off Count"
      expr: COUNT(DISTINCT CASE WHEN ebitda_impact_flag = TRUE THEN write_off_id END)
      comment: "Write-offs flagged as EBITDA-impacting; financial-reporting materiality measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line KPIs for revenue mix, GRP delivery, and discount leakage at line granularity."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service billed on the line for revenue-mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Line currency for multi-currency revenue reporting."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the line for revenue-at-risk at line level."
    - name: "service_period_month"
      expr: DATE_TRUNC('MONTH', service_period_start_date)
      comment: "Service period month for revenue recognition trending."
  measures:
    - name: "Total Line Extended Amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line revenue; granular revenue composition KPI."
    - name: "Total Line Discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total line-level discounts; margin leakage detail."
    - name: "Total GRP Delivered"
      expr: SUM(CAST(grp_delivered AS DOUBLE))
      comment: "Gross rating points delivered on ad lines; ad-fulfillment performance."
    - name: "Total Line Tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Tax charged at line level for compliance reconciliation."
    - name: "Line Count"
      expr: COUNT(1)
      comment: "Number of invoice lines; billing detail volume."
    - name: "Makegood Line Count"
      expr: COUNT(DISTINCT CASE WHEN makegood_flag = TRUE THEN invoice_line_id END)
      comment: "Lines representing makegoods; ad-delivery shortfall remediation indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_revenue_recognition_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition KPIs for deferred revenue, recognized revenue, and ASC606 compliance."
  source: "`vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Recognition status for revenue lifecycle tracking."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method of recognition (straight-line, milestone) for accounting policy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the schedule for multi-currency revenue reporting."
    - name: "next_recognition_month"
      expr: DATE_TRUNC('MONTH', next_recognition_date)
      comment: "Month of next recognition for forward revenue forecasting."
  measures:
    - name: "Total Contract Value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contracted value under recognition schedules; revenue backlog KPI."
    - name: "Total Recognized Revenue"
      expr: SUM(CAST(cumulative_recognized_amount AS DOUBLE))
      comment: "Cumulative revenue recognized; earned-revenue measure for finance."
    - name: "Total Deferred Revenue"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Deferred revenue balance; liability and future-revenue indicator."
    - name: "Current Period Recognized"
      expr: SUM(CAST(current_period_recognized_amount AS DOUBLE))
      comment: "Revenue recognized in current period; period earnings KPI."
    - name: "Schedule Count"
      expr: COUNT(1)
      comment: "Number of recognition schedules; revenue-management workload baseline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_subscription_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "D2C subscription billing KPIs for recurring revenue, churn risk, and proration impact."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Total Amount Paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Subscription cash collected; collection performance for D2C."
    - name: "Subscription Invoice Count"
      expr: COUNT(1)
      comment: "Number of subscription invoices; recurring billing volume."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_ad_billing_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad billing reconciliation KPIs for delivered-vs-contracted variance and affidavit verification."
  source: "`vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for ad-revenue close tracking."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation for process segmentation."
    - name: "affidavit_verification_status"
      expr: affidavit_verification_status
      comment: "Affidavit verification status for ad-delivery proof compliance."
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', reconciliation_date)
      comment: "Month of reconciliation for ad-revenue close trending."
  measures:
    - name: "Total Contracted Amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted ad value; basis for delivery variance analysis."
    - name: "Total Delivered Amount"
      expr: SUM(CAST(delivered_amount AS DOUBLE))
      comment: "Total delivered ad value; ad-fulfillment KPI."
    - name: "Total Net Billable Amount"
      expr: SUM(CAST(net_billable_amount AS DOUBLE))
      comment: "Net billable ad value after adjustments; realized ad revenue."
    - name: "Total Makegood Value"
      expr: SUM(CAST(makegood_value_amount AS DOUBLE))
      comment: "Value of makegoods; ad-delivery shortfall cost."
    - name: "Average Variance Percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average delivered-vs-contracted variance; ad-delivery accuracy KPI."
    - name: "Disputed Reconciliation Count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN ad_billing_reconciliation_id END)
      comment: "Reconciliations in dispute; ad-revenue risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo KPIs for revenue adjustments, bad-debt provisioning, and recovery."
  source: "`vibe_media_broadcasting_v1`.`billing`.`credit_memo`"
  dimensions:
    - name: "credit_memo_status"
      expr: credit_memo_status
      comment: "Status of the credit memo for adjustment lifecycle tracking."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for the credit for revenue-leakage root-cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit memo for multi-currency reporting."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the credit memo was issued for adjustment trending."
  measures:
    - name: "Total Credit Amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credits issued; revenue adjustment and leakage KPI."
    - name: "Total Net Credit Amount"
      expr: SUM(CAST(net_credit_amount AS DOUBLE))
      comment: "Net credit after tax; realized revenue reduction."
    - name: "Total Recovery Amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Recovered amounts tied to credits; collections offset measure."
    - name: "Bad Debt Write-Off Memo Count"
      expr: COUNT(DISTINCT CASE WHEN bad_debt_write_off_flag = TRUE THEN credit_memo_id END)
      comment: "Credit memos tied to bad-debt write-offs; loss-provisioning indicator."
    - name: "Credit Memo Count"
      expr: COUNT(1)
      comment: "Number of credit memos; adjustment volume baseline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_dunning_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning/collections KPIs for recovery effectiveness, churn risk, and service suspension."
  source: "`vibe_media_broadcasting_v1`.`billing`.`dunning_event`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Dunning action taken for collections-strategy effectiveness."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for dunning for outreach-effectiveness comparison."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the dunning action for recovery success analysis."
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_timestamp)
      comment: "Month of dunning action for collections trending."
  measures:
    - name: "Total Amount Recovered"
      expr: SUM(CAST(amount_recovered AS DOUBLE))
      comment: "Total cash recovered via dunning; collections effectiveness KPI."
    - name: "Total Balance At Action"
      expr: SUM(CAST(account_balance_at_action AS DOUBLE))
      comment: "Account balances at dunning time; collection-exposure baseline."
    - name: "Average Churn Risk Score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk of dunned accounts; retention-action trigger."
    - name: "Service Suspension Count"
      expr: COUNT(DISTINCT CASE WHEN service_suspension_flag = TRUE THEN dunning_event_id END)
      comment: "Dunning actions resulting in suspension; severe-delinquency indicator."
    - name: "Response Received Count"
      expr: COUNT(DISTINCT CASE WHEN response_received_flag = TRUE THEN dunning_event_id END)
      comment: "Dunning actions that elicited a response; outreach-engagement measure."
    - name: "Dunning Event Count"
      expr: COUNT(1)
      comment: "Number of dunning events; collections activity volume."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_syndication_license_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Syndication license fee KPIs for content licensing revenue, withholding tax, and payment status."
  source: "`vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the license fee for receivables tracking."
    - name: "license_window_type"
      expr: license_window_type
      comment: "Licensing window type for content-revenue segmentation."
    - name: "license_territory"
      expr: license_territory
      comment: "Territory of the license for geographic revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fee for multi-currency licensing revenue."
  measures:
    - name: "Total License Fee Amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total syndication license fees; content-licensing revenue KPI."
    - name: "Total Net Payment Amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Net payment after withholding; realized licensing cash."
    - name: "Total Withholding Tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Withholding tax on licensing fees; cross-border tax exposure."
    - name: "Average Withholding Tax Rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding rate; tax-efficiency indicator for international deals."
    - name: "License Fee Count"
      expr: COUNT(1)
      comment: "Number of license fee records; licensing-deal volume."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_carriage_fee_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage fee invoice KPIs for distribution revenue, per-subscriber economics, and dispute adjustments."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the carriage invoice for multi-currency reporting."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period month for carriage-revenue trending."
  measures:
    - name: "Carriage Invoice Count"
      expr: COUNT(1)
      comment: "Number of carriage invoices; distribution-billing volume."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing run KPIs for batch processing throughput, error rates, and billed volume per cycle."
  source: "`vibe_media_broadcasting_v1`.`billing`.`run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the billing run for operational monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of billing run for process segmentation."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category billed in the run for revenue-mix analysis."
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month of the billing run for throughput trending."
  measures:
    - name: "Total Amount Billed"
      expr: SUM(CAST(total_amount_billed AS DOUBLE))
      comment: "Total amount billed per run; batch billing throughput KPI."
    - name: "Run Count"
      expr: COUNT(1)
      comment: "Number of billing runs; operational cadence baseline."
    - name: "Runs Requiring Approval"
      expr: COUNT(DISTINCT CASE WHEN approval_required_flag = TRUE THEN run_id END)
      comment: "Runs needing approval; controls and governance indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_ad_billing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad billing order financial metrics"
  source: "`vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the ad order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the ad order"
    - name: "advertiser_id"
      expr: advertiser_id
      comment: "Advertiser identifier"
  measures:
    - name: "ad_billing_order_count"
      expr: COUNT(1)
      comment: "Number of ad billing orders"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount"
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted amount"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding amount"
    - name: "average_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate"
    - name: "average_grp_rate"
      expr: AVG(CAST(grp_rate AS DOUBLE))
      comment: "Average GRP rate"
$$;