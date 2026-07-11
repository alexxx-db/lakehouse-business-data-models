-- Metric views for domain: billing | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial performance metrics covering revenue, tax, discounts, and collection status. Primary KPI surface for AR management, revenue reporting, and billing efficiency analysis."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. Draft, Issued, Paid, Overdue) — primary filter for AR aging and collection dashboards."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice (e.g. Standard, Credit Note, Proforma) — used to segment revenue reporting and exclude non-revenue documents."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (e.g. Unpaid, Partial, Paid) — drives AR aging buckets and collections prioritization."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections workflow status — used to track escalation and recovery pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue consolidation and FX exposure analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms applied to the invoice (e.g. Net30, Net60) — used to analyze DSO by terms bucket."
    - name: "billing_period_start"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Billing period start month — enables monthly revenue trend analysis."
    - name: "billing_period_end"
      expr: DATE_TRUNC('month', billing_period_end)
      comment: "Billing period end month — used to align revenue to the correct reporting period."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Invoice due date bucketed by month — critical for AR aging and cash flow forecasting."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_timestamp)
      comment: "Month the invoice was issued — used for billing volume trend analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the invoice is tax-exempt — used to segment taxable vs. exempt revenue."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified on the invoice — used to analyze payment channel mix and processing costs."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued — baseline volume metric for billing throughput and workload analysis."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts before discounts and tax — top-line billing revenue indicator used in executive revenue dashboards."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts — represents actual recognized billing revenue for P&L reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all invoices — required for tax liability reporting and regulatory compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on invoices — measures commercial discount exposure and pricing discipline."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value — used to track deal size trends and identify shifts in customer billing patterns."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied across invoices — monitors pricing discipline and discount policy adherence."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across invoices — used for tax provision analysis and jurisdiction benchmarking."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers billed — measures billing reach and active customer base size."
    - name: "distinct_invoice_count_by_order"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct orders that generated invoices — used to measure order-to-invoice conversion completeness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level billing metrics for revenue decomposition, product mix analysis, discount management, and deferred revenue tracking. Enables granular margin and pricing analysis by SKU, cost center, and line type."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (e.g. Product, Service, Royalty, Tax) — used to decompose revenue by category."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the invoice line — used to identify lines pending posting or in error."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the line — required for multi-currency revenue analysis."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Method used to recognize revenue on this line (e.g. Point-in-time, Over-time) — critical for ASC 606 / IFRS 15 compliance reporting."
    - name: "deferred_revenue_flag"
      expr: deferred_revenue_flag
      comment: "Indicates whether revenue on this line is deferred — used to track deferred revenue balance and release schedule."
    - name: "is_bundle_line"
      expr: is_bundle_line
      comment: "Indicates whether this line is part of a product bundle — used to analyze bundle revenue allocation."
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Indicates whether this line is a credit memo — used to measure credit note volume and net revenue impact."
    - name: "is_royalty_line"
      expr: is_royalty_line
      comment: "Indicates whether this line represents a royalty charge — used to track royalty revenue streams."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether this line is tax-exempt — used to segment taxable vs. exempt line revenue."
    - name: "service_start_month"
      expr: DATE_TRUNC('month', service_start_date)
      comment: "Service period start month — used to align line revenue to the correct service delivery period."
    - name: "posted_month"
      expr: DATE_TRUNC('month', posted_timestamp)
      comment: "Month the line was posted to the GL — used for period-close revenue reconciliation."
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the billed quantity — used to analyze volume-based billing patterns."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines — measures billing granularity and line-item volume."
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Sum of gross line amounts — top-line revenue decomposition at the line level for product and service mix analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net line amounts after discounts — actual recognized revenue at line level for margin analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level — used for tax liability decomposition by product and jurisdiction."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line level — measures discount exposure by product, customer, and sales channel."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity billed across all lines — used for volume analysis and capacity utilization benchmarking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across invoice lines — monitors pricing trends and detects price erosion."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage at line level — measures pricing discipline and commercial policy compliance."
    - name: "avg_tax_rate_percent"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate at line level — used for tax provision and jurisdiction analysis."
    - name: "total_royalty_amount"
      expr: SUM(CASE WHEN is_royalty_line = TRUE THEN CAST(line_amount AS DOUBLE) ELSE 0 END)
      comment: "Total royalty revenue billed — tracks royalty income stream for IP monetization reporting."
    - name: "total_credit_memo_amount"
      expr: SUM(CASE WHEN is_credit_memo = TRUE THEN CAST(line_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of credit memo lines — measures revenue reversals and return/refund exposure."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs billed — measures product breadth in billing and identifies concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection and cash application metrics covering payment volumes, amounts, discount utilization, and reconciliation status. Core KPI surface for treasury, AR, and cash management."
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Received, Applied, Returned) — primary filter for cash application dashboards."
    - name: "method"
      expr: method
      comment: "Payment method used (e.g. ACH, Wire, Check, Card) — used to analyze payment channel mix and processing cost."
    - name: "channel"
      expr: channel
      comment: "Payment channel (e.g. Online, Branch, EDI) — used to measure digital payment adoption."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency cash flow analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of payment allocation to invoices — identifies unallocated cash requiring AR action."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation applied (e.g. Full, Partial, Advance) — used to analyze payment application patterns."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Bank clearing status — used to reconcile bank statements and identify outstanding items."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (e.g. Receipt, Refund, Reversal) — used to net cash flows correctly."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment receipt — used for monthly cash collection trend analysis."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Indicates whether the payment has been bank-reconciled — used to measure reconciliation completeness."
    - name: "early_payment_discount_applied"
      expr: early_payment_discount_applied
      comment: "Indicates whether an early payment discount was taken — used to measure discount utilization rate."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received — baseline volume metric for cash collection throughput."
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross payment amount received — primary cash collection KPI for treasury and AR management."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net payment amount after discounts and fees — actual cash collected for bank reconciliation."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to invoices — measures AR clearance effectiveness."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken by customers — measures cost of early payment incentive programs."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees — used to analyze payment channel cost and optimize fee structures."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of payments — used for tax remittance reconciliation."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average payment amount — tracks customer payment behavior and identifies changes in payment patterns."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers making payments — measures active paying customer base."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Number of payments not yet bank-reconciled — operational metric for treasury close process and audit readiness."
    - name: "total_unallocated_amount"
      expr: SUM(CASE WHEN allocation_status = 'Unallocated' THEN CAST(amount_gross AS DOUBLE) ELSE 0 END)
      comment: "Total cash received but not yet applied to invoices — measures unapplied cash risk and AR process efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_collections`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections performance metrics covering exposure, recovery, escalation, and promise-to-pay tracking. Drives collections strategy, resource allocation, and bad debt risk management."
  source: "`vibe_manufacturing_v1`.`billing`.`collections`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the collections case (e.g. Open, Closed, Escalated) — primary filter for collections workload management."
    - name: "collection_stage"
      expr: collection_stage
      comment: "Stage in the collections process (e.g. Reminder, Dunning, Legal) — used to analyze pipeline progression and escalation rates."
    - name: "case_strategy"
      expr: case_strategy
      comment: "Collections strategy applied to the case — used to measure effectiveness of different collection approaches."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level — used to track severity distribution of overdue accounts."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency exposure analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the case has been escalated — used to measure escalation rate and management intervention frequency."
    - name: "legal_action_flag"
      expr: legal_action_flag
      comment: "Indicates whether legal action has been initiated — used to track legal recovery pipeline and associated costs."
    - name: "payment_arrangement_flag"
      expr: payment_arrangement_flag
      comment: "Indicates whether a payment arrangement is in place — used to measure structured recovery agreements."
    - name: "write_off_candidate_flag"
      expr: write_off_candidate_flag
      comment: "Indicates whether the case is a write-off candidate — used to estimate bad debt provision requirements."
    - name: "communication_method"
      expr: communication_method
      comment: "Method used to contact the customer (e.g. Email, Phone, Letter) — used to optimize collections outreach strategy."
    - name: "case_open_month"
      expr: DATE_TRUNC('month', case_open_date)
      comment: "Month the collections case was opened — used for vintage analysis of overdue accounts."
  measures:
    - name: "total_case_count"
      expr: COUNT(1)
      comment: "Total number of active collections cases — measures collections workload and portfolio size."
    - name: "total_gross_exposure"
      expr: SUM(CAST(gross_exposure_amount AS DOUBLE))
      comment: "Total gross collections exposure — primary KPI for bad debt risk quantification and provision sizing."
    - name: "total_net_exposure"
      expr: SUM(CAST(net_exposure_amount AS DOUBLE))
      comment: "Total net collections exposure after recoveries — measures actual at-risk AR balance for credit risk reporting."
    - name: "total_promised_amount"
      expr: SUM(CAST(promised_amount AS DOUBLE))
      comment: "Total amount promised by customers in payment arrangements — measures expected near-term cash recovery."
    - name: "total_dunning_charges"
      expr: SUM(CAST(dunning_charges AS DOUBLE))
      comment: "Total dunning charges levied — measures penalty revenue from late payment and collections cost recovery."
    - name: "avg_gross_exposure_per_case"
      expr: AVG(CAST(gross_exposure_amount AS DOUBLE))
      comment: "Average gross exposure per collections case — used to prioritize high-value cases and allocate collector resources."
    - name: "escalated_case_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated collections cases — measures severity of collections portfolio and management intervention demand."
    - name: "legal_action_case_count"
      expr: COUNT(CASE WHEN legal_action_flag = TRUE THEN 1 END)
      comment: "Number of cases with legal action initiated — tracks legal recovery pipeline and associated cost exposure."
    - name: "write_off_candidate_count"
      expr: COUNT(CASE WHEN write_off_candidate_flag = TRUE THEN 1 END)
      comment: "Number of cases flagged as write-off candidates — drives bad debt provision and write-off approval workflow."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers in collections — measures breadth of collections exposure across customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and utilization metrics covering limit adequacy, exposure, and review cycle compliance. Drives credit policy decisions, risk-based customer segmentation, and credit block management."
  source: "`vibe_manufacturing_v1`.`billing`.`credit_limit`"
  dimensions:
    - name: "credit_limit_status"
      expr: credit_limit_status
      comment: "Current status of the credit limit record (e.g. Active, Expired, Suspended) — primary filter for active credit exposure analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the credit limit — used to track pending approvals and governance compliance."
    - name: "limit_type"
      expr: limit_type
      comment: "Type of credit limit (e.g. Total, Per-Order, Revolving) — used to segment credit exposure by limit structure."
    - name: "risk_category"
      expr: risk_category
      comment: "Customer risk classification (e.g. Low, Medium, High) — primary dimension for credit risk portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit limit — required for multi-currency credit exposure consolidation."
    - name: "credit_block_flag"
      expr: credit_block_flag
      comment: "Indicates whether the customer is currently credit-blocked — used to measure blocked account impact on order fulfillment."
    - name: "credit_check_method"
      expr: credit_check_method
      comment: "Method used for credit checking (e.g. Static, Dynamic) — used to analyze credit check policy distribution."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the credit limit became effective — used for credit limit vintage analysis."
    - name: "last_review_month"
      expr: DATE_TRUNC('month', last_review_date)
      comment: "Month of last credit review — used to identify stale credit limits requiring reassessment."
  measures:
    - name: "total_credit_limit_count"
      expr: COUNT(1)
      comment: "Total number of credit limit records — measures credit policy coverage across customer base."
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total credit limit granted across all customers — measures aggregate credit exposure ceiling for risk management."
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure AS DOUBLE))
      comment: "Total current credit exposure across all customers — primary credit risk KPI for CFO and credit committee reporting."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average credit utilization rate across customers — measures how aggressively customers are using available credit."
    - name: "avg_limit_amount"
      expr: AVG(CAST(limit_amount AS DOUBLE))
      comment: "Average credit limit per customer — used to benchmark credit policy generosity and identify outliers."
    - name: "credit_blocked_customer_count"
      expr: COUNT(CASE WHEN credit_block_flag = TRUE THEN 1 END)
      comment: "Number of customers currently credit-blocked — measures order fulfillment risk from credit holds."
    - name: "high_utilization_count"
      expr: COUNT(CASE WHEN CAST(utilization_percentage AS DOUBLE) >= 80 THEN 1 END)
      comment: "Number of customers with credit utilization at or above 80% — identifies customers approaching credit ceiling requiring proactive review."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with credit limits — measures credit policy coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute management metrics covering dispute volume, value, resolution efficiency, and escalation rates. Drives customer satisfaction, billing quality improvement, and AR risk management."
  source: "`vibe_manufacturing_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. Open, Under Review, Resolved, Closed) — primary filter for dispute pipeline management."
    - name: "reason_category"
      expr: reason_category
      comment: "Category of dispute reason (e.g. Pricing Error, Delivery Issue, Quality) — used to identify root causes and drive billing quality improvement."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g. Credit Issued, Rejected, Partial Adjustment) — used to measure resolution outcome distribution."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute — used to ensure high-value disputes receive timely resolution."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency dispute exposure analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the dispute has been escalated — used to measure escalation rate and management intervention frequency."
    - name: "dispute_month"
      expr: DATE_TRUNC('month', dispute_date)
      comment: "Month the dispute was raised — used for dispute volume trend analysis and billing quality monitoring."
    - name: "resolution_month"
      expr: DATE_TRUNC('month', resolution_date)
      comment: "Month the dispute was resolved — used to measure resolution cycle time and backlog aging."
  measures:
    - name: "total_dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised — primary billing quality KPI; high dispute rates signal systemic billing errors."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of disputed invoices — measures financial exposure from billing disputes and AR at-risk balance."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case — used to prioritize dispute resolution resources toward high-value cases."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated disputes — measures severity of dispute portfolio and management escalation burden."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'Open' THEN 1 END)
      comment: "Number of currently open disputes — measures active dispute backlog requiring resolution action."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active disputes — measures breadth of billing quality issues across customer base."
    - name: "total_escalated_disputed_amount"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN CAST(disputed_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of escalated disputes — measures high-severity financial exposure requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off metrics covering write-off volume, amounts, recovery rates, and approval levels. Critical for credit risk management, bad debt provision accuracy, and financial statement integrity."
  source: "`vibe_manufacturing_v1`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of the write-off (e.g. Pending, Approved, Posted, Recovered) — primary filter for write-off pipeline management."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the write-off — used to ensure governance compliance and segregation of duties."
    - name: "reason"
      expr: reason
      comment: "Reason for the write-off (e.g. Bankruptcy, Uncollectible, Statute of Limitations) — used to analyze bad debt root causes."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency bad debt analysis."
    - name: "recovery_flag"
      expr: recovery_flag
      comment: "Indicates whether a recovery has been recorded — used to measure post-write-off recovery success rate."
    - name: "write_off_month"
      expr: DATE_TRUNC('month', write_off_timestamp)
      comment: "Month the write-off was recorded — used for bad debt trend analysis and provision adequacy review."
    - name: "recovery_month"
      expr: DATE_TRUNC('month', recovery_date)
      comment: "Month of recovery — used to track recovery timing and cash flow from previously written-off balances."
  measures:
    - name: "total_write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-off records — measures bad debt incidence rate and credit policy effectiveness."
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount written off — primary bad debt KPI for P&L impact assessment and provision adequacy review."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from previously written-off balances — measures collections effectiveness on bad debt."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per record — used to benchmark write-off size and identify concentration risk."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with write-offs — measures breadth of bad debt exposure across customer base."
    - name: "recovered_write_off_count"
      expr: COUNT(CASE WHEN recovery_flag = TRUE THEN 1 END)
      comment: "Number of write-offs with recorded recoveries — measures post-write-off recovery success rate."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition compliance and performance metrics covering recognized amounts, deferred balances, and adjustment activity. Critical for ASC 606 / IFRS 15 compliance, audit readiness, and revenue quality reporting."
  source: "`vibe_manufacturing_v1`.`billing`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of the revenue recognition event (e.g. Pending, Recognized, Deferred, Adjusted) — primary filter for revenue recognition pipeline."
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of recognition event (e.g. Point-in-time, Over-time, Milestone) — used to analyze revenue recognition method distribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue recognition analysis."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Indicates whether the recognition event has been adjusted — used to measure adjustment frequency and revenue restatement risk."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for revenue recognition adjustment — used to identify systemic issues driving revenue restatements."
    - name: "recognition_month"
      expr: DATE_TRUNC('month', recognition_timestamp)
      comment: "Month revenue was recognized — primary time dimension for revenue trend analysis and period-close reporting."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Start of the performance obligation period — used to align revenue to the correct service delivery period."
  measures:
    - name: "total_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events — measures recognition activity volume for audit and compliance monitoring."
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized — primary top-line revenue KPI for P&L reporting and investor disclosure."
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred revenue balance — measures future revenue backlog and balance sheet deferred revenue liability."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold associated with recognized revenue — used to calculate gross margin at recognition event level."
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total contract amount across recognition events — measures total performance obligation value under management."
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized amount per event — used to benchmark recognition event size and identify outliers."
    - name: "adjusted_event_count"
      expr: COUNT(CASE WHEN is_adjusted = TRUE THEN 1 END)
      comment: "Number of revenue recognition events that required adjustment — measures revenue quality and restatement risk."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with revenue recognition events — measures active revenue-generating customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio metrics covering AR balances, credit exposure, account health, and payment behavior. Drives customer financial relationship management and credit risk oversight."
  source: "`vibe_manufacturing_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "billing_account_status"
      expr: billing_account_status
      comment: "Current status of the billing account (e.g. Active, Suspended, Closed) — primary filter for active account analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g. Corporate, Individual, Government) — used to segment AR portfolio by customer type."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency at which the account is billed (e.g. Monthly, Quarterly, Annual) — used to analyze billing cycle distribution."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the billing account — primary dimension for credit risk portfolio segmentation."
    - name: "collection_stage"
      expr: collection_stage
      comment: "Current collections stage of the account — used to measure collections pipeline distribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Account currency — required for multi-currency AR balance analysis."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address — used for geographic AR and revenue analysis."
    - name: "preferred_payment_method"
      expr: preferred_payment_method
      comment: "Customer preferred payment method — used to analyze payment method adoption and optimize collection strategies."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the account is tax-exempt — used to segment taxable vs. exempt billing accounts."
    - name: "auto_payment_enabled"
      expr: auto_payment_enabled
      comment: "Indicates whether auto-payment is enabled — used to measure autopay adoption and its impact on DSO."
    - name: "open_date_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month the billing account was opened — used for account vintage analysis and cohort-based AR reporting."
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts — measures billing portfolio size and customer base coverage."
    - name: "total_current_ar_balance"
      expr: SUM(CAST(current_ar_balance AS DOUBLE))
      comment: "Total current AR balance across all billing accounts — primary AR portfolio KPI for cash flow forecasting and credit risk management."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit granted across all billing accounts — measures aggregate credit exposure ceiling."
    - name: "avg_current_ar_balance"
      expr: AVG(CAST(current_ar_balance AS DOUBLE))
      comment: "Average AR balance per billing account — used to benchmark account-level exposure and identify high-risk outliers."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per billing account — used to benchmark credit policy generosity across account segments."
    - name: "auto_payment_enabled_count"
      expr: COUNT(CASE WHEN auto_payment_enabled = TRUE THEN 1 END)
      comment: "Number of accounts with auto-payment enabled — measures autopay adoption rate and its impact on collection efficiency."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with billing accounts — measures billing coverage of the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing schedule execution metrics covering planned vs. actual billing, milestone completion, retention, and discount tracking. Drives contract billing compliance and revenue realization monitoring."
  source: "`vibe_manufacturing_v1`.`billing`.`billing_schedule`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing schedule milestone (e.g. Pending, Billed, Cancelled) — primary filter for billing execution monitoring."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of billing milestone (e.g. Delivery, Completion, Time-based) — used to analyze billing trigger distribution."
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency of the billing schedule — required for multi-currency contract billing analysis."
    - name: "is_retention_applicable"
      expr: is_retention_applicable
      comment: "Indicates whether retention is applicable to this milestone — used to track retention billing exposure."
    - name: "planned_billing_month"
      expr: DATE_TRUNC('month', planned_billing_date)
      comment: "Planned billing month — used for forward-looking revenue pipeline and cash flow forecasting."
    - name: "actual_billing_month"
      expr: DATE_TRUNC('month', actual_billing_date)
      comment: "Actual billing month — used to measure billing execution timeliness vs. plan."
  measures:
    - name: "total_schedule_count"
      expr: COUNT(1)
      comment: "Total number of billing schedule milestones — measures contract billing pipeline volume."
    - name: "total_planned_billing_amount"
      expr: SUM(CAST(planned_billing_amount AS DOUBLE))
      comment: "Total planned billing amount across all milestones — measures contracted revenue pipeline for cash flow forecasting."
    - name: "total_actual_billed_amount"
      expr: SUM(CAST(actual_billed_amount AS DOUBLE))
      comment: "Total actual billed amount — measures revenue realized from contract billing milestones."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount withheld — measures retention liability and future cash release schedule."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on billing schedules — measures commercial discount exposure on contract billing."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on billing schedule milestones — used for tax liability forecasting on contract revenue."
    - name: "avg_planned_billing_amount"
      expr: AVG(CAST(planned_billing_amount AS DOUBLE))
      comment: "Average planned billing amount per milestone — used to benchmark milestone size and identify large contract concentrations."
    - name: "avg_percentage_complete_trigger"
      expr: AVG(CAST(percentage_complete_trigger AS DOUBLE))
      comment: "Average completion percentage required to trigger billing — used to analyze billing trigger thresholds across contracts."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advance payment and prepayment metrics covering receipt volumes, amounts, tax exposure, and clearing status. Drives working capital management, liability tracking, and customer prepayment analysis."
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency advance payment liability analysis."
  measures:
    - name: "total_advance_payment_count"
      expr: COUNT(1)
      comment: "Total number of advance payments received — measures prepayment activity volume."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original advance payment amount received — measures gross prepayment inflows for cash flow analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on advance payments — used for tax liability reporting on prepayments."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with advance payments — measures prepayment program adoption across customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_tax_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax determination and compliance metrics covering tax amounts, rates, exemptions, and override activity. Drives tax liability reporting, audit readiness, and tax engine accuracy monitoring."
  source: "`vibe_manufacturing_v1`.`billing`.`tax_determination`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax applied (e.g. VAT, GST, Sales Tax, Withholding) — primary dimension for tax liability decomposition by type."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied — used to analyze tax determination accuracy and code distribution."
    - name: "tax_jurisdiction_country"
      expr: tax_jurisdiction_country
      comment: "Country of tax jurisdiction — used for geographic tax liability reporting and regulatory filing."
    - name: "tax_jurisdiction_region"
      expr: tax_jurisdiction_region
      comment: "Regional tax jurisdiction — used for sub-national tax liability analysis and compliance."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the line is tax-exempt — used to segment taxable vs. exempt transaction volume."
    - name: "tax_override_flag"
      expr: tax_override_flag
      comment: "Indicates whether the tax amount was manually overridden — used to monitor tax engine override rates and audit risk."
    - name: "reverse_charge_indicator"
      expr: reverse_charge_indicator
      comment: "Indicates whether reverse charge mechanism applies — used for VAT compliance reporting in applicable jurisdictions."
    - name: "tax_validated_flag"
      expr: tax_validated_flag
      comment: "Indicates whether the tax determination has been validated — used to measure tax engine validation completeness."
    - name: "tax_line_status"
      expr: tax_line_status
      comment: "Processing status of the tax line — used to identify tax lines pending posting or in error."
    - name: "tax_calculation_method"
      expr: tax_calculation_method
      comment: "Method used to calculate tax (e.g. Gross, Net, Inclusive) — used to analyze tax calculation approach distribution."
    - name: "tax_reporting_period"
      expr: tax_reporting_period
      comment: "Tax reporting period — used to align tax amounts to the correct regulatory filing period."
  measures:
    - name: "total_tax_line_count"
      expr: COUNT(1)
      comment: "Total number of tax determination lines — measures tax engine processing volume and coverage."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount determined — primary tax liability KPI for regulatory reporting and remittance."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total taxable base amount — used to verify tax calculation accuracy and effective tax rate analysis."
    - name: "total_tax_override_amount"
      expr: SUM(CAST(tax_override_amount AS DOUBLE))
      comment: "Total manually overridden tax amount — measures tax engine override exposure and audit risk."
    - name: "total_taxable_quantity"
      expr: SUM(CAST(taxable_quantity AS DOUBLE))
      comment: "Total taxable quantity across all tax lines — used for volume-based tax analysis."
    - name: "avg_tax_rate_percent"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate — used to benchmark tax burden and identify jurisdiction-level rate anomalies."
    - name: "tax_override_count"
      expr: COUNT(CASE WHEN tax_override_flag = TRUE THEN 1 END)
      comment: "Number of tax lines with manual overrides — measures tax engine override frequency and associated audit risk."
    - name: "unvalidated_tax_line_count"
      expr: COUNT(CASE WHEN tax_validated_flag = FALSE THEN 1 END)
      comment: "Number of tax lines not yet validated — measures tax determination quality and compliance readiness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_intercompany_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany billing metrics covering transfer pricing, elimination flags, settlement status, and markup analysis. Drives intercompany reconciliation, legal entity consolidation, and transfer pricing compliance."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the intercompany invoice (e.g. Draft, Posted, Settled) — primary filter for intercompany reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency intercompany analysis."
  measures:
    - name: "total_intercompany_invoice_count"
      expr: COUNT(1)
      comment: "Total number of intercompany invoices — measures intercompany transaction volume for consolidation workload analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net intercompany amount after discounts — used for intercompany balance reconciliation and elimination."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on intercompany invoices — used for intercompany tax compliance and VAT recovery analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts on intercompany invoices — used to analyze intercompany pricing adjustments."
$$;