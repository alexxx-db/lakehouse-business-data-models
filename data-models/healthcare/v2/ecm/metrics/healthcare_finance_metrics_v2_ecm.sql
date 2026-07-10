-- Metric views for domain: finance | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice KPIs for spend management, payment timeliness, and PO match compliance. Source: finance.ap_invoice (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Lifecycle status of the AP invoice (open, paid, on-hold, etc.)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice used for spend categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the invoice for workflow monitoring."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO/receipt/invoice) for procurement compliance."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used or planned to pay the invoice (check, ACH, wire)."
    - name: "invoice_currency_code"
      expr: invoice_currency_code
      comment: "Transaction currency of the invoice."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month bucket of the invoice date for spend trending."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month bucket of the invoice due date for payables aging planning."
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices; baseline volume for payables workload."
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total AP spend committed across invoices; core payables exposure metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on AP invoices for tax accrual and reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-pay/negotiated discounts on invoices; procurement savings signal."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value; indicates spend concentration and PO sizing."
    - name: "held_invoice_count"
      expr: SUM(CASE WHEN hold_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices on hold; drives payables exception remediation."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors invoiced; vendor concentration and consolidation opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment KPIs for disbursement volume, discount capture, and void/reconciliation control. Source: finance.ap_payment (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (issued, cleared, voided)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of disbursement for categorization."
    - name: "payment_method"
      expr: payment_method
      comment: "Disbursement method (check, ACH, wire)."
    - name: "payment_reconciliation_status"
      expr: payment_reconciliation_status
      comment: "Reconciliation status against bank statements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month bucket of the payment date for cash outflow trending."
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments; disbursement workload baseline."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash disbursed to vendors; core cash outflow metric."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts captured; working-capital efficiency."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment size for disbursement pattern analysis."
    - name: "voided_payment_count"
      expr: SUM(CASE WHEN void_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of voided payments; control and error-rate indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ar_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable account KPIs for collections, aging, disputes, and write-off exposure. Source: finance.ar_account (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`ar_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Status of the AR account for collections segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of receivable account."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket of the receivable balance; drives collection prioritization."
    - name: "debtor_type"
      expr: debtor_type
      comment: "Type of debtor (payer, patient, other)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR account."
  measures:
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total AR accounts; receivable portfolio size."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding AR balance; core receivable exposure."
    - name: "total_payments_received"
      expr: SUM(CAST(total_payments_received AS DOUBLE))
      comment: "Total payments received against AR; collections performance."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off; bad-debt leakage indicator."
    - name: "total_interest_accrued"
      expr: SUM(CAST(total_interest_accrued AS DOUBLE))
      comment: "Total interest accrued on overdue receivables."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average balance per AR account for segmentation."
    - name: "disputed_account_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts in dispute; revenue-at-risk indicator."
    - name: "legal_action_account_count"
      expr: SUM(CASE WHEN legal_action_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts in legal action; escalated collections exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ar_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AR transaction KPIs for cash application, posting throughput, and reconciliation status. Source: finance.ar_transaction (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`ar_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of AR transaction (charge, payment, adjustment)."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status to the ledger."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the transaction."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket at transaction level."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month bucket of the transaction date for trending."
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total AR transactions; posting workload baseline."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transacted AR amount; cash and adjustment throughput."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax across AR transactions."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction value for pattern analysis."
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed transactions; control and error indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget KPIs for planning coverage across revenue, expense, capital, and FTE. Source: finance.budget (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Approval/lifecycle status of the budget."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, etc.)."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for grouping."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the budget applies to."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source backing the budget."
  measures:
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budgets; planning coverage baseline."
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(total_budgeted_revenue AS DOUBLE))
      comment: "Total planned revenue; top-line planning target."
    - name: "total_budgeted_expense"
      expr: SUM(CAST(total_budgeted_expense AS DOUBLE))
      comment: "Total planned expense; cost planning target."
    - name: "total_budgeted_capital"
      expr: SUM(CAST(total_budgeted_capital AS DOUBLE))
      comment: "Total planned capital spend; capital allocation view."
    - name: "total_budgeted_net_income"
      expr: SUM(CAST(budgeted_net_income AS DOUBLE))
      comment: "Total planned net income; profitability target."
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte_count AS DOUBLE))
      comment: "Total planned FTE headcount; workforce planning target."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_budget_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget transfer KPIs for reallocation volume, reversal control, and compliance monitoring. Source: finance.budget_transfer (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`budget_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the budget transfer request."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of budget transfer."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level applied to the transfer."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transfer."
    - name: "transfer_month"
      expr: DATE_TRUNC('MONTH', transfer_date)
      comment: "Month bucket of the transfer date."
  measures:
    - name: "transfer_count"
      expr: COUNT(1)
      comment: "Number of budget transfers; reallocation activity baseline."
    - name: "total_transfer_amount"
      expr: SUM(CAST(transfer_amount AS DOUBLE))
      comment: "Total dollars reallocated across budgets; budget flexibility indicator."
    - name: "avg_transfer_amount"
      expr: AVG(CAST(transfer_amount AS DOUBLE))
      comment: "Average transfer size for governance thresholds."
    - name: "reversed_transfer_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed transfers; process-error indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_capital_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure KPIs for CapEx spend, capitalization eligibility, and reversal control. Source: finance.capital_expenditure (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`capital_expenditure`"
  dimensions:
    - name: "expenditure_status"
      expr: expenditure_status
      comment: "Status of the capital expenditure."
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of capital expenditure."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category being funded."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for CapEx governance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure."
    - name: "expenditure_month"
      expr: DATE_TRUNC('MONTH', expenditure_date)
      comment: "Month bucket of the expenditure date."
  measures:
    - name: "expenditure_count"
      expr: COUNT(1)
      comment: "Number of capital expenditures; CapEx activity baseline."
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total capital spend; core CapEx exposure metric."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total internal labor hours capitalized; construction-in-progress effort."
    - name: "avg_expenditure_amount"
      expr: AVG(CAST(expenditure_amount AS DOUBLE))
      comment: "Average CapEx transaction size."
    - name: "capitalization_eligible_count"
      expr: SUM(CASE WHEN capitalization_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of capitalization-eligible expenditures; asset-book pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project KPIs for budget vs actual variance, committed cost, and revenue-generating investment mix. Source: finance.capital_project (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Status of the capital project."
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project."
    - name: "project_priority"
      expr: project_priority
      comment: "Priority ranking of the project."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the project."
  measures:
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of capital projects in the portfolio."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_capital_budget AS DOUBLE))
      comment: "Total approved capital budget; portfolio investment envelope."
    - name: "total_actual_costs"
      expr: SUM(CAST(total_actual_costs AS DOUBLE))
      comment: "Total actual costs incurred; capital burn."
    - name: "total_committed_costs"
      expr: SUM(CAST(total_committed_costs AS DOUBLE))
      comment: "Total committed costs; forward capital commitment exposure."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget-to-actual variance; project cost control indicator."
    - name: "total_expected_annual_savings"
      expr: SUM(CAST(expected_annual_savings AS DOUBLE))
      comment: "Total expected annual savings; ROI justification for capital allocation."
    - name: "revenue_generating_project_count"
      expr: SUM(CASE WHEN is_revenue_generating = TRUE THEN 1 ELSE 0 END)
      comment: "Count of revenue-generating projects; strategic investment mix."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation KPIs for allocated cost distribution, adjustments, and Medicare reportability. Source: finance.cost_allocation (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_category"
      expr: allocation_category
      comment: "Category of the cost allocation."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis used for the allocation (statistics, RVU, etc.)."
    - name: "allocation_run_status"
      expr: allocation_run_status
      comment: "Status of the associated allocation run."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month bucket of the allocation date."
  measures:
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of cost allocation records; allocation activity baseline."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across cost centers; core allocation output."
    - name: "total_allocation_adjustment"
      expr: SUM(CAST(allocation_adjustment_amount AS DOUBLE))
      comment: "Total allocation adjustments; restatement/correction volume."
    - name: "total_source_cost_pool"
      expr: SUM(CAST(source_cost_pool_amount AS DOUBLE))
      comment: "Total source cost pool being allocated."
    - name: "medicare_reportable_count"
      expr: SUM(CASE WHEN is_medicare_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Medicare-reportable allocations; cost-report compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry KPIs for GL posting volume, balancing, and reversal control. Source: finance.journal_entry (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry."
    - name: "journal_category"
      expr: journal_category
      comment: "Category of the journal entry."
    - name: "journal_source"
      expr: journal_source
      comment: "Source system/module of the entry."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the entry."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month bucket of the posting date."
  measures:
    - name: "entry_count"
      expr: COUNT(1)
      comment: "Number of journal entries; GL posting workload baseline."
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debits posted; GL activity magnitude."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credits posted; balances against debits for control."
    - name: "reversal_entry_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal entries; close-quality and error indicator."
    - name: "intercompany_entry_count"
      expr: SUM(CASE WHEN intercompany_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intercompany entries; elimination workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_financial_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecast KPIs for projected revenue, expense, net income, and capital across scenarios. Source: finance.financial_forecast (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`financial_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast."
    - name: "forecast_methodology"
      expr: forecast_methodology
      comment: "Methodology used to build the forecast."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the forecast covers."
    - name: "forecast_period_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Month bucket of the forecast period start."
  measures:
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecasts; forecasting coverage baseline."
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(total_forecasted_revenue AS DOUBLE))
      comment: "Total projected revenue; forward top-line view."
    - name: "total_forecasted_expense"
      expr: SUM(CAST(total_forecasted_expense AS DOUBLE))
      comment: "Total projected expense; forward cost view."
    - name: "total_forecasted_net_income"
      expr: SUM(CAST(total_forecasted_net_income AS DOUBLE))
      comment: "Total projected net income; forward profitability view."
    - name: "total_forecasted_operating_income"
      expr: SUM(CAST(total_forecasted_operating_income AS DOUBLE))
      comment: "Total projected operating income; core-operations profitability."
    - name: "total_forecasted_capex"
      expr: SUM(CAST(total_forecasted_capital_expenditure AS DOUBLE))
      comment: "Total projected capital expenditure; forward capital plan."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_financial_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Period-close KPIs for close cycle time, checklist completion, and open-item control. Source: finance.financial_period_close (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`financial_period_close`"
  dimensions:
    - name: "close_status"
      expr: close_status
      comment: "Status of the period close."
    - name: "close_type"
      expr: close_type
      comment: "Type of close (soft, hard)."
    - name: "close_efficiency_rating"
      expr: close_efficiency_rating
      comment: "Efficiency rating of the close process."
  measures:
    - name: "close_count"
      expr: COUNT(1)
      comment: "Number of period closes tracked."
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(close_checklist_completion_percentage AS DOUBLE))
      comment: "Average checklist completion percentage; close-readiness KPI."
    - name: "prior_period_adjustment_count"
      expr: SUM(CASE WHEN prior_period_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of closes with prior-period adjustments; restatement risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation KPIs for unreconciled variance, outstanding items, and exception control. Source: finance.bank_reconciliation (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the bank reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation."
    - name: "statement_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Month bucket of the bank statement date."
  measures:
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Number of bank reconciliations performed."
    - name: "total_unreconciled_variance"
      expr: SUM(CAST(unreconciled_variance AS DOUBLE))
      comment: "Total unreconciled variance; cash-control risk indicator."
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_total AS DOUBLE))
      comment: "Total outstanding checks; cash-timing exposure."
    - name: "total_deposits_in_transit"
      expr: SUM(CAST(deposits_in_transit_total AS DOUBLE))
      comment: "Total deposits in transit; cash-timing exposure."
    - name: "exception_reconciliation_count"
      expr: SUM(CASE WHEN exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reconciliations flagged as exceptions; control workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund KPIs for balance, endowment corpus, and restricted-fund oversight. Source: finance.fund (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`fund`"
  dimensions:
    - name: "fund_status"
      expr: fund_status
      comment: "Status of the fund."
    - name: "fund_type"
      expr: fund_type
      comment: "Type of fund."
    - name: "fund_category"
      expr: fund_category
      comment: "Category of the fund."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction classification of the fund."
  measures:
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Number of funds under management."
    - name: "total_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total current fund balance; net assets under management."
    - name: "total_endowment_corpus"
      expr: SUM(CAST(endowment_corpus_amount AS DOUBLE))
      comment: "Total endowment corpus; permanently restricted principal."
    - name: "restricted_fund_count"
      expr: SUM(CASE WHEN donor_restriction_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of donor-restricted funds; compliance oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_donor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor / philanthropy KPIs for lifetime giving, segmentation, and pipeline health. Source: finance.donor (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`donor`"
  dimensions:
    - name: "donor_type"
      expr: donor_type
      comment: "Type of donor."
    - name: "donor_status"
      expr: donor_status
      comment: "Status of the donor relationship."
    - name: "segment"
      expr: segment
      comment: "Donor segment for fundraising strategy."
    - name: "wealth_capacity_rating"
      expr: wealth_capacity_rating
      comment: "Wealth capacity rating for major-gift prioritization."
  measures:
    - name: "donor_count"
      expr: COUNT(1)
      comment: "Number of donors; giving base size."
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_amount AS DOUBLE))
      comment: "Total lifetime giving; cumulative philanthropic value."
    - name: "avg_lifetime_giving"
      expr: AVG(CAST(lifetime_giving_amount AS DOUBLE))
      comment: "Average lifetime giving per donor; segment value indicator."
    - name: "avg_affinity_score"
      expr: AVG(CAST(affinity_score AS DOUBLE))
      comment: "Average affinity score; engagement/propensity signal."
    - name: "planned_giving_donor_count"
      expr: SUM(CASE WHEN planned_giving_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of planned-giving donors; legacy pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_depreciation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation run KPIs for depreciation expense, run failures, and posting control. Source: finance.depreciation_run (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`depreciation_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the depreciation run."
    - name: "run_type"
      expr: run_type
      comment: "Type of depreciation run."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Depreciation calculation method applied."
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month bucket of the run date."
  measures:
    - name: "run_count"
      expr: COUNT(1)
      comment: "Number of depreciation runs executed."
    - name: "total_depreciation_amount"
      expr: SUM(CAST(total_depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense recognized; core non-cash expense."
    - name: "reversed_run_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed runs; process-error indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset KPIs for asset base value, accumulated depreciation, and net book value. Source: finance.fixed_asset (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Status of the fixed asset."
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the fixed asset."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset."
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed assets in the register."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost; gross asset base."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation; asset consumption to date."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value; current balance-sheet asset value."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction KPIs for elimination volume, reconciliation variance, and posting control. Source: finance.intercompany_transaction (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the intercompany transaction."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the transaction."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month bucket of the transaction date."
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of intercompany transactions."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction value; consolidation exposure."
    - name: "total_reconciliation_variance"
      expr: SUM(CAST(reconciliation_variance_amount AS DOUBLE))
      comment: "Total reconciliation variance; intercompany control risk."
    - name: "elimination_transaction_count"
      expr: SUM(CASE WHEN elimination_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of elimination-flagged transactions; consolidation workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_payment_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment batch KPIs for disbursement throughput, batch success rate, and reconciliation status. Source: finance.payment_batch (single-table)."
  source: "`vibe_healthcare_v1`.`finance`.`payment_batch`"
  dimensions:
    - name: "payment_batch_status"
      expr: payment_batch_status
      comment: "Status of the payment batch."
    - name: "batch_type"
      expr: batch_type
      comment: "Type of payment batch."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the batch."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the batch."
    - name: "batch_month"
      expr: DATE_TRUNC('MONTH', batch_date)
      comment: "Month bucket of the batch date."
  measures:
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of payment batches processed."
    - name: "total_batch_amount"
      expr: SUM(CAST(total_batch_amount AS DOUBLE))
      comment: "Total gross batch disbursement amount; cash outflow via batches."
    - name: "total_net_batch_amount"
      expr: SUM(CAST(net_batch_amount AS DOUBLE))
      comment: "Total net batch amount after adjustments."
    - name: "avg_batch_amount"
      expr: AVG(CAST(total_batch_amount AS DOUBLE))
      comment: "Average batch size for processing efficiency analysis."
$$;