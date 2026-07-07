-- Metric views for domain: billing | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for premium invoice performance, covering billed amounts, subsidy utilization, collection status, and retroactive adjustments. Used by Finance and Revenue Operations to monitor billing health and cash flow."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_invoice`"
  filter: record_status = 'active'
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., issued, paid, overdue, voided) — primary grouping for collection performance analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, retroactive, adjustment) — used to segment billing activity by nature of charge."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the invoice (e.g., individual, group, Medicare) — key strategic segmentation dimension."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the invoice (e.g., collected, pending, in-collections) — drives accounts receivable and collections strategy."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month of the billing period start date — enables monthly trend analysis of premium billing."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the invoice (e.g., ACH, credit card, check) — informs payment channel strategy."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (e.g., online, mail, agent) — used to optimize collection channel mix."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy applied to the invoice (e.g., APTC, CSR) — used to track government subsidy exposure."
    - name: "is_eligible_for_subsidy"
      expr: is_eligible_for_subsidy
      comment: "Flag indicating whether the invoice is eligible for a subsidy — used to segment subsidized vs. non-subsidized billing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice — used for multi-currency financial reporting."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of the invoice due date — used to bucket aging and overdue analysis."
  measures:
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total gross premium amount billed across all invoices. Core revenue KPI used by Finance to track top-line premium revenue."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after subsidies and discounts. Represents actual cash obligation from members — key for cash flow forecasting."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount applied across invoices. Tracks government subsidy exposure and APTC/CSR liability for regulatory reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices. Used to monitor discount program costs and their impact on net revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed. Required for tax compliance reporting and financial close processes."
    - name: "total_retroactive_adjustment_amount"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustment amounts on invoices. High values signal enrollment or rate correction issues requiring operational intervention."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts issued on invoices. Tracks refund liability and signals potential billing accuracy or member satisfaction issues."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing operations throughput and capacity planning."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of distinct members billed. Used to track billing reach and identify members with missing or duplicate invoices."
    - name: "avg_net_amount_due_per_invoice"
      expr: AVG(CAST(net_amount_due AS DOUBLE))
      comment: "Average net amount due per invoice. Benchmarks typical member payment obligation and detects anomalous billing patterns."
    - name: "subsidy_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(subsidy_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total premium covered by subsidies. Measures government subsidy dependency and risk exposure for the book of business."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for premium payment activity, covering collected amounts, NSF events, suspense resolution, and payment channel performance. Used by Revenue Cycle and Finance to monitor cash collection efficiency and payment quality."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_payment`"
  filter: record_status = 'active'
  dimensions:
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Current status of the payment (e.g., posted, reversed, pending) — primary dimension for payment health monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, check, credit card) — used to analyze payment method mix and associated failure rates."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was received (e.g., online portal, mail, agent) — informs channel optimization strategy."
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (e.g., member, employer, government) — used to segment payment sources for revenue attribution."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (e.g., payment, reversal, adjustment) — used to isolate net cash collections from gross activity."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment — used to track unreconciled cash and close the books accurately."
    - name: "suspense_status"
      expr: suspense_status
      comment: "Status of suspense-held payments — used to monitor unresolved cash and drive suspense clearance operations."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_timestamp)
      comment: "Month of payment receipt — enables monthly cash collection trend analysis."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Flag indicating a non-sufficient funds (NSF) event — used to track payment failure rates and associated collection costs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — used for multi-currency cash reporting."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount received. Primary cash collection KPI used by Finance for revenue recognition and cash flow reporting."
    - name: "total_net_amount_collected"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments. Represents actual cash retained — key for net revenue reporting."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment amounts. High values indicate cash application backlogs that inflate AR and distort collection metrics."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustment amounts. Tracks correction activity volume and signals billing or payment processing quality issues."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees charged on payments (e.g., NSF fees, processing fees). Used to monitor fee revenue and member cost burden."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume metric for payment operations throughput."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Number of payments flagged as NSF (non-sufficient funds). Tracks payment failure volume — a leading indicator of member financial distress."
    - name: "nsf_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that resulted in NSF. Key quality metric for payment channel risk management and member outreach prioritization."
    - name: "unapplied_amount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total payment amount that remains unapplied. Measures cash application efficiency — high rates signal operational bottlenecks."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to benchmark typical payment size and detect anomalous large or small payments."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of distinct members who made payments. Used to measure payment participation rate and identify non-paying members."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level billing KPIs covering premium amounts, APTC subsidies, CSR adjustments, employee/employer contributions, and refund activity. Used by Finance and Actuarial teams to analyze premium composition and billing accuracy at the most granular level."
  source: "`vibe_health_insurance_v1`.`billing`.`invoice_line`"
  filter: record_status = 'active'
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice line (e.g., paid, unpaid, partial) — primary dimension for receivables aging analysis."
    - name: "premium_status"
      expr: premium_status
      comment: "Status of the premium line (e.g., active, terminated, suspended) — used to segment active vs. inactive premium obligations."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of premium rate applied (e.g., standard, COBRA, subsidized) — used to analyze rate tier distribution across the book."
    - name: "is_refund"
      expr: is_refund
      comment: "Flag indicating whether the line is a refund — used to isolate refund activity from gross billing."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Flag indicating a retroactive adjustment — used to quantify retro billing exposure and its impact on revenue recognition."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for billing adjustments — used to categorize and root-cause billing correction activity."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month of the billing period — enables monthly premium trend and cohort analysis."
    - name: "premium_currency"
      expr: premium_currency
      comment: "Currency of the premium line — used for multi-currency financial reporting."
    - name: "premium_reconciliation_flag"
      expr: premium_reconciliation_flag
      comment: "Flag indicating whether the line has been reconciled — used to track reconciliation completeness and identify open items."
  measures:
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total gross premium amount across all invoice lines. Core revenue measure for actuarial and financial reporting."
    - name: "total_aptc_subsidy_amount"
      expr: SUM(CAST(aptc_subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts applied at the line level. Tracks federal subsidy exposure and supports CMS reconciliation reporting."
    - name: "total_csr_adjustment_amount"
      expr: SUM(CAST(csr_adjustment_amount AS DOUBLE))
      comment: "Total Cost-Sharing Reduction (CSR) adjustment amounts. Measures CSR liability and supports regulatory reconciliation with CMS."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution AS DOUBLE))
      comment: "Total employee premium contributions. Used to analyze member cost-sharing and employer group billing splits."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer premium contributions. Used to track employer group revenue and cost-sharing arrangements."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts at the line level. Tracks refund liability and signals billing accuracy issues requiring investigation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts billed at the line level. Required for tax compliance and financial close reporting."
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount (premium + tax + adjustments) across all invoice lines. Represents the complete billing obligation at line level."
    - name: "retroactive_adjustment_line_count"
      expr: COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 END)
      comment: "Number of invoice lines with retroactive adjustments. High counts indicate enrollment or rate change processing delays."
    - name: "retroactive_adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoice lines that are retroactive adjustments. Key billing quality metric — high rates signal systemic enrollment or rate processing issues."
    - name: "aptc_subsidy_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(aptc_subsidy_amount AS DOUBLE)) / NULLIF(SUM(CAST(premium_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross premium covered by APTC subsidies at the line level. Measures federal subsidy dependency across the individual market book."
    - name: "avg_premium_amount_per_line"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per invoice line. Used to benchmark per-member per-month (PMPM) premium levels and detect rating anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_aptc_subsidy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Advance Premium Tax Credit (APTC) subsidy management, covering monthly subsidy amounts, annual caps, year-to-date utilization, and CMS reconciliation status. Critical for ACA compliance, CMS reconciliation, and subsidy risk management."
  source: "`vibe_health_insurance_v1`.`billing`.`aptc_subsidy`"
  filter: record_status = 'active'
  dimensions:
    - name: "aptc_subsidy_status"
      expr: aptc_subsidy_status
      comment: "Current status of the APTC subsidy (e.g., active, terminated, suspended) — primary dimension for subsidy portfolio health monitoring."
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status of the subsidy — used to track federal reconciliation completeness and identify open reconciliation items."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (e.g., APTC, CSR) — used to segment subsidy portfolio by program type."
    - name: "csr_variant"
      expr: csr_variant
      comment: "Cost-Sharing Reduction variant associated with the subsidy — used to analyze CSR plan variant distribution and associated cost exposure."
    - name: "exchange_code"
      expr: exchange_code
      comment: "Exchange or marketplace code where the subsidy was granted — used for state/federal exchange performance comparison."
    - name: "qhp_plan_code"
      expr: qhp_plan_code
      comment: "Qualified Health Plan code associated with the subsidy — used to analyze subsidy distribution across plan offerings."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the subsidy became effective — used for cohort analysis of subsidy enrollment trends."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the subsidy is currently active — used to segment active vs. inactive subsidy population."
  measures:
    - name: "total_aptc_monthly_amount"
      expr: SUM(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Total monthly APTC subsidy amounts across all active subsidies. Primary measure of federal subsidy liability for the current period."
    - name: "total_annual_aptc_cap"
      expr: SUM(CAST(annual_aptc_cap AS DOUBLE))
      comment: "Total annual APTC cap amounts across the subsidy portfolio. Measures maximum federal subsidy exposure for the plan year."
    - name: "total_ytd_aptc_applied"
      expr: SUM(CAST(ytd_aptc_applied AS DOUBLE))
      comment: "Total year-to-date APTC amounts applied. Used to track subsidy utilization against annual caps for CMS reconciliation."
    - name: "active_subsidy_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active APTC subsidies. Tracks the size of the subsidized member population — key for ACA compliance reporting."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of distinct members receiving APTC subsidies. Used to measure subsidy program reach and enrollment trends."
    - name: "ytd_aptc_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(ytd_aptc_applied AS DOUBLE)) / NULLIF(SUM(CAST(annual_aptc_cap AS DOUBLE)), 0), 2)
      comment: "Year-to-date APTC utilization as a percentage of the annual cap. Measures subsidy burn rate — critical for CMS reconciliation risk management and year-end true-up forecasting."
    - name: "avg_monthly_aptc_per_member"
      expr: AVG(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Average monthly APTC subsidy amount per subsidy record. Benchmarks per-member subsidy levels and detects outlier subsidy assignments."
    - name: "pending_cms_reconciliation_count"
      expr: COUNT(CASE WHEN cms_reconciliation_status = 'pending' THEN 1 END)
      comment: "Number of subsidies with pending CMS reconciliation. High counts signal reconciliation backlogs that create regulatory and financial risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for grace period management, covering active grace periods, extension rates, outcomes, and APTC eligibility. Used by Member Services and Compliance to monitor termination risk, regulatory obligations, and collection recovery rates."
  source: "`vibe_health_insurance_v1`.`billing`.`grace_period`"
  filter: record_status = 'active'
  dimensions:
    - name: "grace_period_status"
      expr: grace_period_status
      comment: "Current status of the grace period (e.g., active, expired, cured, terminated) — primary dimension for grace period portfolio health."
    - name: "grace_period_type"
      expr: grace_period_type
      comment: "Type of grace period (e.g., APTC, non-APTC, COBRA) — used to segment grace period exposure by regulatory program."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the grace period (e.g., payment received, terminated, extended) — used to measure collection recovery and termination rates."
    - name: "state_code"
      expr: state_code
      comment: "State associated with the grace period — used for state-level regulatory compliance monitoring and reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction of the grace period — used to ensure compliance with state-specific grace period rules."
    - name: "is_eligible_for_aptc"
      expr: is_eligible_for_aptc
      comment: "Flag indicating APTC eligibility during the grace period — used to segment APTC vs. non-APTC grace period populations for regulatory reporting."
    - name: "extension_flag"
      expr: extension_flag
      comment: "Flag indicating whether the grace period was extended — used to track extension rates and associated collection risk."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the grace period initiation — used to root-cause non-payment events and target member outreach."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the grace period started — used for cohort analysis of grace period trends and seasonal non-payment patterns."
    - name: "termination_warning_issued"
      expr: termination_warning_issued
      comment: "Flag indicating whether a termination warning was issued — used to track compliance with required member notification obligations."
  measures:
    - name: "active_grace_period_count"
      expr: COUNT(CASE WHEN grace_period_status = 'active' THEN 1 END)
      comment: "Number of currently active grace periods. Primary risk indicator for potential member terminations and associated revenue loss."
    - name: "total_grace_period_count"
      expr: COUNT(1)
      comment: "Total number of grace period records. Baseline volume metric for non-payment event tracking and operational workload planning."
    - name: "total_subsidy_amount_at_risk"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount associated with grace period records. Measures federal subsidy liability at risk of recoupment if members are terminated during APTC grace periods."
    - name: "extension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods that were extended. High rates may indicate systemic payment hardship or operational leniency requiring policy review."
    - name: "termination_warning_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN termination_warning_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods where a termination warning was issued. Measures compliance with regulatory notification requirements — low rates create regulatory risk."
    - name: "aptc_grace_period_count"
      expr: COUNT(CASE WHEN is_eligible_for_aptc = TRUE THEN 1 END)
      comment: "Number of grace periods involving APTC-eligible members. APTC grace periods carry a 3-month regulatory obligation — tracking this is critical for ACA compliance."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of distinct members in a grace period. Used to measure the breadth of non-payment risk across the member population."
    - name: "avg_subsidy_amount_per_grace_period"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per grace period record. Used to assess average federal subsidy exposure per non-payment event."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for payment allocation efficiency, covering allocated amounts, overpayments, suspense resolution, variances, and reconciliation status. Used by Revenue Cycle Operations to monitor cash application quality and identify allocation exceptions."
  source: "`vibe_health_insurance_v1`.`billing`.`payment_allocation`"
  filter: record_status = 'active'
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the payment allocation (e.g., applied, pending, reversed) — primary dimension for allocation health monitoring."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., standard, overpayment, suspense) — used to segment allocation activity by nature."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the allocation — used to track unreconciled cash and support financial close processes."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation process applied — used to categorize reconciliation activity and measure process efficiency."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method of the underlying payment — used to analyze allocation patterns by payment channel."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel of the underlying payment — used to assess allocation efficiency by channel."
    - name: "is_overpayment"
      expr: is_overpayment
      comment: "Flag indicating an overpayment allocation — used to track overpayment volume and associated refund liability."
    - name: "is_suspense_resolution"
      expr: is_suspense_resolution
      comment: "Flag indicating a suspense resolution allocation — used to monitor suspense clearance activity and aging."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the allocation — enables monthly trend analysis of cash application activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation — used for multi-currency cash application reporting."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to invoice lines. Primary measure of cash application volume — used to reconcile payments to invoices."
    - name: "total_billed"
      expr: SUM(CAST(total_billed AS DOUBLE))
      comment: "Total billed amount associated with allocations. Used as the denominator for collection rate calculations."
    - name: "total_collected"
      expr: SUM(CAST(total_collected AS DOUBLE))
      comment: "Total collected amount across allocations. Measures actual cash received against billed amounts — core revenue cycle KPI."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between billed and collected amounts. High variance signals billing disputes, underpayments, or cash application errors requiring investigation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amounts applied during allocation. Used to monitor discount program costs and their impact on net collections."
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustment amounts applied during allocation. Tracks correction activity volume and signals cash application quality issues."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_collected AS DOUBLE)) / NULLIF(SUM(CAST(total_billed AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amounts successfully collected. Premier revenue cycle efficiency KPI — directly measures billing-to-cash conversion performance."
    - name: "overpayment_count"
      expr: COUNT(CASE WHEN is_overpayment = TRUE THEN 1 END)
      comment: "Number of overpayment allocations. Tracks overpayment volume — high counts signal billing accuracy issues and create refund liability."
    - name: "suspense_resolution_count"
      expr: COUNT(CASE WHEN is_suspense_resolution = TRUE THEN 1 END)
      comment: "Number of suspense resolution allocations. Measures suspense clearance throughput — key operational metric for cash application teams."
    - name: "variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed AS DOUBLE)), 0), 2)
      comment: "Variance as a percentage of total billed. Measures billing-to-collection accuracy — high rates indicate systemic underpayment or billing disputes."
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average allocated amount per allocation record. Used to benchmark typical allocation size and detect anomalous large or small allocations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for billing account portfolio management, covering account balances, credit utilization, APTC amounts, PMPM rates, and auto-pay adoption. Used by Finance and Member Services to monitor account health, payment risk, and billing program effectiveness."
  source: "`vibe_health_insurance_v1`.`billing`.`account`"
  filter: record_status = 'active'
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g., active, suspended, closed) — primary dimension for account portfolio health segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., individual, group, COBRA) — used to segment account portfolio by market segment."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency of the account (e.g., monthly, quarterly, annual) — used to analyze billing cycle distribution and cash flow timing."
    - name: "billing_method"
      expr: billing_method
      comment: "Billing method used for the account (e.g., electronic, paper, EFT) — used to track billing channel adoption and associated costs."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the account (e.g., current, delinquent, in-collections) — key risk dimension for accounts receivable management."
    - name: "auto_pay_enrollment"
      expr: auto_pay_enrollment
      comment: "Flag indicating auto-pay enrollment — used to measure auto-pay adoption rates and their correlation with payment performance."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating auto-renewal enrollment — used to track renewal automation rates and associated retention impact."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating tax-exempt status — used to segment tax-exempt accounts for compliance and financial reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the account — used for multi-currency financial reporting."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the account became effective — used for account cohort analysis and vintage performance tracking."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all billing accounts. Measures aggregate accounts receivable exposure — key for cash flow and credit risk management."
    - name: "total_payment_due_amount"
      expr: SUM(CAST(payment_due_amount AS DOUBLE))
      comment: "Total payment due amount across accounts. Measures near-term cash collection obligation — used for cash flow forecasting."
    - name: "total_aptc_amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts associated with accounts. Tracks federal subsidy exposure at the account level for ACA compliance reporting."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts across accounts. Measures overall government subsidy dependency in the account portfolio."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of last payment amounts across accounts. Used to benchmark recent payment activity and identify accounts with unusually low or missing payments."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Measures aggregate credit exposure in the billing portfolio."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member per-month (PMPM) rate across accounts. Key actuarial and pricing benchmark — used to monitor rate adequacy and trend."
    - name: "auto_pay_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_pay_enrollment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts enrolled in auto-pay. Higher auto-pay adoption correlates with lower NSF rates and better collection performance — key operational KPI."
    - name: "delinquent_account_count"
      expr: COUNT(CASE WHEN collection_status = 'delinquent' THEN 1 END)
      comment: "Number of accounts in delinquent collection status. Primary risk metric for accounts receivable — drives collections prioritization and member outreach."
    - name: "credit_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(current_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Current balance as a percentage of total credit limit. Measures credit utilization across the account portfolio — high rates signal elevated collection risk."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active billing accounts. Baseline portfolio size metric used for per-account benchmarking and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for premium rate management, covering rate amounts, APTC levels, employee/employer contribution rates, tobacco surcharges, and wellness discounts. Used by Actuarial, Pricing, and Regulatory Affairs to monitor rate adequacy, market competitiveness, and DOI filing compliance."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_rate`"
  filter: record_status = 'active'
  dimensions:
    - name: "premium_rate_status"
      expr: premium_rate_status
      comment: "Current status of the premium rate (e.g., active, expired, pending) — used to segment the active rate portfolio from historical rates."
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (e.g., individual, family, COBRA) — used to analyze rate distribution across premium categories."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier of the rate (e.g., employee only, employee + spouse, family) — key dimension for rate tier analysis and actuarial pricing review."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the rate (e.g., individual, small group, large group) — used to analyze rate adequacy by market segment."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area of the rate — used for geographic rate variation analysis and regulatory compliance."
    - name: "age_band"
      expr: age_band
      comment: "Age band associated with the rate — used for age-rated premium analysis and ACA age rating compliance."
    - name: "rating_method"
      expr: rating_method
      comment: "Rating methodology used (e.g., community rated, experience rated) — used to segment rates by pricing approach."
    - name: "family_tier_structure"
      expr: family_tier_structure
      comment: "Family tier structure of the rate — used to analyze tier structure distribution across the plan portfolio."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the rate became effective — used for rate vintage analysis and year-over-year rate trend comparison."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the rate is currently active — used to isolate the current active rate book."
  measures:
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average premium rate amount. Core actuarial KPI for monitoring rate adequacy and year-over-year rate trend across the portfolio."
    - name: "avg_aptc_amount"
      expr: AVG(CAST(aptc_amount AS DOUBLE))
      comment: "Average APTC subsidy amount embedded in premium rates. Used to assess average federal subsidy level and benchmark against market rates."
    - name: "avg_employee_contribution_rate"
      expr: AVG(CAST(employee_contribution_rate AS DOUBLE))
      comment: "Average employee contribution rate. Used to benchmark member cost-sharing levels and assess affordability across the plan portfolio."
    - name: "avg_employer_contribution_rate"
      expr: AVG(CAST(employer_contribution_rate AS DOUBLE))
      comment: "Average employer contribution rate. Used to benchmark employer cost-sharing and assess group plan competitiveness."
    - name: "avg_cobra_rate"
      expr: AVG(CAST(cobra_rate AS DOUBLE))
      comment: "Average COBRA premium rate. Used to monitor COBRA pricing adequacy and compliance with COBRA continuation coverage regulations."
    - name: "avg_tobacco_surcharge_rate"
      expr: AVG(CAST(tobacco_surcharge_rate AS DOUBLE))
      comment: "Average tobacco surcharge rate. Used to monitor tobacco surcharge program utilization and ACA tobacco rating compliance."
    - name: "avg_wellness_discount_rate"
      expr: AVG(CAST(wellness_discount_rate AS DOUBLE))
      comment: "Average wellness discount rate. Used to measure wellness program incentive levels and their impact on net premium revenue."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active premium rates. Measures the size of the active rate portfolio — used for rate management and DOI filing tracking."
    - name: "total_rate_amount"
      expr: SUM(CAST(rate_amount AS DOUBLE))
      comment: "Total of all premium rate amounts. Used as a portfolio-level rate exposure measure for actuarial and financial planning."
    - name: "avg_subsidy_amount"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount embedded in premium rates. Used to assess average government subsidy dependency across the rate portfolio."
$$;