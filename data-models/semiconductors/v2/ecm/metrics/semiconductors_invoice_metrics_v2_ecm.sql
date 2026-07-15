-- Metric views for domain: invoice | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core accounts-receivable invoice KPIs covering revenue billed, collection efficiency, discount exposure, and tax liability. Used by CFO, AR Director, and Revenue Controller to steer cash-flow and billing quality."
  source: "`vibe_semiconductors_v1`.`invoice`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: ar_invoice_status
      comment: "Current lifecycle status of the invoice (e.g. Draft, Posted, Paid, Cancelled) — primary filter for AR aging and collection dashboards."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (e.g. Open, Partial, Paid, Overdue) — drives dunning and cash-application workflows."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency — used to slice revenue by currency for FX exposure analysis."
    - name: "document_type"
      expr: document_type
      comment: "Invoice document type (Standard, Proforma, Credit Memo) — separates revenue-generating invoices from adjustments."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of invoice issuance — primary time dimension for monthly revenue trend analysis."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Calendar month the invoice is due — used for cash-flow forecasting and aging bucket analysis."
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Flag indicating whether the invoice is a credit memo — separates debit and credit flows in revenue reporting."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Indicates whether the invoice is subject to export control regulations — used for compliance reporting."
    - name: "collection_status"
      expr: collection_status
      comment: "AR collection status (e.g. Current, 30-day, 60-day, 90-day overdue) — drives collections prioritization."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline volume metric for billing throughput and workload analysis."
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts before discounts and taxes. Represents total revenue billed to customers — primary top-line revenue KPI."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts. Represents actual revenue recognized net of commercial discounts — used in P&L reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed across all invoices. Used by tax controllers to reconcile tax liability and VAT/GST filings."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total commercial discounts granted. Measures discount leakage and pricing discipline — reviewed by VP Sales and CFO."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late payment fees charged. Indicates collection enforcement effectiveness and customer payment behavior."
    - name: "total_early_payment_discount"
      expr: SUM(CAST(early_payment_discount AS DOUBLE))
      comment: "Total early payment discounts granted. Measures cost of accelerating cash collection — used in working capital optimization."
    - name: "avg_net_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Tracks deal size trends and is used to identify shifts in customer mix or product pricing."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross billed amount. Key pricing discipline KPI — high values signal margin erosion from excessive discounting."
    - name: "tax_rate_effective_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of net invoice amount. Used by tax controllers to validate tax calculation accuracy and detect anomalies."
    - name: "credit_memo_count"
      expr: COUNT(CASE WHEN is_credit_memo = TRUE THEN 1 END)
      comment: "Number of credit memo invoices. Elevated credit memo volume signals billing errors, returns, or customer disputes requiring investigation."
    - name: "credit_memo_amount"
      expr: SUM(CASE WHEN is_credit_memo = TRUE THEN gross_amount ELSE 0 END)
      comment: "Total gross amount of credit memos issued. Measures revenue reversals — a key indicator of billing quality and customer satisfaction."
    - name: "credit_memo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_credit_memo = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that are credit memos. Benchmark for billing accuracy — industry best practice is below 2%."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level invoice analytics covering revenue by product, channel, region, and charge type. Used by Revenue Operations, Sales Finance, and Product Controllers to analyze revenue mix and margin at the SKU and order-line level."
  source: "`vibe_semiconductors_v1`.`invoice`.`invoice_line`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge on the invoice line (e.g. Product, NRE, Royalty, Service) — primary revenue category dimension."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (e.g. Active, Cancelled, Disputed) — used to filter revenue to recognized lines."
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "ASC 606 revenue recognition category (e.g. Point-in-Time, Over-Time) — critical for revenue accounting compliance."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (e.g. Direct, Distribution, Online) — used to analyze revenue mix by go-to-market channel."
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region — used for regional revenue performance analysis and territory management."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the invoice line — used for multi-currency revenue analysis and FX exposure."
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month of billing period start — primary time dimension for monthly revenue trend analysis at line level."
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Flag indicating whether the line is tax-exempt — used for tax compliance and exemption certificate tracking."
    - name: "is_discount_applied"
      expr: is_discount_applied
      comment: "Flag indicating whether a discount was applied to this line — used to measure discount penetration rate."
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of invoice line items. Baseline volume metric for billing complexity and processing workload."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue across all invoice lines before discounts. Primary revenue KPI at the line level for product and channel mix analysis."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts. Represents actual recognized revenue at line level — used in product P&L and margin analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across invoice lines. Used for tax reconciliation and jurisdiction-level tax liability reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted at line level. Measures pricing discipline and discount leakage by product, channel, and region."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units billed across invoice lines. Used to compute average selling price and track volume trends by product."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price across invoice lines. Key pricing KPI — declining ASP signals pricing pressure or mix shift."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate applied to invoice lines. Used by IP licensing teams to monitor royalty rate trends and compliance."
    - name: "discount_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_discount_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoice lines where a discount was applied. Measures how broadly discounts are being granted — high rates signal pricing policy issues."
    - name: "net_revenue_per_unit"
      expr: ROUND(SUM(CAST(net_amount AS DOUBLE)) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 4)
      comment: "Net revenue per unit billed. Effective average selling price net of discounts — primary metric for pricing strategy and margin management."
    - name: "distinct_skus_billed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs appearing on invoice lines. Measures product breadth in billing and identifies revenue concentration risk."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_payment_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection and payment receipt KPIs covering payment volumes, methods, FX impact, and overpayment/partial payment rates. Used by Treasury, AR Collections, and CFO to manage cash flow and collection efficiency."
  source: "`vibe_semiconductors_v1`.`invoice`.`payment_receipt`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment receipt (e.g. Applied, Unapplied, Reversed) — primary filter for cash application efficiency analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. Wire, ACH, Check, Credit Card) — used to analyze payment channel mix and processing costs."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Standard, Advance, On-Account) — used to classify cash receipts for treasury reporting."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (e.g. Portal, Bank Transfer, Manual) — used to drive digital payment adoption."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment receipt — used for multi-currency cash management and FX gain/loss analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment receipt — primary time dimension for monthly cash collection trend analysis."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Status of compliance screening on the payment (e.g. Cleared, Flagged, Pending) — used for AML/sanctions compliance monitoring."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the payment was reversed — used to identify payment reversal rates and fraud risk."
  measures:
    - name: "total_payments_received"
      expr: COUNT(1)
      comment: "Total number of payment receipts processed. Baseline volume metric for AR cash application workload."
    - name: "total_cash_collected"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total cash collected across all payment receipts. Primary treasury KPI for cash inflow monitoring and liquidity management."
    - name: "total_net_amount_applied"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount applied to invoices after discounts. Measures effective cash application against outstanding AR."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount_total AS DOUBLE))
      comment: "Total amount allocated to specific invoices. Used to measure cash application completeness and identify unapplied cash."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payments converted to functional currency. Used by treasury to measure FX-adjusted cash collections for consolidated reporting."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken by customers. Measures cost of early payment incentive programs against cash acceleration benefit."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts collected in payments. Used for tax remittance reconciliation and VAT/GST compliance."
    - name: "avg_payment_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average payment receipt amount. Tracks customer payment behavior and identifies shifts in payment size patterns."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to payments. Used by treasury to monitor FX rate trends and hedging effectiveness."
    - name: "overpayment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overpayment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that resulted in overpayments. High rates indicate billing or payment processing errors requiring investigation."
    - name: "partial_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN partial_payment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that are partial. High partial payment rates signal customer cash flow stress or invoice disputes."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were reversed. Elevated reversal rates indicate fraud risk, bank errors, or customer disputes."
    - name: "residual_open_amount_total"
      expr: SUM(CAST(residual_open_amount AS DOUBLE))
      comment: "Total residual open amount remaining after payment application. Measures unapplied cash and partial payment exposure in AR."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute KPIs covering dispute volumes, amounts, resolution rates, and aging. Used by AR Director, Customer Success, and CFO to manage dispute resolution efficiency and protect revenue."
  source: "`vibe_semiconductors_v1`.`invoice`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. Open, In Review, Resolved, Escalated) — primary filter for dispute pipeline management."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g. Pricing, Quantity, Quality, Duplicate) — used to identify systemic billing issues by root cause."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the dispute — used for process improvement and reducing dispute recurrence."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution outcome (e.g. Accepted, Rejected, Settled) — used to measure dispute win/loss rates and settlement patterns."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the dispute — used to identify disputes requiring executive intervention."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount — used for multi-currency dispute exposure analysis."
    - name: "dispute_open_month"
      expr: DATE_TRUNC('MONTH', open_timestamp)
      comment: "Month the dispute was opened — primary time dimension for dispute trend analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute (e.g. High, Medium, Low) — used to prioritize resolution resources."
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of disputes raised. Baseline volume metric for billing quality and customer satisfaction monitoring."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute. Primary financial exposure KPI — high values signal revenue at risk requiring urgent resolution."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled in dispute resolution. Measures actual revenue concessions made to resolve disputes."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute. Tracks dispute severity trends — rising averages signal escalating billing issues."
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Settlement amount as a percentage of disputed amount. Measures revenue concession rate — high values indicate weak dispute defense."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'Open' THEN 1 END)
      comment: "Number of currently open disputes. Key operational KPI for AR collections team — drives daily dispute resolution prioritization."
    - name: "open_dispute_amount"
      expr: SUM(CASE WHEN dispute_status = 'Open' THEN disputed_amount ELSE 0 END)
      comment: "Total amount in open disputes. Measures current revenue at risk from unresolved disputes — reported to CFO weekly."
    - name: "distinct_customers_with_disputes"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with disputes. Identifies breadth of dispute exposure across the customer base."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_credit_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit hold KPIs covering hold volumes, amounts, risk scores, and release rates. Used by Credit Risk, AR Director, and CFO to manage customer credit exposure and order release decisions."
  source: "`vibe_semiconductors_v1`.`invoice`.`credit_hold`"
  dimensions:
    - name: "credit_hold_status"
      expr: credit_hold_status
      comment: "Current status of the credit hold (e.g. Active, Released, Expired) — primary filter for active credit risk exposure."
    - name: "hold_category"
      expr: hold_category
      comment: "Category of the credit hold (e.g. Credit Limit Exceeded, Overdue, Risk Score) — used to identify root causes of holds."
    - name: "hold_reason"
      expr: hold_reason
      comment: "Specific reason for the credit hold — used for credit policy analysis and customer communication."
    - name: "block_level"
      expr: block_level
      comment: "Level at which the hold is applied (e.g. Account, Order, Invoice) — used to assess scope of credit restriction."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the hold amount — used for multi-currency credit exposure analysis."
    - name: "hold_placed_month"
      expr: DATE_TRUNC('MONTH', hold_placed_timestamp)
      comment: "Month the credit hold was placed — used for trend analysis of credit hold frequency."
  measures:
    - name: "total_credit_holds"
      expr: COUNT(1)
      comment: "Total number of credit holds placed. Baseline metric for credit risk management activity and customer financial health."
    - name: "total_hold_amount"
      expr: SUM(CAST(hold_amount AS DOUBLE))
      comment: "Total revenue amount blocked by credit holds. Measures revenue at risk from credit restrictions — key metric for order management and sales."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across credit holds. Primary indicator of AR collection risk and customer payment delinquency."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit across all holds. Measures aggregate credit exposure granted to customers under hold."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average customer risk score across credit holds. Tracks portfolio credit quality — rising scores signal deteriorating customer creditworthiness."
    - name: "active_hold_count"
      expr: COUNT(CASE WHEN credit_hold_status = 'Active' THEN 1 END)
      comment: "Number of currently active credit holds. Operational KPI for order management — active holds block revenue and require daily review."
    - name: "active_hold_amount"
      expr: SUM(CASE WHEN credit_hold_status = 'Active' THEN hold_amount ELSE 0 END)
      comment: "Total revenue blocked by active credit holds. Measures current revenue impact of credit restrictions — reported to VP Sales and CFO."
    - name: "distinct_customers_on_hold"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts currently on credit hold. Measures breadth of credit risk exposure across the customer portfolio."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_customer_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit limit portfolio KPIs covering credit utilization, limit adequacy, and risk classification. Used by Credit Risk Management, CFO, and Treasury to manage credit exposure and set appropriate limits."
  source: "`vibe_semiconductors_v1`.`invoice`.`customer_credit_limit`"
  dimensions:
    - name: "credit_limit_status"
      expr: credit_limit_status
      comment: "Status of the credit limit record (e.g. Active, Expired, Under Review) — primary filter for active credit portfolio analysis."
    - name: "credit_limit_type"
      expr: credit_limit_type
      comment: "Type of credit limit (e.g. Standard, Secured, Insured) — used to analyze credit structure and risk mitigation."
    - name: "credit_risk_classification"
      expr: credit_risk_classification
      comment: "Risk classification of the customer (e.g. Low, Medium, High, Watch) — primary dimension for credit risk portfolio analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "External or internal credit rating of the customer — used for credit policy compliance and limit-setting governance."
    - name: "credit_currency"
      expr: credit_currency
      comment: "Currency in which the credit limit is denominated — used for multi-currency credit exposure analysis."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the customer credit relationship — used for credit exposure analysis by business segment."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the customer — used for regional credit risk concentration analysis."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Flag indicating whether the customer is currently on credit hold — used to filter active credit risk cases."
  measures:
    - name: "total_customers_with_credit_limits"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with active credit limits. Measures breadth of credit portfolio and customer base coverage."
    - name: "total_credit_limit_granted"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit granted across all customers. Measures aggregate credit exposure — primary KPI for credit risk management and capital allocation."
    - name: "total_credit_utilized"
      expr: SUM(CAST(credit_utilization_amount AS DOUBLE))
      comment: "Total credit currently utilized by customers. Measures actual credit exposure vs. limit — used for liquidity and risk management."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amounts across all credit limit records. Key indicator of collection risk and potential bad debt exposure."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage across customers. High utilization signals customers approaching credit limits — triggers proactive credit review."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per customer. Tracks credit policy generosity trends and benchmarks against industry norms."
    - name: "customers_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of customers currently on credit hold. Operational KPI for AR and sales — holds block order processing and revenue."
    - name: "credit_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_utilization_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "Portfolio-level credit utilization rate. Measures how much of the total credit granted is being used — high rates signal elevated credit risk."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_dunning_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning and collections KPIs covering overdue amounts, dunning escalation levels, and collection effectiveness. Used by AR Collections, Credit Risk, and CFO to manage delinquent receivables and reduce bad debt."
  source: "`vibe_semiconductors_v1`.`invoice`.`dunning_notice`"
  dimensions:
    - name: "dunning_notice_status"
      expr: dunning_notice_status
      comment: "Current status of the dunning notice (e.g. Sent, Responded, Escalated, Closed) — primary filter for active collections pipeline."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level (e.g. Level 1, 2, 3, Legal) — measures severity of collection action and customer delinquency."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the dunning notice (e.g. Email, Post, Phone) — used to optimize collection channel effectiveness."
    - name: "response_status"
      expr: response_status
      comment: "Customer response to the dunning notice (e.g. Promised, Disputed, No Response) — used to forecast collection outcomes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the overdue amount — used for multi-currency collections analysis."
    - name: "notice_month"
      expr: DATE_TRUNC('MONTH', notice_date)
      comment: "Month the dunning notice was issued — primary time dimension for collections activity trend analysis."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Flag indicating whether the account is under legal hold — used to identify accounts in legal collections proceedings."
    - name: "escalation_threshold_exceeded"
      expr: escalation_threshold_exceeded
      comment: "Flag indicating whether the escalation threshold has been exceeded — used to prioritize high-risk collection cases."
  measures:
    - name: "total_dunning_notices"
      expr: COUNT(1)
      comment: "Total number of dunning notices issued. Baseline metric for collections activity volume and AR delinquency breadth."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across all dunning notices. Primary collections KPI — measures total delinquent AR requiring active collection."
    - name: "total_dunning_charges"
      expr: SUM(CAST(dunning_charge AS DOUBLE))
      comment: "Total dunning/late fees charged. Measures revenue from penalty enforcement and incentive for timely payment."
    - name: "total_interest_charged"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged on overdue amounts. Measures financial penalty enforcement effectiveness and cost to delinquent customers."
    - name: "total_due_amount"
      expr: SUM(CAST(total_due AS DOUBLE))
      comment: "Total amount due including principal, interest, and fees. Comprehensive collections exposure metric for treasury and credit management."
    - name: "avg_interest_rate_pct"
      expr: AVG(CAST(interest_rate_percent AS DOUBLE))
      comment: "Average interest rate applied to overdue amounts. Used to assess consistency of penalty enforcement across the customer portfolio."
    - name: "legal_hold_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts under legal hold for collections. Measures severity of delinquency requiring legal intervention — reported to CFO and General Counsel."
    - name: "escalation_exceeded_count"
      expr: COUNT(CASE WHEN escalation_threshold_exceeded = TRUE THEN 1 END)
      comment: "Number of dunning notices where escalation threshold was exceeded. Identifies high-risk accounts requiring immediate collections action."
    - name: "distinct_customers_in_dunning"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with active dunning notices. Measures breadth of delinquency across the customer base."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_adjustment_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice adjustment memo KPIs covering credit/debit memo volumes, amounts, approval rates, and settlement efficiency. Used by Revenue Accounting, AR, and Audit to control revenue adjustments and ensure proper authorization."
  source: "`vibe_semiconductors_v1`.`invoice`.`adjustment_memo`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g. Credit, Debit, Rebate, Write-Off) — primary classification for revenue adjustment analysis."
    - name: "adjustment_subtype"
      expr: adjustment_subtype
      comment: "Sub-type of adjustment providing additional classification granularity — used for detailed adjustment root cause analysis."
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Business category of the adjustment (e.g. Pricing Error, Return, Dispute Settlement) — used to identify systemic billing issues."
    - name: "adjustment_memo_status"
      expr: adjustment_memo_status
      comment: "Current status of the adjustment memo (e.g. Draft, Pending Approval, Approved, Applied) — used to track adjustment pipeline."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (e.g. Pending, Approved, Rejected) — used for authorization control and audit compliance."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the adjustment (e.g. Settled, Pending, Partial) — used to track adjustment application to invoices."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment — used for multi-currency adjustment analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the adjustment is effective — primary time dimension for adjustment trend analysis."
    - name: "is_manual"
      expr: is_manual
      comment: "Flag indicating whether the adjustment was manually created — used to monitor manual override rates and audit risk."
  measures:
    - name: "total_adjustment_memos"
      expr: COUNT(1)
      comment: "Total number of adjustment memos issued. Baseline metric for revenue adjustment activity and billing correction frequency."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied through adjustment memos. Measures actual revenue adjustments posted — key metric for revenue integrity and audit."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for adjustment. Measures authorized revenue adjustments — compared to applied amount to detect unauthorized postings."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total unapplied balance remaining on adjustment memos. Measures pending revenue adjustments not yet applied to invoices."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of adjustment memos. Used for tax credit/debit reconciliation in VAT and GST filings."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total amount per adjustment memo. Tracks adjustment size trends — large averages signal systemic pricing or billing issues."
    - name: "manual_adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that are manually created. High manual rates indicate process gaps and elevated audit risk — target is below 10%."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustment memos that received approval. Measures authorization compliance — low rates signal approval bottlenecks."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 revenue recognition KPIs covering recognized revenue, deferred revenue, COGS, and profit by period. Used by Revenue Accounting, CFO, and External Auditors to ensure compliant revenue recognition and accurate financial reporting."
  source: "`vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event`"
  dimensions:
    - name: "revenue_recognition_event_status"
      expr: revenue_recognition_event_status
      comment: "Status of the recognition event (e.g. Recognized, Deferred, Reversed) — primary filter for revenue recognition pipeline."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (e.g. Point-in-Time, Over-Time, Milestone) — used for ASC 606 compliance analysis."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue being recognized (e.g. Product, NRE, Royalty, Service) — used for revenue mix analysis in financial reporting."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for the recognition event — primary dimension for period-over-period revenue comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recognition event — used for multi-currency revenue reporting and FX analysis."
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_timestamp)
      comment: "Month of revenue recognition — primary time dimension for monthly revenue trend analysis."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating whether the recognition event was reversed — used to identify and investigate revenue reversals."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the recognition period start — used for over-time revenue spread analysis."
  measures:
    - name: "total_revenue_recognized"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue recognized in the period. Primary financial reporting KPI — directly feeds the income statement and is audited for ASC 606 compliance."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods. Key balance sheet metric — measures performance obligations not yet satisfied."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold associated with recognized revenue. Used to calculate gross margin and assess product profitability."
    - name: "total_profit_amount"
      expr: SUM(CAST(profit_amount AS DOUBLE))
      comment: "Total profit from recognized revenue events. Measures gross profitability of recognized revenue — key P&L metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax associated with revenue recognition events. Used for tax provision calculations and regulatory reporting."
    - name: "avg_revenue_per_event"
      expr: AVG(CAST(revenue_amount AS DOUBLE))
      comment: "Average revenue amount per recognition event. Tracks deal size and revenue concentration trends."
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(profit_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage on recognized revenue. Primary profitability KPI — directly informs pricing strategy and cost management decisions."
    - name: "deferred_revenue_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_amount AS DOUBLE)) + SUM(CAST(deferred_amount AS DOUBLE)), 0), 2)
      comment: "Deferred revenue as a percentage of total revenue (recognized + deferred). Measures revenue timing risk and backlog quality under ASC 606."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Number of reversed revenue recognition events. Elevated reversals signal accounting errors or contract modifications requiring investigation."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 performance obligation KPIs covering obligation fulfillment, revenue recognition progress, and backlog. Used by Revenue Accounting and CFO to manage contract performance obligations and ensure compliant revenue recognition."
  source: "`vibe_semiconductors_v1`.`invoice`.`performance_obligation`"
  dimensions:
    - name: "performance_obligation_status"
      expr: performance_obligation_status
      comment: "Status of the performance obligation (e.g. Open, Partially Satisfied, Fully Satisfied, Cancelled) — primary filter for obligation pipeline."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of performance obligation (e.g. Product Delivery, NRE Service, License, Support) — used for revenue category analysis."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Method for recognizing this obligation (e.g. Point-in-Time, Over-Time) — used for ASC 606 compliance monitoring."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing for the obligation (e.g. Monthly, Quarterly, Milestone) — used for cash flow forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the performance obligation — used for multi-currency contract analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the obligation becomes effective — used for obligation cohort analysis and backlog aging."
  measures:
    - name: "total_performance_obligations"
      expr: COUNT(1)
      comment: "Total number of performance obligations. Baseline metric for contract complexity and revenue recognition workload."
    - name: "total_obligation_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations. Measures total contracted revenue backlog — key metric for revenue forecasting."
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total amount recognized from performance obligations. Measures revenue earned from contract fulfillment — feeds the income statement."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax associated with performance obligations. Used for tax provision and compliance reporting."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total target quantity across performance obligations. Used to measure volume commitments and fulfillment progress."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity delivered against performance obligations. Measures fulfillment progress against contractual commitments."
    - name: "obligation_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total obligation amount that has been recognized. Measures contract fulfillment progress — critical for ASC 606 compliance and revenue forecasting."
    - name: "quantity_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of target quantity actually delivered. Measures operational fulfillment against contractual volume commitments."
    - name: "avg_obligation_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction price per performance obligation. Tracks contract size trends and revenue concentration."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_royalty_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP royalty billing KPIs covering royalty revenue, rates, audit status, and payment collection. Used by IP Licensing, Finance, and Legal to manage royalty revenue streams and ensure compliance with licensing agreements."
  source: "`vibe_semiconductors_v1`.`invoice`.`royalty_billing`"
  dimensions:
    - name: "royalty_type"
      expr: royalty_type
      comment: "Type of royalty (e.g. Unit-Based, Revenue-Based, Flat Fee) — used to analyze royalty revenue by licensing structure."
    - name: "royalty_calculation_method"
      expr: royalty_calculation_method
      comment: "Method used to calculate the royalty (e.g. Per Unit, Percentage of Revenue, Tiered) — used for royalty audit and compliance."
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status (e.g. Billed, Pending, Disputed) — primary filter for royalty billing pipeline management."
    - name: "audit_status"
      expr: audit_status
      comment: "Royalty audit status (e.g. Not Audited, In Progress, Completed) — used to track royalty audit coverage and compliance."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the royalty billing — used to identify unreconciled royalty amounts."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty billing — used for multi-currency royalty revenue analysis."
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month of royalty billing — primary time dimension for royalty revenue trend analysis."
    - name: "tier_level"
      expr: tier_level
      comment: "Royalty tier level applicable to the billing — used to analyze royalty rate tier distribution."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the royalty billing is under dispute — used to identify disputed royalty revenue."
  measures:
    - name: "total_royalty_billings"
      expr: COUNT(1)
      comment: "Total number of royalty billing records. Baseline metric for IP licensing activity volume."
    - name: "total_royalty_gross_amount"
      expr: SUM(CAST(royalty_amount_gross AS DOUBLE))
      comment: "Total gross royalty revenue billed. Primary IP licensing revenue KPI — measures total royalty income before adjustments."
    - name: "total_royalty_net_amount"
      expr: SUM(CAST(royalty_amount_net AS DOUBLE))
      comment: "Total net royalty revenue after adjustments. Measures actual royalty income recognized — used in IP licensing P&L reporting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty billings. Measures royalty correction magnitude — large adjustments signal reporting inaccuracies by licensees."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on royalty billings. Used for withholding tax compliance and cross-border royalty tax reporting."
    - name: "total_unit_shipment_volume"
      expr: SUM(CAST(unit_shipment_volume AS DOUBLE))
      comment: "Total units shipped by licensees as reported for royalty calculation. Used to verify royalty reports and detect under-reporting."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across all billings. Tracks effective royalty rate trends and benchmarks against licensing agreement terms."
    - name: "avg_exchange_rate_to_usd"
      expr: AVG(CAST(exchange_rate_to_usd AS DOUBLE))
      comment: "Average FX rate used for USD conversion of royalty billings. Used by treasury to monitor FX impact on royalty revenue."
    - name: "disputed_royalty_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of royalty billings under dispute. High rates signal licensee non-compliance or calculation methodology disagreements."
    - name: "royalty_adjustment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(adjustment_amount AS DOUBLE)) / NULLIF(SUM(CAST(royalty_amount_gross AS DOUBLE)), 0), 2)
      comment: "Royalty adjustments as a percentage of gross royalty billed. Measures royalty reporting accuracy — high rates indicate systemic licensee under/over-reporting."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off KPIs covering write-off volumes, amounts, recovery rates, and financial impact. Used by CFO, Credit Risk, and External Auditors to manage bad debt expense and assess collection effectiveness."
  source: "`vibe_semiconductors_v1`.`invoice`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of the write-off (e.g. Pending, Approved, Posted, Reversed) — primary filter for write-off pipeline management."
    - name: "write_off_type"
      expr: write_off_type
      comment: "Type of write-off (e.g. Bad Debt, Disputed, Uncollectible) — used to classify bad debt expense by cause."
    - name: "write_off_category"
      expr: write_off_category
      comment: "Category of the write-off — used for detailed bad debt analysis and provision adequacy assessment."
    - name: "method"
      expr: method
      comment: "Write-off method applied (e.g. Direct, Allowance) — used for accounting policy compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the write-off — used for multi-currency bad debt analysis."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month the write-off was recorded — primary time dimension for bad debt trend analysis."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Recovery status of the written-off amount (e.g. Not Attempted, In Progress, Recovered) — used to track post-write-off recovery efforts."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating whether the write-off was reversed — used to identify recovered write-offs and adjust bad debt expense."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the write-off has compliance implications — used for regulatory reporting and audit."
  measures:
    - name: "total_write_offs"
      expr: COUNT(1)
      comment: "Total number of write-off records. Baseline metric for bad debt activity volume and collection failure frequency."
    - name: "total_gross_write_off_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount written off. Primary bad debt KPI — measures total revenue permanently lost to uncollectible receivables."
    - name: "total_net_write_off_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net write-off amount after adjustments. Measures actual bad debt expense recognized in the P&L."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount_adjustment AS DOUBLE))
      comment: "Total adjustments applied to write-offs. Used to reconcile gross vs. net write-off amounts and validate allowance adequacy."
    - name: "total_tax_effect_amount"
      expr: SUM(CAST(tax_effect_amount AS DOUBLE))
      comment: "Total tax effect of write-offs. Used by tax controllers to calculate deductible bad debt expense for tax filings."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross write-off amount per record. Tracks write-off severity trends — rising averages signal deteriorating customer credit quality."
    - name: "recovery_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recovery_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of write-offs flagged for recovery. Measures post-write-off collection effort coverage — low rates indicate missed recovery opportunities."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reversed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of write-offs that were subsequently reversed. Measures write-off accuracy — high reversal rates indicate premature write-offs."
    - name: "distinct_customers_written_off"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with write-offs. Measures breadth of bad debt exposure across the customer portfolio."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_pricing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer pricing agreement and rebate KPIs covering agreement values, rebate accruals, settlement rates, and discount structures. Used by Sales Finance, Revenue Operations, and CFO to manage pricing governance and rebate liability."
  source: "`vibe_semiconductors_v1`.`invoice`.`pricing_agreement`"
  dimensions:
    - name: "pricing_agreement_status"
      expr: pricing_agreement_status
      comment: "Current status of the pricing agreement (e.g. Active, Expired, Pending Approval) — primary filter for active pricing governance."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (e.g. Volume Rebate, Special Price, Distribution) — used to analyze pricing structure by agreement type."
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g. Volume, Growth, Loyalty) — used to analyze rebate program effectiveness and cost."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing agreement — used for multi-currency pricing analysis."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "Frequency of rebate settlement (e.g. Monthly, Quarterly, Annual) — used for cash flow planning and rebate liability management."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the pricing agreement is exclusive — used to identify strategic customer pricing commitments."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the pricing agreement becomes effective — used for agreement cohort analysis."
  measures:
    - name: "total_pricing_agreements"
      expr: COUNT(1)
      comment: "Total number of pricing agreements. Baseline metric for pricing governance complexity and customer pricing coverage."
    - name: "total_price_amount"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Total contracted price amount across pricing agreements. Measures total pricing commitment value in the portfolio."
    - name: "total_rebate_accrued"
      expr: SUM(CAST(rebate_accrued_amount AS DOUBLE))
      comment: "Total rebate amount accrued but not yet settled. Measures rebate liability on the balance sheet — key metric for financial close."
    - name: "total_rebate_settled"
      expr: SUM(CAST(rebate_settled_amount AS DOUBLE))
      comment: "Total rebate amount settled with customers. Measures actual cash paid out for rebate programs — used in pricing ROI analysis."
    - name: "total_minimum_commitment"
      expr: SUM(CAST(minimum_commitment_amount AS DOUBLE))
      comment: "Total minimum purchase commitments across pricing agreements. Measures contracted revenue floor and customer volume obligations."
    - name: "total_maximum_commitment"
      expr: SUM(CAST(maximum_commitment_amount AS DOUBLE))
      comment: "Total maximum purchase commitments across pricing agreements. Measures contracted revenue ceiling and capacity planning inputs."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across pricing agreements. Tracks pricing discipline — rising averages signal margin erosion from excessive discounting."
    - name: "avg_rebate_rate_pct"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate across pricing agreements. Measures cost of rebate programs — used to optimize rebate structure and ROI."
    - name: "rebate_settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rebate_settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(rebate_accrued_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of accrued rebates that have been settled. Measures rebate settlement efficiency — low rates indicate accrual-to-cash timing gaps."
    - name: "distinct_customers_with_agreements"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with pricing agreements. Measures pricing agreement coverage across the customer base."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_nre_billing_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) billing milestone KPIs covering milestone completion, billing amounts, and schedule adherence. Used by Program Management, Finance, and Sales to manage NRE revenue recognition and project billing."
  source: "`vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone`"
  dimensions:
    - name: "nre_billing_milestone_status"
      expr: nre_billing_milestone_status
      comment: "Current status of the NRE billing milestone (e.g. Planned, In Progress, Completed, Billed) — primary filter for NRE billing pipeline."
    - name: "billing_trigger_type"
      expr: billing_trigger_type
      comment: "Type of event that triggers billing (e.g. Tapeout, Wafer Start, Delivery, Acceptance) — used to analyze NRE billing structure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the NRE milestone billing — used for multi-currency NRE revenue analysis."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the milestone is recurring — used to separate one-time and recurring NRE revenue streams."
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month the milestone was planned — used for NRE schedule adherence analysis."
    - name: "actual_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Month the milestone was actually completed — used to measure NRE delivery schedule performance."
  measures:
    - name: "total_nre_milestones"
      expr: COUNT(1)
      comment: "Total number of NRE billing milestones. Baseline metric for NRE program complexity and billing activity."
    - name: "total_nre_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross NRE revenue billed across milestones. Primary NRE revenue KPI — measures total engineering services revenue."
    - name: "total_nre_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net NRE revenue after adjustments. Measures actual NRE revenue recognized — used in program P&L reporting."
    - name: "total_nre_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on NRE billings. Used for tax compliance and cross-border NRE service tax reporting."
    - name: "avg_nre_milestone_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average NRE milestone billing amount. Tracks NRE deal size trends and benchmarks against program budgets."
    - name: "distinct_nre_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Number of distinct IC design projects with NRE billing milestones. Measures NRE program breadth and customer engagement depth."
    - name: "distinct_nre_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with NRE billing milestones. Measures NRE customer base breadth and revenue concentration."
$$;


CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_tax_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax determination and compliance KPIs covering tax amounts, rates, withholding, and reverse charge mechanisms. Used by Tax Controllers, CFO, and Compliance teams to manage tax liability, filing accuracy, and regulatory compliance."
  source: "`vibe_semiconductors_v1`.`invoice`.`tax_determination`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g. VAT, GST, Sales Tax, Withholding) — primary dimension for tax liability analysis by tax regime."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category (e.g. Standard Rate, Reduced Rate, Zero Rate, Exempt) — used for tax rate compliance analysis."
    - name: "tax_jurisdiction_type"
      expr: tax_jurisdiction_type
      comment: "Type of tax jurisdiction (e.g. Federal, State, Local, Country) — used for multi-jurisdiction tax reporting."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction code — used for jurisdiction-level tax liability analysis and filing."
    - name: "tax_line_status"
      expr: tax_line_status
      comment: "Status of the tax determination line (e.g. Active, Voided, Adjusted) — used to filter valid tax records."
    - name: "tax_currency"
      expr: tax_currency
      comment: "Currency of the tax determination — used for multi-currency tax analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating whether the transaction is tax-exempt — used for exemption certificate compliance monitoring."
    - name: "tax_is_reverse_charge"
      expr: tax_is_reverse_charge
      comment: "Flag indicating whether reverse charge mechanism applies — used for B2B cross-border VAT compliance."
    - name: "tax_withholding_flag"
      expr: tax_withholding_flag
      comment: "Flag indicating whether withholding tax applies — used for withholding tax compliance and remittance tracking."
    - name: "tax_reporting_month"
      expr: DATE_TRUNC('MONTH', tax_reporting_period)
      comment: "Month of the tax reporting period — primary time dimension for periodic tax filing analysis."
  measures:
    - name: "total_tax_determinations"
      expr: COUNT(1)
      comment: "Total number of tax determination records. Baseline metric for tax calculation volume and compliance coverage."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount determined. Primary tax liability KPI — used for tax provision, filing, and remittance calculations."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total taxable base amount. Used to validate effective tax rates and detect base erosion or misclassification."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credits applied. Measures tax credit utilization — used to optimize tax position and reduce effective tax rate."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total withholding tax amounts. Used for withholding tax remittance compliance and cross-border payment reporting."
    - name: "total_taxable_quantity"
      expr: SUM(CAST(taxable_quantity AS DOUBLE))
      comment: "Total taxable quantity across tax determinations. Used to validate quantity-based tax calculations."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across determinations. Used to monitor tax rate consistency and detect anomalies in tax calculation."
    - name: "avg_withholding_rate_pct"
      expr: AVG(CAST(withholding_rate AS DOUBLE))
      comment: "Average withholding tax rate applied. Used to verify withholding rate compliance with treaty rates and local regulations."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(tax_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable base. Key tax compliance KPI — deviations from statutory rates trigger audit investigation."
    - name: "tax_exempt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tax_exempt_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax determinations that are tax-exempt. Used to monitor exemption certificate coverage and compliance risk."
    - name: "reverse_charge_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tax_is_reverse_charge = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions subject to reverse charge mechanism. Used for cross-border VAT compliance monitoring and reporting."
$$;
