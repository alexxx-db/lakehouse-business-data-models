-- Metric views for domain: finance | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_accounts_receivable_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key accounts receivable metrics tracking invoice aging, collection performance, and revenue recognition for construction projects"
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., draft, issued, paid, overdue)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., progress billing, final, retention release)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before deductions"
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount held by clients"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of invoices currently under dispute"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecasting metrics for construction project liquidity management and working capital planning"
  source: "`vibe_construction_v1`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of cash flow forecast (e.g., project-level, portfolio, enterprise)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g., draft, approved, superseded)"
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Time granularity of the forecast (e.g., weekly, monthly, quarterly)"
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month the forecast was prepared"
    - name: "forecast_period_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Month of the forecasted period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the forecast is denominated"
  measures:
    - name: "total_forecasted_inflow"
      expr: SUM(CAST(forecasted_inflow_amount AS DOUBLE))
      comment: "Total forecasted cash inflows"
    - name: "total_forecasted_outflow"
      expr: SUM(CAST(forecasted_outflow_amount AS DOUBLE))
      comment: "Total forecasted cash outflows"
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow (inflows minus outflows)"
    - name: "avg_closing_cash_balance"
      expr: AVG(CAST(closing_cash_balance AS DOUBLE))
      comment: "Average forecasted closing cash balance"
    - name: "total_working_capital_gap"
      expr: SUM(CAST(working_capital_gap AS DOUBLE))
      comment: "Total working capital gap requiring financing"
    - name: "max_peak_funding_requirement"
      expr: MAX(CAST(peak_funding_requirement AS DOUBLE))
      comment: "Maximum peak funding requirement across all forecasts"
    - name: "avg_credit_facility_utilization"
      expr: AVG(CAST(credit_facility_utilization AS DOUBLE))
      comment: "Average credit facility utilization percentage"
    - name: "total_subcontractor_payments"
      expr: SUM(CAST(subcontractor_payment_amount AS DOUBLE))
      comment: "Total forecasted subcontractor payments"
    - name: "total_material_procurement"
      expr: SUM(CAST(material_procurement_amount AS DOUBLE))
      comment: "Total forecasted material procurement costs"
    - name: "total_payroll"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Total forecasted payroll expenses"
    - name: "total_retention_release"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total forecasted retention releases from clients"
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Total number of cash flow forecasts"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_job_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job costing metrics tracking actual costs incurred on construction projects by cost code, phase, and resource"
  source: "`vibe_construction_v1`.`finance`.`job_cost_transaction`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost (e.g., labor, material, equipment, subcontractor)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (e.g., pending, approved, posted, reversed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transaction"
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the cost is billable to the client"
    - name: "billed_flag"
      expr: billed_flag
      comment: "Indicates whether the cost has been billed to the client"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this is a reversal transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month the transaction occurred"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the transaction was posted to the general ledger"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the transaction is recorded"
  measures:
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost incurred across all transactions"
    - name: "total_base_currency_cost"
      expr: SUM(CAST(base_currency_cost AS DOUBLE))
      comment: "Total cost in base currency after exchange rate conversion"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across transactions"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of resources consumed"
    - name: "billable_cost"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost that is billable to clients"
    - name: "non_billable_cost"
      expr: SUM(CASE WHEN billable_flag = FALSE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost that is not billable to clients"
    - name: "billable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of total costs that are billable"
    - name: "billed_cost"
      expr: SUM(CASE WHEN billed_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost that has been billed to clients"
    - name: "unbilled_cost"
      expr: SUM(CASE WHEN billable_flag = TRUE AND billed_flag = FALSE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total billable cost that has not yet been billed"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of job cost transactions"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budget performance metrics tracking budget vs actual costs, variances, and forecast at completion"
  source: "`vibe_construction_v1`.`finance`.`project_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., original, revised, forecast)"
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the budget (e.g., draft, approved, active, closed)"
    - name: "is_baseline_budget"
      expr: is_baseline_budget
      comment: "Indicates whether this is the baseline budget"
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the budget is currently active"
    - name: "budget_period_month"
      expr: DATE_TRUNC('MONTH', budget_period_start_date)
      comment: "Month of the budget period"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the budget was approved"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the budget"
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original budget amount before any changes"
    - name: "total_approved_change_orders"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Total approved change order amounts"
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget AS DOUBLE))
      comment: "Total current approved budget including change orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred to date"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs (e.g., purchase orders, subcontracts)"
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Total forecasted cost at project completion"
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total variance between budget and actual costs"
    - name: "budget_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(budget_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_approved_budget AS DOUBLE)), 0), 2)
      comment: "Budget variance as a percentage of current approved budget"
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(current_approved_budget AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost_amount AS DOUBLE)), 0), 3)
      comment: "Cost Performance Index (budgeted cost / actual cost) - values >1 indicate under budget"
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve_amount AS DOUBLE))
      comment: "Total contingency reserve allocated"
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve allocated"
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_approved_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of current approved budget utilized"
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_progress_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Progress billing metrics tracking work completed, amounts billed, and payment collection for construction projects"
  source: "`vibe_construction_v1`.`finance`.`progress_billing`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of payment (e.g., pending, received, overdue)"
    - name: "payment_certificate_type"
      expr: payment_certificate_type
      comment: "Type of payment certificate (e.g., interim, final, retention release)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging category for outstanding payments"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the billing is denominated"
  measures:
    - name: "total_scheduled_value"
      expr: SUM(CAST(scheduled_value AS DOUBLE))
      comment: "Total scheduled value of work"
    - name: "total_work_completed_to_date"
      expr: SUM(CAST(work_completed_to_date AS DOUBLE))
      comment: "Total value of work completed to date"
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average percentage of work completed"
    - name: "total_current_period_claim"
      expr: SUM(CAST(current_period_claim AS DOUBLE))
      comment: "Total amount claimed in the current billing period"
    - name: "total_previous_amount_billed"
      expr: SUM(CAST(previous_amount_billed AS DOUBLE))
      comment: "Total amount billed in previous periods"
    - name: "total_gross_amount_due"
      expr: SUM(CAST(gross_amount_due AS DOUBLE))
      comment: "Total gross amount due before deductions"
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount withheld"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage"
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after all deductions"
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total amount received from clients"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance not yet collected"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(net_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of net amounts due that have been collected"
    - name: "billing_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(work_completed_to_date AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_value AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled value that has been completed and billed"
    - name: "billing_count"
      expr: COUNT(1)
      comment: "Total number of progress billing records"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor invoices, payment processing, and cash disbursement"
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Status of the invoice (e.g., received, approved, paid, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo, debit memo)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the invoice is on hold"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (invoice, PO, receipt)"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the invoice was paid"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before deductions"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount taken"
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount withheld"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable to vendors"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage withheld"
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount captured as discounts"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of invoices under dispute"
    - name: "on_hold_invoice_count"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of invoices on hold"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN invoice_status = 'paid' THEN 1 ELSE 0 END)
      comment: "Number of invoices that have been paid"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_payment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing metrics tracking cash disbursements and receipts, payment timing, and reconciliation"
  source: "`vibe_construction_v1`.`finance`.`payment_record`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., vendor payment, customer receipt, advance, retention release)"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (e.g., pending, processed, cleared, failed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., wire transfer, check, ACH, credit card)"
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval status of the payment"
    - name: "clearing_status"
      expr: clearing_status
      comment: "Clearing status of the payment"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment"
    - name: "advance_payment_flag"
      expr: advance_payment_flag
      comment: "Indicates whether this is an advance payment"
    - name: "partial_payment_flag"
      expr: partial_payment_flag
      comment: "Indicates whether this is a partial payment"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment is denominated"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount processed"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after all deductions"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to payments"
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount withheld or released"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount deducted"
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional currency"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to payments"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment records"
    - name: "advance_payment_count"
      expr: SUM(CASE WHEN advance_payment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of advance payments"
    - name: "partial_payment_count"
      expr: SUM(CASE WHEN partial_payment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of partial payments"
$$;