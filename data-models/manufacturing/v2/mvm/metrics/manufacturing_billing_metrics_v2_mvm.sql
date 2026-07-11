-- Metric views for domain: billing | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:39:56

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic billing account health and credit exposure metrics for AR management and credit risk steering."
  source: "`vibe_manufacturing_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., corporate, individual, government)."
    - name: "billing_account_status"
      expr: billing_account_status
      comment: "Current status of the billing account (active, suspended, closed)."
    - name: "collection_stage"
      expr: collection_stage
      comment: "Current collection stage for overdue accounts (e.g., early, escalated, legal)."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account for risk assessment."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing cycles (monthly, quarterly, annual)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the account operates."
    - name: "payment_method"
      expr: payment_method
      comment: "Primary payment method for the account."
    - name: "auto_payment_enabled"
      expr: auto_payment_enabled
      comment: "Whether automatic payment is enabled for the account."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the account is tax-exempt."
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year the account was opened."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of billing accounts."
    - name: "total_ar_balance"
      expr: SUM(CAST(current_ar_balance AS DOUBLE))
      comment: "Total accounts receivable balance across all accounts — key cash flow and working capital metric."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended to all accounts — measures credit exposure and risk appetite."
    - name: "avg_ar_balance_per_account"
      expr: AVG(CAST(current_ar_balance AS DOUBLE))
      comment: "Average AR balance per account — indicates typical account size and collection efficiency."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account — measures typical credit exposure per customer."
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(current_ar_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total credit limit currently utilized — critical for credit risk management and liquidity planning."
    - name: "accounts_with_ar_balance"
      expr: COUNT(CASE WHEN current_ar_balance > 0 THEN 1 END)
      comment: "Number of accounts with outstanding AR balance — measures active receivables portfolio size."
    - name: "accounts_in_collection"
      expr: COUNT(CASE WHEN collection_stage IS NOT NULL AND collection_stage != '' THEN 1 END)
      comment: "Number of accounts currently in collection stages — key indicator of credit quality deterioration."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core revenue recognition and invoice performance metrics for financial planning and cash conversion analysis."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (draft, issued, paid, cancelled)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit note, debit note, proforma)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (unpaid, partial, paid, overdue)."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status for overdue invoices."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms applied to the invoice (e.g., Net 30, Net 60)."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the invoice is tax-exempt."
    - name: "is_self_billing"
      expr: is_self_billing
      comment: "Whether the invoice is a self-billing invoice."
    - name: "issue_year"
      expr: YEAR(issue_timestamp)
      comment: "Year the invoice was issued."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Month the invoice was issued."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the invoice is due."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes — measures top-line billing volume."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and taxes — key revenue recognition metric for financial reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given across all invoices — measures pricing concessions and margin erosion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices — critical for tax remittance and compliance reporting."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value — indicates typical transaction size and customer order patterns."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to invoices — measures pricing strategy effectiveness."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to invoices."
    - name: "discount_penetration_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross revenue given as discounts — key margin management and pricing power indicator."
    - name: "effective_tax_rate"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as percentage of net revenue — measures blended tax burden for financial planning."
    - name: "invoices_overdue"
      expr: COUNT(CASE WHEN payment_status = 'overdue' THEN 1 END)
      comment: "Number of overdue invoices — critical early warning indicator for cash flow and credit risk."
    - name: "invoices_paid"
      expr: COUNT(CASE WHEN payment_status = 'paid' THEN 1 END)
      comment: "Number of fully paid invoices — measures collection effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular revenue and margin analytics at line-item level for product mix and pricing optimization."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the invoice line item."
    - name: "line_type"
      expr: line_type
      comment: "Type of line item (product, service, fee, discount)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Method used for revenue recognition (immediate, deferred, milestone-based)."
    - name: "deferred_revenue_flag"
      expr: deferred_revenue_flag
      comment: "Whether revenue for this line is deferred."
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Whether the line is part of a credit memo."
    - name: "is_royalty_line"
      expr: is_royalty_line
      comment: "Whether the line represents a royalty payment."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the line item is tax-exempt."
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the line item quantity."
    - name: "service_start_year"
      expr: YEAR(service_start_date)
      comment: "Year the service period starts for subscription/service lines."
    - name: "service_start_month"
      expr: DATE_TRUNC('MONTH', service_start_date)
      comment: "Month the service period starts."
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of invoice line items."
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total line amount before discounts and taxes — measures gross product/service revenue."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net line amount after discounts and taxes — key revenue metric for product mix analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount given at line level — measures promotional effectiveness and margin impact."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on line items."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items invoiced — measures volume throughput."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all line items — indicates pricing trends and product mix shift."
    - name: "avg_line_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per line item — measures typical line-level transaction value."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied to line items — key pricing strategy metric."
    - name: "line_discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(line_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of line amount given as discounts — measures line-level margin erosion."
    - name: "deferred_revenue_lines"
      expr: COUNT(CASE WHEN deferred_revenue_flag = TRUE THEN 1 END)
      comment: "Number of lines with deferred revenue — critical for revenue recognition timing and financial forecasting."
    - name: "credit_memo_lines"
      expr: COUNT(CASE WHEN is_credit_memo = TRUE THEN 1 END)
      comment: "Number of credit memo lines — measures returns, adjustments, and customer satisfaction issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection and payment performance metrics for treasury management and working capital optimization."
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (pending, cleared, failed, reversed)."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of payment allocation to invoices."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Bank clearing status of the payment."
    - name: "method"
      expr: method
      comment: "Payment method used (wire, check, ACH, credit card)."
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payment was received."
    - name: "original_currency"
      expr: original_currency
      comment: "Original currency if payment was converted."
    - name: "early_payment_discount_applied"
      expr: early_payment_discount_applied
      comment: "Whether early payment discount was applied."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the payment has been reconciled with bank statements."
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was received."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was received."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the payment was due."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions."
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross payment amount received — key cash inflow metric for treasury management."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net payment amount after fees and discounts — measures actual cash collected."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to invoices — measures payment application efficiency."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken by customers — measures cost of accelerating cash collection."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees — measures cost of payment channels and methods."
    - name: "avg_payment_amount_net"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net payment amount — indicates typical payment size and customer payment behavior."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate for multi-currency payments."
    - name: "payment_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount_gross AS DOUBLE)), 0), 2)
      comment: "Payment processing fees as percentage of gross amount — measures cost efficiency of payment channels."
    - name: "early_discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_taken AS DOUBLE)) / NULLIF(SUM(CAST(amount_gross AS DOUBLE)), 0), 2)
      comment: "Early payment discounts as percentage of gross amount — measures cost of cash acceleration programs."
    - name: "payments_with_early_discount"
      expr: COUNT(CASE WHEN early_payment_discount_applied = TRUE THEN 1 END)
      comment: "Number of payments that took early payment discount — measures program adoption and cash flow acceleration."
    - name: "unreconciled_payments"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Number of payments not yet reconciled — critical control metric for cash management and audit compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment allocation efficiency and cash application performance metrics for AR operations optimization."
  source: "`vibe_manufacturing_v1`.`billing`.`payment_application`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the payment allocation (pending, applied, reversed)."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (full, partial, overpayment, underpayment)."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Clearing status of the allocation."
    - name: "early_payment_discount_applied"
      expr: early_payment_discount_applied
      comment: "Whether early payment discount was applied in this allocation."
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year the payment was allocated."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month the payment was allocated."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of payment allocation transactions."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated from payments to invoices — measures cash application throughput and AR reduction."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discount taken at allocation — measures realized cost of early payment programs."
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average amount allocated per transaction — indicates typical allocation size and complexity."
    - name: "avg_allocation_sequence"
      expr: AVG(CAST(allocation_sequence AS DOUBLE))
      comment: "Average allocation sequence number — higher values indicate complex multi-invoice payment scenarios."
    - name: "discount_take_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_taken AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Discount taken as percentage of allocated amount — measures customer adoption of early payment incentives."
    - name: "allocations_with_discount"
      expr: COUNT(CASE WHEN early_payment_discount_applied = TRUE THEN 1 END)
      comment: "Number of allocations where early payment discount was applied — measures program utilization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk exposure and utilization metrics for credit policy management and risk mitigation."
  source: "`vibe_manufacturing_v1`.`billing`.`credit_limit`"
  dimensions:
    - name: "credit_limit_status"
      expr: credit_limit_status
      comment: "Current status of the credit limit (active, suspended, expired)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the credit limit request."
    - name: "limit_type"
      expr: limit_type
      comment: "Type of credit limit (temporary, permanent, project-specific)."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the credit limit (low, medium, high)."
    - name: "credit_block_flag"
      expr: credit_block_flag
      comment: "Whether credit is currently blocked for this limit."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit limit."
    - name: "credit_check_method"
      expr: credit_check_method
      comment: "Method used for credit checking (automatic, manual, external)."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the credit limit became effective."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the credit limit became effective."
  measures:
    - name: "total_credit_limits"
      expr: COUNT(1)
      comment: "Total number of credit limit records."
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total credit limit extended — measures total credit risk exposure and lending capacity."
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure AS DOUBLE))
      comment: "Total current credit exposure — key metric for credit risk monitoring and capital allocation."
    - name: "avg_limit_amount"
      expr: AVG(CAST(limit_amount AS DOUBLE))
      comment: "Average credit limit per customer — indicates typical credit policy and customer profile."
    - name: "avg_current_exposure"
      expr: AVG(CAST(current_exposure AS DOUBLE))
      comment: "Average current exposure per credit limit."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average credit utilization percentage — critical indicator of credit demand and risk concentration."
    - name: "portfolio_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(current_exposure AS DOUBLE)) / NULLIF(SUM(CAST(limit_amount AS DOUBLE)), 0), 2)
      comment: "Portfolio-wide credit utilization rate — key metric for credit capacity planning and risk management."
    - name: "credit_limits_blocked"
      expr: COUNT(CASE WHEN credit_block_flag = TRUE THEN 1 END)
      comment: "Number of credit limits currently blocked — measures credit control actions and risk mitigation."
    - name: "high_risk_limits"
      expr: COUNT(CASE WHEN risk_category = 'high' THEN 1 END)
      comment: "Number of high-risk credit limits — critical for portfolio risk assessment and provisioning."
$$;