-- Metric views for domain: finance | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-payable invoice metrics tracking spend volume, aging, discount capture, and tax liability across suppliers, cost centers, and legal entities."
  source: "`vibe_restaurants_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current approval/payment status of the AP invoice (e.g. Open, Paid, Blocked)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. Standard, Credit Memo, Down Payment)."
    - name: "expense_category"
      expr: expense_category
      comment: "Business expense category for spend analysis (e.g. Food, Labor, Utilities)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used or planned for payment (e.g. ACH, Check, Wire)."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the invoice for granular trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend analysis."
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued by the supplier."
    - name: "due_date"
      expr: due_date
      comment: "Payment due date for aging and cash-flow planning."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "PO/GR/Invoice three-way match result — key control indicator."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice value — primary spend volume KPI."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice value after discounts — actual liability."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on AP invoices — tax liability tracking."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured — cash management efficiency."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on AP invoices — compliance and cash-flow impact."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices — volume indicator for workload and supplier activity."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount — benchmark for spend concentration and anomaly detection."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_indicator = TRUE THEN 1 END)
      comment: "Number of invoices with a payment block — operational risk and cash-flow risk indicator."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'Matched' THEN 1 END)
      comment: "Invoices not yet three-way matched — procurement control quality metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ap_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level AP invoice metrics enabling granular spend analysis by GL account, cost center, expense category, and capex vs opex classification."
  source: "`vibe_restaurants_v1`.`finance`.`ap_invoice_line`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category of the line item for spend classification."
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (e.g. Material, Service, Freight)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly trend analysis."
    - name: "is_capex"
      expr: is_capex
      comment: "Flag indicating whether the line is a capital expenditure — capex vs opex split."
    - name: "is_cogs"
      expr: is_cogs
      comment: "Flag indicating whether the line is cost of goods sold — food cost tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency analysis."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status at line level — control quality indicator."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice line — workflow efficiency indicator."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total AP invoice line amount — granular spend volume."
    - name: "total_line_amount_with_tax"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Total line amount including tax — full cost liability per line."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on invoice lines — tax liability by category."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts captured at line level — procurement savings tracking."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total PO-to-invoice variance — procurement accuracy and supplier compliance KPI."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity ordered/invoiced — volume tracking for ingredient and supply procurement."
    - name: "capex_spend_amount"
      expr: SUM(CASE WHEN is_capex = TRUE THEN line_amount ELSE 0 END)
      comment: "Total capital expenditure spend at line level — capex budget utilization."
    - name: "cogs_spend_amount"
      expr: SUM(CASE WHEN is_cogs = TRUE THEN line_amount ELSE 0 END)
      comment: "Total cost-of-goods-sold spend — food and beverage cost tracking."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of invoice lines — processing volume and workload indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-payable payment metrics tracking cash outflows, payment method mix, discount capture, and withholding tax across vendors and payment runs."
  source: "`vibe_restaurants_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (ACH, Check, Wire) — cash management and bank fee analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Regular, Advance, Final) — payment lifecycle analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Cleared, Outstanding, Reversed)."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity cash reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cash-flow analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cash-flow trend analysis."
    - name: "payment_date"
      expr: payment_date
      comment: "Date payment was executed — cash timing analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status — financial control quality indicator."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash paid to vendors — primary AP cash outflow KPI."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local currency — functional currency cash outflow."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts captured — working capital efficiency KPI."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments — tax compliance tracking."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of AP payments processed — payment run volume indicator."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount — benchmark for payment concentration and anomaly detection."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 END)
      comment: "Payments not yet bank-reconciled — financial close risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-receivable invoice metrics tracking revenue recognition, outstanding balances, aging, and collection efficiency for franchise royalties and other receivables."
  source: "`vibe_restaurants_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g. Open, Paid, Overdue)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (e.g. Royalty, Rent, Marketing Fund)."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity AR reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AR analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level — collections intensity indicator."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the invoice — collections channel analysis."
    - name: "invoice_date"
      expr: invoice_date
      comment: "Invoice issuance date for aging and trend analysis."
    - name: "due_date"
      expr: due_date
      comment: "Payment due date for DSO and aging bucket analysis."
    - name: "business_area"
      expr: business_area
      comment: "Business area for segment-level AR reporting."
  measures:
    - name: "total_gross_ar_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AR invoice value — revenue billed KPI."
    - name: "total_net_ar_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR invoice value after discounts — net revenue recognized."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance — primary collections and liquidity KPI."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on AR invoices — tax liability and compliance tracking."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR invoices — revenue leakage indicator."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to AR invoices — credit note and dispute volume."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AR invoices issued — billing volume indicator."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue AR invoices — collections risk and DSO quality indicator."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per invoice — concentration risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-receivable payment metrics tracking cash collections, unapplied cash, and payment method mix for franchise and customer receivables."
  source: "`vibe_restaurants_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Collection method (ACH, Check, Wire, Card) — channel mix analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of AR payment (e.g. Regular, Advance, Partial)."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Applied, Unapplied, Reversed)."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity cash reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual collections analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly collections trend."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating a reversed payment — payment quality and error rate indicator."
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date cash was received — cash timing and DSO analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash collected from customers/franchisees — primary AR cash inflow KPI."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to open invoices — collections effectiveness."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash — cash application backlog and working capital risk."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts granted — revenue concession tracking."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total collections in functional currency — FX-adjusted cash inflow."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of AR payments received — collections volume indicator."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed AR payments — payment quality and error rate KPI."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average AR payment amount — collections concentration and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting volumes, debit/credit balances, reversal rates, and period-close activity across legal entities and ledgers."
  source: "`vibe_restaurants_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g. SA, KR, DR) — entry classification."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity GL reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual GL volume analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close activity analysis."
    - name: "ledger_group"
      expr: ledger_group
      comment: "Ledger group (e.g. GAAP, IFRS) — multi-GAAP reporting dimension."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag for intercompany entries — elimination and reconciliation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversed journal entries — error rate and adjustment quality."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Approval workflow status — period-close readiness indicator."
    - name: "posting_date"
      expr: posting_date
      comment: "GL posting date for time-series analysis."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that generated the entry — data lineage and integration quality."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit postings — GL activity volume and balance verification."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit postings — GL activity volume and balance verification."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Number of journal entries — period-close workload and automation rate indicator."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries — error rate and adjustment quality KPI."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries — elimination workload indicator."
    - name: "avg_line_item_count"
      expr: AVG(CAST(line_item_count AS DOUBLE))
      comment: "Average number of lines per journal entry — entry complexity indicator."
    - name: "parked_entry_count"
      expr: COUNT(CASE WHEN parked_indicator = TRUE THEN 1 END)
      comment: "Number of parked (unposted) journal entries — period-close risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics tracking approved budgets, baseline amounts, and budget utilization across units, cost centers, and fiscal periods."
  source: "`vibe_restaurants_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g. Operating, Capital, Marketing) — budget category analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for spend classification."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval status of the budget (e.g. Draft, Approved, Locked)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget tracking."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (Franchise, Corporate) — budget split by ownership model."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code for multi-brand budget analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional budget analysis."
    - name: "nro_flag"
      expr: nro_flag
      comment: "Flag for new restaurant opening budgets — NRO investment tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total approved budget amount — primary budget volume KPI."
    - name: "total_baseline_amount"
      expr: SUM(CAST(baseline_amount AS DOUBLE))
      comment: "Total baseline budget amount — prior-year or zero-based baseline for variance analysis."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records — planning coverage indicator."
    - name: "avg_budget_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average budget amount per record — budget concentration analysis."
    - name: "nro_budget_amount"
      expr: SUM(CASE WHEN nro_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total budget allocated to new restaurant openings — NRO investment KPI."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_pct AS DOUBLE))
      comment: "Average variance threshold percentage — budget control tightness indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level metrics enabling granular planned vs. actual analysis by GL account, cost center, and fiscal period for operational and capital budgets."
  source: "`vibe_restaurants_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for spend classification at line level."
    - name: "budget_subcategory"
      expr: budget_subcategory
      comment: "Budget subcategory for granular spend analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval status of the budget line."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget line analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget line tracking."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity budget reporting."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget to this line — allocation quality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget line currency for multi-currency analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart dimension for time-of-day budget analysis (e.g. Breakfast, Lunch, Dinner)."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount at line level — primary budget planning KPI."
    - name: "total_baseline_amount"
      expr: SUM(CAST(baseline_amount AS DOUBLE))
      comment: "Total baseline amount for variance-to-baseline analysis."
    - name: "total_quantity_target"
      expr: SUM(CAST(quantity_target AS DOUBLE))
      comment: "Total quantity target for volume-based budget lines — operational planning KPI."
    - name: "avg_budget_percentage_target"
      expr: AVG(CAST(budget_percentage_target AS DOUBLE))
      comment: "Average budget percentage target — cost ratio planning benchmark."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_percentage AS DOUBLE))
      comment: "Average variance threshold percentage — budget control tightness at line level."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget lines — planning granularity and coverage indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure project metrics tracking approved budgets, actual spend, ROI, and variance for restaurant construction, remodel, and equipment projects."
  source: "`vibe_restaurants_v1`.`finance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the capex project (e.g. Planned, In Progress, Completed)."
    - name: "project_type"
      expr: project_type
      comment: "Type of capex project (e.g. New Build, Remodel, Equipment) — investment category."
    - name: "project_category"
      expr: project_category
      comment: "Project category for capex portfolio analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity capex reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Project currency for multi-currency capex analysis."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned project start date for timeline analysis."
    - name: "planned_completion_date"
      expr: planned_completion_date
      comment: "Planned completion date for schedule adherence tracking."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capex budget — primary investment authorization KPI."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual capex spend — budget utilization and cash outflow KPI."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total capex budget variance (actual vs. approved) — project financial control KPI."
    - name: "avg_expected_roi_percent"
      expr: AVG(CAST(expected_roi_percent AS DOUBLE))
      comment: "Average expected ROI across capex projects — investment quality indicator."
    - name: "avg_actual_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average actual ROI achieved — investment performance vs. expectation."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of capex projects — investment pipeline volume indicator."
    - name: "completed_project_count"
      expr: COUNT(CASE WHEN project_status = 'Completed' THEN 1 END)
      comment: "Number of completed capex projects — delivery rate indicator."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget amount across all capex projects — total capital commitment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_royalty_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise royalty accrual metrics tracking royalty revenue, marketing fund contributions, technology fees, and accrual accuracy across franchisees and periods."
  source: "`vibe_restaurants_v1`.`finance`.`royalty_accrual`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Revenue recognition status of the accrual (e.g. Recognized, Deferred, Reversed)."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity royalty reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual royalty revenue analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly royalty trend analysis."
    - name: "adjustment_indicator"
      expr: adjustment_indicator
      comment: "Flag for adjustment accruals — accrual quality and correction rate."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversed accruals — accrual accuracy indicator."
    - name: "accrual_period_start_date"
      expr: accrual_period_start_date
      comment: "Start date of the accrual period for time-series analysis."
  measures:
    - name: "total_accrued_royalty_amount"
      expr: SUM(CAST(accrued_royalty_amount AS DOUBLE))
      comment: "Total royalty revenue accrued — primary franchise revenue KPI."
    - name: "total_royalty_base_net_sales"
      expr: SUM(CAST(royalty_base_net_sales AS DOUBLE))
      comment: "Total net sales used as royalty base — franchise system sales volume KPI."
    - name: "total_marketing_fund_contribution"
      expr: SUM(CAST(marketing_fund_contribution AS DOUBLE))
      comment: "Total marketing fund contributions accrued — brand fund health KPI."
    - name: "total_technology_fee"
      expr: SUM(CAST(technology_fee AS DOUBLE))
      comment: "Total technology fees accrued — tech revenue stream tracking."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total accrued amount including all fee components — comprehensive franchise revenue KPI."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across accruals — rate compliance and agreement adherence."
    - name: "avg_marketing_fund_rate_percent"
      expr: AVG(CAST(marketing_fund_rate_percent AS DOUBLE))
      comment: "Average marketing fund contribution rate — fund rate compliance indicator."
    - name: "accrual_count"
      expr: COUNT(1)
      comment: "Number of royalty accrual records — accrual volume and franchisee coverage."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed royalty accruals — accrual accuracy and correction rate KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_pos_settlement_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS settlement batch metrics tracking daily sales settlement, processor fees, refunds, and reconciliation status across restaurant units and card brands."
  source: "`vibe_restaurants_v1`.`finance`.`pos_settlement_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the settlement batch (e.g. Settled, Pending, Failed)."
    - name: "card_brand"
      expr: card_brand
      comment: "Card brand (Visa, Mastercard, Amex) — payment mix and fee analysis."
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor used — processor performance and fee comparison."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status — financial close quality indicator."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity settlement reporting."
    - name: "batch_date"
      expr: batch_date
      comment: "Date of the settlement batch — daily sales trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency for multi-currency analysis."
  measures:
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales settled through POS — primary daily revenue KPI."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement after fees and refunds — actual cash deposited KPI."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds processed — guest satisfaction and revenue leakage indicator."
    - name: "total_processor_fee_amount"
      expr: SUM(CAST(processor_fee_amount AS DOUBLE))
      comment: "Total payment processor fees — cost of payment acceptance KPI."
    - name: "total_interchange_fee_amount"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees — card acceptance cost breakdown."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tips collected through POS — labor compensation and guest generosity indicator."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross batch amount — settlement volume KPI."
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of settlement batches — operational volume indicator."
    - name: "avg_gross_sales_per_batch"
      expr: AVG(CAST(gross_sales_amount AS DOUBLE))
      comment: "Average gross sales per settlement batch — unit-level daily sales benchmark."
    - name: "unreconciled_batch_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 END)
      comment: "Number of unreconciled settlement batches — financial close risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_asset_depreciation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset depreciation metrics tracking depreciation expense, accumulated depreciation, net book value, and impairment across asset classes and legal entities."
  source: "`vibe_restaurants_v1`.`finance`.`asset_depreciation`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (e.g. Equipment, Leasehold Improvements, Vehicles) — depreciation by asset type."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (Straight-Line, Declining Balance) — accounting policy analysis."
    - name: "depreciation_status"
      expr: depreciation_status
      comment: "Status of the depreciation run — processing quality indicator."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity asset reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual depreciation analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly depreciation trend."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag for impaired assets — asset quality and write-down risk indicator."
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area (e.g. Book, Tax) — multi-ledger depreciation analysis."
  measures:
    - name: "total_depreciation_amount"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense for the period — P&L impact KPI."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — asset age and replacement planning indicator."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of assets — balance sheet asset value KPI."
    - name: "total_acquisition_value"
      expr: SUM(CAST(acquisition_value AS DOUBLE))
      comment: "Total original acquisition value — gross asset base KPI."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized — asset quality and write-down KPI."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life of assets — asset refresh and capex planning indicator."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of impaired assets — asset quality risk indicator."
    - name: "asset_record_count"
      expr: COUNT(1)
      comment: "Number of depreciation records — asset portfolio size indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_lease_liability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 842 / IFRS 16 lease liability metrics tracking right-of-use asset values, interest expense, principal payments, and liability balances for restaurant location leases."
  source: "`vibe_restaurants_v1`.`finance`.`lease_liability`"
  dimensions:
    - name: "lease_classification"
      expr: lease_classification
      comment: "Lease classification (Operating, Finance) — accounting treatment and P&L impact."
    - name: "accounting_standard"
      expr: accounting_standard
      comment: "Accounting standard (ASC 842, IFRS 16) — multi-GAAP lease reporting."
    - name: "lease_liability_status"
      expr: lease_liability_status
      comment: "Current status of the lease liability (Active, Terminated, Renewed)."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity lease reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual lease liability analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly lease liability trend."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Payment frequency (Monthly, Quarterly, Annual) — cash flow planning."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Flag for leases with renewal options — lease term risk and extension planning."
    - name: "remeasurement_indicator"
      expr: remeasurement_indicator
      comment: "Flag for remeasured leases — lease modification and reassessment activity."
    - name: "commencement_date"
      expr: commencement_date
      comment: "Lease commencement date for portfolio age analysis."
  measures:
    - name: "total_initial_liability_amount"
      expr: SUM(CAST(initial_liability_amount AS DOUBLE))
      comment: "Total initial lease liability recognized at commencement — balance sheet impact KPI."
    - name: "total_opening_liability_balance"
      expr: SUM(CAST(opening_liability_balance AS DOUBLE))
      comment: "Total opening lease liability balance for the period — period-start exposure."
    - name: "total_closing_liability_balance"
      expr: SUM(CAST(closing_liability_balance AS DOUBLE))
      comment: "Total closing lease liability balance — period-end balance sheet KPI."
    - name: "total_current_liability_amount"
      expr: SUM(CAST(current_liability_amount AS DOUBLE))
      comment: "Total current portion of lease liabilities — short-term balance sheet classification."
    - name: "total_noncurrent_liability_amount"
      expr: SUM(CAST(noncurrent_liability_amount AS DOUBLE))
      comment: "Total non-current portion of lease liabilities — long-term balance sheet classification."
    - name: "total_interest_expense"
      expr: SUM(CAST(interest_expense_amount AS DOUBLE))
      comment: "Total interest expense on lease liabilities — P&L financing cost KPI."
    - name: "total_principal_payment"
      expr: SUM(CAST(principal_payment_amount AS DOUBLE))
      comment: "Total principal payments made on leases — cash outflow and liability reduction KPI."
    - name: "total_right_of_use_asset"
      expr: SUM(CAST(right_of_use_asset_amount AS DOUBLE))
      comment: "Total right-of-use asset value — balance sheet asset KPI for leased locations."
    - name: "total_monthly_payment_amount"
      expr: SUM(CAST(monthly_payment_amount AS DOUBLE))
      comment: "Total monthly lease payment obligations — recurring cash commitment KPI."
    - name: "total_lease_payments"
      expr: SUM(CAST(total_lease_payments AS DOUBLE))
      comment: "Total undiscounted future lease payments — lease commitment exposure KPI."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate applied to lease liabilities — borrowing rate benchmark."
    - name: "lease_count"
      expr: COUNT(1)
      comment: "Number of lease liability records — lease portfolio size indicator."
    - name: "remeasured_lease_count"
      expr: COUNT(CASE WHEN remeasurement_indicator = TRUE THEN 1 END)
      comment: "Number of remeasured leases — lease modification activity and accounting complexity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics tracking allocation amounts, methods, and accuracy across cost centers, GL accounts, and fiscal periods for overhead distribution analysis."
  source: "`vibe_restaurants_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method used (e.g. Fixed Percentage, Statistical Key Figure) — methodology analysis."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for allocation (e.g. Headcount, Revenue, Square Footage) — driver analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity allocation reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual allocation analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly allocation trend."
    - name: "cycle_name"
      expr: cycle_name
      comment: "Allocation cycle name — identifies the allocation run for traceability."
    - name: "cost_allocation_status"
      expr: cost_allocation_status
      comment: "Status of the allocation (e.g. Posted, Reversed, Pending) — processing quality."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversed allocations — correction rate and accuracy indicator."
    - name: "currency_code"
      expr: currency_code
      comment: "Allocation currency for multi-currency analysis."
  measures:
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total cost allocated — overhead distribution volume KPI."
    - name: "total_sender_amount"
      expr: SUM(CAST(sender_amount AS DOUBLE))
      comment: "Total amount sent from source cost centers — overhead pool size KPI."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage — distribution concentration indicator."
    - name: "total_receiver_units"
      expr: SUM(CAST(total_receiver_units AS DOUBLE))
      comment: "Total receiver units used in statistical allocations — allocation driver volume."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of cost allocation records — allocation complexity and volume indicator."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed allocations — allocation accuracy and correction rate KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial period-close metrics tracking close duration, reconciliation status, and exception counts to drive close cycle efficiency and audit readiness."
  source: "`vibe_restaurants_v1`.`finance`.`period_close`"
  dimensions:
    - name: "close_status"
      expr: close_status
      comment: "Current status of the period close (e.g. Open, In Progress, Closed)."
    - name: "close_phase"
      expr: close_phase
      comment: "Phase of the close process (e.g. Pre-Close, Hard Close, Reporting) — close timeline analysis."
    - name: "period_type"
      expr: period_type
      comment: "Type of period (Monthly, Quarterly, Annual) — close complexity analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity close tracking."
    - name: "ap_reconciliation_status"
      expr: ap_reconciliation_status
      comment: "AP sub-ledger reconciliation status — close readiness indicator."
    - name: "ar_reconciliation_status"
      expr: ar_reconciliation_status
      comment: "AR sub-ledger reconciliation status — close readiness indicator."
    - name: "bank_reconciliation_status"
      expr: bank_reconciliation_status
      comment: "Bank reconciliation status — cash close readiness indicator."
    - name: "audit_readiness_flag"
      expr: audit_readiness_flag
      comment: "Flag indicating audit readiness — compliance and governance indicator."
    - name: "actual_close_date"
      expr: actual_close_date
      comment: "Actual date the period was closed — close timing analysis."
  measures:
    - name: "avg_close_duration_hours"
      expr: AVG(CAST(close_duration_hours AS DOUBLE))
      comment: "Average period-close duration in hours — close efficiency KPI and benchmark."
    - name: "total_close_duration_hours"
      expr: SUM(CAST(close_duration_hours AS DOUBLE))
      comment: "Total close duration hours across all entities — aggregate close workload."
    - name: "total_exception_count"
      expr: SUM(CAST(exception_count AS DOUBLE))
      comment: "Total exceptions identified during close — close quality and risk indicator."
    - name: "total_adjustment_entry_count"
      expr: SUM(CAST(adjustment_entry_count AS DOUBLE))
      comment: "Total adjustment journal entries posted during close — close complexity indicator."
    - name: "period_close_count"
      expr: COUNT(1)
      comment: "Number of period-close records — close coverage across entities and periods."
    - name: "audit_ready_count"
      expr: COUNT(CASE WHEN audit_readiness_flag = TRUE THEN 1 END)
      comment: "Number of periods flagged as audit-ready — compliance readiness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking cross-entity transaction volumes, elimination status, and reconciliation quality for consolidated financial reporting."
  source: "`vibe_restaurants_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (e.g. Loan, Service, Goods) — elimination category."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the intercompany transaction — processing quality indicator."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between entities — consolidation quality KPI."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany trend."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Flag for eliminated transactions — consolidation completeness indicator."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversed intercompany transactions — correction rate indicator."
    - name: "group_currency_code"
      expr: group_currency_code
      comment: "Group reporting currency for consolidated analysis."
    - name: "netting_indicator"
      expr: netting_indicator
      comment: "Flag for netted intercompany transactions — cash management efficiency."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount — cross-entity activity volume KPI."
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in group currency — consolidated exposure KPI."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in local currency — entity-level exposure."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of intercompany transactions — cross-entity activity volume."
    - name: "uneliminated_transaction_count"
      expr: COUNT(CASE WHEN elimination_flag = FALSE THEN 1 END)
      comment: "Number of intercompany transactions not yet eliminated — consolidation risk KPI."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 END)
      comment: "Number of unreconciled intercompany transactions — consolidation quality risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics tracking tax liabilities, tax rates, filing status, and exemptions across jurisdictions, legal entities, and tax types for compliance reporting."
  source: "`vibe_restaurants_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (Sales Tax, VAT, Use Tax, Withholding) — tax liability classification."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code for granular tax rate analysis."
    - name: "tax_direction"
      expr: tax_direction
      comment: "Tax direction (Input/Output) — tax receivable vs. payable classification."
    - name: "tax_filing_status"
      expr: tax_filing_status
      comment: "Filing status of the tax posting — compliance and filing deadline tracking."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction for multi-jurisdiction compliance analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for multi-entity tax reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual tax liability analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly tax trend analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversed tax postings — correction rate and accuracy indicator."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Flag for tax postings under audit — compliance risk indicator."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted — primary tax liability KPI."
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount — tax exposure and effective rate calculation base."
    - name: "avg_tax_rate_percent"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate — tax rate compliance and jurisdiction analysis."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Number of tax postings — tax transaction volume indicator."
    - name: "audit_flagged_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN 1 END)
      comment: "Number of tax postings flagged for audit — compliance risk exposure KPI."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed tax postings — tax accuracy and correction rate KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ledger balances summary"
  source: "`vibe_restaurants_v1`.`finance`.`ledger`"
  dimensions:
    - name: "ledger_type"
      expr: ledger_type
      comment: "Type of ledger"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ledger amounts"
  measures:
    - name: "ledger_count"
      expr: COUNT(1)
      comment: "Number of ledger records"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run financial totals"
  source: "`vibe_restaurants_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Number of payment runs"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance targets"
  source: "`vibe_restaurants_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Unique profit center identifier"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the profit center"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area code"
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Current status of the profit center"
    - name: "valid_from_year"
      expr: DATE_TRUNC('year', valid_from_date)
      comment: "Year the profit center became valid"
  measures:
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Number of profit centers"
    - name: "total_ebitda_target_amount"
      expr: SUM(CAST(ebitda_target_amount AS DOUBLE))
      comment: "Total EBITDA target amount across profit centers"
    - name: "total_aov_target_amount"
      expr: SUM(CAST(aov_target_amount AS DOUBLE))
      comment: "Total AOV target amount across profit centers"
$$;