-- Metric views for domain: billing | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice performance metrics tracking revenue billed, collection efficiency, discount impact, and tax exposure across the billing domain. Primary KPI surface for CFO and AR leadership."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo, intercompany) for segmenting billing mix."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (draft, issued, paid, overdue, disputed, cancelled)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated, enabling multi-currency revenue analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "AR collection status of the invoice, used to segment outstanding vs. collected receivables."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the invoice was issued, enabling trend analysis of billing volumes over time."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice payment is due, used for cash flow forecasting and aging analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Start of the billing period, enabling period-over-period revenue comparison."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the invoice is tax-exempt, used for tax compliance and exposure reporting."
    - name: "is_self_billing"
      expr: is_self_billing
      comment: "Indicates self-billing invoices where the customer generates the invoice on behalf of the supplier."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing throughput and workload."
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed before discounts and taxes. Primary revenue recognition input for the CFO dashboard."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount billed after discounts. Represents actual revenue obligation from customers."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across all invoices. Critical for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on invoices. Measures commercial discount leakage impacting margin."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Tracks deal size trends and customer billing profile changes."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied across invoices. Monitors pricing discipline and discount policy adherence."
    - name: "discount_to_gross_ratio"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross billed amount. Key margin protection KPI for sales and finance leadership."
    - name: "tax_to_net_ratio"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Tax burden as a percentage of net revenue. Used by tax and finance teams to monitor effective tax rate."
    - name: "distinct_customers_billed"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers billed in the period. Measures billing reach and customer activity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level billing metrics enabling product, SKU, and cost-center revenue analysis. Supports margin management, deferred revenue tracking, and royalty exposure reporting."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (product, service, tax, freight, royalty) for revenue mix analysis."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the invoice line (active, cancelled, disputed, posted)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice line for multi-currency revenue reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the billed quantity, enabling volume-based revenue analysis."
    - name: "is_bundle_line"
      expr: is_bundle_line
      comment: "Whether the line is part of a product bundle, used to analyze bundled vs. standalone revenue."
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Identifies credit memo lines for net revenue and returns analysis."
    - name: "deferred_revenue_flag"
      expr: deferred_revenue_flag
      comment: "Flags lines with deferred revenue treatment, critical for ASC 606 / IFRS 15 compliance reporting."
    - name: "is_royalty_line"
      expr: is_royalty_line
      comment: "Identifies royalty-bearing lines for royalty obligation tracking and cost management."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the line is tax-exempt, used for tax compliance segmentation."
    - name: "service_start_month"
      expr: DATE_TRUNC('MONTH', service_start_date)
      comment: "Month the service period begins, enabling period-based revenue allocation analysis."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total billed line amount across all invoice lines. Core revenue volume metric at line granularity."
    - name: "total_net_line_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts at line level. Represents actual revenue earned per line."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at line level. Enables SKU-level and product-level discount leakage analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level. Supports granular tax liability reporting by product and jurisdiction."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity billed across invoice lines. Enables volume-based pricing and demand analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price billed. Monitors realized pricing vs. list price and price erosion trends."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage at line level. Key pricing discipline KPI for sales and commercial teams."
    - name: "total_royalty_amount"
      expr: SUM(CASE WHEN is_royalty_line = TRUE THEN CAST(line_amount AS DOUBLE) ELSE 0 END)
      comment: "Total royalty-bearing revenue. Tracks royalty obligation exposure for IP and licensing management."
    - name: "deferred_revenue_amount"
      expr: SUM(CASE WHEN deferred_revenue_flag = TRUE THEN CAST(line_amount AS DOUBLE) ELSE 0 END)
      comment: "Total deferred revenue on invoice lines. Critical for revenue recognition compliance and balance sheet accuracy."
    - name: "credit_memo_amount"
      expr: SUM(CASE WHEN is_credit_memo = TRUE THEN CAST(line_amount AS DOUBLE) ELSE 0 END)
      comment: "Total credit memo value issued. Measures returns, adjustments, and billing error corrections impacting net revenue."
    - name: "discount_to_line_ratio"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(line_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross line amount. Monitors commercial discount discipline at line level."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection and cash application metrics. Tracks payment volumes, reconciliation rates, discount capture, and cash receipt efficiency for treasury and AR management."
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (receipt, refund, adjustment, reversal) for cash flow categorization."
    - name: "channel"
      expr: channel
      comment: "Payment channel (bank transfer, credit card, check, ACH) for payment method mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment for multi-currency cash management reporting."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of payment allocation to invoices (allocated, unallocated, partially allocated). Drives AR clearing efficiency."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Bank clearing status of the payment, used for cash position and reconciliation reporting."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the payment has been bank-reconciled. Key control metric for treasury and audit."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt for cash collection trend analysis."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Method by which payment was allocated (specific invoice, oldest first, proportional)."
  measures:
    - name: "total_payments_received"
      expr: COUNT(1)
      comment: "Total number of payments received. Baseline volume metric for cash collection activity."
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash collected from customers. Primary treasury KPI for cash inflow monitoring."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total payment amount successfully allocated to invoices. Measures AR clearing effectiveness."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken by customers. Monitors cost of early payment incentive programs."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred. Tracks transaction cost of payment channel mix."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of payments received. Supports tax remittance and compliance reporting."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Tracks customer payment behavior and deal size trends."
    - name: "reconciliation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_reconciled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that have been bank-reconciled. Critical treasury control and audit readiness metric."
    - name: "allocation_rate"
      expr: ROUND(100.0 * SUM(CAST(allocated_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash successfully allocated to invoices. Measures AR clearing efficiency and unapplied cash risk."
    - name: "distinct_customers_paid"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers who made payments in the period. Measures active payer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_collections`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections performance metrics tracking outstanding exposure, recovery rates, dunning effectiveness, and legal escalation risk. Core KPI surface for credit and collections management."
  source: "`vibe_manufacturing_v1`.`billing`.`collections`"
  dimensions:
    - name: "collection_stage"
      expr: collection_stage
      comment: "Stage of the collections process (early, mid, late, legal) for pipeline and escalation analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Current status of the collection case (open, resolved, written off, legal) for portfolio health monitoring."
    - name: "case_status"
      expr: case_status
      comment: "Operational status of the collection case for workload and resolution tracking."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level reached, indicating severity of payment delinquency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the collection exposure for multi-currency risk reporting."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the case has been escalated, used to segment high-risk accounts requiring management attention."
    - name: "legal_action_flag"
      expr: legal_action_flag
      comment: "Whether legal action has been initiated. Critical risk flag for executive and legal team reporting."
    - name: "payment_arrangement_flag"
      expr: payment_arrangement_flag
      comment: "Whether a payment arrangement has been agreed, indicating cooperative resolution path."
    - name: "write_off_candidate_flag"
      expr: write_off_candidate_flag
      comment: "Whether the case is a write-off candidate, used for bad debt provisioning and reserve management."
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the collection case was opened for vintage analysis and aging cohort reporting."
  measures:
    - name: "total_collection_cases"
      expr: COUNT(1)
      comment: "Total number of active collection cases. Baseline workload metric for collections team capacity planning."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding amount under active collection. Primary bad debt exposure metric for CFO and credit risk."
    - name: "total_gross_exposure"
      expr: SUM(CAST(gross_exposure_amount AS DOUBLE))
      comment: "Total gross collection exposure before recoveries. Measures maximum credit risk in the collections portfolio."
    - name: "total_net_exposure"
      expr: SUM(CAST(net_exposure_amount AS DOUBLE))
      comment: "Total net collection exposure after recoveries. Represents actual expected loss for provisioning purposes."
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered from collection cases. Measures collections team effectiveness and recovery performance."
    - name: "total_dunning_charges"
      expr: SUM(CAST(dunning_charges AS DOUBLE))
      comment: "Total dunning charges levied on delinquent accounts. Tracks penalty revenue and collections cost recovery."
    - name: "total_promised_amount"
      expr: SUM(CAST(promised_amount AS DOUBLE))
      comment: "Total amount promised by customers in payment arrangements. Forward-looking cash recovery indicator."
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_exposure_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross exposure recovered. Primary collections effectiveness KPI for credit management leadership."
    - name: "legal_escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN legal_action_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collection cases escalated to legal action. Measures severity of delinquency portfolio and legal cost risk."
    - name: "write_off_candidate_exposure"
      expr: SUM(CASE WHEN write_off_candidate_flag = TRUE THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding amount from write-off candidate cases. Drives bad debt reserve and provisioning decisions."
    - name: "payment_arrangement_coverage"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_arrangement_flag = TRUE THEN CAST(promised_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(outstanding_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of outstanding exposure covered by payment arrangements. Measures structured recovery pipeline strength."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and utilization metrics tracking credit exposure, utilization rates, and approval pipeline. Enables proactive credit risk management and customer credit health monitoring."
  source: "`vibe_manufacturing_v1`.`billing`.`credit_limit`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current credit status of the customer (good standing, watch, blocked, suspended) for risk segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the credit limit (pending, approved, rejected, expired) for workflow monitoring."
    - name: "limit_type"
      expr: limit_type
      comment: "Type of credit limit (total, per-order, revolving) for credit structure analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the customer (low, medium, high, critical) for portfolio risk segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit limit for multi-currency credit exposure reporting."
    - name: "credit_block_flag"
      expr: credit_block_flag
      comment: "Whether the customer is currently credit-blocked. Operational flag for order management and sales teams."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the credit limit became effective for trend analysis of credit policy changes."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', next_review_date)
      comment: "Month of next scheduled credit review for proactive review pipeline management."
  measures:
    - name: "total_credit_limits"
      expr: COUNT(1)
      comment: "Total number of credit limits in the portfolio. Baseline metric for credit management scope."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total credit extended to customers. Measures aggregate credit risk exposure for the business."
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure AS DOUBLE))
      comment: "Total current credit exposure (outstanding AR + open orders). Primary credit risk metric for the CFO."
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit_amount AS DOUBLE))
      comment: "Total available credit headroom across all customers. Indicates capacity for additional business without credit risk increase."
    - name: "total_utilized_credit"
      expr: SUM(CAST(utilized_credit_amount AS DOUBLE))
      comment: "Total credit currently utilized by customers. Measures active credit consumption against approved limits."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average credit utilization rate across customers. Key credit health indicator — high utilization signals collection risk."
    - name: "portfolio_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(utilized_credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(limit_amount AS DOUBLE)), 0), 2)
      comment: "Portfolio-level credit utilization rate. Measures aggregate credit consumption vs. approved limits for risk management."
    - name: "credit_blocked_customers"
      expr: SUM(CASE WHEN credit_block_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of customers currently credit-blocked. Operational metric impacting order fulfillment and revenue at risk."
    - name: "high_risk_exposure"
      expr: SUM(CASE WHEN risk_category = 'high' OR risk_category = 'critical' THEN CAST(current_exposure AS DOUBLE) ELSE 0 END)
      comment: "Total credit exposure from high and critical risk customers. Drives provisioning and credit review prioritization."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(limit_amount AS DOUBLE))
      comment: "Average credit limit per customer. Benchmarks credit generosity and tracks policy changes over time."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute resolution metrics tracking dispute volumes, disputed amounts, resolution rates, and escalation patterns. Supports AR quality management and customer satisfaction monitoring."
  source: "`vibe_manufacturing_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, under review, resolved, escalated, closed) for pipeline management."
    - name: "reason_category"
      expr: reason_category
      comment: "Category of dispute reason (pricing, quantity, quality, delivery, duplicate) for root cause analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Specific reason code for the dispute, enabling granular billing error pattern identification."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (credit issued, payment confirmed, partial adjustment) for resolution mix analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute (low, medium, high, critical) for workload triage and SLA management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount for multi-currency dispute exposure reporting."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the dispute has been escalated, indicating high-risk or complex cases requiring management attention."
    - name: "dispute_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month the dispute was opened for trend analysis of billing quality and dispute frequency."
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of disputes raised. Baseline billing quality metric — high volumes indicate systemic billing errors."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute. Measures revenue at risk from billing disputes and customer challenges."
    - name: "total_resolved_amount"
      expr: SUM(CAST(resolved_amount AS DOUBLE))
      comment: "Total amount resolved from disputes. Measures dispute resolution effectiveness and revenue recovery."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case. Tracks dispute severity and identifies high-value dispute patterns."
    - name: "dispute_resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_status = 'resolved' OR dispute_status = 'closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes resolved. Primary billing quality KPI — low resolution rates indicate process bottlenecks."
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes escalated. Measures dispute complexity and customer relationship risk."
    - name: "resolution_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(resolved_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount successfully resolved in favor of the business. Measures dispute outcome effectiveness."
    - name: "distinct_customers_disputing"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with active disputes. Identifies accounts with systemic billing relationship issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off metrics tracking write-off volumes, amounts, recovery rates, and approval patterns. Critical for bad debt provisioning, credit policy evaluation, and financial statement accuracy."
  source: "`vibe_manufacturing_v1`.`billing`.`write_off`"
  dimensions:
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the write-off (bankruptcy, uncollectable, statute of limitations) for root cause analysis."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the write-off, indicating materiality and governance compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the write-off for multi-currency bad debt reporting."
    - name: "recovery_flag"
      expr: recovery_flag
      comment: "Whether any recovery has been achieved on the written-off amount. Tracks post-write-off collection success."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month the write-off was processed for trend analysis of bad debt recognition timing."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the write-off was approved for governance and approval cycle time analysis."
  measures:
    - name: "total_write_offs"
      expr: COUNT(1)
      comment: "Total number of write-off transactions. Baseline bad debt activity metric for credit policy evaluation."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as bad debt. Primary P&L impact metric for bad debt expense reporting."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered after write-off. Measures post-write-off collection effectiveness and net bad debt cost."
    - name: "net_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE) - CAST(recovery_amount AS DOUBLE))
      comment: "Net bad debt expense after recoveries. True P&L impact of credit losses for financial reporting."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(write_off_amount AS DOUBLE))
      comment: "Average write-off amount per transaction. Tracks severity of individual bad debt events."
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(write_off_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of written-off amounts subsequently recovered. Measures post-write-off collection program effectiveness."
    - name: "distinct_customers_written_off"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with write-offs. Identifies concentration of bad debt risk across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition compliance metrics tracking recognized amounts, deferred balances, and recognition timing. Essential for ASC 606 / IFRS 15 compliance and accurate financial reporting."
  source: "`vibe_manufacturing_v1`.`billing`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (point-in-time, over-time, milestone, percentage-of-completion) for compliance segmentation."
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of recognition event (initial, adjustment, reversal, catch-up) for audit trail analysis."
    - name: "event_type"
      expr: event_type
      comment: "Business event triggering recognition (delivery, acceptance, invoice, contract modification)."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Processing status of the recognition event (pending, posted, reversed, error) for close process monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recognition event for multi-currency revenue reporting."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Whether the recognition event includes an adjustment, used to track restatements and corrections."
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month revenue was recognized for period-over-period revenue trend analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the recognition event was posted to the GL for close process and period accuracy monitoring."
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period. Primary top-line revenue metric for financial reporting and investor relations."
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods. Critical balance sheet metric for contract liability reporting under ASC 606."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold associated with recognized revenue. Enables gross margin calculation at recognition event level."
    - name: "total_revenue_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total contract transaction price across recognition events. Measures total revenue obligation being managed."
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized revenue per event. Tracks deal size and recognition pattern changes over time."
    - name: "deferred_to_total_ratio"
      expr: ROUND(100.0 * SUM(CAST(deferred_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value deferred. Measures backlog of unrecognized revenue and future revenue visibility."
    - name: "recognition_to_total_ratio"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value recognized. Tracks revenue recognition progress against total obligation."
    - name: "adjusted_event_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_adjusted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recognition events requiring adjustment. High rates indicate contract modification complexity or billing errors."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advance payment and prepayment metrics tracking advance balances, application rates, and remaining unapplied amounts. Supports working capital management and contract liability monitoring."
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the advance payment for multi-currency working capital reporting."
  measures:
    - name: "total_advance_payments"
      expr: COUNT(1)
      comment: "Total number of advance payment records. Baseline metric for prepayment activity volume."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on advance payments. Supports tax liability reporting for advance payment tax treatment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio health metrics tracking account balances, credit utilization, AR aging, and dunning status. Enables proactive account management and revenue assurance."
  source: "`vibe_manufacturing_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (direct, indirect, intercompany, government) for portfolio segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (active, suspended, closed, on-hold) for portfolio health monitoring."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual, milestone) for cash flow planning."
    - name: "collection_stage"
      expr: collection_stage
      comment: "Collections stage of the account for AR risk segmentation and dunning prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Account currency for multi-currency AR portfolio reporting."
    - name: "billing_country"
      expr: billing_country
      comment: "Country of the billing address for geographic revenue and AR analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the account is tax-exempt for tax compliance and revenue reporting segmentation."
    - name: "auto_pay_flag"
      expr: auto_pay_flag
      comment: "Whether auto-pay is enabled, used to segment accounts by payment automation and DSO risk."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the billing account was opened for cohort analysis and account growth tracking."
  measures:
    - name: "total_billing_accounts"
      expr: COUNT(1)
      comment: "Total number of billing accounts. Baseline metric for billing portfolio scope and customer base size."
    - name: "total_ar_balance"
      expr: SUM(CAST(current_ar_balance AS DOUBLE))
      comment: "Total current AR balance across all billing accounts. Primary receivables health metric for treasury and CFO."
    - name: "total_account_balance"
      expr: SUM(CAST(balance_amount AS DOUBLE))
      comment: "Total account balance across the billing portfolio. Measures aggregate outstanding customer obligations."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit extended across all billing accounts. Measures aggregate credit risk exposure."
    - name: "avg_ar_balance"
      expr: AVG(CAST(current_ar_balance AS DOUBLE))
      comment: "Average AR balance per billing account. Tracks typical customer payment behavior and DSO trends."
    - name: "auto_pay_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_pay_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of billing accounts with auto-pay enabled. Higher rates reduce DSO and collection costs."
    - name: "ar_to_credit_limit_ratio"
      expr: ROUND(100.0 * SUM(CAST(current_ar_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "AR balance as a percentage of total credit limit. Portfolio-level credit utilization and risk concentration metric."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_tax_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax determination and compliance metrics tracking tax amounts, exemption rates, override patterns, and jurisdiction exposure. Supports indirect tax compliance and audit readiness."
  source: "`vibe_manufacturing_v1`.`billing`.`tax_determination`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (VAT, GST, sales tax, withholding) for tax liability segmentation by regime."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied for granular tax rate and rule analysis."
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction for geographic tax liability and compliance reporting."
    - name: "tax_jurisdiction_country"
      expr: tax_jurisdiction_country
      comment: "Country of the tax jurisdiction for cross-border tax exposure analysis."
    - name: "tax_calculation_method"
      expr: tax_calculation_method
      comment: "Method used to calculate tax (gross-up, net, inclusive) for tax methodology compliance monitoring."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the line is tax-exempt for exemption rate and compliance tracking."
    - name: "tax_override_flag"
      expr: tax_override_flag
      comment: "Whether the tax was manually overridden, used to identify non-standard tax treatments requiring audit review."
    - name: "tax_validated_flag"
      expr: tax_validated_flag
      comment: "Whether the tax determination has been validated, used for tax close process completeness monitoring."
    - name: "determination_month"
      expr: DATE_TRUNC('MONTH', determination_date)
      comment: "Month of tax determination for period-based tax liability reporting."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax determined across all invoice lines. Primary tax liability metric for compliance and remittance reporting."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable base amount. Measures the revenue base subject to indirect tax obligations."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total tax base amount used for tax calculation. Supports tax audit and reconciliation."
    - name: "total_tax_override_amount"
      expr: SUM(CAST(tax_override_amount AS DOUBLE))
      comment: "Total manually overridden tax amounts. High values indicate non-standard tax treatments requiring audit scrutiny."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across determinations. Monitors blended tax rate trends and jurisdiction mix changes."
    - name: "tax_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tax_override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax determinations with manual overrides. High rates signal tax automation gaps or compliance risk."
    - name: "tax_exemption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tax_exempt_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines with tax exemptions applied. Monitors exemption certificate compliance and audit exposure."
    - name: "tax_validation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tax_validated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax determinations validated. Measures tax close process completeness and audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_intercompany_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany billing and transfer pricing metrics tracking intercompany volumes, markup rates, elimination status, and settlement efficiency. Supports consolidation, transfer pricing compliance, and intercompany reconciliation."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Status of the intercompany invoice (draft, approved, posted, settled) for close process monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the intercompany invoice for multi-currency consolidation and FX exposure analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the intercompany invoice was issued for period-based intercompany volume analysis."
  measures:
    - name: "total_intercompany_invoices"
      expr: COUNT(1)
      comment: "Total number of intercompany invoices. Baseline metric for intercompany transaction volume and complexity."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross intercompany billing amount. Measures total intercompany revenue flows requiring elimination in consolidation."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net intercompany amount after discounts. Represents net intercompany obligation for settlement."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on intercompany invoices. Supports transfer pricing tax compliance and VAT recovery analysis."
$$;