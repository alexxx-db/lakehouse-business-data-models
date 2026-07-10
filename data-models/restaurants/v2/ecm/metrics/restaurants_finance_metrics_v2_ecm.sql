-- Metric views for domain: finance | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor invoice volumes, amounts, tax exposure, and payment efficiency across the restaurant enterprise."
  source: "`vibe_restaurants_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g. Open, Paid, Disputed) for pipeline and aging analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice type (e.g. Standard, Credit Memo, Recurring) to segment payables by category."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. ACH, Check, Wire) to analyze payment channel mix and associated costs."
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category assigned to the invoice for cost classification and budget variance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for year-over-year payables trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for period-level payables reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the invoice to monitor bottlenecks in the AP approval process."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO, GR, Invoice) indicating procurement control compliance."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for monthly payables trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of invoice due date for cash flow forecasting and aging bucket analysis."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of all AP invoices. Core payables volume KPI used in cash flow planning and vendor spend analysis."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Represents actual payables obligation for cash management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across AP invoices. Used for tax liability reporting and compliance monitoring."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured on AP invoices. Measures effectiveness of discount capture programs."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax applied across invoices. Required for tax compliance and regulatory reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed. Baseline volume metric for AP workload and vendor activity tracking."
    - name: "avg_gross_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Indicates typical vendor transaction size and flags anomalous invoices."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross invoice value captured as early-payment discounts. Measures AP discount optimization performance."
    - name: "tax_rate_effective_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate across AP invoices (tax / net amount). Used for tax planning and jurisdiction analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ap_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level AP invoice metrics for granular spend analysis, COGS vs CAPEX classification, and procurement cost control."
  source: "`vibe_restaurants_v1`.`finance`.`ap_invoice_line`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category of the invoice line for cost classification and budget variance analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (e.g. Goods, Services, Freight) for spend category analysis."
    - name: "is_capex"
      expr: is_capex
      comment: "Flag indicating whether the line item is a capital expenditure. Used to separate CAPEX from OPEX spend."
    - name: "is_cogs"
      expr: is_cogs
      comment: "Flag indicating whether the line item is cost of goods sold. Used for gross margin and food cost analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice line for workflow compliance monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice line for annual spend trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice line for period-level cost reporting."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status at line level to identify unmatched items requiring resolution."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for monthly cost accrual and spend trend analysis."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total invoice line amount. Primary spend volume metric for procurement cost analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at line level for granular tax liability analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line level. Measures vendor discount effectiveness."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between invoiced and expected amounts. High variance signals procurement control issues."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods or services invoiced. Used for unit cost and volume analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across invoice lines. Benchmarks vendor pricing and identifies price drift."
    - name: "capex_spend_amount"
      expr: SUM(CASE WHEN is_capex = TRUE THEN line_amount ELSE 0 END)
      comment: "Total CAPEX spend from AP invoice lines. Used for capital budget tracking and asset investment monitoring."
    - name: "cogs_spend_amount"
      expr: SUM(CASE WHEN is_cogs = TRUE THEN line_amount ELSE 0 END)
      comment: "Total COGS spend from AP invoice lines. Directly feeds into food and beverage cost of goods analysis."
    - name: "variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(line_amount AS DOUBLE)), 0), 2)
      comment: "Variance as a percentage of total line amount. Measures invoice accuracy and procurement process quality."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of AP invoice lines processed. Baseline volume metric for AP processing workload."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment metrics tracking payment volumes, discount capture, withholding tax, and payment method mix."
  source: "`vibe_restaurants_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the AP payment (e.g. Cleared, Pending, Reversed) for cash position monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (ACH, Check, Wire) to analyze payment channel efficiency and cost."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Regular, Advance, Partial) for payables classification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for annual cash outflow trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for period-level cash management reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment to identify unreconciled items."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date for monthly cash outflow trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total AP payment amount disbursed. Primary cash outflow KPI for treasury and cash management."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local currency. Used for multi-currency cash flow consolidation."
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts captured. Measures working capital optimization through discount programs."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments. Required for tax compliance and vendor remittance reporting."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments processed. Baseline volume metric for payment run efficiency."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average AP payment amount. Benchmarks typical vendor payment size and flags anomalous disbursements."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_taken_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Early-payment discount captured as a percentage of total payments. Measures AP discount optimization effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics tracking revenue billing, outstanding balances, and collection performance for franchise and corporate accounts."
  source: "`vibe_restaurants_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g. Open, Paid, Overdue) for receivables pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (e.g. Royalty, Franchise Fee, Service) for revenue stream classification."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the invoice for collection channel analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level indicating collection urgency for overdue receivables management."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency receivables analysis and FX exposure monitoring."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address for geographic receivables analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for monthly revenue billing trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of invoice due date for cash collection forecasting."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed to customers/franchisees. Primary revenue billing volume KPI."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after discounts. Represents actual revenue recognized from AR invoices."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance. Critical KPI for cash flow forecasting and collection prioritization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on AR invoices. Used for tax liability and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR invoices. Measures revenue leakage from billing adjustments."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to AR invoices. Monitors credit note and dispute resolution activity."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline billing volume metric."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per AR invoice. Indicates typical receivables exposure per billing event."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(gross_amount AS DOUBLE)) - SUM(CAST(outstanding_balance AS DOUBLE))) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount collected (gross minus outstanding / gross). Core AR collection efficiency KPI."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross billed amount. Measures revenue leakage from billing concessions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable payment metrics tracking cash receipts, unapplied cash, and payment application efficiency."
  source: "`vibe_restaurants_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the AR payment (e.g. Applied, Unapplied, Reversed) for cash application monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (ACH, Wire, Check, Card) for collection channel analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of AR payment for classification of cash receipts."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment for multi-currency cash receipt analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the payment was reversed. Used to identify payment quality issues."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for annual cash receipt trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for period-level cash receipt reporting."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of receipt date for monthly cash collection trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash received from customers. Primary cash inflow KPI for treasury and revenue management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to open AR invoices. Measures cash application effectiveness."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash balance. High unapplied cash indicates cash application backlog and revenue recognition risk."
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts taken by customers. Measures discount program utilization."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional currency. Used for consolidated cash receipt reporting."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payments received. Baseline cash receipt volume metric."
    - name: "cash_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash applied to invoices. Measures AR cash application efficiency — low rates signal operational bottlenecks."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AR payments that were reversed. Indicates payment quality and dispute frequency."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget metrics tracking approved budget amounts, variances, and budget utilization across cost centers, fiscal periods, and ownership types."
  source: "`vibe_restaurants_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g. Operating, Capital, Marketing) for budget category analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for granular spend planning and variance analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and lifecycle status of the budget for governance and planning cycle monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget for period-level budget vs. actual analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g. Company-owned, Franchise) for budget segmentation by restaurant model."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the budget for multi-brand budget analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the budget for regional financial planning analysis."
    - name: "nro_flag"
      expr: nro_flag
      comment: "Flag indicating new restaurant opening budget. Used to track NRO investment pipeline."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total approved budget amount. Primary financial planning KPI for resource allocation decisions."
    - name: "total_baseline_amount"
      expr: SUM(CAST(baseline_amount AS DOUBLE))
      comment: "Total baseline budget amount before adjustments. Used for budget revision and variance tracking."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Baseline metric for budget planning activity volume."
    - name: "avg_budget_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average budget amount per budget record. Benchmarks typical budget allocation size."
    - name: "nro_budget_amount"
      expr: SUM(CASE WHEN nro_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total budget allocated to new restaurant openings. Tracks NRO investment commitment."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_pct AS DOUBLE))
      comment: "Average variance threshold percentage set across budgets. Indicates organizational tolerance for budget deviation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure project metrics tracking approved budgets, actual spend, variance, and ROI targets for restaurant investment decisions."
  source: "`vibe_restaurants_v1`.`finance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the CAPEX project (e.g. Approved, In Progress, Completed, Cancelled) for portfolio management."
    - name: "project_type"
      expr: project_type
      comment: "Type of CAPEX project (e.g. New Build, Remodel, Equipment) for investment category analysis."
    - name: "capex_category"
      expr: capex_category
      comment: "CAPEX category for investment classification and budget allocation analysis."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class of the CAPEX investment for depreciation planning and balance sheet classification."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the CAPEX project for milestone tracking and resource planning."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the CAPEX project for investment risk management and prioritization."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the capitalized asset for financial reporting analysis."
    - name: "project_start_date_year"
      expr: YEAR(project_start_date)
      comment: "Year the CAPEX project started for investment vintage analysis."
  measures:
    - name: "total_approved_budget_amount"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved CAPEX budget across projects. Primary investment commitment KPI for capital allocation decisions."
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual CAPEX spend to date. Measures capital deployment against approved budgets."
    - name: "total_committed_cost_amount"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed but not yet spent CAPEX. Used for cash flow forecasting and budget availability analysis."
    - name: "total_remaining_budget_amount"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining CAPEX budget across active projects. Indicates available capital for new investments."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total CAPEX budget variance (actual vs. approved). High variance signals project cost control issues."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of CAPEX projects. Baseline metric for capital investment portfolio size."
    - name: "avg_roi_target_pct"
      expr: AVG(CAST(roi_target_percent AS DOUBLE))
      comment: "Average ROI target across CAPEX projects. Benchmarks expected return on capital investments."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Actual CAPEX spend as a percentage of approved budget. Measures capital deployment efficiency."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average CAPEX budget variance percentage across projects. Indicates overall project cost control performance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center metrics tracking budget allocations, labor and COGS targets, and cost center portfolio composition for operational financial management."
  source: "`vibe_restaurants_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (e.g. Restaurant, Regional, Corporate) for organizational cost structure analysis."
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category of the cost center for cost classification and reporting hierarchy."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Active/inactive status of the cost center for portfolio management."
    - name: "franchise_flag"
      expr: franchise_flag
      comment: "Flag indicating whether the cost center is franchise-operated. Used to segment company vs. franchise cost structures."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the cost center for multi-brand cost analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the cost center for regional cost performance analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the cost center for international cost structure analysis."
    - name: "format_code"
      expr: format_code
      comment: "Restaurant format code (e.g. Drive-Thru, Dine-In, Kiosk) for format-level cost benchmarking."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget amount allocated across cost centers. Primary financial planning KPI for cost center management."
    - name: "cost_center_count"
      expr: COUNT(1)
      comment: "Total number of cost centers. Baseline metric for organizational cost structure complexity."
    - name: "avg_labor_percent_target"
      expr: AVG(CAST(labor_percent_target AS DOUBLE))
      comment: "Average labor cost percentage target across cost centers. Benchmarks labor efficiency expectations."
    - name: "avg_cogs_percent_target"
      expr: AVG(CAST(cogs_percent_target AS DOUBLE))
      comment: "Average COGS percentage target across cost centers. Benchmarks food cost efficiency expectations."
    - name: "franchise_cost_center_count"
      expr: COUNT(CASE WHEN franchise_flag = TRUE THEN 1 END)
      comment: "Number of franchise-operated cost centers. Tracks franchise network size for royalty and fee management."
    - name: "avg_budget_per_cost_center"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget amount per cost center. Benchmarks typical cost center investment level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry metrics tracking posting volumes, reversal rates, and intercompany activity for general ledger governance and audit readiness."
  source: "`vibe_restaurants_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g. Standard, Accrual, Reversal) for GL activity classification."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Approval workflow status of the journal entry for governance and audit compliance monitoring."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the journal entry is a reversal. Used to monitor reversal activity and accrual management."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag indicating intercompany journal entries. Used for intercompany elimination and reconciliation analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for annual GL activity analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry for period-close activity monitoring."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that generated the journal entry for data lineage and integration monitoring."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for monthly GL activity trend analysis."
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline GL activity volume metric for period-close monitoring."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. High reversal counts indicate accrual quality issues or posting errors."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Used for intercompany reconciliation workload monitoring."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. High rates signal accrual management or posting quality issues."
    - name: "intercompany_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are intercompany. Measures intercompany transaction complexity."
    - name: "parked_entry_count"
      expr: COUNT(CASE WHEN parked_indicator = TRUE THEN 1 END)
      comment: "Number of parked (unposted) journal entries. Indicates period-close backlog and posting completeness risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry line metrics for GL balance analysis, debit/credit volumes, and tax posting activity at the transaction line level."
  source: "`vibe_restaurants_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for the journal line. Used to analyze GL balance composition."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal line for annual GL balance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal line for period-level GL activity reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the journal line is part of a reversal entry."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for monthly GL balance trend analysis."
    - name: "document_currency_code"
      expr: document_currency_code
      comment: "Currency of the journal line for multi-currency GL analysis."
  measures:
    - name: "total_amount_document_currency"
      expr: SUM(CAST(amount_document_currency AS DOUBLE))
      comment: "Total journal line amount in document currency. Primary GL balance metric for financial statement preparation."
    - name: "total_amount_local_currency"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total journal line amount in local currency. Used for local statutory reporting and currency translation analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted at journal line level. Used for tax provision and compliance reporting."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines. Baseline GL posting volume metric."
    - name: "debit_amount"
      expr: SUM(CASE WHEN debit_credit_indicator = 'D' THEN amount_document_currency ELSE 0 END)
      comment: "Total debit amount posted. Used for GL balance verification and trial balance preparation."
    - name: "credit_amount"
      expr: SUM(CASE WHEN debit_credit_indicator = 'C' THEN amount_document_currency ELSE 0 END)
      comment: "Total credit amount posted. Used for GL balance verification and trial balance preparation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_asset_depreciation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset depreciation metrics tracking depreciation expense, accumulated depreciation, net book value, and impairment activity for asset lifecycle management."
  source: "`vibe_restaurants_v1`.`finance`.`asset_depreciation`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (e.g. Buildings, Equipment, Vehicles) for depreciation analysis by asset category."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. Straight-Line, Declining Balance) for accounting policy analysis."
    - name: "depreciation_status"
      expr: depreciation_status
      comment: "Status of the depreciation run for asset lifecycle and period-close monitoring."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating whether the asset has been impaired. Used to track impairment exposure."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation posting for annual depreciation expense analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the depreciation posting for period-level expense reporting."
    - name: "depreciation_run_date_month"
      expr: DATE_TRUNC('MONTH', depreciation_run_date)
      comment: "Month of the depreciation run for monthly depreciation expense trend analysis."
  measures:
    - name: "total_depreciation_amount"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense posted. Primary asset cost allocation KPI for P&L and tax reporting."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across assets. Measures overall asset aging and replacement planning needs."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of assets. Key balance sheet metric for asset base valuation."
    - name: "total_acquisition_value"
      expr: SUM(CAST(acquisition_value AS DOUBLE))
      comment: "Total original acquisition value of assets. Used for gross asset base analysis and insurance valuation."
    - name: "total_impairment_loss_amount"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized. Tracks asset write-down exposure for financial risk management."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of asset depreciation records. Baseline metric for asset portfolio size."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life across assets. Indicates asset fleet age and upcoming replacement investment needs."
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(depreciation_amount AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_value AS DOUBLE)), 0), 2)
      comment: "Depreciation expense as a percentage of acquisition value. Measures asset cost consumption rate."
    - name: "net_book_value_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_book_value AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_value AS DOUBLE)), 0), 2)
      comment: "Net book value as a percentage of acquisition value. Indicates remaining asset value and fleet freshness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_royalty_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty accrual metrics tracking franchise royalty revenue, marketing fund contributions, and technology fees for franchise financial performance management."
  source: "`vibe_restaurants_v1`.`finance`.`royalty_accrual`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Revenue recognition status of the royalty accrual for revenue accounting compliance."
    - name: "adjustment_indicator"
      expr: adjustment_indicator
      comment: "Flag indicating whether the accrual is an adjustment entry. Used to separate base accruals from corrections."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the accrual was reversed. Used to monitor accrual quality."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the royalty accrual for annual franchise revenue analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the royalty accrual for period-level franchise revenue reporting."
    - name: "accrual_period_start_month"
      expr: DATE_TRUNC('MONTH', accrual_period_start_date)
      comment: "Month of the accrual period start for monthly royalty revenue trend analysis."
  measures:
    - name: "total_accrued_royalty_amount"
      expr: SUM(CAST(accrued_royalty_amount AS DOUBLE))
      comment: "Total royalty amount accrued from franchisees. Primary franchise revenue KPI for financial planning and investor reporting."
    - name: "total_royalty_base_net_sales"
      expr: SUM(CAST(royalty_base_net_sales AS DOUBLE))
      comment: "Total net sales base used for royalty calculation. Measures franchisee revenue performance driving royalty income."
    - name: "total_marketing_fund_contribution"
      expr: SUM(CAST(marketing_fund_contribution AS DOUBLE))
      comment: "Total marketing fund contributions from franchisees. Tracks marketing fund pool size for brand investment planning."
    - name: "total_technology_fee"
      expr: SUM(CAST(technology_fee AS DOUBLE))
      comment: "Total technology fees accrued from franchisees. Measures technology revenue stream from the franchise network."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total combined accrued amount (royalty + marketing fund + technology fee). Comprehensive franchise fee revenue KPI."
    - name: "accrual_count"
      expr: COUNT(1)
      comment: "Total number of royalty accrual records. Baseline metric for franchise billing activity volume."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across franchise agreements. Benchmarks royalty rate consistency and contract compliance."
    - name: "avg_marketing_fund_rate_pct"
      expr: AVG(CAST(marketing_fund_rate_percent AS DOUBLE))
      comment: "Average marketing fund contribution rate. Monitors marketing fund rate consistency across the franchise network."
    - name: "royalty_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(accrued_royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(royalty_base_net_sales AS DOUBLE)), 0), 2)
      comment: "Effective royalty yield as a percentage of net sales. Measures actual royalty capture rate vs. contracted rates."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Period close metrics tracking close cycle duration, reconciliation status, and close quality for financial reporting governance."
  source: "`vibe_restaurants_v1`.`finance`.`period_close`"
  dimensions:
    - name: "close_status"
      expr: close_status
      comment: "Current status of the period close (e.g. Open, In Progress, Closed) for close cycle monitoring."
    - name: "close_phase"
      expr: close_phase
      comment: "Current phase of the close process for milestone tracking and bottleneck identification."
    - name: "period_type"
      expr: period_type
      comment: "Type of period being closed (e.g. Monthly, Quarterly, Annual) for close cycle analysis."
    - name: "bank_reconciliation_status"
      expr: bank_reconciliation_status
      comment: "Status of bank reconciliation within the period close. Monitors a critical close dependency."
    - name: "ap_reconciliation_status"
      expr: ap_reconciliation_status
      comment: "Status of AP reconciliation within the period close. Monitors payables close completeness."
    - name: "ar_reconciliation_status"
      expr: ar_reconciliation_status
      comment: "Status of AR reconciliation within the period close. Monitors receivables close completeness."
    - name: "audit_readiness_flag"
      expr: audit_readiness_flag
      comment: "Flag indicating whether the period close is audit-ready. Used for audit preparation monitoring."
    - name: "actual_close_date_month"
      expr: DATE_TRUNC('MONTH', actual_close_date)
      comment: "Month of actual close date for close cycle trend analysis."
  measures:
    - name: "avg_close_duration_hours"
      expr: AVG(CAST(close_duration_hours AS DOUBLE))
      comment: "Average period close duration in hours. Primary close efficiency KPI — reducing close time is a strategic finance objective."
    - name: "max_close_duration_hours"
      expr: MAX(close_duration_hours)
      comment: "Maximum period close duration in hours. Identifies worst-case close performance for process improvement targeting."
    - name: "period_close_count"
      expr: COUNT(1)
      comment: "Total number of period close records. Baseline metric for close cycle volume."
    - name: "audit_ready_count"
      expr: COUNT(CASE WHEN audit_readiness_flag = TRUE THEN 1 END)
      comment: "Number of period closes flagged as audit-ready. Measures financial reporting quality and audit preparedness."
    - name: "audit_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_readiness_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of period closes that are audit-ready. Key governance KPI for financial reporting quality."
    - name: "total_close_duration_hours"
      expr: SUM(CAST(close_duration_hours AS DOUBLE))
      comment: "Total hours spent on period close activities. Used for finance team capacity planning and efficiency benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_pos_settlement_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS settlement batch metrics tracking daily sales settlement volumes, fees, and reconciliation status for restaurant cash management."
  source: "`vibe_restaurants_v1`.`finance`.`pos_settlement_batch`"
  dimensions:
    - name: "pos_settlement_batch_status"
      expr: pos_settlement_batch_status
      comment: "Status of the POS settlement batch (e.g. Settled, Pending, Failed) for daily cash reconciliation monitoring."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Settlement method (e.g. Card, Cash, Digital Wallet) for payment channel mix analysis."
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement for classification of POS cash flows."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the settlement batch for multi-currency cash management."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of settlement date for monthly POS revenue trend analysis."
    - name: "period_start_date_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the settlement period start for period-level sales analysis."
  measures:
    - name: "total_gross_settlement_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross POS settlement amount. Primary restaurant sales revenue KPI from point-of-sale systems."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net POS settlement amount after fees. Represents actual cash received from POS transactions."
    - name: "total_fee_amount"
      expr: SUM(CAST(total_fee_amount AS DOUBLE))
      comment: "Total payment processing fees on POS settlements. Measures payment processing cost burden."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax collected through POS settlements. Used for sales tax remittance and compliance reporting."
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Total number of POS settlement batches. Baseline metric for daily settlement activity volume."
    - name: "avg_gross_amount_per_batch"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross amount per POS settlement batch. Benchmarks typical daily sales volume per location."
    - name: "fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_amount AS DOUBLE)), 0), 2)
      comment: "Payment processing fee as a percentage of gross settlement. Measures payment processing cost efficiency."
    - name: "net_settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_net_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_amount AS DOUBLE)), 0), 2)
      comment: "Net settlement as a percentage of gross. Measures cash retention after payment processing fees."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics tracking tax liabilities, effective tax rates, and filing status across jurisdictions for tax compliance and planning."
  source: "`vibe_restaurants_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g. Sales Tax, VAT, Withholding) for tax liability classification."
    - name: "tax_direction"
      expr: tax_direction
      comment: "Direction of the tax posting (Input/Output) for VAT and sales tax reconciliation."
    - name: "tax_filing_status"
      expr: tax_filing_status
      comment: "Filing status of the tax posting for compliance monitoring and deadline tracking."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction for geographic tax liability analysis and multi-jurisdiction compliance."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the posting for tax rate and category analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax posting for annual tax liability analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the tax posting for period-level tax reporting."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Flag indicating whether the tax posting is flagged for audit. Used for tax audit risk monitoring."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for monthly tax liability trend analysis."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted. Primary tax liability KPI for compliance reporting and cash flow planning."
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount. Used to calculate effective tax rates and validate tax calculations."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings. Baseline metric for tax transaction volume."
    - name: "audit_flagged_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN 1 END)
      comment: "Number of tax postings flagged for audit. Measures tax audit risk exposure."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across postings. Benchmarks tax rate consistency and identifies rate anomalies."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate (tax amount / taxable base). Core tax planning KPI for jurisdiction-level tax burden analysis."
    - name: "audit_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax postings flagged for audit. Measures overall tax compliance risk level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_bank_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank statement metrics tracking reconciliation status, statement balances, and transaction volumes for treasury cash management."
  source: "`vibe_restaurants_v1`.`finance`.`bank_statement`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the bank statement (e.g. Reconciled, Unreconciled, In Progress) for cash control monitoring."
    - name: "bank_statement_status"
      expr: bank_statement_status
      comment: "Processing status of the bank statement for operational cash management."
    - name: "statement_type"
      expr: statement_type
      comment: "Type of bank statement for classification of cash account activity."
    - name: "is_electronic"
      expr: is_electronic
      comment: "Flag indicating electronic vs. paper statement. Used to track electronic banking adoption."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bank statement for multi-currency cash position analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start)
      comment: "Month of the statement period start for monthly cash balance trend analysis."
  measures:
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Total closing balance across bank statements. Measures aggregate cash position for treasury management."
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance across bank statements. Used for period-over-period cash movement analysis."
    - name: "total_credits"
      expr: SUM(CAST(total_credits AS DOUBLE))
      comment: "Total credit transactions across bank statements. Measures cash inflows for treasury cash flow analysis."
    - name: "total_debits"
      expr: SUM(CAST(total_debits AS DOUBLE))
      comment: "Total debit transactions across bank statements. Measures cash outflows for treasury cash flow analysis."
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Total number of bank statements processed. Baseline metric for bank account activity volume."
    - name: "net_cash_movement"
      expr: SUM((CAST(total_credits AS DOUBLE)) - (CAST(total_debits AS DOUBLE)))
      comment: "Net cash movement (credits minus debits) across bank statements. Core treasury cash flow KPI."
    - name: "reconciled_statement_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 END)
      comment: "Number of fully reconciled bank statements. Measures bank reconciliation completeness."
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bank statements fully reconciled. Key treasury control KPI for cash management governance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run metrics tracking batch payment volumes, processing efficiency, and error rates for AP payment operations management."
  source: "`vibe_restaurants_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Status of the payment run (e.g. Completed, Failed, Pending) for payment operations monitoring."
    - name: "payment_run_type"
      expr: payment_run_type
      comment: "Type of payment run (e.g. Regular, Emergency, Reversal) for payment batch classification."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the run (ACH, Wire, Check) for payment channel analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the payment run for governance and control monitoring."
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether the payment run was automated. Measures automation adoption in AP operations."
    - name: "retry_flag"
      expr: retry_flag
      comment: "Flag indicating whether the payment run was a retry. High retry rates signal payment processing issues."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment run for annual payment volume analysis."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of the scheduled payment run date for monthly payment volume trend analysis."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount disbursed across payment runs. Primary AP cash outflow KPI for treasury management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payment amount after discounts. Represents actual cash disbursed to vendors."
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured across payment runs. Measures working capital optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount included in payment runs. Used for tax payment compliance monitoring."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of payment transactions processed across runs. Measures AP payment throughput."
    - name: "total_error_count"
      expr: SUM(CAST(error_count AS DOUBLE))
      comment: "Total payment processing errors across runs. High error counts indicate payment system quality issues."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed. Baseline metric for AP payment batch activity."
    - name: "error_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(error_count AS DOUBLE)) / NULLIF(SUM(CAST(transaction_count AS DOUBLE)), 0), 2)
      comment: "Payment error rate (errors / total transactions). Measures AP payment processing quality and system reliability."
    - name: "automation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment runs that are automated. Measures AP automation maturity and efficiency."
$$;