-- Metric views for domain: billing | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core billing invoice KPIs tracking revenue billed, charge composition, collection risk, and billing cycle performance. Primary steering dashboard for the billing domain."
  source: "`vibe_water_utilities_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. ISSUED, PAID, OVERDUE, DISPUTED, CANCELLED) — primary segmentation for AR aging and collection risk analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. REGULAR, FINAL, ESTIMATED, CORRECTED) — used to separate routine billing from exception billing."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the invoice was delivered to the customer (e.g. PAPER, EMAIL, PORTAL) — supports paperless adoption tracking."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating the invoice was generated from an estimated read rather than an actual meter read — key quality indicator for billing accuracy."
    - name: "is_final"
      expr: is_final
      comment: "Flag indicating this is a final bill (account closure) — used to track churn and service termination volumes."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating the invoice is under customer dispute — drives dispute resolution workload and revenue-at-risk reporting."
    - name: "rate_schedule_code"
      expr: rate_schedule_code
      comment: "Rate schedule applied to the invoice — enables revenue analysis by tariff class and rate structure."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of invoice issuance — primary time grain for monthly billing trend analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month the billing period began — used to align revenue to service consumption period."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month payment is due — used for cash flow forecasting and AR aging bucket analysis."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing throughput and cycle completeness monitoring."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total dollar amount billed to customers across all invoices. Primary revenue-billed KPI for financial reporting and cash flow forecasting."
    - name: "total_water_charge"
      expr: SUM(CAST(water_charge_amount AS DOUBLE))
      comment: "Total water service charges billed. Tracks the core water revenue stream and supports rate adequacy analysis."
    - name: "total_wastewater_charge"
      expr: SUM(CAST(wastewater_charge_amount AS DOUBLE))
      comment: "Total wastewater service charges billed. Tracks the wastewater revenue stream separately for cost-of-service and regulatory reporting."
    - name: "total_stormwater_charge"
      expr: SUM(CAST(stormwater_charge_amount AS DOUBLE))
      comment: "Total stormwater charges billed. Supports stormwater program cost recovery analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices. Required for tax remittance reconciliation and regulatory compliance reporting."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed. Indicates collection pressure and customer payment behavior trends."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to invoices (credits and debits). High adjustment volumes signal billing accuracy issues or policy exceptions."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice amount per bill. Tracks average revenue per billing event and supports rate impact analysis."
    - name: "total_water_consumption_volume"
      expr: SUM(CAST(water_consumption_volume AS DOUBLE))
      comment: "Total water volume billed across all invoices. Core operational metric linking consumption to revenue for rate adequacy and conservation program evaluation."
    - name: "avg_water_consumption_volume"
      expr: AVG(CAST(water_consumption_volume AS DOUBLE))
      comment: "Average water consumption volume per invoice. Tracks per-customer usage trends and supports demand forecasting."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. Drives dispute resolution staffing decisions and revenue-at-risk quantification."
    - name: "disputed_amount_at_risk"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(total_amount_due AS DOUBLE) ELSE 0 END)
      comment: "Total billed amount on disputed invoices. Quantifies revenue at risk from billing disputes for executive risk reporting."
    - name: "estimated_invoice_count"
      expr: COUNT(CASE WHEN is_estimated = TRUE THEN 1 END)
      comment: "Number of invoices generated from estimated reads. High estimated-read rates indicate meter access or AMI issues requiring operational intervention."
    - name: "final_bill_count"
      expr: COUNT(CASE WHEN is_final = TRUE THEN 1 END)
      comment: "Number of final bills issued (account closures). Tracks customer churn volume and service termination activity."
    - name: "total_previous_balance"
      expr: SUM(CAST(previous_balance_amount AS DOUBLE))
      comment: "Total carried-forward balances on invoices. Indicates the stock of unpaid prior charges entering each billing cycle — key AR health indicator."
    - name: "total_wastewater_volume"
      expr: SUM(CAST(wastewater_volume AS DOUBLE))
      comment: "Total wastewater volume billed. Supports wastewater cost-of-service analysis and regulatory flow reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection KPIs tracking cash receipts, payment channel mix, NSF/reversal rates, and autopay adoption. Drives treasury, collections, and customer experience decisions."
  source: "`vibe_water_utilities_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. POSTED, REVERSED, PENDING, NSF) — primary segmentation for cash receipt and exception reporting."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of the payment (e.g. REGULAR, ADVANCE, PARTIAL) — used to distinguish full payments from partial and advance payments."
    - name: "payment_method"
      expr: method
      comment: "Payment instrument used (e.g. CHECK, ACH, CREDIT_CARD, CASH) — drives channel cost analysis and digital payment adoption strategy."
    - name: "payment_channel"
      expr: channel
      comment: "Channel through which payment was received (e.g. ONLINE, IVR, WALK_IN, LOCKBOX) — supports channel optimization and cost-to-collect analysis."
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Flag indicating payment was made via autopay enrollment — tracks autopay adoption rate and its impact on delinquency reduction."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Flag indicating the payment returned as non-sufficient funds — drives NSF fee recovery and customer risk scoring."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment receipt — primary time grain for monthly cash collection trend analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month payment was posted to the account — used for revenue recognition and period-close reconciliation."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions received. Baseline volume metric for payment processing throughput."
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash collected from customers. Primary cash receipts KPI for treasury management and AR reduction tracking."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount successfully applied to invoices or charges. Measures effective cash application and AR clearance."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to a specific charge. High unapplied balances indicate cash application backlog and reconciliation risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Tracks typical customer payment behavior and supports payment plan sizing decisions."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Number of payments returned as non-sufficient funds. Tracks customer financial distress signals and NSF fee recovery opportunities."
    - name: "nsf_fee_revenue"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees assessed on returned payments. Tracks fee recovery from dishonored payments and informs NSF policy decisions."
    - name: "autopay_payment_count"
      expr: COUNT(CASE WHEN is_auto_pay = TRUE THEN 1 END)
      comment: "Number of payments made via autopay. Tracks autopay adoption volume — autopay customers have significantly lower delinquency rates."
    - name: "autopay_payment_amount"
      expr: SUM(CASE WHEN is_auto_pay = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total cash collected via autopay. Quantifies the revenue secured through automated payment enrollment."
    - name: "distinct_paying_accounts"
      expr: COUNT(DISTINCT payment_plan_id)
      comment: "Count of distinct payment plans with payments received. Proxy for active paying customer count within the payment dataset."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer billing account health KPIs tracking AR aging, delinquency, collection status, and account lifecycle. Primary view for credit and collections management and customer financial health monitoring."
  source: "`vibe_water_utilities_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the billing account (e.g. ACTIVE, CLOSED, SUSPENDED) — primary segmentation for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. RESIDENTIAL, COMMERCIAL, INDUSTRIAL) — drives rate class analysis and customer segment reporting."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collections stage of the account (e.g. CURRENT, DELINQUENT, COLLECTIONS, WRITE_OFF) — primary driver for collections prioritization."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "How often the account is billed (e.g. MONTHLY, BIMONTHLY, QUARTERLY) — used to normalize revenue and consumption metrics across billing cycles."
    - name: "autopay_enrolled"
      expr: autopay_enrolled
      comment: "Flag indicating the account is enrolled in autopay — key predictor of on-time payment and delinquency risk."
    - name: "budget_billing_enrolled"
      expr: budget_billing_enrolled
      comment: "Flag indicating the account is on a budget billing plan — tracks program adoption and its impact on payment predictability."
    - name: "payment_plan_active"
      expr: payment_plan_active
      comment: "Flag indicating an active payment arrangement is in place — used to segment delinquent accounts by recovery strategy."
    - name: "paperless_billing"
      expr: paperless_billing
      comment: "Flag indicating the account receives paperless bills — tracks digital adoption and supports cost-reduction initiatives."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit risk classification of the account — used for deposit policy decisions and collection risk stratification."
    - name: "account_opened_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month the account was opened — used for cohort analysis and customer acquisition trend reporting."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of billing accounts. Baseline portfolio size metric for capacity planning and market penetration analysis."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts. Primary AR balance KPI for financial close and cash flow forecasting."
    - name: "total_past_due_amount"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past-due balance across all accounts. Core delinquency KPI driving collections prioritization and write-off risk assessment."
    - name: "total_aging_current"
      expr: SUM(CAST(aging_current AS DOUBLE))
      comment: "Total current (0-30 day) AR balance. Component of AR aging waterfall for financial reporting."
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_30_days AS DOUBLE))
      comment: "Total 30-day past-due AR balance. Early delinquency indicator used to trigger first-notice collections activity."
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_60_days AS DOUBLE))
      comment: "Total 60-day past-due AR balance. Mid-stage delinquency indicator used to escalate collections and assess disconnection candidates."
    - name: "total_aging_90_days"
      expr: SUM(CAST(aging_90_days AS DOUBLE))
      comment: "Total 90-day past-due AR balance. Late-stage delinquency indicator driving disconnection orders and payment plan negotiations."
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_over_90_days AS DOUBLE))
      comment: "Total AR balance over 90 days past due. Highest-risk delinquency bucket — primary input to bad debt reserve and write-off decisions."
    - name: "total_deposit_on_file"
      expr: SUM(CAST(deposit_on_file AS DOUBLE))
      comment: "Total customer deposits held. Tracks deposit liability and informs deposit policy adequacy relative to delinquency exposure."
    - name: "total_late_fee_assessed"
      expr: SUM(CAST(late_fee_assessed AS DOUBLE))
      comment: "Total late fees assessed across accounts. Tracks fee revenue and signals the scale of payment delinquency in the portfolio."
    - name: "total_current_charges"
      expr: SUM(CAST(current_charges AS DOUBLE))
      comment: "Total current period charges billed to accounts. Tracks revenue billed in the current cycle for period-close reconciliation."
    - name: "delinquent_account_count"
      expr: COUNT(CASE WHEN past_due_amount > 0 THEN 1 END)
      comment: "Number of accounts with any past-due balance. Tracks the breadth of delinquency across the customer portfolio."
    - name: "payment_plan_account_count"
      expr: COUNT(CASE WHEN payment_plan_active = TRUE THEN 1 END)
      comment: "Number of accounts on active payment arrangements. Tracks the scale of payment plan utilization and associated recovery risk."
    - name: "autopay_enrolled_count"
      expr: COUNT(CASE WHEN autopay_enrolled = TRUE THEN 1 END)
      comment: "Number of accounts enrolled in autopay. Tracks autopay adoption — a leading indicator of reduced delinquency and lower collection costs."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per account. Tracks typical customer balance level and supports credit limit policy calibration."
    - name: "total_payment_plan_balance"
      expr: SUM(CAST(payment_plan_balance AS DOUBLE))
      comment: "Total balance enrolled in active payment plans. Quantifies the deferred revenue under payment arrangements and associated collection risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment KPIs tracking credit/debit volumes, adjustment reasons, regulatory compliance, and financial impact. Drives billing accuracy governance and revenue leakage detection."
  source: "`vibe_water_utilities_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment applied (e.g. CREDIT, DEBIT, LEAK_ALLOWANCE, METER_ERROR) — primary segmentation for root cause analysis of billing corrections."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current lifecycle status of the adjustment (e.g. PENDING, APPROVED, APPLIED, REVERSED) — tracks adjustment workflow throughput."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment — enables systematic analysis of adjustment drivers and billing error patterns."
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge being adjusted (e.g. WATER, WASTEWATER, STORMWATER, FEES) — supports revenue impact analysis by service line."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the adjustment — used to attribute adjustment impact to specific utility service lines."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Flag indicating the adjustment required supervisory approval — tracks governance compliance and approval workflow volumes."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating this adjustment is a reversal of a prior adjustment — tracks correction-on-correction activity as a billing quality signal."
    - name: "leak_allowance_flag"
      expr: leak_allowance_flag
      comment: "Flag indicating the adjustment is a leak allowance credit — tracks the financial impact of the utility leak forgiveness program."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating the adjustment was made for regulatory compliance reasons — required for regulatory reporting and audit trails."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the adjustment became effective — primary time grain for monthly adjustment trend and revenue impact analysis."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of billing adjustments issued. Baseline volume metric for billing correction activity and quality governance."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Net total dollar value of all adjustments. Primary revenue impact KPI — large negative values indicate systematic billing errors or policy-driven credits."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average dollar value per adjustment. Tracks typical adjustment magnitude and helps identify outlier or high-value correction events."
    - name: "total_consumption_volume_adjusted"
      expr: SUM(CAST(consumption_volume_adjusted AS DOUBLE))
      comment: "Total consumption volume corrected through adjustments. Quantifies the scale of metering or estimation errors driving billing corrections."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of adjustments that are reversals of prior adjustments. High reversal counts indicate systemic billing process quality issues."
    - name: "leak_allowance_count"
      expr: COUNT(CASE WHEN leak_allowance_flag = TRUE THEN 1 END)
      comment: "Number of leak allowance credits issued. Tracks program utilization and customer service responsiveness to leak events."
    - name: "leak_allowance_amount"
      expr: SUM(CASE WHEN leak_allowance_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of leak allowance credits. Quantifies the financial cost of the leak forgiveness program for rate-setting and policy review."
    - name: "regulatory_adjustment_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of adjustments made for regulatory compliance. Required for regulatory audit reporting and compliance program monitoring."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE AND adjustment_status = 'PENDING' THEN 1 END)
      comment: "Number of adjustments awaiting supervisory approval. Tracks approval workflow backlog and associated revenue recognition delay risk."
    - name: "total_approval_threshold_amount"
      expr: SUM(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Sum of approval threshold amounts across adjustments requiring approval. Indicates the total value of adjustments subject to governance controls."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment arrangement KPIs tracking plan enrollment, compliance, balance recovery, and program effectiveness. Drives collections strategy and customer financial assistance program management."
  source: "`vibe_water_utilities_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g. ACTIVE, COMPLETED, BROKEN, CANCELLED) — primary segmentation for plan performance and recovery rate analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment arrangement (e.g. STANDARD, LIHEAP, HARDSHIP, BUDGET) — used to evaluate effectiveness of different assistance program types."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g. MONTHLY, BIWEEKLY, WEEKLY) — used to analyze plan structure and customer payment capacity."
    - name: "liheap_eligible"
      expr: liheap_eligible
      comment: "Flag indicating the customer qualifies for LIHEAP (Low Income Home Energy Assistance Program equivalent) — tracks low-income assistance program reach."
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month the payment plan was initiated — used for cohort analysis of plan enrollment and subsequent performance."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of payment plans created. Baseline metric for collections program scale and customer financial distress volume."
    - name: "total_enrolled_balance"
      expr: SUM(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Total delinquent balance enrolled in payment plans at inception. Quantifies the total AR placed under structured recovery arrangements."
    - name: "total_current_plan_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total remaining balance outstanding on active payment plans. Tracks the stock of deferred AR under payment arrangements at any point in time."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at plan enrollment. Tracks upfront cash recovery from delinquent accounts entering payment arrangements."
    - name: "avg_installment_amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average monthly installment amount across plans. Informs plan affordability assessment and default risk modeling."
    - name: "broken_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'BROKEN' THEN 1 END)
      comment: "Number of payment plans that have been broken (missed installment). Primary plan failure KPI driving re-enrollment or escalation to disconnection."
    - name: "completed_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'COMPLETED' THEN 1 END)
      comment: "Number of payment plans successfully completed. Tracks recovery program success rate and informs plan design improvements."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active payment plans. Tracks the live collections workload under structured payment arrangements."
    - name: "liheap_plan_count"
      expr: COUNT(CASE WHEN liheap_eligible = TRUE THEN 1 END)
      comment: "Number of payment plans for LIHEAP-eligible customers. Tracks low-income assistance program reach and regulatory compliance with affordability mandates."
    - name: "total_balance_recovered"
      expr: SUM(CAST(enrolled_balance_amount AS DOUBLE) - CAST(current_balance_amount AS DOUBLE))
      comment: "Total balance recovered through payment plan payments (enrolled minus remaining). Measures the effectiveness of the payment arrangement program in reducing delinquent AR."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-item KPIs providing granular revenue analysis by charge type, service type, rate component, and tax treatment. Enables detailed revenue decomposition and rate structure performance analysis."
  source: "`vibe_water_utilities_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "charge_type_code"
      expr: charge_type_code
      comment: "Standardized code for the type of charge on the line (e.g. BASE, VOLUMETRIC, SURCHARGE, TAX) — primary dimension for revenue decomposition by charge category."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the line item (e.g. WATER, WASTEWATER, STORMWATER) — enables revenue attribution by utility service line."
    - name: "revenue_class"
      expr: revenue_class
      comment: "Revenue classification for GL and regulatory reporting — maps line items to revenue accounts for financial close and rate case support."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (e.g. ACTIVE, REVERSED, DISPUTED) — used to filter valid revenue from corrections and disputes."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Flag indicating the line item is subject to tax — used for tax compliance reporting and taxable revenue analysis."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating the line item is under dispute — tracks disputed revenue at the charge level for granular revenue-at-risk analysis."
    - name: "is_prorated"
      expr: is_prorated
      comment: "Flag indicating the charge was prorated — used to identify partial-period billing and assess proration accuracy."
    - name: "billing_determinant"
      expr: billing_determinant
      comment: "The measured quantity or determinant driving the charge (e.g. consumption volume, meter size) — links revenue to the underlying service driver."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month the billing period began for this line — aligns revenue to the service consumption period for accrual-basis reporting."
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of invoice line items. Baseline volume metric for billing complexity and charge item throughput."
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total pre-tax line item revenue. Core revenue decomposition metric enabling analysis of revenue by charge type, service, and rate component."
    - name: "total_line_amount_with_tax"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Total line item amount including tax. Represents the full customer-facing charge for each line — used for invoice reconciliation and revenue reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the line item level. Supports tax remittance reconciliation and taxable revenue compliance reporting."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate charged across line items. Tracks effective rate levels and supports rate schedule performance analysis."
    - name: "avg_proration_factor"
      expr: AVG(CAST(proration_factor AS DOUBLE))
      comment: "Average proration factor applied to prorated line items. Tracks the extent of partial-period billing and its revenue impact."
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed invoice line items. Granular dispute tracking enabling root cause analysis by charge type and service."
    - name: "disputed_line_amount"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN CAST(line_amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue on disputed line items. Quantifies revenue at risk from billing disputes at the charge level."
    - name: "taxable_line_amount"
      expr: SUM(CASE WHEN is_taxable = TRUE THEN CAST(line_amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue on taxable line items. Required for tax base calculation and compliance with tax remittance obligations."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average effective tax rate applied across taxable line items. Monitors tax rate consistency and flags anomalies in tax application."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate schedule governance KPIs tracking tariff structure, rate adequacy, and regulatory compliance. Supports rate case preparation, conservation program evaluation, and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`"
  dimensions:
    - name: "billing_rate_schedule_status"
      expr: billing_rate_schedule_status
      comment: "Current status of the rate schedule (e.g. ACTIVE, SUPERSEDED, PENDING_APPROVAL, EXPIRED) — tracks the active rate schedule portfolio."
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Type of rate structure (e.g. FLAT, TIERED, INCLINING_BLOCK, SEASONAL) — primary dimension for rate design analysis and conservation effectiveness."
    - name: "service_type"
      expr: service_type
      comment: "Service type covered by the rate schedule (e.g. WATER, WASTEWATER, STORMWATER) — enables rate analysis by utility service line."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the rate schedule (e.g. MONTHLY, BIMONTHLY) — used to normalize rate comparisons across billing cycles."
    - name: "conservation_rate_indicator"
      expr: conservation_rate_indicator
      comment: "Flag indicating the rate schedule includes conservation pricing tiers — tracks the reach of conservation-oriented rate structures."
    - name: "seasonal_indicator"
      expr: seasonal_indicator
      comment: "Flag indicating the rate schedule has seasonal pricing components — used to analyze seasonal rate design and demand management effectiveness."
    - name: "drought_surcharge_applicable"
      expr: drought_surcharge_applicable
      comment: "Flag indicating a drought surcharge applies under this schedule — tracks drought response rate mechanism deployment."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction governing the rate schedule — enables rate analysis by regulatory territory for multi-jurisdiction utilities."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rate schedule became effective — used to track rate change history and align revenue impacts to rate change events."
  measures:
    - name: "total_rate_schedules"
      expr: COUNT(1)
      comment: "Total number of rate schedules in the system. Tracks rate schedule portfolio complexity and supports rate rationalization initiatives."
    - name: "active_rate_schedule_count"
      expr: COUNT(CASE WHEN billing_rate_schedule_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active rate schedules. Tracks the live tariff portfolio and supports rate schedule governance."
    - name: "avg_base_charge_amount"
      expr: AVG(CAST(base_charge_amount AS DOUBLE))
      comment: "Average base (fixed) charge across rate schedules. Tracks fixed cost recovery levels and informs rate adequacy analysis for infrastructure investment."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum bill amount across rate schedules. Tracks minimum revenue guarantee levels and their adequacy for fixed cost recovery."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum charge cap across rate schedules. Tracks bill protection levels and their impact on high-consumption revenue recovery."
    - name: "conservation_rate_schedule_count"
      expr: COUNT(CASE WHEN conservation_rate_indicator = TRUE THEN 1 END)
      comment: "Number of rate schedules with conservation pricing. Tracks the breadth of conservation rate design deployment across the service territory."
    - name: "drought_surcharge_schedule_count"
      expr: COUNT(CASE WHEN drought_surcharge_applicable = TRUE THEN 1 END)
      comment: "Number of rate schedules with drought surcharge provisions. Tracks drought response rate mechanism readiness across the tariff portfolio."
$$;