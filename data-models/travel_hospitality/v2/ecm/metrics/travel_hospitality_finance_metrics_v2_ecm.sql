-- Metric views for domain: finance | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_allocation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation run metrics tracking allocation volumes, amounts, variance, and execution quality for management accounting and cost center performance management."
  source: "`vibe_travel_hospitality_v1`.`finance`.`allocation_run`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the allocation run for property-level cost allocation management."
    - name: "allocation_run_status"
      expr: allocation_run_status
      comment: "Current run status (Completed, Failed, Reversed) for allocation process monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of allocation run (Actual, Budget, Forecast) for allocation category analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method used (Headcount, Square Footage, Revenue) for methodology analysis."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for cost allocation for management accounting transparency."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for monthly allocation tracking."
    - name: "gl_posting_status"
      expr: gl_posting_status
      comment: "GL posting status for close process and sub-ledger reconciliation monitoring."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates reversed allocation runs for error rate and reprocessing analysis."
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates automated vs. manual allocation runs for process efficiency analysis."
  measures:
    - name: "total_amount_allocated"
      expr: SUM(CAST(total_amount_allocated AS DOUBLE))
      comment: "Total cost amount allocated across cost centers — primary management accounting KPI for cost distribution analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total allocation variance amount for reconciliation quality and exception management."
    - name: "allocation_run_count"
      expr: COUNT(1)
      comment: "Total number of allocation runs for process throughput and close completeness monitoring."
    - name: "failed_run_count"
      expr: COUNT(CASE WHEN allocation_run_status = 'Failed' THEN 1 END)
      comment: "Number of failed allocation runs — a process quality KPI requiring operational intervention."
    - name: "reversal_run_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed allocation runs indicating errors or period adjustments."
    - name: "avg_amount_allocated"
      expr: AVG(CAST(total_amount_allocated AS DOUBLE))
      comment: "Average amount allocated per run for benchmarking and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking vendor payment obligations, aging, discount capture, and invoice processing efficiency across properties and vendors."
  source: "`vibe_travel_hospitality_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the AP invoice for property-level spend analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., Open, Paid, Disputed) for pipeline analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Standard, Credit Memo) for categorization."
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category for spend classification and budget variance analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, Check, Wire) for treasury analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice for workflow monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for monthly reporting."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for trend analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO/GR/Invoice) for procurement compliance monitoring."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount representing total vendor obligations. Drives cash flow forecasting and spend management decisions."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts, representing actual payable liability."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding AP balance — key liquidity and working capital metric for CFO review."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid to vendors in the period, used for cash disbursement reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured, a direct cost-saving KPI for treasury."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed, used for workload and throughput analysis."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per invoice, used to benchmark vendor transaction sizes."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END)
      comment: "Number of invoices with active disputes — a vendor relationship and process quality KPI."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status NOT IN ('Matched', 'Approved') THEN 1 END)
      comment: "Count of invoices failing three-way match, indicating procurement control breakdowns requiring intervention."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment execution metrics tracking disbursement volumes, reversal rates, discount capture, and payment method mix for treasury and cash management."
  source: "`vibe_travel_hospitality_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the payment for property-level cash management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (ACH, Wire, Check) for treasury channel analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status for pipeline and exception monitoring."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment for categorization and reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period cash disbursement analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cash disbursement reporting."
    - name: "payment_date"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment date truncated to month for trend analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the payment was reversed, used for exception and error rate analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed to vendors — primary cash outflow KPI for treasury."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after fees and discounts, representing actual cash out."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured, a direct cost-saving metric for CFO review."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments for tax compliance reporting."
    - name: "total_bank_fees"
      expr: SUM(CAST(bank_fee_amount AS DOUBLE))
      comment: "Total bank fees incurred on payments, a controllable cost metric for treasury optimization."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments processed for throughput and workload analysis."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed payments indicating payment errors or disputes requiring investigation."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction for benchmarking and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics tracking revenue billed, collections performance, aging, and write-off risk across properties, guests, and corporate accounts."
  source: "`vibe_travel_hospitality_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the AR invoice for property-level revenue and collections analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current invoice status (Open, Paid, Written-Off) for collections pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice for revenue categorization."
    - name: "billing_entity_type"
      expr: billing_entity_type
      comment: "Type of billing entity (Guest, Corporate, Group) for segment-level AR analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections status for aging and dunning workflow management."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket (Current, 30, 60, 90+ days) for DSO and collections risk reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for revenue channel analysis."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for revenue trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency revenue reporting."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total AR invoice amount billed — primary revenue recognition KPI for finance leadership."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance — critical liquidity and collections KPI for CFO."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected against AR invoices for cash receipts reporting."
    - name: "total_room_revenue_billed"
      expr: SUM(CAST(room_revenue_amount AS DOUBLE))
      comment: "Total room revenue billed on AR invoices for rooms revenue reconciliation."
    - name: "total_fnb_revenue_billed"
      expr: SUM(CAST(fnb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue billed on AR invoices for F&B revenue reconciliation."
    - name: "total_event_revenue_billed"
      expr: SUM(CAST(event_revenue_amount AS DOUBLE))
      comment: "Total event revenue billed on AR invoices for events revenue reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed on AR invoices for tax liability and compliance reporting."
    - name: "total_write_off_amount"
      expr: SUM(CASE WHEN write_off_flag = TRUE THEN total_amount ELSE 0 END)
      comment: "Total amount written off as uncollectable — a credit risk and collections quality KPI."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on AR invoices for revenue leakage analysis."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued for billing volume and throughput analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed AR invoices — a guest/corporate satisfaction and billing accuracy KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable payment receipt metrics tracking cash collections, refund rates, advance deposits, and payment channel mix for revenue and treasury management."
  source: "`vibe_travel_hospitality_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the AR payment for property-level cash receipts analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (Credit Card, Cash, Wire) for payment channel mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status for collections pipeline monitoring."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (Front Desk, OTA, Direct) for channel analysis."
    - name: "card_type"
      expr: card_type
      comment: "Card type (Visa, Mastercard, Amex) for payment processing cost analysis."
    - name: "is_advance_deposit"
      expr: is_advance_deposit
      comment: "Indicates advance deposit payments for deposit liability tracking."
    - name: "is_refund"
      expr: is_refund
      comment: "Indicates refund transactions for refund rate and guest satisfaction analysis."
    - name: "payment_date"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment date truncated to month for cash receipts trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total AR payments received — primary cash receipts KPI for treasury and revenue management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after fees, representing actual cash collected."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to AR invoices for collections effectiveness measurement."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash — a cash application backlog KPI requiring operational action."
    - name: "total_transaction_fees"
      expr: SUM(CAST(transaction_fee AS DOUBLE))
      comment: "Total payment processing fees incurred — a controllable cost KPI for treasury optimization."
    - name: "total_advance_deposits"
      expr: SUM(CASE WHEN is_advance_deposit = TRUE THEN payment_amount ELSE 0 END)
      comment: "Total advance deposit receipts for deposit liability and revenue recognition tracking."
    - name: "total_refund_amount"
      expr: SUM(CASE WHEN is_refund = TRUE THEN payment_amount ELSE 0 END)
      comment: "Total refunds issued — a guest satisfaction and revenue leakage KPI."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payment transactions for volume and throughput analysis."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average AR payment amount per transaction for benchmarking and anomaly detection."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank account metrics tracking cash positions, account balances, reconciliation status, and treasury management performance"
  source: "`travel_hospitality_ecm`.`finance`.`bank_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the bank account (e.g., active, closed, dormant)"
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (e.g., checking, savings, money market, payroll)"
    - name: "account_purpose"
      expr: account_purpose
      comment: "Business purpose of the account (e.g., operating, payroll, reserve, escrow)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation status of the account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the account is denominated"
    - name: "is_primary_account"
      expr: is_primary_account
      comment: "Indicates whether this is the primary operating account"
    - name: "is_zero_balance_account"
      expr: is_zero_balance_account
      comment: "Indicates whether this is a zero-balance account (ZBA)"
    - name: "interest_bearing"
      expr: interest_bearing
      comment: "Indicates whether the account earns interest"
    - name: "electronic_banking_enabled"
      expr: electronic_banking_enabled
      comment: "Indicates whether electronic banking is enabled"
    - name: "positive_pay_enabled"
      expr: positive_pay_enabled
      comment: "Indicates whether positive pay fraud prevention is enabled"
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all bank accounts"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available balance across all bank accounts"
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance when accounts were established"
    - name: "total_last_statement_balance"
      expr: SUM(CAST(last_statement_balance AS DOUBLE))
      comment: "Total balance from most recent bank statements"
    - name: "total_minimum_balance_required"
      expr: SUM(CAST(minimum_balance_required AS DOUBLE))
      comment: "Total minimum balance requirements across all accounts"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per bank account"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across interest-bearing accounts"
    - name: "active_account_count"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active bank accounts"
    - name: "reconciled_account_count"
      expr: SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END)
      comment: "Count of bank accounts that are fully reconciled"
    - name: "interest_bearing_account_count"
      expr: SUM(CASE WHEN interest_bearing = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts that earn interest"
    - name: "positive_pay_enabled_count"
      expr: SUM(CASE WHEN positive_pay_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with positive pay fraud prevention enabled"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line item metrics tracking planned spend, budget utilization, and variance analysis for financial planning and control"
  source: "`travel_hospitality_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operating, capital, project)"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget line (e.g., labor, supplies, utilities, marketing)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget line"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the budget"
    - name: "department_code"
      expr: department_code
      comment: "Department code responsible for the budget line"
    - name: "budget_version"
      expr: budget_version
      comment: "Version of the budget (e.g., original, revised, forecast)"
    - name: "locked_flag"
      expr: locked_flag
      comment: "Indicates whether the budget line is locked from further changes"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget across periods or entities"
  measures:
    - name: "total_budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items"
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all line items"
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual spend for comparison"
    - name: "yoy_budget_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(planned_amount AS DOUBLE)) - SUM(CAST(prior_year_actual_amount AS DOUBLE))) / NULLIF(SUM(CAST(prior_year_actual_amount AS DOUBLE)), 0), 2)
      comment: "Year-over-year budget growth percentage compared to prior year actuals"
    - name: "avg_planned_amount"
      expr: AVG(CAST(planned_amount AS DOUBLE))
      comment: "Average planned amount per budget line"
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage for budget monitoring"
    - name: "approved_budget_line_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of budget lines that have been approved"
    - name: "locked_budget_line_count"
      expr: SUM(CASE WHEN locked_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of budget lines locked from further changes"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request metrics tracking CapEx pipeline, approval rates, ROI targets, and budget utilization for capital allocation and asset management decisions."
  source: "`vibe_travel_hospitality_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the CapEx request for property-level capital planning."
    - name: "request_status"
      expr: request_status
      comment: "Current request status (Submitted, Approved, Rejected, In Progress) for pipeline management."
    - name: "request_type"
      expr: request_type
      comment: "Type of CapEx request (PIP, Maintenance, Expansion) for capital category analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for CapEx spend categorization and depreciation planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the CapEx request for capital allocation decision-making."
    - name: "budget_year"
      expr: budget_year
      comment: "Budget year for annual CapEx planning and tracking."
    - name: "is_multi_year_project"
      expr: is_multi_year_project
      comment: "Indicates multi-year CapEx projects for long-term capital commitment tracking."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Approval authority level required for governance and delegation of authority compliance."
  measures:
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total CapEx requested — primary capital demand KPI for capital allocation committee review."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total CapEx approved — actual capital commitment for cash flow and financing planning."
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Total number of CapEx requests for pipeline volume and governance monitoring."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN request_status = 'Approved' THEN 1 END)
      comment: "Number of approved CapEx requests for approval rate calculation."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across CapEx requests — a capital efficiency KPI for investment committee decisions."
    - name: "avg_requested_amount"
      expr: AVG(CAST(requested_amount AS DOUBLE))
      comment: "Average CapEx request size for benchmarking and anomaly detection."
    - name: "sox_controlled_request_count"
      expr: COUNT(CASE WHEN sox_control_required = TRUE THEN 1 END)
      comment: "Number of CapEx requests requiring SOX controls for compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finance budget metrics tracking budgeted performance targets across revenue, expense, profitability, and operational KPIs for property-level budget management and variance analysis."
  source: "`vibe_travel_hospitality_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the budget for property-level budget management."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (Operating, Capital, Forecast) for budget category analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Current budget status (Draft, Approved, Locked) for budget governance monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget tracking."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for departmental budget analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency budget reporting."
    - name: "version"
      expr: version
      comment: "Budget version for tracking revisions and reforecasts."
  measures:
    - name: "total_budgeted_revenue"
      expr: SUM(CAST(budgeted_total_revenue AS DOUBLE))
      comment: "Total budgeted revenue across all streams — primary top-line budget KPI for executive review."
    - name: "total_budgeted_rooms_revenue"
      expr: SUM(CAST(budgeted_rooms_revenue AS DOUBLE))
      comment: "Total budgeted rooms revenue for rooms department budget management."
    - name: "total_budgeted_fnb_revenue"
      expr: SUM(CAST(budgeted_fnb_revenue AS DOUBLE))
      comment: "Total budgeted F&B revenue for F&B department budget management."
    - name: "total_budgeted_events_revenue"
      expr: SUM(CAST(budgeted_events_revenue AS DOUBLE))
      comment: "Total budgeted events revenue for events department budget management."
    - name: "total_budgeted_gop"
      expr: SUM(CAST(budgeted_gop AS DOUBLE))
      comment: "Total budgeted Gross Operating Profit — a primary profitability target KPI for ownership review."
    - name: "total_budgeted_ebitda"
      expr: SUM(CAST(budgeted_ebitda AS DOUBLE))
      comment: "Total budgeted EBITDA — a key investor and ownership profitability target."
    - name: "total_budgeted_noi"
      expr: SUM(CAST(budgeted_noi AS DOUBLE))
      comment: "Total budgeted Net Operating Income — critical for owner distribution and HMA compliance."
    - name: "total_budgeted_labor_expense"
      expr: SUM(CAST(budgeted_labor_expense AS DOUBLE))
      comment: "Total budgeted labor expense — largest controllable cost line for operational management."
    - name: "total_budgeted_operating_expense"
      expr: SUM(CAST(budgeted_operating_expense AS DOUBLE))
      comment: "Total budgeted operating expenses for cost management and efficiency analysis."
    - name: "avg_budgeted_adr"
      expr: AVG(CAST(budgeted_adr AS DOUBLE))
      comment: "Average budgeted ADR (Average Daily Rate) across properties for rate strategy benchmarking."
    - name: "avg_budgeted_revpar"
      expr: AVG(CAST(budgeted_revpar AS DOUBLE))
      comment: "Average budgeted RevPAR across properties — the hospitality industry's primary revenue efficiency KPI."
    - name: "avg_budgeted_goppar"
      expr: AVG(CAST(budgeted_goppar AS DOUBLE))
      comment: "Average budgeted GOPPAR (GOP Per Available Room) — a key profitability efficiency KPI for ownership."
    - name: "avg_budgeted_occupancy_rate"
      expr: AVG(CAST(budgeted_occupancy_rate AS DOUBLE))
      comment: "Average budgeted occupancy rate for demand planning and rate strategy."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records for budget governance and completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking asset book values, accumulated depreciation, impairment, disposal gains/losses, and FF&E reserve eligibility for asset management and financial reporting."
  source: "`vibe_travel_hospitality_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the fixed asset for property-level asset register management."
    - name: "asset_status"
      expr: asset_status
      comment: "Current asset status (Active, Disposed, Impaired) for asset lifecycle management."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (FF&E, Building, Equipment) for asset class analysis."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for depreciation and financial reporting classification."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (Straight-Line, Declining Balance) for depreciation policy analysis."
    - name: "ffe_reserve_eligible"
      expr: ffe_reserve_eligible
      comment: "Indicates FF&E reserve eligible assets for reserve adequacy analysis."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Indicates impaired assets for impairment review and financial reporting."
    - name: "acquisition_date"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Acquisition date truncated to year for asset vintage analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets — primary asset base KPI for balance sheet reporting."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets — key balance sheet metric for asset valuation and financing."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation for asset age and replacement planning analysis."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized — a financial risk and asset quality KPI for auditors and investors."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals for asset recycling and capital recovery analysis."
    - name: "total_gain_loss_on_disposal"
      expr: SUM(CAST(gain_loss_on_disposal AS DOUBLE))
      comment: "Total gain or loss on asset disposals for P&L impact and asset management effectiveness."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of fixed assets for residual value planning."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets in the register for asset completeness and audit purposes."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of impaired assets requiring write-down — a financial risk KPI for audit and investor reporting."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset for asset portfolio benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_gl_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General Ledger batch metrics tracking posting volumes, control totals, reversal rates, and batch processing quality for financial close management and audit compliance."
  source: "`vibe_travel_hospitality_v1`.`finance`.`gl_batch`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the GL batch for property-level close management."
    - name: "batch_status"
      expr: batch_status
      comment: "Current batch status (Open, Posted, Reversed) for close process monitoring."
    - name: "batch_type"
      expr: batch_type
      comment: "Type of GL batch (Manual, System, Recurring) for batch categorization."
    - name: "source_module"
      expr: source_module
      comment: "Source module that generated the batch (AR, AP, Payroll) for sub-ledger reconciliation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the GL batch for period-over-period close analysis."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for monthly close tracking."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for close timeline analysis."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates recurring batches for automated close process monitoring."
    - name: "is_balanced"
      expr: is_balanced
      comment: "Indicates whether the batch is balanced (debits = credits) for control quality monitoring."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across GL batches for ledger volume and close completeness analysis."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across GL batches for ledger balance verification."
    - name: "total_control_amount"
      expr: SUM(CAST(control_total AS DOUBLE))
      comment: "Total control total across batches for batch integrity and reconciliation."
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Total number of GL batches processed — a financial close throughput KPI."
    - name: "unbalanced_batch_count"
      expr: COUNT(CASE WHEN is_balanced = FALSE THEN 1 END)
      comment: "Number of unbalanced GL batches — a critical financial control quality KPI requiring immediate remediation."
    - name: "reversal_batch_count"
      expr: COUNT(CASE WHEN gl_reversal_batch_id IS NOT NULL THEN 1 END)
      comment: "Number of reversed GL batches indicating posting errors or period adjustments."
    - name: "avg_control_total"
      expr: AVG(CAST(control_total AS DOUBLE))
      comment: "Average control total per GL batch for batch size benchmarking and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_hma_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hotel Management Agreement contract metrics tracking fee structures, contract terms, performance test flags, and renewal pipeline for ownership and operator governance."
  source: "`vibe_travel_hospitality_v1`.`finance`.`hma_contract`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the HMA contract for property-level contract management."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (Active, Expired, Terminated) for contract lifecycle management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of HMA contract for contract structure analysis."
    - name: "fee_calculation_basis"
      expr: fee_calculation_basis
      comment: "Basis for fee calculation (Gross Revenue, Total Revenue) for fee structure benchmarking."
    - name: "performance_test_flag"
      expr: performance_test_flag
      comment: "Indicates contracts with performance tests for operator accountability monitoring."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Contract effective date truncated to year for contract vintage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency HMA portfolio analysis."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Governing law jurisdiction for legal risk and compliance analysis."
  measures:
    - name: "total_minimum_annual_fee"
      expr: SUM(CAST(minimum_annual_fee_amount AS DOUBLE))
      comment: "Total minimum annual management fee commitments across HMA contracts — a guaranteed fee obligation KPI for ownership."
    - name: "total_working_capital"
      expr: SUM(CAST(working_capital_amount AS DOUBLE))
      comment: "Total working capital committed under HMA contracts for liquidity planning."
    - name: "total_indemnification_cap"
      expr: SUM(CAST(indemnification_cap_amount AS DOUBLE))
      comment: "Total indemnification cap exposure across HMA contracts for legal risk quantification."
    - name: "avg_base_management_fee_pct"
      expr: AVG(CAST(base_management_fee_percentage AS DOUBLE))
      comment: "Average base management fee percentage across HMA contracts for fee benchmarking and negotiation."
    - name: "avg_incentive_fee_pct"
      expr: AVG(CAST(incentive_fee_percentage AS DOUBLE))
      comment: "Average incentive management fee percentage for performance-linked fee analysis."
    - name: "avg_ffe_reserve_pct"
      expr: AVG(CAST(capital_expenditure_reserve_percentage AS DOUBLE))
      comment: "Average FF&E reserve percentage across contracts for capital maintenance commitment analysis."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of HMA contracts for portfolio size and governance monitoring."
    - name: "performance_test_contract_count"
      expr: COUNT(CASE WHEN performance_test_flag = TRUE THEN 1 END)
      comment: "Number of HMA contracts with performance tests — an operator accountability and termination risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry metrics tracking posting volumes, debit/credit balances, reversal rates, and intercompany activity for financial close quality and audit compliance."
  source: "`vibe_travel_hospitality_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the journal entry for property-level ledger analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry for close process monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Document type (SA, AA, KR) for journal entry categorization."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period journal entry analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for close timeline analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates intercompany journal entries for elimination and consolidation analysis."
    - name: "capex_indicator"
      expr: capex_indicator
      comment: "Indicates CapEx journal entries for capital expenditure tracking."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates reversed journal entries for error rate and close quality analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount posted across journal entries — primary ledger volume KPI for close management."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount posted across journal entries for ledger balance verification."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted for close throughput and workload analysis."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries — a financial close quality and error rate KPI."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries for consolidation and elimination monitoring."
    - name: "capex_entry_count"
      expr: COUNT(CASE WHEN capex_indicator = TRUE THEN 1 END)
      comment: "Number of CapEx journal entries for capital expenditure tracking and budget compliance."
    - name: "avg_debit_amount"
      expr: AVG(CAST(debit_amount AS DOUBLE))
      comment: "Average debit amount per journal entry for benchmarking and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_management_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hotel Management Agreement fee metrics tracking base and incentive fee accruals, payment status, and fee rate performance for ownership and operator financial governance."
  source: "`vibe_travel_hospitality_v1`.`finance`.`management_fee`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the management fee for property-level HMA compliance."
    - name: "fee_type"
      expr: fee_type
      comment: "Type of management fee (Base, Incentive, Other) for fee structure analysis."
    - name: "fee_status"
      expr: fee_status
      comment: "Current fee status (Accrued, Paid, Disputed) for payment pipeline monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the management fee for governance and control monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual fee performance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly fee accrual tracking."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for fee calculation (Gross Revenue, GOP) for fee structure analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates intercompany management fees for consolidation and elimination."
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total management fee amount accrued — primary HMA financial obligation KPI for ownership review."
    - name: "total_net_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net management fee after adjustments — actual fee liability for cash planning."
    - name: "total_basis_amount"
      expr: SUM(CAST(basis_amount AS DOUBLE))
      comment: "Total fee calculation basis amount (revenue or GOP) for fee rate verification."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total fee adjustments applied — a fee dispute and reconciliation KPI."
    - name: "avg_fee_rate_percentage"
      expr: AVG(CAST(fee_rate_percentage AS DOUBLE))
      comment: "Average management fee rate percentage across properties for HMA benchmarking."
    - name: "fee_count"
      expr: COUNT(1)
      comment: "Total number of management fee records for accrual completeness monitoring."
    - name: "reversal_fee_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed management fees indicating disputes or calculation errors."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_owner_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Owner distribution metrics tracking NOI, GOP, distribution amounts, FFE reserve contributions, and debt service for ownership entity financial performance and HMA compliance."
  source: "`vibe_travel_hospitality_v1`.`finance`.`owner_distribution`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the owner distribution for property-level ownership performance."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current distribution status (Calculated, Approved, Paid) for distribution pipeline monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual ownership return analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly distribution tracking."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates disputed distributions for ownership dispute monitoring."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Distribution period start date truncated to month for trend analysis."
  measures:
    - name: "total_distribution_amount"
      expr: SUM(CAST(distribution_amount AS DOUBLE))
      comment: "Total owner distribution amount — primary ownership return KPI for investor and board reporting."
    - name: "total_noi_amount"
      expr: SUM(CAST(noi_amount AS DOUBLE))
      comment: "Total Net Operating Income — the key profitability metric driving owner distributions and asset valuation."
    - name: "total_gop_amount"
      expr: SUM(CAST(gop_amount AS DOUBLE))
      comment: "Total Gross Operating Profit for operational performance benchmarking against budget."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue used as distribution calculation basis for HMA compliance verification."
    - name: "total_ffe_reserve_contribution"
      expr: SUM(CAST(ffe_reserve_contribution_amount AS DOUBLE))
      comment: "Total FF&E reserve contributions — a capital maintenance compliance KPI for ownership and brand standards."
    - name: "total_debt_service"
      expr: SUM(CAST(debt_service_amount AS DOUBLE))
      comment: "Total debt service deducted from distributions for leverage and coverage ratio analysis."
    - name: "total_base_management_fee"
      expr: SUM(CAST(base_management_fee_amount AS DOUBLE))
      comment: "Total base management fees deducted for HMA fee compliance monitoring."
    - name: "total_incentive_management_fee"
      expr: SUM(CAST(incentive_management_fee_amount AS DOUBLE))
      comment: "Total incentive management fees paid — a performance-linked fee KPI for operator accountability."
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses_amount AS DOUBLE))
      comment: "Total operating expenses for cost efficiency and NOI margin analysis."
    - name: "distribution_count"
      expr: COUNT(1)
      comment: "Number of owner distribution records for distribution completeness and governance monitoring."
    - name: "avg_ffe_reserve_balance"
      expr: AVG(CAST(ffe_reserve_balance AS DOUBLE))
      comment: "Average FF&E reserve balance across properties for capital maintenance adequacy assessment."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics tracking disbursement success rates, failed payments, processing fees, and reconciliation status for treasury operations management."
  source: "`vibe_travel_hospitality_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the payment run for property-level treasury management."
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current payment run status (Completed, Failed, Partial) for treasury operations monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (Regular, Emergency, Reversal) for payment categorization."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (ACH, Wire, Check) for payment channel analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for bank reconciliation completeness monitoring."
    - name: "scheduled_date"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Scheduled payment date truncated to month for cash flow planning."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates payment runs requiring approval for governance and control monitoring."
  measures:
    - name: "total_disbursement_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total payment run disbursement amount — primary cash outflow KPI for treasury management."
    - name: "total_successful_amount"
      expr: SUM(CAST(successful_amount AS DOUBLE))
      comment: "Total successfully disbursed amount for payment execution effectiveness measurement."
    - name: "total_failed_amount"
      expr: SUM(CAST(failed_amount AS DOUBLE))
      comment: "Total failed payment amount — a payment operations quality KPI requiring immediate remediation."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net disbursement after fees for actual cash outflow reporting."
    - name: "total_processing_fees"
      expr: SUM(CAST(processing_fee_amount AS DOUBLE))
      comment: "Total payment processing fees — a controllable treasury cost KPI."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs for treasury throughput and workload analysis."
    - name: "avg_disbursement_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average disbursement amount per payment run for benchmarking and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics tracking tax liabilities, filing status, exemptions, and tax type mix for tax compliance, regulatory reporting, and jurisdiction-level tax management."
  source: "`vibe_travel_hospitality_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the tax posting for property-level tax compliance."
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (VAT, Occupancy Tax, Sales Tax) for tax liability categorization."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code for detailed tax rate and jurisdiction analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Tax jurisdiction for multi-jurisdiction compliance reporting."
    - name: "filing_status"
      expr: filing_status
      comment: "Tax filing status (Filed, Pending, Overdue) for compliance deadline monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual tax liability analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly tax accrual tracking."
    - name: "exemption_indicator"
      expr: exemption_indicator
      comment: "Indicates tax-exempt transactions for exemption rate and compliance analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates reversed tax postings for error rate and adjustment analysis."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted — primary tax liability KPI for regulatory compliance and cash planning."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total taxable base amount for effective tax rate calculation and audit support."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average effective tax rate across postings for tax rate benchmarking and jurisdiction analysis."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings for compliance volume and filing completeness monitoring."
    - name: "exempt_posting_count"
      expr: COUNT(CASE WHEN exemption_indicator = TRUE THEN 1 END)
      comment: "Number of tax-exempt postings for exemption compliance and audit risk monitoring."
    - name: "reversal_posting_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed tax postings indicating adjustments or errors requiring investigation."
$$;
