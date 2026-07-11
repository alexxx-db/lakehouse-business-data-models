-- Metric views for domain: finance | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance metrics tracking approved amounts, actual expenditures, variances, and burn rates across grants, cost centers, and country offices. Supports executive-level budget stewardship and donor reporting."
  source: "`vibe_ngo_v1`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for time-series analysis and year-over-year comparisons."
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g., operational, project, grant) to segment performance by budget category."
    - name: "budget_status"
      expr: budget_status
      comment: "Current lifecycle status of the budget (e.g., draft, approved, closed) for pipeline and approval tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated, enabling multi-currency analysis."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Budget period start month for trend analysis."
    - name: "period_end_date"
      expr: DATE_TRUNC('month', period_end_date)
      comment: "Budget period end month for pipeline and expiry tracking."
    - name: "donor_reporting_frequency"
      expr: donor_reporting_frequency
      comment: "Frequency at which donor reports are required, used to segment budgets by reporting obligation intensity."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount across all selected budgets. Core KPI for resource allocation oversight."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(total_actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure recorded against budgets. Drives burn rate and variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Sum of budget-to-actual variance amounts. Negative values indicate overspend; positive values indicate underspend."
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct cost budget across all budgets. Used to assess programmatic spend capacity."
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost (overhead) budget. Used to monitor ICR compliance and overhead ratios."
    - name: "avg_burn_rate_percentage"
      expr: AVG(CAST(burn_rate_percentage AS DOUBLE))
      comment: "Average budget burn rate percentage across budgets. Signals whether programs are on track to fully utilize funding within the period."
    - name: "total_cost_share_requirement"
      expr: SUM(CAST(cost_share_requirement_amount AS DOUBLE))
      comment: "Total cost-share (match) requirement across budgets. Critical for donor compliance and co-funding tracking."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(total_actual_expenditure AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget that has been expended. Key executive KPI for program delivery pace and financial risk."
    - name: "indirect_to_direct_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(indirect_cost_budget AS DOUBLE)) / NULLIF(SUM(CAST(direct_cost_budget AS DOUBLE)), 0), 2)
      comment: "Ratio of indirect to direct cost budget as a percentage. Monitors overhead efficiency and donor-imposed ICR caps."
    - name: "avg_icr_rate_applied"
      expr: AVG(CAST(icr_rate_applied AS DOUBLE))
      comment: "Average indirect cost recovery rate applied across budgets. Used to benchmark against NICRA negotiated rates."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records in scope. Baseline volume metric for portfolio sizing."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level metrics for granular cost analysis, allocation efficiency, and donor budget category compliance. Supports grant financial management and audit readiness."
  source: "`vibe_ngo_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Functional expense category of the budget line (e.g., personnel, travel, supplies) for cost structure analysis."
    - name: "cost_type"
      expr: cost_type
      comment: "Direct or indirect cost classification of the budget line, critical for ICR and donor compliance."
    - name: "donor_budget_category"
      expr: donor_budget_category
      comment: "Donor-defined budget category for the line item, used in donor financial reporting."
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Lifecycle status of the budget line (e.g., active, revised, closed)."
    - name: "is_cost_share"
      expr: is_cost_share
      comment: "Flag indicating whether this line represents a cost-share (match) contribution."
    - name: "is_allowable"
      expr: is_allowable
      comment: "Flag indicating whether the cost is allowable under the applicable grant or donor rules."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line for multi-currency portfolio analysis."
    - name: "budget_period_type"
      expr: budget_period_type
      comment: "Period type (annual, multi-year, etc.) of the budget line for temporal segmentation."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original budgeted amount across all lines. Baseline for modification and revision tracking."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount after approved modifications. Reflects current authorized spending authority."
    - name: "budget_revision_variance"
      expr: ROUND(SUM(CAST(revised_amount AS DOUBLE)) - SUM(CAST(original_amount AS DOUBLE)), 2)
      comment: "Net change between revised and original budget amounts. Indicates scope and cost growth or reduction."
    - name: "budget_revision_rate"
      expr: ROUND(100.0 * (SUM(CAST(revised_amount AS DOUBLE)) - SUM(CAST(original_amount AS DOUBLE))) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage change from original to revised budget. Signals budget volatility and grant modification frequency."
    - name: "total_cost_share_lines_amount"
      expr: SUM(CASE WHEN is_cost_share = TRUE THEN revised_amount ELSE 0 END)
      comment: "Total revised budget amount for cost-share lines. Tracks match commitment fulfillment."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied across budget lines. Used to verify NICRA compliance at line level."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average cost allocation percentage across lines. Monitors shared-cost distribution fairness."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines. Baseline volume metric for budget complexity assessment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry metrics for general ledger activity monitoring, compliance tracking, and financial close management. Supports audit readiness and period-close efficiency."
  source: "`vibe_ngo_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., standard, reversal, accrual) for transaction classification."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (e.g., posted, pending, reversed) for close management."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry."
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Flag indicating whether the entry is an adjustment, used to separate routine from corrective postings."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the journal entry has a compliance issue requiring review."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for trend analysis of GL activity volume."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area classification of the journal entry for programmatic vs. administrative cost analysis."
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries. Baseline volume metric for GL activity and close workload."
    - name: "compliance_flagged_entry_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of journal entries flagged for compliance issues. Drives audit risk prioritization."
    - name: "compliance_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries with compliance flags. Key risk indicator for financial controls quality."
    - name: "adjustment_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_adjustment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are adjustments. High rates may indicate data quality or process issues."
    - name: "reversal_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. Elevated rates signal posting errors or accrual management issues."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across journal entries. Used to monitor FX exposure in multi-currency operations."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied in journal entries. Validates NICRA rate application consistency."
    - name: "distinct_award_count"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct grant awards with journal activity. Indicates portfolio breadth of financial activity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry line-level metrics for detailed expenditure analysis, cost classification, and donor allowability compliance. The most granular financial transaction layer."
  source: "`vibe_ngo_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry line for annual expenditure reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the line for monthly expenditure trend analysis."
    - name: "functional_expense_category"
      expr: functional_expense_category
      comment: "Functional expense category (e.g., program services, G&A, fundraising) for nonprofit financial statement classification."
    - name: "natural_account_classification"
      expr: natural_account_classification
      comment: "Natural account classification (e.g., salaries, rent, supplies) for cost structure analysis."
    - name: "donor_restriction_type"
      expr: donor_restriction_type
      comment: "Donor restriction type on the expenditure line, critical for restricted fund compliance."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Flag indicating whether the line is a direct program cost, used to separate direct from indirect expenditures."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Flag indicating whether the cost is allowable under applicable grant terms."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the journal line for financial controls monitoring."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for expenditure trend analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across journal lines. Represents gross expenditure and asset increases."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across journal lines. Represents revenue recognition and liability increases."
    - name: "net_expenditure_amount"
      expr: ROUND(SUM(CAST(debit_amount AS DOUBLE)) - SUM(CAST(credit_amount AS DOUBLE)), 2)
      comment: "Net expenditure (debits minus credits) across journal lines. Core measure for actual spend reporting."
    - name: "unallowable_cost_amount"
      expr: SUM(CASE WHEN allowable_cost_flag = FALSE THEN debit_amount ELSE 0 END)
      comment: "Total debit amount on lines flagged as unallowable. Critical for donor audit risk and cost recovery exposure."
    - name: "unallowable_cost_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN allowable_cost_flag = FALSE THEN debit_amount ELSE 0 END) / NULLIF(SUM(CAST(debit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total debits that are unallowable costs. Key compliance KPI for grant audits."
    - name: "indirect_cost_amount"
      expr: SUM(CASE WHEN direct_cost_flag = FALSE THEN debit_amount ELSE 0 END)
      comment: "Total indirect cost expenditure. Used to monitor overhead against NICRA-negotiated rates."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied at line level. Validates consistent NICRA application."
    - name: "distinct_gl_account_count"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts with activity. Indicates breadth of cost distribution across the chart of accounts."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable metrics for vendor payment management, aging analysis, and cash flow forecasting. Supports treasury, procurement, and donor compliance functions."
  source: "`vibe_ngo_v1`.`finance`.`payable`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the payable (e.g., pending, paid, disputed) for cash flow and aging analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., wire, check, EFT) for payment channel analysis."
    - name: "invoice_currency_code"
      expr: invoice_currency_code
      comment: "Currency of the invoice for multi-currency payables analysis."
    - name: "is_grant_eligible"
      expr: is_grant_eligible
      comment: "Flag indicating whether the payable is eligible for grant funding, used for grant expenditure reporting."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating whether the payable is charged to a restricted fund."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO, receipt, invoice) for procurement controls monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the payable for financial controls and authorization tracking."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the payable is due for cash flow forecasting."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice amount across all payables. Core measure for AP liability and cash requirement."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and adjustments. Reflects actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payables. Used for VAT/tax reclaim and compliance reporting."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payables. Relevant for vendor tax compliance and regulatory reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in optimizing payment timing."
    - name: "three_way_match_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status != 'matched' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payables that failed three-way match. High rates indicate procurement control weaknesses."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(invoice_net_amount AS DOUBLE))
      comment: "Average net invoice amount per payable. Benchmarks typical vendor transaction size."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to payables. Monitors FX exposure in vendor payments."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with outstanding or paid payables. Measures vendor base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable metrics for grant drawdown tracking, donor billing management, and cash collection efficiency. Supports revenue recognition and liquidity management."
  source: "`vibe_ngo_v1`.`finance`.`receivable`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status of the receivable (e.g., current, overdue, written-off) for aging and risk analysis."
    - name: "invoice_currency_code"
      expr: invoice_currency_code
      comment: "Currency of the receivable invoice for multi-currency AR analysis."
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Method used to deliver the invoice to the payer, for billing process efficiency analysis."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method by which payment was received (e.g., wire, check) for cash management analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the receivable is under dispute, used to identify collection risk."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the receivable is due for cash flow forecasting."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Month of revenue recognition for financial reporting alignment."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount across all receivables. Core measure for revenue billed and grant drawdown volume."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance. Key liquidity and cash flow KPI for treasury management."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible. Signals collection effectiveness and donor relationship risk."
    - name: "total_allowance_for_doubtful_accounts"
      expr: SUM(CAST(allowance_for_doubtful_accounts AS DOUBLE))
      comment: "Total allowance provisioned for doubtful receivables. Reflects management's estimate of collection risk."
    - name: "collection_rate"
      expr: ROUND(100.0 * (SUM(CAST(invoice_amount AS DOUBLE)) - SUM(CAST(outstanding_balance AS DOUBLE))) / NULLIF(SUM(CAST(invoice_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amounts that have been collected. Core KPI for AR efficiency and donor payment reliability."
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoice_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amounts written off. Elevated rates indicate systemic collection or donor relationship issues."
    - name: "disputed_receivable_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN outstanding_balance ELSE 0 END)
      comment: "Total outstanding balance on disputed receivables. Quantifies financial risk from billing disputes."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per receivable. Benchmarks typical grant drawdown or billing size."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to receivables. Monitors FX translation risk on donor receipts."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_bank_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank transaction metrics for cash flow monitoring, reconciliation status tracking, and payment channel analysis. Supports treasury operations and financial controls."
  source: "`vibe_ngo_v1`.`finance`.`bank_transaction`"
  dimensions:
    - name: "bank_transaction_type"
      expr: bank_transaction_type
      comment: "Type of bank transaction (e.g., debit, credit, transfer) for cash flow classification."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., wire, ACH, check) for payment channel analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was processed for operational efficiency analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the transaction (e.g., reconciled, unreconciled) for close management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bank transaction for multi-currency cash management."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating whether the transaction is associated with a restricted fund."
    - name: "is_indirect_cost"
      expr: is_indirect_cost
      comment: "Flag indicating whether the transaction represents an indirect cost."
    - name: "bank_transaction_date_month"
      expr: DATE_TRUNC('month', bank_transaction_date)
      comment: "Month of the bank transaction date for cash flow trend analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross transaction amount across all bank transactions. Core cash flow volume metric."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit (inflow) amount. Measures cash receipts and grant drawdowns."
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit (outflow) amount. Measures cash disbursements and vendor payments."
    - name: "net_cash_flow"
      expr: ROUND(SUM(CAST(credit_amount AS DOUBLE)) - SUM(CAST(debit_amount AS DOUBLE)), 2)
      comment: "Net cash flow (credits minus debits). Primary treasury KPI for liquidity position monitoring."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN 1 END)
      comment: "Number of transactions not yet reconciled. Drives period-close prioritization and audit risk management."
    - name: "unreconciled_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that remain unreconciled. Key financial controls quality indicator."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction amount. Benchmarks typical cash movement size for anomaly detection."
    - name: "distinct_bank_account_count"
      expr: COUNT(DISTINCT bank_account_id)
      comment: "Number of distinct bank accounts with transaction activity. Monitors cash concentration and account utilization."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation metrics for financial close quality, variance monitoring, and compliance tracking. Supports internal controls, audit readiness, and treasury governance."
  source: "`vibe_ngo_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "bank_reconciliation_status"
      expr: bank_reconciliation_status
      comment: "Status of the reconciliation (e.g., in-progress, completed, approved) for close management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reconciliation for annual controls reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the reconciliation for monthly close tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation for multi-currency treasury analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the reconciliation has a compliance issue."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating whether the reconciliation covers a restricted fund account."
    - name: "bank_reconciliation_date_month"
      expr: DATE_TRUNC('month', bank_reconciliation_date)
      comment: "Month of the reconciliation date for trend analysis of close timeliness."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total reconciliation variance (GL vs. bank statement). Unresolved variances represent financial reporting risk."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average reconciliation variance per reconciliation. Benchmarks typical reconciliation quality."
    - name: "total_outstanding_checks_amount"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks not yet cleared. Represents timing differences and potential stale check risk."
    - name: "total_outstanding_deposits_amount"
      expr: SUM(CAST(outstanding_deposits_amount AS DOUBLE))
      comment: "Total deposits in transit not yet reflected in bank statement. Measures timing of cash receipt recording."
    - name: "total_unrecorded_bank_charges"
      expr: SUM(CAST(unrecorded_bank_charges_amount AS DOUBLE))
      comment: "Total bank charges not yet recorded in the GL. Drives accrual and catch-up posting requirements."
    - name: "compliance_flagged_reconciliation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations with compliance flags. Key internal controls quality KPI."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of bank reconciliations completed. Baseline volume metric for close workload."
    - name: "avg_gl_book_balance"
      expr: AVG(CAST(gl_book_balance AS DOUBLE))
      comment: "Average GL book balance across reconciliations. Provides context for variance materiality assessment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run metrics for disbursement efficiency, failure rate monitoring, and cash management. Supports treasury operations, vendor management, and financial controls."
  source: "`vibe_ngo_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Status of the payment run (e.g., scheduled, executed, completed, failed) for operational monitoring."
    - name: "payment_run_type"
      expr: payment_run_type
      comment: "Type of payment run (e.g., vendor, payroll, grant) for disbursement category analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the run (e.g., wire, ACH, check) for channel efficiency analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel for the run, used to analyze processing efficiency by channel."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment run for multi-currency disbursement analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment run for annual disbursement reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment run for monthly cash outflow analysis."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the payment run is recurring, used to separate routine from ad-hoc disbursements."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the payment run has a compliance issue."
  measures:
    - name: "total_disbursement_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount disbursed across all payment runs. Core treasury KPI for cash outflow management."
    - name: "total_successful_amount"
      expr: SUM(CAST(successful_amount AS DOUBLE))
      comment: "Total amount successfully processed in payment runs. Measures effective disbursement capacity."
    - name: "total_failed_amount"
      expr: SUM(CAST(failed_amount AS DOUBLE))
      comment: "Total amount that failed processing in payment runs. Drives remediation and vendor relationship management."
    - name: "payment_failure_rate_by_amount"
      expr: ROUND(100.0 * SUM(CAST(failed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total disbursement amount that failed processing. Key operational risk KPI for treasury."
    - name: "avg_disbursement_per_run"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total disbursement amount per payment run. Benchmarks run size for capacity planning."
    - name: "compliance_flagged_run_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment runs with compliance flags. Signals financial controls issues in disbursement processes."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed. Baseline volume metric for disbursement operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund-level financial health metrics for restricted and unrestricted fund management, compliance monitoring, and donor reporting. Supports CFO-level fund stewardship and audit readiness."
  source: "`vibe_ngo_v1`.`finance`.`finance_fund`"
  dimensions:
    - name: "finance_fund_type"
      expr: finance_fund_type
      comment: "Type of fund (e.g., restricted, unrestricted, temporarily restricted) for fund classification analysis."
    - name: "finance_fund_status"
      expr: finance_fund_status
      comment: "Current status of the fund (e.g., active, closed, suspended) for portfolio management."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction type on the fund, critical for compliance and fund usage monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fund for multi-currency portfolio analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the fund for annual reporting."
    - name: "donor_reporting_frequency"
      expr: donor_reporting_frequency
      comment: "Frequency of donor reporting required for the fund, used to segment by reporting obligation."
    - name: "audit_required_flag"
      expr: audit_required_flag
      comment: "Flag indicating whether the fund requires an external audit, for audit planning."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all funds. Measures total authorized financial capacity."
    - name: "total_expended_amount"
      expr: SUM(CAST(expended_amount AS DOUBLE))
      comment: "Total amount expended from funds. Core measure for fund utilization and burn rate."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet expended) amount. Measures encumbrance and future cash requirements."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all funds. Key liquidity KPI for treasury and program management."
    - name: "fund_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(expended_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fund budget that has been expended. Primary KPI for fund stewardship and donor accountability."
    - name: "total_match_fulfilled_amount"
      expr: SUM(CAST(match_fulfilled_amount AS DOUBLE))
      comment: "Total cost-share match fulfilled across funds. Tracks compliance with donor match requirements."
    - name: "match_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(match_fulfilled_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)) * AVG(CAST(match_requirement_percentage AS DOUBLE)) / 100.0, 0), 2)
      comment: "Percentage of required match fulfilled. Signals risk of donor match non-compliance."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate applied across funds. Validates NICRA compliance at fund level."
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of funds in scope. Baseline portfolio size metric."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN audit_required_flag = TRUE THEN 1 END)
      comment: "Number of funds requiring external audit. Drives audit planning and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_exchange_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exchange rate metrics for FX risk monitoring, rate variance analysis, and multi-currency financial management. Supports treasury and donor reporting in multi-currency NGO operations."
  source: "`vibe_ngo_v1`.`finance`.`exchange_rate`"
  dimensions:
    - name: "from_currency_code"
      expr: from_currency_code
      comment: "Source currency of the exchange rate for FX pair analysis."
    - name: "to_currency_code"
      expr: to_currency_code
      comment: "Target currency of the exchange rate for FX pair analysis."
    - name: "exchange_rate_type"
      expr: exchange_rate_type
      comment: "Type of exchange rate (e.g., spot, budget, UN operational) for rate source classification."
    - name: "exchange_rate_status"
      expr: exchange_rate_status
      comment: "Status of the exchange rate (e.g., active, expired, superseded) for rate validity monitoring."
    - name: "un_operational_rate_flag"
      expr: un_operational_rate_flag
      comment: "Flag indicating whether this is the UN operational rate, used for UN-funded grant compliance."
    - name: "donor_required_rate_flag"
      expr: donor_required_rate_flag
      comment: "Flag indicating whether the donor mandates use of this rate, for donor compliance tracking."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the exchange rate became effective for trend analysis."
  measures:
    - name: "avg_exchange_rate_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average exchange rate value across the selected period and currency pairs. Baseline for FX trend analysis."
    - name: "avg_variance_from_prior_rate"
      expr: AVG(CAST(variance_from_prior_rate AS DOUBLE))
      comment: "Average variance from the prior exchange rate. Measures FX volatility and translation risk."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from prior rate. Key FX risk KPI for treasury and budget reforecasting."
    - name: "avg_spread_percentage"
      expr: AVG(CAST(spread_percentage AS DOUBLE))
      comment: "Average spread percentage between buy and sell rates. Measures transaction cost of currency conversion."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN exchange_rate_status = 'active' THEN 1 END)
      comment: "Number of currently active exchange rates. Ensures adequate rate coverage for all operational currencies."
    - name: "distinct_currency_pair_count"
      expr: COUNT(DISTINCT CONCAT(from_currency_code, '_', to_currency_code))
      comment: "Number of distinct currency pairs with active rates. Measures FX coverage breadth for multi-currency operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics for indirect cost distribution analysis, NICRA compliance, and fund-level cost attribution. Supports grant financial management and audit readiness."
  source: "`vibe_ngo_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "cost_allocation_status"
      expr: cost_allocation_status
      comment: "Status of the cost allocation (e.g., pending, posted, reversed) for processing pipeline monitoring."
    - name: "method"
      expr: method
      comment: "Cost allocation method used (e.g., direct, proportional, headcount) for methodology analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost being allocated (e.g., facilities, administration) for overhead analysis."
    - name: "cost_pool"
      expr: cost_pool
      comment: "Cost pool from which the allocation originates, used for indirect cost pool management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost allocation for multi-currency analysis."
    - name: "is_fa_cost"
      expr: is_fa_cost
      comment: "Flag indicating whether the allocation is a facilities and administrative (F&A) cost, critical for NICRA compliance."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating whether the allocation is to a restricted fund."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the allocation has a compliance issue."
    - name: "cost_allocation_date_month"
      expr: DATE_TRUNC('month', cost_allocation_date)
      comment: "Month of the cost allocation date for trend analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated across all cost allocation records. Core measure for indirect cost distribution volume."
    - name: "avg_allocation_rate"
      expr: AVG(CAST(rate AS DOUBLE))
      comment: "Average allocation rate applied. Used to validate consistency with NICRA-negotiated rates."
    - name: "compliance_flagged_allocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cost allocations with compliance flags. Key NICRA audit risk indicator."
    - name: "fa_cost_allocation_amount"
      expr: SUM(CASE WHEN is_fa_cost = TRUE THEN allocated_amount ELSE 0 END)
      comment: "Total F&A cost allocation amount. Directly used in NICRA rate calculation and donor reporting."
    - name: "fa_cost_allocation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_fa_cost = TRUE THEN allocated_amount ELSE 0 END) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total allocations that are F&A costs. Monitors overhead burden relative to total cost base."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of cost allocation records. Baseline volume metric for allocation processing workload."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`finance_grant_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant budget metrics for award financial management, cost-share compliance, and donor reporting. Supports grant managers and finance directors in monitoring award financial health."
  source: "`vibe_ngo_v1`.`finance`.`budget`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the grant budget for multi-currency award analysis."
    - name: "period_start_date_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month the grant budget period starts for portfolio timeline analysis."
  measures:
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct cost budget across grant budgets. Measures programmatic spending capacity."
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost budget across grant budgets. Monitors overhead recovery from grants."
    - name: "indirect_to_direct_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(indirect_cost_budget AS DOUBLE)) / NULLIF(SUM(CAST(direct_cost_budget AS DOUBLE)), 0), 2)
      comment: "Ratio of indirect to direct cost budget as a percentage. Monitors overhead efficiency against donor caps."
    - name: "grant_budget_count"
      expr: COUNT(1)
      comment: "Total number of grant budgets. Baseline measure for grant portfolio breadth."
$$;