-- Metric views for domain: billing | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core billing invoice KPIs tracking revenue billed, charge composition, collection risk, and billing cycle performance for the water utility. Used by Finance and Revenue Management to steer billing operations and forecast cash flow."
  source: "`vibe_water_utilities_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., ISSUED, PAID, OVERDUE, CANCELLED). Primary grouping for AR aging and collection analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g., REGULAR, FINAL, ESTIMATED, ADJUSTMENT). Drives revenue recognition and billing process segmentation."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the invoice was delivered to the customer (e.g., PAPER, EMAIL, PORTAL). Used to track paperless adoption and delivery cost reduction."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether the invoice was generated from an estimated read rather than an actual meter read. High estimated-read rates signal meter access or AMI issues."
    - name: "is_final"
      expr: is_final
      comment: "Flag indicating this is a final bill (account closure). Used to track churn and service termination volumes."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates the invoice is under customer dispute. Elevated dispute rates signal billing accuracy or rate communication issues."
    - name: "billing_period_start_date"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period start month bucket for trend analysis of billed revenue over time."
    - name: "billing_period_end_date"
      expr: DATE_TRUNC('month', billing_period_end_date)
      comment: "Billing period end month bucket for aligning revenue to service delivery periods."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was issued. Used for billing cycle throughput and revenue recognition timing analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the invoice payment is due. Used for cash flow forecasting and AR aging bucket analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice. Supports multi-currency reporting for utilities operating across jurisdictions."
    - name: "generation_method"
      expr: generation_method
      comment: "Method used to generate the invoice (e.g., BATCH, MANUAL, SYSTEM). Identifies manual intervention rates and automation efficiency."
  measures:
    - name: "total_invoices_issued"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing cycle throughput and operational capacity planning."
    - name: "total_billed_amount_usd"
      expr: SUM(CAST(total_amount_usd AS DOUBLE))
      comment: "Total USD amount billed across all invoices. Primary revenue-billed KPI used by Finance for revenue recognition and cash flow forecasting."
    - name: "total_balance_due_usd"
      expr: SUM(CAST(balance_due_usd AS DOUBLE))
      comment: "Total outstanding balance due across all invoices. Core AR metric for collections prioritization and liquidity risk assessment."
    - name: "total_water_charge_amount"
      expr: SUM(CAST(water_charge_amount AS DOUBLE))
      comment: "Total water service charges billed. Used to track water revenue contribution and rate schedule effectiveness."
    - name: "total_wastewater_charge_amount"
      expr: SUM(CAST(wastewater_charge_amount AS DOUBLE))
      comment: "Total wastewater service charges billed. Used to track wastewater revenue contribution separately from water revenue."
    - name: "total_stormwater_charge_amount"
      expr: SUM(CAST(stormwater_charge_amount AS DOUBLE))
      comment: "Total stormwater charges billed. Tracks stormwater fee revenue for regulatory compliance and infrastructure cost recovery."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices. Required for tax remittance reporting and regulatory compliance."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed on invoices. Elevated late fees indicate collection risk and customer payment behavior trends."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to invoices. High adjustment volumes signal billing accuracy issues or rate dispute activity."
    - name: "total_previous_balance_amount"
      expr: SUM(CAST(previous_balance_amount AS DOUBLE))
      comment: "Sum of previous balances carried forward onto new invoices. Indicates chronic non-payment and AR roll-forward risk."
    - name: "avg_invoice_amount_usd"
      expr: AVG(CAST(total_amount_usd AS DOUBLE))
      comment: "Average invoice value in USD. Tracks revenue per billing event and detects anomalies in billing amounts across customer segments."
    - name: "total_water_consumption_volume"
      expr: SUM(CAST(water_consumption_volume AS DOUBLE))
      comment: "Total water consumption volume billed. Links revenue to physical consumption for rate adequacy and conservation program impact analysis."
    - name: "avg_water_consumption_volume"
      expr: AVG(CAST(water_consumption_volume AS DOUBLE))
      comment: "Average water consumption volume per invoice. Used to benchmark per-customer usage and detect outliers or billing errors."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. Tracks billing accuracy and customer satisfaction risk."
    - name: "estimated_invoice_count"
      expr: COUNT(CASE WHEN is_estimated = TRUE THEN 1 END)
      comment: "Number of invoices generated from estimated reads. High counts indicate meter access problems or AMI failures requiring operational intervention."
    - name: "final_invoice_count"
      expr: COUNT(CASE WHEN is_final = TRUE THEN 1 END)
      comment: "Number of final bills issued (account closures). Tracks customer churn and service termination volume."
    - name: "distinct_customer_accounts_billed"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts billed. Measures billing reach and active customer base size for a given period."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection KPIs for the water utility billing domain. Tracks payment volumes, methods, channels, NSF activity, and auto-pay adoption to steer collections strategy and reduce payment processing costs."
  source: "`vibe_water_utilities_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., POSTED, REVERSED, PENDING, NSF). Primary grouping for payment success rate and collections analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment transaction (e.g., PAYMENT, CREDIT, REFUND). Used to separate inbound cash from credits and refunds."
    - name: "method"
      expr: method
      comment: "Payment method used (e.g., CHECK, ACH, CREDIT_CARD, CASH). Drives payment processing cost analysis and channel optimization."
    - name: "channel"
      expr: channel
      comment: "Channel through which the payment was received (e.g., ONLINE, IVR, WALK_IN, LOCKBOX). Used to optimize self-service adoption and reduce cost-to-collect."
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Flag indicating the payment was made via auto-pay enrollment. Auto-pay adoption reduces delinquency and collection costs."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating the payment is part of a recurring payment arrangement. Tracks payment plan compliance and recurring revenue predictability."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Flag indicating the payment was returned for non-sufficient funds. NSF rates signal customer financial stress and collection risk."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month the payment was made. Used for cash receipt trend analysis and monthly revenue reconciliation."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the payment was posted to the account. Used for AR reconciliation and revenue recognition timing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment. Supports multi-currency cash receipt reporting."
    - name: "card_type"
      expr: card_type
      comment: "Card network used for card payments (e.g., VISA, MASTERCARD). Used to analyze card processing fee exposure."
  measures:
    - name: "total_payments_received"
      expr: COUNT(1)
      comment: "Total number of payment transactions received. Baseline volume metric for payment processing capacity and collections throughput."
    - name: "total_payment_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total USD value of payments received. Primary cash collections KPI used by Finance for daily cash position and revenue reconciliation."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount of payments applied to invoices. Measures effective AR reduction from payment activity."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment balance. Elevated unapplied amounts indicate cash application backlogs and AR reconciliation risk."
    - name: "total_nsf_fee_amount"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees assessed on returned payments. Tracks financial stress signals and fee revenue from returned payments."
    - name: "avg_payment_amount_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average payment amount in USD. Detects shifts in payment behavior (e.g., partial payments increasing) that signal collection risk."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Number of payments returned for non-sufficient funds. Tracks customer financial distress and collection risk exposure."
    - name: "auto_pay_payment_count"
      expr: COUNT(CASE WHEN is_auto_pay = TRUE THEN 1 END)
      comment: "Number of payments made via auto-pay. Tracks auto-pay adoption which reduces delinquency and lowers cost-to-collect."
    - name: "distinct_paying_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts making payments in the period. Measures payment participation rate and active payer base."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio health KPIs for the water utility. Tracks AR aging, delinquency, credit risk, auto-pay adoption, and account lifecycle status to steer collections strategy and customer financial risk management."
  source: "`vibe_water_utilities_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g., ACTIVE, CLOSED, SUSPENDED, FINAL). Primary segmentation for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., RESIDENTIAL, COMMERCIAL, INDUSTRIAL). Drives rate class segmentation and revenue mix analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collections status of the account (e.g., CURRENT, DELINQUENT, WRITE_OFF, PAYMENT_PLAN). Core metric for AR risk stratification."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "How often the account is billed (e.g., MONTHLY, BIMONTHLY, QUARTERLY). Used to normalize revenue and AR metrics across billing cycles."
    - name: "autopay_enrolled"
      expr: autopay_enrolled
      comment: "Whether the account is enrolled in auto-pay. Auto-pay enrollment reduces delinquency and collection costs."
    - name: "budget_billing_enrolled"
      expr: budget_billing_enrolled
      comment: "Whether the account is enrolled in budget billing (levelized payment program). Tracks program adoption and revenue smoothing."
    - name: "paperless_billing"
      expr: paperless_billing
      comment: "Whether the account receives paperless bills. Tracks digital adoption and paper/postage cost reduction progress."
    - name: "payment_plan_active"
      expr: payment_plan_active
      comment: "Whether the account has an active payment plan. Accounts on payment plans represent structured delinquency resolution."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit risk rating of the account. Used to segment AR risk and set deposit/credit limit policies."
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Whether the account is tax-exempt. Used for tax compliance reporting and revenue net-of-tax calculations."
    - name: "open_date_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month the account was opened. Used for cohort analysis of new account acquisition and revenue ramp."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms assigned to the account (e.g., NET_15, NET_30). Used to segment AR aging expectations."
  measures:
    - name: "total_billing_accounts"
      expr: COUNT(1)
      comment: "Total number of billing accounts in the portfolio. Baseline metric for customer base size and billing operations scale."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding current balance across all billing accounts. Primary AR portfolio balance KPI for Finance and Collections leadership."
    - name: "total_past_due_amount"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past-due balance across all accounts. Core delinquency KPI driving collections prioritization and write-off risk assessment."
    - name: "total_aging_current"
      expr: SUM(CAST(aging_current AS DOUBLE))
      comment: "Total AR balance in the current (0-30 day) aging bucket. Used for AR aging waterfall analysis and cash flow forecasting."
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_30_days AS DOUBLE))
      comment: "Total AR balance in the 31-60 day aging bucket. Elevated 30-day aging signals early delinquency trends requiring proactive outreach."
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_60_days AS DOUBLE))
      comment: "Total AR balance in the 61-90 day aging bucket. Accounts in this bucket are at elevated disconnection and write-off risk."
    - name: "total_aging_90_days"
      expr: SUM(CAST(aging_90_days AS DOUBLE))
      comment: "Total AR balance in the 91-120 day aging bucket. High balances here indicate chronic delinquency requiring escalated collections action."
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_over_90_days AS DOUBLE))
      comment: "Total AR balance over 90 days past due. Primary write-off risk indicator and input to bad debt reserve calculations."
    - name: "total_credit_balance_amount"
      expr: SUM(CAST(credit_balance_amount AS DOUBLE))
      comment: "Total credit balances held on accounts (overpayments). Represents refund liability and cash management exposure."
    - name: "total_payment_plan_balance"
      expr: SUM(CAST(payment_plan_balance AS DOUBLE))
      comment: "Total balance enrolled in active payment plans. Measures structured delinquency resolution program scale and recovery pipeline."
    - name: "total_deposit_on_file"
      expr: SUM(CAST(deposit_on_file AS DOUBLE))
      comment: "Total security deposits held on file. Tracks deposit liability and credit risk mitigation coverage."
    - name: "avg_current_balance_per_account"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per billing account. Benchmarks per-account AR exposure and detects shifts in payment behavior."
    - name: "autopay_enrolled_account_count"
      expr: COUNT(CASE WHEN autopay_enrolled = TRUE THEN 1 END)
      comment: "Number of accounts enrolled in auto-pay. Tracks auto-pay adoption progress which directly reduces delinquency rates."
    - name: "payment_plan_active_account_count"
      expr: COUNT(CASE WHEN payment_plan_active = TRUE THEN 1 END)
      comment: "Number of accounts with an active payment plan. Measures the scale of structured delinquency resolution in the portfolio."
    - name: "paperless_billing_account_count"
      expr: COUNT(CASE WHEN paperless_billing = TRUE THEN 1 END)
      comment: "Number of accounts enrolled in paperless billing. Tracks digital adoption and paper/postage cost reduction progress."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment KPIs tracking the volume, value, and nature of billing corrections for the water utility. High adjustment rates signal billing accuracy issues, rate disputes, or leak allowance program activity — all material to revenue integrity and regulatory compliance."
  source: "`vibe_water_utilities_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of billing adjustment (e.g., LEAK_ALLOWANCE, RATE_ERROR, METER_ERROR, GOODWILL). Drives root cause analysis of billing accuracy issues."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., PENDING, APPROVED, APPLIED, REVERSED). Used to track adjustment pipeline and approval bottlenecks."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment. Used for systematic billing error categorization and process improvement targeting."
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge being adjusted (e.g., WATER, WASTEWATER, STORMWATER, TAX). Used to identify which service lines have the highest adjustment activity."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the adjustment (e.g., WATER, SEWER). Enables service-line revenue integrity analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the adjustment required supervisory approval. Tracks high-value adjustment governance and approval workflow compliance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (e.g., PENDING, APPROVED, REJECTED). Identifies approval bottlenecks impacting customer resolution timelines."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating this adjustment is a reversal of a prior adjustment. Reversal rates indicate adjustment quality and rework."
    - name: "leak_allowance_flag"
      expr: leak_allowance_flag
      comment: "Flag indicating the adjustment is a leak allowance credit. Tracks leak allowance program utilization and associated revenue impact."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating the adjustment is required for regulatory compliance. Used for regulatory reporting and audit trail completeness."
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('month', adjustment_date)
      comment: "Month the adjustment was issued. Used for trend analysis of billing correction activity over time."
    - name: "billing_period_start_date_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period the adjustment relates to. Used to match adjustments back to the original billing period for revenue restatement analysis."
  measures:
    - name: "total_adjustments_issued"
      expr: COUNT(1)
      comment: "Total number of billing adjustments issued. Baseline volume metric for billing accuracy and correction workload."
    - name: "total_adjustment_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total USD value of billing adjustments. Primary revenue integrity KPI — large adjustment totals signal systemic billing errors or rate disputes."
    - name: "total_consumption_volume_adjusted"
      expr: SUM(CAST(consumption_volume_adjusted AS DOUBLE))
      comment: "Total consumption volume adjusted across all billing adjustments. Measures the physical billing correction volume, key for leak allowance and meter error programs."
    - name: "avg_adjustment_amount_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average adjustment amount per transaction. Tracks the typical size of billing corrections — rising averages may indicate systemic rate or meter issues."
    - name: "leak_allowance_adjustment_count"
      expr: COUNT(CASE WHEN leak_allowance_flag = TRUE THEN 1 END)
      comment: "Number of adjustments issued as leak allowance credits. Tracks leak allowance program utilization and customer service responsiveness."
    - name: "reversal_adjustment_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of adjustments that are reversals of prior adjustments. High reversal counts indicate adjustment quality issues and rework costs."
    - name: "pending_approval_adjustment_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE AND approval_status = 'PENDING' THEN 1 END)
      comment: "Number of adjustments awaiting supervisory approval. Tracks approval workflow bottlenecks that delay customer credit resolution."
    - name: "distinct_customers_with_adjustments"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts receiving billing adjustments. Measures the breadth of billing accuracy issues across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_collection_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection notice KPIs for the water utility tracking delinquency escalation, disconnection risk, customer protection holds, and collections resolution effectiveness. Critical for regulatory compliance (shutoff moratoriums, low-income protections) and revenue recovery management."
  source: "`vibe_water_utilities_v1`.`billing`.`collection_notice`"
  dimensions:
    - name: "collection_notice_type"
      expr: collection_notice_type
      comment: "Type of collection notice issued (e.g., PAST_DUE, DISCONNECTION_WARNING, FINAL_NOTICE). Drives escalation stage analysis."
    - name: "collection_notice_status"
      expr: collection_notice_status
      comment: "Current status of the collection notice (e.g., ISSUED, RESOLVED, CANCELLED, ESCALATED). Used to track collections pipeline and resolution rates."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation stage of the collection notice. Tracks how far delinquent accounts have progressed through the collections workflow."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the collection notice (e.g., MAIL, EMAIL, PHONE). Used to optimize notice delivery effectiveness and cost."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Whether the notice was successfully delivered. Undelivered notices create regulatory and legal risk for disconnection actions."
    - name: "disconnection_scheduled_flag"
      expr: disconnection_scheduled_flag
      comment: "Flag indicating a disconnection has been scheduled. Tracks disconnection pipeline volume for field operations planning."
    - name: "is_low_income_protected"
      expr: is_low_income_protected
      comment: "Flag indicating the account has low-income protection from disconnection. Required for regulatory compliance reporting on customer protection programs."
    - name: "is_medical_hold"
      expr: is_medical_hold
      comment: "Flag indicating the account has a medical hold preventing disconnection. Tracks medical hold program compliance and volume."
    - name: "is_winter_moratorium"
      expr: is_winter_moratorium
      comment: "Flag indicating the account is protected by a winter shutoff moratorium. Tracks seasonal regulatory compliance exposure."
    - name: "is_shutoff_protected"
      expr: is_shutoff_protected
      comment: "Flag indicating the account has any active shutoff protection. Aggregates all protection types for total protected account reporting."
    - name: "resolution_status"
      expr: resolution_status
      comment: "How the collection notice was resolved (e.g., PAID, PAYMENT_PLAN, WRITTEN_OFF, DISCONNECTED). Measures collections effectiveness by resolution pathway."
    - name: "notice_date_month"
      expr: DATE_TRUNC('month', notice_date)
      comment: "Month the collection notice was issued. Used for delinquency trend analysis and seasonal collections pattern identification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amounts on the collection notice. Supports multi-currency collections reporting."
  measures:
    - name: "total_collection_notices_issued"
      expr: COUNT(1)
      comment: "Total number of collection notices issued. Baseline delinquency volume metric for collections operations capacity planning."
    - name: "total_amount_due_usd"
      expr: SUM(CAST(amount_due_usd AS DOUBLE))
      comment: "Total USD amount due on collection notices. Measures the total delinquent AR under active collections action."
    - name: "total_past_due_amount"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past-due balance on collection notices. Primary delinquency exposure KPI for collections leadership and CFO reporting."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed on collection notices. Tracks late fee revenue and customer financial stress indicators."
    - name: "avg_amount_due_usd"
      expr: AVG(CAST(amount_due_usd AS DOUBLE))
      comment: "Average amount due per collection notice. Tracks typical delinquency size — rising averages indicate worsening customer financial health."
    - name: "disconnection_scheduled_count"
      expr: COUNT(CASE WHEN disconnection_scheduled_flag = TRUE THEN 1 END)
      comment: "Number of accounts with a disconnection scheduled. Tracks disconnection pipeline for field operations planning and regulatory exposure."
    - name: "low_income_protected_count"
      expr: COUNT(CASE WHEN is_low_income_protected = TRUE THEN 1 END)
      comment: "Number of accounts with low-income disconnection protection active. Required for regulatory compliance reporting on customer protection programs."
    - name: "medical_hold_count"
      expr: COUNT(CASE WHEN is_medical_hold = TRUE THEN 1 END)
      comment: "Number of accounts with a medical hold preventing disconnection. Tracks medical hold program volume for compliance and field operations."
    - name: "winter_moratorium_count"
      expr: COUNT(CASE WHEN is_winter_moratorium = TRUE THEN 1 END)
      comment: "Number of accounts protected by winter shutoff moratorium. Tracks seasonal regulatory compliance exposure and deferred disconnection volume."
    - name: "resolved_notice_count"
      expr: COUNT(CASE WHEN resolved_flag = TRUE THEN 1 END)
      comment: "Number of collection notices resolved. Measures collections resolution throughput and program effectiveness."
    - name: "distinct_delinquent_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts with active collection notices. Measures the breadth of delinquency across the customer portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan program KPIs for the water utility tracking enrollment, compliance, completion, and financial recovery from structured delinquency resolution programs. Used by Collections and Customer Service leadership to evaluate program effectiveness and LIHEAP/assistance program reach."
  source: "`vibe_water_utilities_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g., ACTIVE, BROKEN, COMPLETED, CANCELLED). Primary segmentation for plan performance analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (e.g., STANDARD, LIHEAP, HARDSHIP, BUDGET). Used to evaluate program-specific enrollment and completion rates."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g., MONTHLY, BIWEEKLY, WEEKLY). Used to analyze plan structure and customer payment capacity."
    - name: "liheap_eligible"
      expr: liheap_eligible
      comment: "Flag indicating the customer is LIHEAP-eligible. Tracks low-income assistance program reach and regulatory compliance."
    - name: "plan_start_date_month"
      expr: DATE_TRUNC('month', plan_start_date)
      comment: "Month the payment plan was initiated. Used for cohort analysis of plan enrollment and subsequent completion/breakage rates."
    - name: "broken_reason"
      expr: broken_reason
      comment: "Reason the payment plan was broken (e.g., MISSED_PAYMENT, NSF, CANCELLED). Used to identify root causes of plan failure and improve program design."
  measures:
    - name: "total_payment_plans"
      expr: COUNT(1)
      comment: "Total number of payment plans created. Baseline metric for structured delinquency resolution program scale."
    - name: "total_enrolled_balance_amount"
      expr: SUM(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Total delinquent balance enrolled in payment plans. Measures the total AR under structured recovery and the scale of the collections program."
    - name: "total_current_balance_amount"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total remaining balance on active payment plans. Tracks outstanding recovery pipeline and expected future cash collections from plans."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at payment plan enrollment. Measures upfront cash recovery from delinquent accounts entering structured plans."
    - name: "total_installment_amount_usd"
      expr: SUM(CAST(installment_amount_usd AS DOUBLE))
      comment: "Total scheduled installment amounts across all active plans. Used for cash flow forecasting of expected payment plan receipts."
    - name: "avg_enrolled_balance_amount"
      expr: AVG(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Average delinquent balance enrolled per payment plan. Tracks typical plan size and customer financial distress levels."
    - name: "broken_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'BROKEN' THEN 1 END)
      comment: "Number of payment plans that have been broken (missed installment). High breakage rates indicate plan terms are not aligned with customer payment capacity."
    - name: "completed_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'COMPLETED' THEN 1 END)
      comment: "Number of payment plans successfully completed. Primary program effectiveness KPI — completion rate drives collections recovery ROI."
    - name: "liheap_eligible_plan_count"
      expr: COUNT(CASE WHEN liheap_eligible = TRUE THEN 1 END)
      comment: "Number of payment plans for LIHEAP-eligible customers. Tracks low-income assistance program reach and regulatory compliance with affordability mandates."
    - name: "distinct_accounts_on_plans"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts enrolled in payment plans. Measures the breadth of structured delinquency resolution across the customer portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level revenue composition KPIs for the water utility. Enables granular analysis of charge type mix, taxability, proration activity, and revenue class contribution — essential for rate adequacy analysis and regulatory revenue reporting."
  source: "`vibe_water_utilities_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge on the invoice line (e.g., BASE_CHARGE, VOLUMETRIC, SURCHARGE, TAX). Primary dimension for revenue composition analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the charge (e.g., WATER, SEWER, STORMWATER). Used to decompose revenue by service line."
    - name: "revenue_class"
      expr: revenue_class
      comment: "Revenue classification for GL and regulatory reporting (e.g., RESIDENTIAL, COMMERCIAL, INDUSTRIAL). Drives rate class revenue mix analysis."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Whether the line item is subject to tax. Used for tax compliance reporting and taxable revenue base analysis."
    - name: "is_prorated"
      expr: is_prorated
      comment: "Whether the charge was prorated (partial period). Tracks proration activity volume and its impact on revenue recognition accuracy."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether the line item is under dispute. Disputed line items represent revenue at risk and billing accuracy issues."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (e.g., ACTIVE, REVERSED, ADJUSTED). Used to filter to revenue-recognized lines."
    - name: "billing_period_start_date_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period start month for the line item. Used to align revenue to service delivery periods for accrual and trend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the billed quantity (e.g., CCF, GAL, FLAT). Used to normalize volumetric revenue analysis."
    - name: "billing_determinant"
      expr: billing_determinant
      comment: "The billing determinant driving the charge calculation (e.g., CONSUMPTION, METER_SIZE, AREA). Used for rate structure analysis and billing accuracy validation."
  measures:
    - name: "total_invoice_lines"
      expr: COUNT(1)
      comment: "Total number of invoice line items. Baseline metric for billing detail volume and charge composition breadth."
    - name: "total_line_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total USD revenue from all invoice line items. Granular revenue KPI enabling charge-type and service-line revenue decomposition for rate adequacy analysis."
    - name: "total_tax_amount_usd"
      expr: SUM(CAST(tax_amount_usd AS DOUBLE))
      comment: "Total tax collected at the invoice line level. Used for tax remittance reporting and taxable revenue base reconciliation."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity_value AS DOUBLE))
      comment: "Total quantity billed across all invoice lines. Measures total billed consumption volume for rate adequacy and conservation program impact analysis."
    - name: "avg_line_amount_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average revenue per invoice line item. Tracks per-charge revenue trends and detects anomalies in charge amounts."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate applied across billed line items. Used to monitor effective rate levels and detect rate schedule application errors."
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of invoice lines under dispute. Tracks billing accuracy at the charge level and identifies problematic charge types."
    - name: "prorated_line_count"
      expr: COUNT(CASE WHEN is_prorated = TRUE THEN 1 END)
      comment: "Number of prorated invoice lines. High proration volumes indicate frequent service start/stop activity and associated revenue recognition complexity."
    - name: "distinct_invoices_with_lines"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of distinct invoices represented in the line items. Used to validate invoice-to-line completeness and detect missing charge lines."
$$;