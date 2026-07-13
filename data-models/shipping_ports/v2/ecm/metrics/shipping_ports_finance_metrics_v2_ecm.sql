-- Metric views for domain: finance | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging, collection performance, and dispute analytics for port revenue management. Drives DSO monitoring, write-off risk assessment, and dunning prioritization."
  source: "`vibe_shipping_ports_v1`.`finance`.`receivable`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (current, 1-30, 31-60, 61-90, 90+ days) for overdue analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period AR trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) for monthly AR reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency AR exposure analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the receivable is under dispute, enabling disputed vs clean AR segmentation."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates whether the receivable has been written off, for bad debt tracking."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Clearing status of the receivable (open, cleared, partially cleared) for collection pipeline view."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code to analyze AR performance by credit terms granted."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for time-series AR trend analysis."
  measures:
    - name: "total_outstanding_ar"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding accounts receivable balance. Core liquidity KPI monitored by CFO and treasury."
    - name: "total_net_ar"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR amount before tax, representing gross revenue exposure in receivables."
    - name: "total_tax_on_ar"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of outstanding receivables for VAT/GST liability reporting."
    - name: "total_written_off_amount"
      expr: SUM(CAST(CASE WHEN write_off_flag = TRUE THEN outstanding_amount ELSE 0 END AS INT))
      comment: "Total AR written off as bad debt. Drives credit risk policy and provisioning decisions."
    - name: "total_disputed_ar"
      expr: SUM(CAST(CASE WHEN dispute_flag = TRUE THEN outstanding_amount ELSE 0 END AS INT))
      comment: "Total AR under active dispute. High disputed AR signals billing quality or customer satisfaction issues."
    - name: "count_open_receivables"
      expr: COUNT(CASE WHEN clearing_status != 'Cleared' THEN receivable_id END)
      comment: "Number of open (uncleared) receivable items for collection workload assessment."
    - name: "count_overdue_receivables"
      expr: COUNT(CASE WHEN aging_bucket NOT IN ('Current') THEN receivable_id END)
      comment: "Number of overdue receivable items requiring dunning or escalation action."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN write_off_flag = TRUE THEN outstanding_amount ELSE 0 END AS INT)) / NULLIF(SUM(CAST(outstanding_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total AR written off as bad debt. Key credit risk and collection effectiveness KPI."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN dispute_flag = TRUE THEN outstanding_amount ELSE 0 END AS INT)) / NULLIF(SUM(CAST(outstanding_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of AR under dispute. Elevated dispute rate signals billing accuracy or service delivery issues."
    - name: "avg_outstanding_per_receivable"
      expr: AVG(CAST(outstanding_amount AS DOUBLE))
      comment: "Average outstanding amount per receivable item. Useful for benchmarking collection effort per invoice."
    - name: "total_cash_discount_amount"
      expr: SUM(CAST(cash_discount_amount AS DOUBLE))
      comment: "Total early-payment discounts granted to customers. Measures cost of accelerating cash collection."
    - name: "total_local_currency_ar"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total AR in local (functional) currency for FX-neutral financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice analytics covering payment performance, discount capture, and vendor liability management. Supports working capital optimization and procure-to-pay governance."
  source: "`vibe_shipping_ports_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (open, paid, blocked, cancelled) for payables pipeline view."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (standard, credit memo, recurring) for payables mix analysis."
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category for spend analytics by cost type (port services, maintenance, utilities, etc.)."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (wire, ACH, cheque) for treasury and bank relationship management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AP spend trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AP accrual and cash flow forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency payables exposure analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (Net 30, Net 60, etc.) for DPO and working capital analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for time-series AP volume and spend trending."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level on AP invoice for overdue vendor payment escalation tracking."
  measures:
    - name: "total_gross_ap"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount. Primary payables liability KPI for CFO and treasury."
    - name: "total_net_ap"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP amount (gross minus discounts) representing actual cash obligation."
    - name: "total_outstanding_ap"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid AP balance. Critical for cash flow forecasting and working capital management."
    - name: "total_paid_ap"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices. Measures payment throughput and vendor settlement velocity."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured from vendors. Measures treasury efficiency in discount optimization."
    - name: "total_tax_ap"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total VAT/GST on AP invoices for tax reclaim and compliance reporting."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments for tax authority remittance tracking."
    - name: "count_ap_invoices"
      expr: COUNT(ap_invoice_id)
      comment: "Total number of AP invoices processed. Measures AP processing volume and workload."
    - name: "count_blocked_invoices"
      expr: COUNT(CASE WHEN payment_block IS NOT NULL AND payment_block != '' THEN ap_invoice_id END)
      comment: "Number of invoices with a payment block. Blocked invoices signal approval bottlenecks or disputes."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross AP captured as early-payment discounts. Key treasury performance indicator."
    - name: "payment_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total AP invoiced that has been paid. Measures payables settlement efficiency."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average AP invoice amount. Useful for benchmarking vendor invoice sizes and detecting anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution analytics covering payment amounts, FX impact, bank charges, and withholding tax. Supports DPO optimization and treasury cash management."
  source: "`vibe_shipping_ports_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the AP payment (executed, reversed, pending) for payment pipeline monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (wire transfer, ACH, cheque) for bank channel utilization analysis."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which payment was executed for FX exposure and hedging analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Functional currency for local reporting and FX translation analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual payment outflow analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cash outflow and DPO calculation."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment execution for cash outflow time-series analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates reversed payments for payment error rate and rework cost analysis."
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of expenditure for spend category analysis (capex, opex, maintenance, etc.)."
    - name: "payment_priority"
      expr: payment_priority
      comment: "Payment priority level for treasury queue management and critical vendor prioritization."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount executed. Primary cash outflow KPI for treasury management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after discounts and deductions. Actual cash disbursed to vendors."
    - name: "total_local_currency_payment"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment in local functional currency for FX-neutral cash flow reporting."
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments. Drives bank fee negotiation and channel optimization."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts taken at payment execution. Measures realized discount savings."
    - name: "total_withholding_tax_deducted"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted at payment for tax authority remittance compliance."
    - name: "count_payments_executed"
      expr: COUNT(ap_payment_id)
      comment: "Total number of AP payments executed. Measures payment processing throughput."
    - name: "count_reversed_payments"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN ap_payment_id END)
      comment: "Number of reversed payments. High reversal count signals payment processing errors or fraud risk."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN ap_payment_id END) / NULLIF(COUNT(ap_payment_id), 0), 2)
      comment: "Percentage of payments that were reversed. Key payment quality and control effectiveness KPI."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Useful for anomaly detection and vendor payment benchmarking."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to payments. Monitors FX rate quality vs. market benchmarks."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry analytics covering posting volumes, reversal rates, and period-close health. Supports financial close governance, audit readiness, and GL integrity monitoring."
  source: "`vibe_shipping_ports_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (SA, KR, DR, etc.) for GL posting mix analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (posted, parked, held, reversed) for period-close completeness monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual GL volume and close quality trending."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close analytics and period-end accrual monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency GL analysis."
    - name: "accounting_principle"
      expr: accounting_principle
      comment: "Accounting principle (IFRS, US GAAP, local GAAP) for multi-ledger reporting."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flags intercompany journal entries for elimination and consolidation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversed journal entries for close quality and error rate monitoring."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for time-series GL activity analysis."
    - name: "workflow_approval_status"
      expr: workflow_approval_status
      comment: "Workflow approval status for journal entry governance and segregation of duties monitoring."
  measures:
    - name: "count_journal_entries"
      expr: COUNT(journal_entry_id)
      comment: "Total number of journal entries posted. Measures GL activity volume and close workload."
    - name: "count_posted_entries"
      expr: COUNT(CASE WHEN posting_status = 'Posted' THEN journal_entry_id END)
      comment: "Number of successfully posted journal entries. Measures close completeness."
    - name: "count_reversed_entries"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN journal_entry_id END)
      comment: "Number of reversed journal entries. High reversal count signals posting errors or control weaknesses."
    - name: "count_intercompany_entries"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN journal_entry_id END)
      comment: "Number of intercompany journal entries requiring elimination in group consolidation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN journal_entry_id END) / NULLIF(COUNT(journal_entry_id), 0), 2)
      comment: "Percentage of journal entries reversed. Key GL quality and financial control KPI for audit."
    - name: "intercompany_entry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN intercompany_indicator = TRUE THEN journal_entry_id END) / NULLIF(COUNT(journal_entry_id), 0), 2)
      comment: "Percentage of GL entries that are intercompany. Drives consolidation complexity and elimination workload."
    - name: "total_exchange_rate_avg"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across journal entries. Monitors FX translation consistency."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL line-item analytics covering debit/credit volumes, tax postings, and line-level financial flows. Enables granular P&L, balance sheet, and cost centre analysis."
  source: "`vibe_shipping_ports_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "posting_key"
      expr: posting_key
      comment: "GL posting key (debit/credit indicator) for debit vs credit flow analysis."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Transaction currency for multi-currency GL line analysis."
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency for local GAAP reporting and FX translation analysis."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment-level P&L and cost reporting."
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area (operations, admin, sales) for functional cost analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code for VAT/GST line-level tax analysis and compliance reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversed GL lines for net posting analysis and error rate monitoring."
    - name: "value_date"
      expr: DATE_TRUNC('month', value_date)
      comment: "Month of value date for cash-basis financial analysis."
    - name: "segment_code"
      expr: segment_code
      comment: "Segment code for IFRS 8 segment reporting and divisional P&L analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit postings across GL lines. Core measure for balance sheet and P&L debit-side analysis."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit postings across GL lines. Core measure for balance sheet and P&L credit-side analysis."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount in transaction currency. Measures gross financial flow through the GL."
    - name: "total_tax_posted"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted at GL line level. Drives VAT/GST compliance and tax authority reporting."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax posted at line level for tax remittance and compliance tracking."
    - name: "net_debit_credit_balance"
      expr: SUM((CAST(debit_amount AS DOUBLE)) - (CAST(credit_amount AS DOUBLE)))
      comment: "Net debit minus credit balance across GL lines. A non-zero value signals unbalanced postings requiring investigation."
    - name: "count_gl_lines"
      expr: COUNT(journal_entry_line_id)
      comment: "Total number of GL line items. Measures posting granularity and close workload."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per GL line. Useful for anomaly detection and materiality benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget execution analytics covering planned vs actual spend, variance analysis, and budget utilization. Core KPI layer for financial planning and performance management."
  source: "`vibe_shipping_ports_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Budget type (capex, opex, revenue) for budget mix and allocation analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for spend classification and departmental budget analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Budget line status (approved, draft, locked) for budget governance monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget line for authorization workflow tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget planning and execution analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget vs actual variance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency budget consolidation."
    - name: "budget_version"
      expr: budget_version
      comment: "Budget version (original, revised, reforecast) for version-controlled budget comparison."
    - name: "is_carry_forward"
      expr: is_carry_forward
      comment: "Flags carry-forward budget lines from prior year for multi-year project tracking."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates locked budget lines to monitor budget freeze status."
  measures:
    - name: "total_planned_budget"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount. Primary budget baseline for variance analysis and financial planning."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget. Core execution KPI for financial performance management."
    - name: "total_committed_amount"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) budget. Critical for available budget calculation."
    - name: "total_available_budget"
      expr: SUM(CAST(available_budget AS DOUBLE))
      comment: "Total remaining available budget. Drives spend authorization and budget reallocation decisions."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (planned minus actual). Negative variance signals overspend requiring management action."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned budget consumed. Key budget execution KPI for CFO and budget owners."
    - name: "commitment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(commitment_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget committed (obligated). High commitment rate signals limited remaining flexibility."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across lines. Measures overall budget forecast accuracy."
    - name: "count_budget_lines"
      expr: COUNT(budget_line_id)
      comment: "Total number of budget lines. Measures budget granularity and planning complexity."
    - name: "count_overspent_lines"
      expr: COUNT(CASE WHEN variance_amount < 0 THEN budget_line_id END)
      comment: "Number of budget lines in overspend. Drives corrective action and budget reallocation prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio analytics covering asset values, depreciation, impairment, and lifecycle status. Supports CAPEX governance, asset utilization, and IFRS 16 compliance."
  source: "`vibe_shipping_ports_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class (buildings, machinery, vehicles, IT) for asset portfolio segmentation."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for financial reporting classification (tangible, intangible, ROU)."
    - name: "asset_status"
      expr: asset_status
      comment: "Asset lifecycle status (active, retired, disposed, under construction) for asset base management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, declining balance) for depreciation policy analysis."
    - name: "is_leased"
      expr: is_leased
      comment: "Flags leased assets (IFRS 16 ROU assets) for lease vs owned asset portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Asset currency for multi-currency asset register reporting."
    - name: "capitalization_date_year"
      expr: DATE_TRUNC('year', capitalization_date)
      comment: "Year of capitalization for asset vintage analysis and CAPEX cohort tracking."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source (own funds, grant, loan) for asset financing mix analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets. Primary CAPEX portfolio size KPI."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Core balance sheet asset value for financial reporting."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation. Measures asset age and remaining useful life across the portfolio."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment losses recognized. Elevated impairment signals asset obsolescence or market value decline."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value of assets at end of useful life. Impacts depreciation charge calculations."
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of fixed assets. Measures insurance coverage adequacy vs net book value."
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total government grants received for asset acquisition. Relevant for port infrastructure funding reporting."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Measures asset recycling efficiency and disposal gain/loss."
    - name: "depreciation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of acquisition cost depreciated. High percentage indicates aging asset base requiring replacement investment."
    - name: "impairment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(impairment_amount AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Impairment as percentage of acquisition cost. Key asset quality KPI for CFO and audit committee."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets in years. Drives depreciation policy review and asset replacement planning."
    - name: "count_active_assets"
      expr: COUNT(CASE WHEN asset_status = 'Active' THEN fixed_asset_id END)
      comment: "Number of active fixed assets in the portfolio. Measures operational asset base size."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual accounting analytics covering accrual balances, settlement performance, and variance tracking. Supports period-close quality, IFRS compliance, and accrual reversal governance."
  source: "`vibe_shipping_ports_v1`.`finance`.`accrual`"
  dimensions:
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (revenue, expense, payroll, port services) for accrual mix analysis."
    - name: "accrual_category"
      expr: accrual_category
      comment: "Accrual category for detailed classification within accrual type."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual for close governance and authorization tracking."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (posted, reversed, pending) for period-close completeness monitoring."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the accrual for liability clearance tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual accrual volume and balance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly accrual close and reversal analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Accrual currency for multi-currency accrual balance reporting."
    - name: "accrual_date_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Month of accrual date for time-series accrual trend analysis."
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrual amount posted. Primary accrual liability/asset balance KPI for period-close reporting."
    - name: "total_local_currency_accrual"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total accrual in local functional currency for FX-neutral balance sheet reporting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between accrued and settled amounts. Measures accrual estimation accuracy."
    - name: "count_accruals"
      expr: COUNT(accrual_id)
      comment: "Total number of accrual entries. Measures close workload and accrual process complexity."
    - name: "count_pending_accruals"
      expr: COUNT(CASE WHEN posting_status != 'Posted' THEN accrual_id END)
      comment: "Number of accruals not yet posted. Measures period-close backlog and risk of incomplete close."
    - name: "count_unsettled_accruals"
      expr: COUNT(CASE WHEN settlement_status != 'Settled' THEN accrual_id END)
      comment: "Number of accruals not yet settled. Persistent unsettled accruals signal liability management issues."
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN settlement_status = 'Settled' THEN accrual_id END) / NULLIF(COUNT(accrual_id), 0), 2)
      comment: "Percentage of accruals settled. Key accrual lifecycle completion KPI for close quality."
    - name: "avg_accrual_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average accrual amount per entry. Useful for materiality assessment and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IAS 37 provision and contingent liability analytics covering provision balances, probability assessments, and settlement tracking. Supports audit committee reporting and legal risk management."
  source: "`vibe_shipping_ports_v1`.`finance`.`provision`"
  dimensions:
    - name: "provision_type"
      expr: provision_type
      comment: "Type of provision (legal, environmental, restructuring, port liability) for risk category analysis."
    - name: "provision_category"
      expr: provision_category
      comment: "Provision category for detailed classification within provision type."
    - name: "provision_status"
      expr: provision_status
      comment: "Status of the provision (active, settled, reversed, released) for provision lifecycle tracking."
    - name: "probability_assessment"
      expr: probability_assessment
      comment: "Probability of outflow (probable, possible, remote) per IAS 37 for contingent liability disclosure."
    - name: "contingent_liability_flag"
      expr: contingent_liability_flag
      comment: "Flags contingent liabilities requiring disclosure but not recognition under IAS 37."
    - name: "disclosure_required_flag"
      expr: disclosure_required_flag
      comment: "Flags provisions requiring financial statement disclosure for audit and regulatory compliance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual provision balance and movement analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly provision movement and close reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Provision currency for multi-currency liability reporting."
    - name: "reimbursement_expected_flag"
      expr: reimbursement_expected_flag
      comment: "Flags provisions where reimbursement is expected (e.g., insurance recovery) for net liability calculation."
  measures:
    - name: "total_current_provision"
      expr: SUM(CAST(current_provision_amount AS DOUBLE))
      comment: "Total current provision balance. Primary IAS 37 liability KPI for balance sheet and audit committee."
    - name: "total_original_provision"
      expr: SUM(CAST(original_provision_amount AS DOUBLE))
      comment: "Total originally recognized provision amount for provision movement waterfall analysis."
    - name: "total_outstanding_provision"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding (unsettled) provision balance. Measures remaining financial exposure."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount settled against provisions. Measures provision utilization and cash outflow from provisions."
    - name: "total_reimbursement_amount"
      expr: SUM(CAST(reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursements (insurance, indemnities) offsetting provision exposure."
    - name: "total_undiscounted_provision"
      expr: SUM(CAST(undiscounted_amount AS DOUBLE))
      comment: "Total undiscounted provision amount for comparison with discounted carrying value."
    - name: "total_discount_unwinding"
      expr: SUM(CAST(discount_unwinding_amount AS DOUBLE))
      comment: "Total discount unwinding (interest accretion) on long-term provisions. Impacts finance cost reporting."
    - name: "total_maximum_exposure"
      expr: SUM(CAST(maximum_estimate_amount AS DOUBLE))
      comment: "Total maximum possible provision outflow. Measures worst-case financial exposure for stress testing."
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_provision_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of original provision settled. Measures provision accuracy and legal/operational risk resolution rate."
    - name: "count_active_provisions"
      expr: COUNT(CASE WHEN provision_status = 'Active' THEN provision_id END)
      comment: "Number of active provisions. Measures open legal and operational risk exposure count."
    - name: "count_contingent_liabilities"
      expr: COUNT(CASE WHEN contingent_liability_flag = TRUE THEN provision_id END)
      comment: "Number of contingent liabilities requiring disclosure. Key audit and regulatory reporting metric."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_lease_liability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IFRS 16 lease liability and right-of-use asset analytics covering lease balances, depreciation, and payment schedules. Supports IFRS 16 compliance reporting and lease portfolio management."
  source: "`vibe_shipping_ports_v1`.`finance`.`lease_liability`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Lease type (finance, operating, short-term, low-value) for IFRS 16 classification analysis."
    - name: "lease_status"
      expr: lease_status
      comment: "Lease status (active, terminated, modified, expired) for lease portfolio lifecycle management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to ROU asset for accounting policy consistency monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Lease currency for multi-currency IFRS 16 balance reporting."
    - name: "extension_option_flag"
      expr: extension_option_flag
      comment: "Flags leases with extension options for lease term reassessment and liability remeasurement tracking."
    - name: "modification_flag"
      expr: modification_flag
      comment: "Flags modified leases requiring IFRS 16 remeasurement for compliance monitoring."
    - name: "variable_payment_flag"
      expr: variable_payment_flag
      comment: "Flags leases with variable payments for cash flow forecasting complexity assessment."
    - name: "lease_commencement_year"
      expr: DATE_TRUNC('year', lease_commencement_date)
      comment: "Year of lease commencement for lease vintage and maturity profile analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Payment frequency (monthly, quarterly, annual) for cash flow planning."
  measures:
    - name: "total_initial_lease_liability"
      expr: SUM(CAST(initial_lease_liability AS DOUBLE))
      comment: "Total initial IFRS 16 lease liability recognized at commencement. Measures total lease obligation taken on."
    - name: "total_current_lease_liability"
      expr: SUM(CAST(current_lease_liability AS DOUBLE))
      comment: "Total current carrying value of lease liabilities. Primary IFRS 16 balance sheet KPI."
    - name: "total_short_term_liability"
      expr: SUM(CAST(short_term_liability_portion AS DOUBLE))
      comment: "Total current portion of lease liabilities (due within 12 months). Critical for liquidity reporting."
    - name: "total_long_term_liability"
      expr: SUM(CAST(long_term_liability_portion AS DOUBLE))
      comment: "Total non-current portion of lease liabilities. Measures long-term financial commitment from leases."
    - name: "total_rou_asset_value"
      expr: SUM(CAST(current_rou_asset_value AS DOUBLE))
      comment: "Total current right-of-use asset value. Measures IFRS 16 asset base from leased port infrastructure."
    - name: "total_accumulated_rou_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on ROU assets. Measures ROU asset consumption over lease terms."
    - name: "total_accumulated_interest_expense"
      expr: SUM(CAST(accumulated_interest_expense AS DOUBLE))
      comment: "Total interest expense accrued on lease liabilities. Impacts finance cost and EBITDA reporting."
    - name: "total_monthly_lease_payments"
      expr: SUM(CAST(monthly_lease_payment AS DOUBLE))
      comment: "Total monthly lease payment obligations. Critical for cash flow forecasting and liquidity management."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses on ROU assets. Signals underutilized or abandoned leased assets."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average incremental borrowing rate applied to leases. Monitors rate consistency and IFRS 16 compliance."
    - name: "count_active_leases"
      expr: COUNT(CASE WHEN lease_status = 'Active' THEN lease_liability_id END)
      comment: "Number of active leases in the portfolio. Measures lease portfolio size and management complexity."
    - name: "count_modified_leases"
      expr: COUNT(CASE WHEN modification_flag = TRUE THEN lease_liability_id END)
      comment: "Number of leases modified requiring IFRS 16 remeasurement. High count signals lease renegotiation activity."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_investment_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital investment program analytics covering CAPEX execution, ROI, NPV, and strategic initiative tracking. Supports board-level investment governance and port infrastructure development decisions."
  source: "`vibe_shipping_ports_v1`.`finance`.`investment_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Investment program type (infrastructure, technology, sustainability, safety) for CAPEX portfolio segmentation."
    - name: "program_category"
      expr: program_category
      comment: "Program category for detailed investment classification within program type."
    - name: "investment_program_status"
      expr: investment_program_status
      comment: "Program status (active, completed, on-hold, cancelled) for portfolio health monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Investment priority level for resource allocation and portfolio prioritization decisions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the investment program for risk-adjusted portfolio analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source (equity, debt, grant, PPP) for investment financing mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Program currency for multi-currency CAPEX portfolio reporting."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering active vs completed investment programs."
    - name: "planned_start_year"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Planned start year for investment pipeline and CAPEX phasing analysis."
    - name: "strategic_objective"
      expr: strategic_objective
      comment: "Strategic objective alignment for portfolio-to-strategy linkage analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved CAPEX budget across investment programs. Primary board-level CAPEX authorization KPI."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend against investment programs. Measures CAPEX execution velocity."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (contracted but not yet spent) CAPEX. Measures near-term cash outflow obligation."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecast spend to completion. Enables EAC (Estimate at Completion) analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total CAPEX variance (approved budget minus forecast). Negative variance signals cost overrun risk."
    - name: "total_npv"
      expr: SUM(CAST(net_present_value_amount AS DOUBLE))
      comment: "Total net present value across investment programs. Primary financial return KPI for investment committee."
    - name: "budget_execution_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved CAPEX budget spent. Measures investment execution pace vs plan."
    - name: "avg_expected_roi_pct"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI across investment programs. Key investment quality KPI for capital allocation decisions."
    - name: "avg_irr_pct"
      expr: AVG(CAST(internal_rate_of_return_percentage AS DOUBLE))
      comment: "Average internal rate of return across programs. Measures portfolio-level investment attractiveness."
    - name: "count_active_programs"
      expr: COUNT(CASE WHEN is_active = TRUE THEN investment_program_id END)
      comment: "Number of active investment programs. Measures CAPEX portfolio breadth and management complexity."
    - name: "count_programs_by_status"
      expr: COUNT(investment_program_id)
      comment: "Total count of investment programs for portfolio size and pipeline analysis."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction analytics covering elimination status, reconciliation variances, and transfer pricing compliance. Supports group consolidation, IFRS 10 compliance, and transfer pricing governance."
  source: "`vibe_shipping_ports_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Intercompany transaction type (service charge, loan, dividend, management fee) for elimination categorization."
    - name: "elimination_status"
      expr: elimination_status
      comment: "Elimination status (eliminated, pending, not-required) for consolidation completeness monitoring."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between sending and receiving entities for intercompany matching quality."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of intercompany balances for cash pooling and netting management."
    - name: "netting_flag"
      expr: netting_flag
      comment: "Flags transactions included in netting agreements for cash management efficiency analysis."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Flags transactions requiring group consolidation elimination."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany volume and elimination analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany reconciliation and close monitoring."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Transaction currency for multi-currency intercompany exposure analysis."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method (CUP, cost-plus, TNMM) for transfer pricing compliance analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount. Measures gross intercompany flow requiring elimination."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net intercompany amount after netting. Measures actual intercompany cash settlement obligation."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in local currency for entity-level reporting."
    - name: "total_tax_on_intercompany"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on intercompany transactions for transfer pricing tax compliance."
    - name: "total_reconciliation_variance"
      expr: SUM(CAST(reconciliation_variance_amount AS DOUBLE))
      comment: "Total reconciliation variance between intercompany counterparties. Non-zero variance blocks consolidation close."
    - name: "count_unreconciled_transactions"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN intercompany_transaction_id END)
      comment: "Number of unreconciled intercompany transactions. Drives consolidation close risk and remediation priority."
    - name: "count_pending_eliminations"
      expr: COUNT(CASE WHEN elimination_flag = TRUE AND elimination_status != 'Eliminated' THEN intercompany_transaction_id END)
      comment: "Number of transactions pending elimination. Measures consolidation close backlog."
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'Reconciled' THEN intercompany_transaction_id END) / NULLIF(COUNT(intercompany_transaction_id), 0), 2)
      comment: "Percentage of intercompany transactions reconciled. Key consolidation quality KPI for group finance."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX rate applied to intercompany transactions for FX translation consistency monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation cycle analytics covering allocated amounts, allocation basis, and reversal rates. Supports management accounting, overhead absorption, and cost centre performance reporting."
  source: "`vibe_shipping_ports_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Allocation type (assessment, distribution, reposting) for cost flow methodology analysis."
    - name: "allocation_basis_type"
      expr: allocation_basis_type
      comment: "Basis used for allocation (headcount, TEU throughput, floor area) for allocation driver analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation (completed, reversed, pending) for cycle close monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost allocation volume and amount analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly management accounting close and cost centre reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Allocation currency for multi-currency cost centre reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversed allocations for allocation error rate and rework analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of allocation posting for time-series cost flow analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across cost centres. Measures overhead absorption and cost redistribution volume."
    - name: "total_sender_original_cost"
      expr: SUM(CAST(sender_original_cost_amount AS DOUBLE))
      comment: "Total original cost in sender cost centres before allocation. Measures overhead pool size."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage applied. Monitors allocation rate consistency across cycles."
    - name: "count_allocations"
      expr: COUNT(cost_allocation_id)
      comment: "Total number of cost allocation records. Measures allocation cycle complexity and volume."
    - name: "count_reversed_allocations"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN cost_allocation_id END)
      comment: "Number of reversed allocations. High reversal count signals allocation rule errors or cycle failures."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN cost_allocation_id END) / NULLIF(COUNT(cost_allocation_id), 0), 2)
      comment: "Percentage of allocations reversed. Key management accounting quality KPI."
    - name: "avg_allocation_basis_quantity"
      expr: AVG(CAST(allocation_basis_quantity AS DOUBLE))
      comment: "Average allocation driver quantity (e.g., average TEUs, headcount) used as allocation basis."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`finance_asset_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset transaction analytics covering CAPEX additions, disposals, depreciation postings, and revaluations. Supports asset lifecycle management, CAPEX governance, and IFRS compliance."
  source: "`vibe_shipping_ports_v1`.`finance`.`asset_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Asset transaction type (acquisition, disposal, depreciation, revaluation, transfer) for asset movement analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Transaction status (posted, reversed, pending) for asset accounting close monitoring."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for CAPEX portfolio segmentation (port equipment, buildings, IT, vehicles)."
    - name: "capex_opex_indicator"
      expr: capex_opex_indicator
      comment: "CAPEX vs OPEX classification for spend categorization and P&L vs balance sheet impact analysis."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for accounting policy consistency monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual asset movement and CAPEX analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly asset accounting and depreciation charge analysis."
    - name: "transaction_currency"
      expr: transaction_currency
      comment: "Transaction currency for multi-currency asset register reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversed asset transactions for error rate and rework analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting for time-series CAPEX and depreciation trend analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total asset transaction amount. Measures gross CAPEX additions, disposals, and adjustments."
    - name: "total_company_code_amount"
      expr: SUM(CAST(company_code_amount AS DOUBLE))
      comment: "Total asset transaction amount in company code currency for entity-level asset reporting."
    - name: "total_tax_on_asset_transactions"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on asset transactions for input tax reclaim and compliance reporting."
    - name: "total_capex_additions"
      expr: SUM(CAST(CASE WHEN transaction_type = 'Acquisition' THEN transaction_amount ELSE 0 END AS INT))
      comment: "Total CAPEX additions from asset acquisitions. Primary CAPEX investment KPI for board reporting."
    - name: "total_disposal_amount"
      expr: SUM(CAST(CASE WHEN transaction_type = 'Disposal' THEN transaction_amount ELSE 0 END AS INT))
      comment: "Total asset disposal proceeds. Measures asset recycling and portfolio rationalization activity."
    - name: "count_asset_transactions"
      expr: COUNT(asset_transaction_id)
      comment: "Total number of asset transactions. Measures asset accounting activity volume."
    - name: "count_reversed_transactions"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN asset_transaction_id END)
      comment: "Number of reversed asset transactions. Signals asset accounting errors requiring investigation."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life assigned to assets at transaction time. Monitors depreciation policy application."
$$;