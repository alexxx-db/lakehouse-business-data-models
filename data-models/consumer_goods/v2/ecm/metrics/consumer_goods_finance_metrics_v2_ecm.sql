-- Metric views for domain: finance | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics covering invoice volumes, outstanding liabilities, discount capture, and payment efficiency — core AP performance KPIs for the CFO and Treasury teams."
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: ap_invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g., Open, Paid, Blocked) for status-based segmentation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, Wire, Check) to analyze payment channel mix."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g., Net30, 2/10 Net30) to assess discount eligibility and cash flow timing."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for year-over-year AP liability trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for periodic AP accrual and cash flow planning."
    - name: "invoice_category"
      expr: invoice_category
      comment: "Category of the invoice (e.g., Goods, Services, Freight) for spend category analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency to support multi-currency AP exposure reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for monthly AP volume and aging trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due, enabling cash outflow forecasting by due period."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status (e.g., Matched, Unmatched, Exception) to track invoice processing quality."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Reason code for payment block to identify and resolve payment holds."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices — baseline volume KPI for AP workload and vendor activity tracking."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount representing the full AP liability before discounts and taxes — key for cash flow planning."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts — actual cash obligation for treasury management."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid outstanding AP balance — critical for working capital and days payable outstanding (DPO) analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts available — measures discount capture opportunity."
    - name: "total_early_payment_discount_taken"
      expr: SUM(CAST(early_payment_discount_taken AS DOUBLE))
      comment: "Total early payment discounts actually captured — measures discount realization performance."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from AP payments — required for tax compliance reporting."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per invoice — benchmarks vendor invoice size and detects anomalies."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(early_payment_discount_taken AS DOUBLE)) / NULLIF(SUM(CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available early payment discounts actually captured — a key treasury efficiency KPI; low rates indicate missed savings."
    - name: "outstanding_to_gross_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(outstanding_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of outstanding unpaid balance to total gross invoiced amount — measures AP clearance efficiency; high ratio signals payment backlog."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of invoices with an active payment block — operational KPI for AP exception management and supplier relationship risk."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN match_status = 'Unmatched' THEN 1 END)
      comment: "Number of invoices failing three-way match — drives AP exception workload and signals procurement/receiving process gaps."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment execution metrics covering payment volumes, amounts, discount utilization, and payment processing efficiency — used by Treasury and AP Operations."
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: ap_payment_status
      comment: "Current status of the AP payment (e.g., Pending, Cleared, Rejected) for payment pipeline monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., ACH, Wire, Check) to analyze channel mix and associated costs."
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval workflow status to track payments awaiting authorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency payment exposure analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment execution for monthly cash outflow trend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms to assess compliance with contractual payment schedules."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Payment block reason code to identify and resolve payment holds."
    - name: "remittance_advice_sent_flag"
      expr: CAST(remittance_advice_sent_flag AS STRING)
      comment: "Whether remittance advice was sent to the supplier — tracks supplier communication compliance."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments executed — baseline volume KPI for AP operations throughput."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash disbursed via AP payments — primary cash outflow KPI for treasury management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts — actual cash outflow for working capital reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured on payments — measures realized savings from early payment programs."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local currency — required for entity-level financial reporting and FX exposure analysis."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction — benchmarks payment size and detects outliers."
    - name: "blocked_payment_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of payments currently blocked — operational KPI for AP exception resolution and supplier payment risk."
    - name: "remittance_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remittance_advice_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments where remittance advice was sent — measures supplier communication compliance; low rates increase dispute risk."
    - name: "discount_to_payment_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Discount savings as a percentage of total payment amount — measures the financial benefit of early payment programs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics covering revenue billed, collections performance, deductions, disputes, and DSO drivers — core AR KPIs for the CFO, Credit, and Collections teams."
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: ar_invoice_status
      comment: "Current AR invoice status (e.g., Open, Cleared, Disputed) for collections pipeline segmentation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the AR invoice to track collection progress."
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the invoice is under dispute — segments disputed vs. clean AR for collections prioritization."
    - name: "dso_aging_bucket"
      expr: dso_aging_bucket
      comment: "Aging bucket (e.g., 0-30, 31-60, 61-90, 90+ days) for DSO and collections aging analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level to track collections intensity and overdue account management."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AR exposure reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for year-over-year AR and revenue trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic revenue recognition and AR aging reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for monthly billing volume and revenue trend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms to assess DSO drivers and collections risk by terms bucket."
    - name: "billing_document_type"
      expr: billing_document_type
      comment: "Type of billing document (e.g., Invoice, Credit Memo, Debit Memo) for AR composition analysis."
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for customer deductions to identify root causes of short payments."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices — baseline billing volume KPI."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount — top-line revenue billed KPI for revenue performance tracking."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR amount after trade discounts — net revenue billed for P&L reporting."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid AR balance — primary DSO driver and working capital KPI."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all AR invoices — used for credit exposure and collections prioritization."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash collected against AR invoices — measures collections effectiveness."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total customer deductions taken — key trade spend leakage KPI; high deductions signal pricing or promotion compliance issues."
    - name: "total_trade_discount_amount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discounts granted — measures trade investment impact on net revenue."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total AR written off as uncollectible — measures bad debt exposure and credit risk management effectiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices for tax liability and compliance reporting."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under active dispute — measures collections risk and customer satisfaction issues."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount collected — primary collections effectiveness KPI; low rates signal credit or dispute issues."
    - name: "deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Customer deductions as a percentage of gross billed — measures trade spend leakage; high rates require commercial investigation."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Bad debt write-offs as a percentage of gross billed — measures credit risk and collections quality."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount — benchmarks customer order size and detects billing anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable payment receipt metrics covering cash application, deductions, short payments, and collections quality — used by Credit, Collections, and Treasury teams."
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the AR payment (e.g., Applied, Unapplied, Reversed) for cash application pipeline monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., ACH, Check, Wire) to analyze customer payment channel preferences."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received for channel-level collections analysis."
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for customer deductions to identify root causes of short payments."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cash application reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for year-over-year cash collections trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic cash collections and deduction reporting."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt for monthly cash inflow trend analysis."
    - name: "short_payment_flag"
      expr: CAST(short_payment_flag AS STRING)
      comment: "Whether the payment was short of the invoiced amount — segments short-pay events for deduction management."
    - name: "reversal_flag"
      expr: CAST(reversal_flag AS STRING)
      comment: "Whether the payment was reversed — identifies payment reversal events for exception management."
    - name: "overpayment_flag"
      expr: CAST(overpayment_flag AS STRING)
      comment: "Whether the customer overpaid — identifies overpayment events requiring credit memo or refund."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payments received — baseline cash application volume KPI."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash received from customers — primary cash inflow KPI for treasury and collections management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount successfully applied to AR invoices — measures cash application efficiency."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions taken by customers — key trade spend leakage and collections quality KPI."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts granted to customers — measures cost of early payment incentive programs."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local currency for entity-level cash reporting."
    - name: "short_payment_count"
      expr: COUNT(CASE WHEN short_payment_flag = TRUE THEN 1 END)
      comment: "Number of short payments received — measures deduction frequency and collections dispute volume."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of payment reversals — measures payment quality and fraud/error risk."
    - name: "cash_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash successfully applied to invoices — measures cash application efficiency; unapplied cash inflates AR and distorts DSO."
    - name: "deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Deductions as a percentage of total payments received — measures trade spend leakage rate; high rates require commercial and compliance investigation."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per receipt — benchmarks customer payment behavior and detects anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_cogs_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of Goods Sold allocation metrics covering total COGS, cost component breakdown, and variance analysis — used by Cost Accounting, FP&A, and Supply Chain Finance teams."
  source: "`vibe_consumer_goods_v1`.`finance`.`cogs_allocation`"
  dimensions:
    - name: "cogs_allocation_status"
      expr: cogs_allocation_status
      comment: "Status of the COGS allocation (e.g., Released, Preliminary) for cost version management."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate COGS (e.g., Standard, Actual, Activity-Based) for cost methodology analysis."
    - name: "costing_type"
      expr: costing_type
      comment: "Type of cost estimate (e.g., Standard, Actual, Plan) for cost version comparison."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for year-over-year COGS trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic COGS reporting and variance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the COGS allocation for multi-currency cost reporting."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of COGS allocation for monthly cost trend analysis."
    - name: "variance_category"
      expr: variance_category
      comment: "Category of cost variance (e.g., Price, Quantity, Efficiency) for root cause analysis."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Material valuation class for cost pool segmentation."
  measures:
    - name: "total_cogs_amount"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total COGS allocated — primary cost of goods KPI for gross margin calculation and P&L reporting."
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material cost component — measures material cost exposure and procurement efficiency impact on COGS."
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor cost component — measures labor efficiency and workforce cost impact on COGS."
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead absorbed — measures plant capacity utilization impact on unit cost."
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead cost — measures variable manufacturing efficiency."
    - name: "total_packaging_cost"
      expr: SUM(CAST(packaging_cost AS DOUBLE))
      comment: "Total packaging cost component — measures packaging spend as a COGS driver, relevant for sustainability and cost reduction initiatives."
    - name: "total_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Total inbound freight cost — measures logistics cost impact on COGS."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total COGS variance (actual vs. standard) — key cost control KPI; large variances trigger manufacturing and procurement investigations."
    - name: "total_depreciation_cost"
      expr: SUM(CAST(depreciation_cost AS DOUBLE))
      comment: "Total depreciation absorbed into COGS — measures capital asset cost impact on product cost."
    - name: "raw_material_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(raw_material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cost_amount AS DOUBLE)), 0), 2)
      comment: "Raw material cost as a percentage of total COGS — measures material intensity; high percentages indicate procurement leverage opportunity."
    - name: "variance_to_total_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_cost_amount AS DOUBLE)), 0), 2)
      comment: "COGS variance as a percentage of total cost — measures standard cost accuracy; high variance rates signal costing model recalibration needs."
    - name: "avg_unit_cost"
      expr: AVG(CAST(total_cost_amount AS DOUBLE))
      comment: "Average COGS allocation amount per record — benchmarks unit cost levels across SKUs and facilities."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finance accrual metrics covering accrual volumes, amounts, reversal activity, and SOX compliance — used by Controllers, FP&A, and Audit teams for period-close accrual management."
  source: "`vibe_consumer_goods_v1`.`finance`.`finance_accrual`"
  dimensions:
    - name: "accrual_status"
      expr: finance_accrual_status
      comment: "Status of the accrual (e.g., Posted, Reversed, Pending) for accrual lifecycle management."
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g., Trade Promotion, Rebate, Bonus) for accrual category analysis."
    - name: "accrual_category"
      expr: accrual_category
      comment: "Business category of the accrual for spend category-level accrual reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual for authorization workflow tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual accrual trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-close accrual balance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Accrual currency for multi-currency accrual reporting."
    - name: "sox_compliant_flag"
      expr: CAST(sox_compliant_flag AS STRING)
      comment: "Whether the accrual is SOX compliant — critical for internal controls and audit trail."
    - name: "accrual_date_month"
      expr: DATE_TRUNC('MONTH', accrual_date)
      comment: "Month of accrual posting for monthly accrual trend analysis."
  measures:
    - name: "total_accrual_count"
      expr: COUNT(1)
      comment: "Total number of accrual records — baseline accrual volume KPI for period-close workload monitoring."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrual amount — primary accrual liability KPI for balance sheet and P&L impact assessment."
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total financial amount across accrual records — supports accrual completeness verification."
    - name: "avg_accrual_amount"
      expr: AVG(CAST(accrual_amount AS DOUBLE))
      comment: "Average accrual amount per record — benchmarks typical accrual size and detects outliers."
    - name: "sox_compliant_accrual_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sox_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accruals that are SOX compliant — measures accrual control quality; low rates increase audit risk."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of accruals pending approval — measures period-close bottleneck in the accrual authorization workflow."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finance budget metrics covering budget vs. actual performance, budget utilization, and variance analysis — used by FP&A, Controllers, and Business Unit Finance teams for financial planning and control."
  source: "`vibe_consumer_goods_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "budget_status"
      expr: finance_budget_status
      comment: "Status of the budget (e.g., Approved, Draft, Locked) for budget lifecycle management."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Operating, Capital, Marketing) for budget category analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for spend category-level budget performance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget performance tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly budget vs. actual variance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency budget consolidation."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status to track budget authorization workflow."
    - name: "ebitda_category"
      expr: ebitda_category
      comment: "EBITDA line item category for P&L budget structure analysis."
    - name: "budget_version"
      expr: budget_version
      comment: "Budget version (e.g., Original, Revised, Forecast) for version comparison analysis."
    - name: "lock_indicator"
      expr: CAST(lock_indicator AS STRING)
      comment: "Whether the budget is locked for changes — identifies finalized vs. editable budget records."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget amount — primary financial planning baseline for resource allocation decisions."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget — measures budget execution and financial discipline."
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned amount in local currency — supports entity-level budget planning and reporting."
    - name: "total_planned_amount_group"
      expr: SUM(CAST(planned_amount_group AS DOUBLE))
      comment: "Total planned amount in group currency — supports consolidated group-level budget reporting."
    - name: "budget_variance_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budget) — primary budget control KPI; positive values indicate overspend requiring management action."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of approved budget — measures budget consumption rate; values over 100% signal budget overrun."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage set for budget alerts — measures the tolerance bands configured for budget control."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Total number of budget records — measures budget granularity and planning coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics covering asset base value, depreciation, net book value, and asset lifecycle management — used by Asset Accounting, FP&A, and Capital Planning teams."
  source: "`vibe_consumer_goods_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset (e.g., Active, Retired, Under Construction) for asset lifecycle management."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (e.g., Buildings, Machinery, Vehicles) for asset portfolio composition analysis."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g., Straight-Line, Declining Balance) for depreciation policy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Asset currency for multi-currency asset reporting."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of asset acquisition for capital investment vintage analysis."
    - name: "fixed_asset_status"
      expr: fixed_asset_status
      comment: "Detailed fixed asset status for asset management workflow tracking."
    - name: "disposal_reason"
      expr: disposal_reason
      comment: "Reason for asset disposal to analyze asset retirement patterns and replacement planning."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets — measures total capital invested in the asset base."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets — primary balance sheet asset value KPI for capital structure analysis."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures asset age and remaining useful life across the portfolio."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total asset impairment charges — measures write-down exposure; large impairments signal asset value deterioration requiring strategic review."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — measures asset monetization and capital recycling efficiency."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total asset revaluation adjustments — measures fair value uplift or write-down from revaluation exercises."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets — measures asset base size for capacity and capital planning."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset — benchmarks asset value and identifies high-value assets for insurance and risk management."
    - name: "depreciation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Accumulated depreciation as a percentage of acquisition cost — measures average asset age/utilization; high percentages indicate aging asset base requiring capital reinvestment."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of fixed assets in years — measures asset longevity profile for capital planning and depreciation policy review."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics covering IC volumes, amounts, elimination status, netting, and transfer pricing compliance — used by Group Consolidation, Tax, and Treasury teams."
  source: "`vibe_consumer_goods_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (e.g., Loan, Trade, Service) for IC activity categorization."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the IC transaction (e.g., Open, Cleared, Eliminated) for IC reconciliation pipeline monitoring."
    - name: "matching_status"
      expr: matching_status
      comment: "IC matching status (e.g., Matched, Unmatched, Partial) for IC reconciliation quality analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "IC reconciliation status for period-close IC elimination tracking."
    - name: "elimination_flag"
      expr: CAST(elimination_flag AS STRING)
      comment: "Whether the IC transaction has been eliminated in consolidation — tracks IC elimination completeness."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual IC transaction trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic IC reconciliation and elimination reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency IC exposure analysis."
    - name: "netting_status"
      expr: netting_status
      comment: "IC netting status to track cash pooling and netting efficiency."
    - name: "arms_length_validated_flag"
      expr: CAST(arms_length_validated_flag AS STRING)
      comment: "Whether the IC transaction has been validated as arm's length — critical for transfer pricing compliance."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method applied (e.g., CUP, TNMM, Cost Plus) for tax compliance analysis."
  measures:
    - name: "total_ic_transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions — baseline IC activity volume for consolidation workload planning."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount — measures IC exposure requiring elimination in group consolidation."
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total IC amount in group currency — primary IC elimination amount for consolidated financial statements."
    - name: "total_transfer_price"
      expr: SUM(CAST(transfer_price AS DOUBLE))
      comment: "Total transfer prices applied to IC transactions — measures transfer pricing exposure for tax compliance."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on IC transactions — measures cross-border tax cost of IC arrangements."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total IC matching variance — measures IC reconciliation gaps requiring investigation before period close."
    - name: "unmatched_ic_count"
      expr: COUNT(CASE WHEN matching_status = 'Unmatched' THEN 1 END)
      comment: "Number of unmatched IC transactions — measures IC reconciliation backlog; high counts delay period close."
    - name: "elimination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IC transactions eliminated in consolidation — measures IC elimination completeness; below 100% indicates consolidation risk."
    - name: "arms_length_validation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN arms_length_validated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IC transactions validated as arm's length — measures transfer pricing compliance; low rates increase tax audit risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, amounts, reversal rates, and SOX compliance — used by Controllers, Internal Audit, and Finance Operations."
  source: "`vibe_consumer_goods_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "journal_entry_status"
      expr: journal_entry_status
      comment: "Status of the journal entry (e.g., Posted, Reversed, Pending) for GL pipeline monitoring."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g., Manual, Automatic, Recurring) to analyze manual vs. automated posting mix."
    - name: "document_type"
      expr: document_type
      comment: "Document type classification for journal entry categorization and audit trail analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for year-over-year GL activity trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-close GL volume and balance analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting date for monthly close activity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency GL reporting."
    - name: "intercompany_indicator"
      expr: CAST(intercompany_indicator AS STRING)
      comment: "Whether the entry is an intercompany transaction — segments IC vs. third-party GL activity."
    - name: "sox_control_flag"
      expr: CAST(sox_control_flag AS STRING)
      comment: "Whether the entry is subject to SOX controls — critical for internal audit and compliance reporting."
    - name: "reversal_flag"
      expr: CAST(reversal_flag AS STRING)
      comment: "Whether the entry has been reversed — identifies reversal activity for period-close quality analysis."
  measures:
    - name: "total_journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries — baseline GL activity volume KPI for period-close monitoring."
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit AS DOUBLE))
      comment: "Total debit postings across all journal entries — measures GL debit activity for balance verification."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit AS DOUBLE))
      comment: "Total credit postings across all journal entries — measures GL credit activity for balance verification."
    - name: "total_debit_amount_detail"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total detailed debit amount for reconciliation against summary debit totals."
    - name: "total_credit_amount_detail"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total detailed credit amount for reconciliation against summary credit totals."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed journal entries — measures period-close error rate and correction activity."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that were reversed — high reversal rates signal posting quality issues and increase audit risk."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries — measures IC transaction volume for elimination and reconciliation workload."
    - name: "sox_controlled_entry_count"
      expr: COUNT(CASE WHEN sox_control_flag = TRUE THEN 1 END)
      comment: "Number of journal entries subject to SOX controls — measures SOX-controlled GL activity for compliance reporting."
    - name: "avg_entry_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average journal entry amount — benchmarks typical posting size and detects unusually large manual entries."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry line-level metrics for granular GL analysis covering debit/credit composition, cost center and profit center allocation, and tax posting for Consumer Goods financial reporting."
  source: "`vibe_consumer_goods_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for GL balance analysis and trial balance construction."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency line-level analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity for entity-level GL line analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental cost allocation analysis."
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center for segment-level P&L analysis."
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area (COGS, SG&A, R&D) for income statement line classification."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code for VAT/GST line-level tax analysis and compliance reporting."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Whether line was reversed; used for net posting analysis and error correction tracking."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total GL line amount; primary measure for trial balance and financial statement construction."
    - name: "total_document_amount"
      expr: SUM(CAST(document_amount AS DOUBLE))
      comment: "Total document currency amount; required for multi-currency GL reconciliation."
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total local currency amount; required for entity-level financial reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax posted at line level; required for VAT/GST compliance and tax return preparation."
    - name: "total_amount_company_code_currency"
      expr: SUM(CAST(amount_company_code_currency AS DOUBLE))
      comment: "Total amount in company code currency; required for legal entity financial statements."
    - name: "total_amount_group_currency"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total amount in group currency; required for consolidated group financial reporting."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total GL line items; baseline for posting volume and period-close completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_netting_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany netting run metrics covering netted amounts, gross-to-net efficiency, and settlement performance for Consumer Goods treasury and intercompany cash management."
  source: "`vibe_consumer_goods_v1`.`finance`.`netting_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Netting run execution status for treasury operations monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of netting run (bilateral, multilateral) for netting program analysis."
    - name: "netting_cycle"
      expr: netting_cycle
      comment: "Netting cycle (weekly, monthly) for settlement frequency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency for multi-currency netting analysis."
    - name: "is_automated"
      expr: CAST(is_automated AS STRING)
      comment: "Whether netting run was automated; automation rate measures treasury efficiency."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross intercompany obligations before netting; measures gross IC exposure."
    - name: "total_netted_amount"
      expr: SUM(CAST(netted_amount AS DOUBLE))
      comment: "Total amount netted in settlement runs; primary netting efficiency metric — higher netting reduces cash movement."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net settlement amount after netting; measures actual cash required for IC settlement."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied in netting runs; measures reconciliation corrections and netting accuracy."
    - name: "netting_run_count"
      expr: COUNT(1)
      comment: "Total netting runs executed; baseline for treasury netting program activity."
    - name: "avg_netted_amount"
      expr: AVG(CAST(netted_amount AS DOUBLE))
      comment: "Average amount netted per run; measures netting program scale and efficiency per cycle."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics covering payment batch performance, error rates, and processing efficiency — used by Treasury, AP Operations, and Cash Management teams."
  source: "`vibe_consumer_goods_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the payment run (e.g., Completed, Failed, In Progress) for payment batch monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (e.g., Regular, Emergency, Netting) for payment batch categorization."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the run (e.g., ACH, Wire, Check) for channel mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment run for multi-currency cash management."
    - name: "run_date_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of payment run execution for monthly cash outflow trend analysis."
    - name: "priority_flag"
      expr: CAST(priority_flag AS STRING)
      comment: "Whether the payment run was flagged as priority — segments urgent vs. routine payment batches."
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Detailed payment run status for operational monitoring."
  measures:
    - name: "total_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed — baseline payment processing volume KPI."
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total cash disbursed across all payment runs — primary cash outflow KPI for treasury management."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount processed in payment runs — measures total payment batch value."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after fees and discounts — actual cash outflow for working capital reporting."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees — measures transaction cost of payment operations."
    - name: "total_error_count"
      expr: SUM(CAST(error_count AS DOUBLE))
      comment: "Total payment errors across all runs — measures payment processing quality; high error counts signal system or data issues."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of individual payment transactions processed — measures payment operations throughput."
    - name: "avg_payment_run_amount"
      expr: AVG(CAST(total_payment_amount AS DOUBLE))
      comment: "Average payment amount per run — benchmarks payment batch size for capacity planning."
    - name: "error_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(error_count AS DOUBLE)) / NULLIF(SUM(CAST(transaction_count AS DOUBLE)), 0), 2)
      comment: "Payment error rate as a percentage of total transactions — measures payment processing quality; high rates indicate systemic issues requiring IT or process intervention."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance obligation KPI metrics."
  source: "`consumer_goods_ecm`.`finance`.`performance_obligation`"
  dimensions:
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code linked to the obligation."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of performance obligation."
    - name: "status"
      expr: status
      comment: "Current status of the obligation."
  measures:
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Number of performance obligations."
    - name: "total_metric_target_value"
      expr: SUM(CAST(metric_target_value AS DOUBLE))
      comment: "Sum of target metric values across obligations."
    - name: "average_actual_metric_value"
      expr: AVG(CAST(actual_metric_value AS DOUBLE))
      comment: "Average actual metric value achieved."
    - name: "total_actual_metric_value"
      expr: SUM(CAST(actual_metric_value AS DOUBLE))
      comment: "Total actual metric value across obligations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_revenue_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue contract metrics covering contract value, renewal rates, and contract portfolio health — used by Revenue Accounting, Sales Finance, and Legal teams for contract lifecycle management."
  source: "`vibe_consumer_goods_v1`.`finance`.`revenue_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the revenue contract (e.g., Active, Expired, Terminated) for contract portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of revenue contract (e.g., Fixed Price, Time & Materials, Subscription) for contract mix analysis."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied to the contract for ASC 606 compliance analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (e.g., Monthly, Quarterly, Annual) for cash flow timing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency contract portfolio reporting."
    - name: "contract_start_year"
      expr: DATE_TRUNC('YEAR', contract_start_date)
      comment: "Year of contract start for contract vintage and cohort analysis."
    - name: "renewal_flag"
      expr: CAST(renewal_flag AS STRING)
      comment: "Whether the contract is a renewal — measures renewal rate and customer retention."
    - name: "tax_exempt_flag"
      expr: CAST(tax_exempt_flag AS STRING)
      comment: "Whether the contract is tax exempt — segments taxable vs. exempt contract revenue."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of revenue contracts — measures contract portfolio size and sales activity."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value (TCV) across all revenue contracts — primary revenue backlog KPI for financial planning."
    - name: "total_annual_recurring_revenue"
      expr: SUM(CAST(annual_recurring_revenue AS DOUBLE))
      comment: "Total annual recurring revenue (ARR) — key SaaS/subscription revenue KPI for investor reporting and growth planning."
    - name: "total_contract_value_amount"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted revenue amount — measures total revenue commitment under active contracts."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value — benchmarks deal size and identifies upsell/cross-sell opportunities."
    - name: "renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts that are renewals — measures customer retention and revenue predictability; low renewal rates signal churn risk."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active revenue contracts — measures active revenue-generating contract base."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per contract — measures credit exposure per customer relationship."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics covering recognized revenue, deferred revenue, variable consideration, and ASC 606/IFRS 15 compliance — used by Revenue Accounting, FP&A, and External Reporting teams."
  source: "`vibe_consumer_goods_v1`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition (e.g., Recognized, Deferred, Pending) for revenue pipeline monitoring."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (e.g., Point-in-Time, Over-Time) for ASC 606 compliance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue recognition trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic revenue recognition and deferred revenue reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue reporting."
    - name: "recognition_date_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month of revenue recognition for monthly revenue trend analysis."
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Detailed revenue recognition status for compliance and audit trail analysis."
    - name: "sox_compliant_flag"
      expr: CAST(sox_compliant_flag AS STRING)
      comment: "Whether the recognition event is SOX compliant — critical for internal controls and external audit."
    - name: "constraint_applied_flag"
      expr: CAST(constraint_applied_flag AS STRING)
      comment: "Whether a variable consideration constraint was applied — measures revenue constraint impact under ASC 606."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Whether the recognition event was reversed — identifies revenue reversal activity for period-close quality analysis."
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognized — primary top-line revenue KPI for P&L reporting and investor communications."
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total recognized amount across all recognition events — supports revenue completeness verification."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total deferred revenue balance — measures future revenue obligation and backlog for financial planning."
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred amount pending recognition — supports balance sheet deferred revenue reporting."
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations — measures total contracted revenue under ASC 606."
    - name: "total_variable_consideration_estimate"
      expr: SUM(CAST(variable_consideration_estimate AS DOUBLE))
      comment: "Total variable consideration estimated (e.g., rebates, returns) — measures revenue at risk from variable pricing arrangements."
    - name: "total_trade_promotion_deduction"
      expr: SUM(CAST(trade_promotion_deduction AS DOUBLE))
      comment: "Total trade promotion deductions from recognized revenue — measures trade investment impact on net revenue."
    - name: "total_rebate_accrual"
      expr: SUM(CAST(rebate_accrual AS DOUBLE))
      comment: "Total rebate accruals reducing recognized revenue — measures rebate liability impact on net revenue."
    - name: "total_estimated_returns_reserve"
      expr: SUM(CAST(estimated_returns_reserve AS DOUBLE))
      comment: "Total estimated returns reserve — measures revenue at risk from product returns under ASC 606 constraint guidance."
    - name: "deferred_revenue_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Deferred revenue as a percentage of total transaction price — measures the proportion of contracted revenue not yet recognized; high rates indicate long performance obligation fulfillment cycles."
    - name: "sox_compliant_recognition_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sox_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revenue recognition events that are SOX compliant — critical internal controls KPI for external audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOX internal control metrics covering control effectiveness, testing results, deficiency rates, and remediation status — used by Internal Audit, External Auditors, and the CFO for SOX compliance management."
  source: "`vibe_consumer_goods_v1`.`finance`.`sox_control`"
  dimensions:
    - name: "control_status"
      expr: control_status
      comment: "Current status of the SOX control (e.g., Active, Retired, Under Review) for control portfolio management."
    - name: "control_type"
      expr: control_type
      comment: "Type of control (e.g., Preventive, Detective, Manual, Automated) for control design analysis."
    - name: "control_frequency"
      expr: control_frequency
      comment: "Frequency of control execution (e.g., Daily, Monthly, Quarterly) for control coverage analysis."
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Assessed effectiveness of the control (e.g., Effective, Ineffective, Needs Improvement) for audit opinion support."
    - name: "deficiency_classification"
      expr: deficiency_classification
      comment: "Classification of control deficiency (e.g., Material Weakness, Significant Deficiency, Control Deficiency) for risk prioritization."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of deficiency remediation — tracks open vs. closed control deficiencies."
    - name: "process_area"
      expr: process_area
      comment: "Business process area covered by the control (e.g., Revenue, Procure-to-Pay, Close) for process-level risk analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of SOX testing for annual compliance cycle tracking."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of SOX testing for quarterly compliance reporting."
    - name: "key_control_indicator"
      expr: CAST(key_control_indicator AS STRING)
      comment: "Whether the control is a key control — segments key vs. non-key controls for audit scope management."
    - name: "itgc_dependent_indicator"
      expr: CAST(itgc_dependent_indicator AS STRING)
      comment: "Whether the control relies on IT General Controls — identifies IT-dependent controls for ITGC scope."
  measures:
    - name: "total_control_count"
      expr: COUNT(1)
      comment: "Total number of SOX controls in scope — measures SOX compliance program scale."
    - name: "effective_control_count"
      expr: COUNT(CASE WHEN control_effectiveness = 'Effective' THEN 1 END)
      comment: "Number of controls assessed as effective — primary SOX compliance KPI for audit opinion."
    - name: "control_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN control_effectiveness = 'Effective' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SOX controls assessed as effective — primary SOX compliance rate KPI; below threshold triggers material weakness risk."
    - name: "deficiency_count"
      expr: COUNT(CASE WHEN deficiency_classification IS NOT NULL AND deficiency_classification <> '' THEN 1 END)
      comment: "Total number of control deficiencies identified — measures SOX risk exposure; high counts signal systemic control environment weakness."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN deficiency_classification = 'Material Weakness' THEN 1 END)
      comment: "Number of material weaknesses — the most critical SOX KPI; any material weakness requires immediate CEO/CFO disclosure and remediation."
    - name: "open_remediation_count"
      expr: COUNT(CASE WHEN remediation_status = 'Open' THEN 1 END)
      comment: "Number of control deficiencies with open remediation — measures outstanding compliance risk requiring management action."
    - name: "remediation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_status = 'Closed' THEN 1 END) / NULLIF(COUNT(CASE WHEN deficiency_classification IS NOT NULL AND deficiency_classification <> '' THEN 1 END), 0), 2)
      comment: "Percentage of identified deficiencies with completed remediation — measures SOX remediation program effectiveness."
    - name: "key_control_count"
      expr: COUNT(CASE WHEN key_control_indicator = TRUE THEN 1 END)
      comment: "Number of key controls in scope — measures the core SOX control framework size for audit planning."
    - name: "automated_control_count"
      expr: COUNT(CASE WHEN control_type = 'Automated' THEN 1 END)
      comment: "Number of automated controls — measures control automation maturity; higher automation reduces manual testing burden and error risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard cost metrics covering cost component structure, cost variance, and cost version management — used by Cost Accounting and Supply Chain Finance for product profitability analysis."
  source: "`vibe_consumer_goods_v1`.`finance`.`standard_cost`"
  dimensions:
    - name: "standard_cost_status"
      expr: standard_cost_status
      comment: "Status of the standard cost estimate (e.g., Released, Saved, Marked) for cost version lifecycle management."
    - name: "costing_type"
      expr: costing_type
      comment: "Type of cost estimate (e.g., Standard, Modified Standard, Actual) for cost methodology comparison."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the cost estimate — identifies released vs. preliminary standard costs."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the standard cost for year-over-year cost trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic standard cost review and variance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the standard cost for multi-currency cost reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the cost estimate — tracks cost approval workflow compliance."
    - name: "valuation_variant"
      expr: valuation_variant
      comment: "Valuation variant used for cost estimation — differentiates costing approaches."
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(total_standard_cost AS DOUBLE))
      comment: "Total standard cost across all cost estimates — primary product cost baseline for margin planning and pricing decisions."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component in standard cost — measures material cost baseline for procurement negotiations."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component in standard cost — measures labor cost baseline for workforce planning."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component — measures overhead absorption in standard cost for capacity planning."
    - name: "total_packaging_material_cost"
      expr: SUM(CAST(packaging_material_cost AS DOUBLE))
      comment: "Total packaging material cost in standard cost — measures packaging cost baseline for sustainability and cost reduction programs."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. standard) — measures standard cost accuracy; large variances trigger cost model updates."
    - name: "avg_cost_variance_pct"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage — measures standard cost accuracy across the product portfolio; high averages indicate costing model drift."
    - name: "material_cost_pct_of_standard"
      expr: ROUND(100.0 * SUM(CAST(material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_standard_cost AS DOUBLE)), 0), 2)
      comment: "Material cost as a percentage of total standard cost — measures material intensity in the cost structure; key input for make-vs-buy and sourcing decisions."
    - name: "overhead_cost_pct_of_standard"
      expr: ROUND(100.0 * SUM(CAST(overhead_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_standard_cost AS DOUBLE)), 0), 2)
      comment: "Overhead cost as a percentage of total standard cost — measures overhead burden rate; high percentages signal capacity underutilization."
$$;
