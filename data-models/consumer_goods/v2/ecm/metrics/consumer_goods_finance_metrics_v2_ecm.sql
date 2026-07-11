-- Metric views for domain: finance | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor invoice volumes, amounts, tax, discounts, and payment performance for cash management and procurement finance oversight."
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g. Open, Cleared, Blocked) — primary filter for aging and outstanding liability analysis."
    - name: "invoice_category"
      expr: invoice_category
      comment: "Category of the AP invoice (e.g. Goods, Services, Credit Memo) — used to segment payables by type."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity payables reporting and intercompany reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice — required for multi-currency payables analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to settle the invoice (e.g. ACH, Wire, Check) — informs treasury and payment operations."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Agreed payment terms code (e.g. Net30, 2/10Net30) — drives discount capture and cash flow forecasting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice — enables year-over-year payables trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — supports period-close payables reporting."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month — enables monthly payables volume and amount trending."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Due date truncated to month — supports cash outflow forecasting by due month."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status of the invoice (e.g. Matched, Unmatched, Exception) — critical for AP controls and audit."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Payment block reason code — identifies invoices held from payment for dispute or compliance reasons."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center charged for the invoice — enables departmental spend analysis."
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center associated with the invoice — supports P&L-level payables attribution."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices — baseline volume metric for payables workload and vendor activity tracking."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts — total payables liability before discounts and tax; key cash management KPI."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts — actual cash obligation to vendors; used in cash flow forecasting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across AP invoices — required for tax reporting and VAT/GST reconciliation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts available — measures potential savings from prompt payment programs."
    - name: "total_early_payment_discount_taken"
      expr: SUM(CAST(early_payment_discount_taken AS DOUBLE))
      comment: "Total early payment discounts actually captured — measures effectiveness of discount capture program vs. available discounts."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments — required for tax compliance and vendor remittance reporting."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices — measures actual cash disbursed to vendors in the period."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount — benchmarks typical vendor invoice size; outliers indicate unusual procurement activity."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(early_payment_discount_taken AS DOUBLE)) / NULLIF(SUM(CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available early payment discounts actually captured — strategic KPI for working capital optimization; low rate signals missed savings."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of invoices currently blocked from payment — operational KPI for AP exception management and vendor relationship risk."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN match_status <> 'Matched' THEN 1 END)
      comment: "Number of invoices failing three-way match — controls KPI indicating procurement-to-pay process exceptions requiring resolution."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers invoiced — measures vendor base breadth and concentration risk in payables."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics covering payment volumes, amounts, discount capture, block rates, and approval cycle performance for treasury and AP operations."
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the AP payment (e.g. Pending, Cleared, Reversed) — primary filter for payment execution monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. ACH, Wire, Check) — informs treasury channel mix and cost analysis."
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval workflow status of the payment — tracks compliance with dual-control payment authorization requirements."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity payment reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the payment — supports multi-currency treasury analysis."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which the payment was executed — used for FX exposure and settlement analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment date truncated to month — enables monthly cash disbursement trending."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Code indicating why a payment is blocked — used to categorize and resolve payment holds."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments executed — baseline volume metric for payment operations throughput."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed — primary cash outflow KPI for treasury management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts — actual cash disbursed net of early payment discounts captured."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured in payments — measures working capital savings from prompt payment."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local currency — used for entity-level cash reporting and FX translation."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction — benchmarks typical disbursement size; large deviations may indicate errors or fraud risk."
    - name: "blocked_payment_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of payments currently blocked — operational KPI for payment exception resolution and vendor satisfaction."
    - name: "reversed_payment_count"
      expr: COUNT(CASE WHEN remittance_advice_sent_flag = FALSE THEN 1 END)
      comment: "Number of payments where remittance advice was not sent — proxy for payment communication gaps affecting vendor reconciliation."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers paid — measures vendor payment breadth and concentration in disbursements."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to payments — monitors currency conversion rates used in cross-currency disbursements."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics covering revenue billed, collections performance, outstanding balances, deductions, disputes, and DSO-related KPIs for credit and collections management."
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g. Open, Cleared, Disputed) — primary filter for collections prioritization."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity receivables reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — required for multi-currency AR analysis and FX exposure reporting."
    - name: "billing_document_type"
      expr: billing_document_type
      comment: "Type of billing document (e.g. Invoice, Credit Memo, Debit Memo) — segments AR by transaction type."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales distribution channel (e.g. Direct, Distributor, eCommerce) — enables channel-level revenue and collections analysis."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the invoice — supports regional and organizational AR performance comparison."
    - name: "dso_aging_bucket"
      expr: dso_aging_bucket
      comment: "Aging bucket for DSO analysis (e.g. Current, 1-30, 31-60, 61-90, 90+) — critical for collections prioritization and credit risk management."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level applied to the invoice — indicates severity of collection effort and customer payment behavior."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute — segments disputed vs. clean receivables for collections strategy."
    - name: "billing_date_month"
      expr: DATE_TRUNC('month', billing_date)
      comment: "Billing date truncated to month — enables monthly revenue billed trending."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the AR invoice — supports year-over-year revenue and collections comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the AR invoice — supports period-close receivables reporting."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Customer payment terms — used to segment AR by terms and analyze compliance with agreed payment schedules."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices — baseline volume metric for billing activity and customer transaction frequency."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed to customers — top-line revenue billed KPI for financial reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after trade discounts — net revenue billed used in P&L and revenue recognition reporting."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance — primary liquidity KPI measuring uncollected receivables; drives working capital management decisions."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash collected against AR invoices — measures collections effectiveness and cash conversion performance."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total customer deductions taken — measures trade spend leakage and deduction management effectiveness."
    - name: "total_trade_discount_amount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discounts granted — measures promotional and contractual discount impact on net revenue."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total AR written off as uncollectable — measures bad debt expense and credit risk materialization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed on AR invoices — required for tax compliance and VAT/sales tax reporting."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed gross amount collected — primary collections effectiveness KPI; low rate signals credit risk or customer disputes."
    - name: "deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Deductions as a percentage of gross billed amount — measures trade spend leakage rate; high rate triggers deduction management review."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Write-off amount as a percentage of gross billed — bad debt rate KPI; rising rate signals deteriorating customer credit quality."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under active dispute — operational KPI for dispute resolution workload and customer relationship health."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of distinct customers invoiced — measures active customer billing base breadth."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per customer transaction — benchmarks typical billing size; used in revenue mix analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable payment and cash application metrics covering cash collected, deductions, discounts, reversals, and payment channel mix for collections and treasury management."
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the AR payment (e.g. Applied, Unapplied, Reversed) — primary filter for cash application monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the customer (e.g. ACH, Wire, Check) — informs channel mix and processing cost analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (e.g. Lockbox, EDI, Portal) — used to optimize cash application operations."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity cash collections reporting."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of the customer payment — required for multi-currency collections analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment date truncated to month — enables monthly cash collections trending."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment — supports year-over-year collections comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment — supports period-close cash reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the payment was reversed — identifies payment reversals that reduce effective cash collected."
    - name: "short_payment_flag"
      expr: short_payment_flag
      comment: "Whether the customer paid short of the invoiced amount — flags deduction or dispute activity requiring follow-up."
    - name: "overpayment_flag"
      expr: overpayment_flag
      comment: "Whether the customer overpaid — identifies credit balances requiring refund or application."
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for customer deductions — enables deduction root-cause analysis and trade spend management."
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payments received — baseline volume metric for cash application workload."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross cash received from customers — primary cash collections KPI for treasury and working capital management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to open invoices — measures cash application effectiveness and unapplied cash risk."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions taken by customers in payments — measures trade spend leakage and deduction management burden."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts granted to customers — measures cost of discount programs vs. cash acceleration benefit."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local currency — used for entity-level cash reporting and FX translation."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed AR payments — measures payment quality and fraud/error rate in cash collections."
    - name: "short_payment_count"
      expr: COUNT(CASE WHEN short_payment_flag = TRUE THEN 1 END)
      comment: "Number of short payments received — measures deduction frequency and customer payment compliance rate."
    - name: "deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Deductions as a percentage of total payments received — strategic KPI for trade spend management; high rate triggers deduction recovery programs."
    - name: "cash_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash successfully applied to invoices — measures cash application efficiency; low rate indicates unapplied cash backlog."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of distinct customers making payments — measures active paying customer base."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per customer remittance — benchmarks typical payment size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_cogs_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of goods sold allocation metrics covering standard cost components, variances, and cost structure analysis by SKU, facility, and cost center for margin management and product profitability."
  source: "`vibe_consumer_goods_v1`.`finance`.`cogs_allocation`"
  dimensions:
    - name: "costing_type"
      expr: costing_type
      comment: "Type of cost estimate (e.g. Standard, Actual, Plan) — primary segmentation for cost analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs (e.g. Activity-Based, Absorption) — informs cost methodology consistency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost allocation — required for multi-currency cost reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost allocation — supports year-over-year cost structure comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost allocation — supports period-close cost reporting."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the cost estimate (e.g. Released, Preliminary) — filters for approved vs. draft cost data."
    - name: "variance_category"
      expr: variance_category
      comment: "Category of cost variance (e.g. Price, Quantity, Efficiency) — enables root-cause analysis of cost deviations."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Material valuation class — groups SKUs by cost behavior for inventory valuation analysis."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Allocation date truncated to month — enables monthly cost trend analysis."
  measures:
    - name: "total_cost_amount"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total COGS allocated — primary cost KPI for gross margin calculation and product profitability analysis."
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material cost component — measures direct material spend; key input for procurement cost management."
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor cost component — measures manufacturing labor efficiency and workforce cost impact on COGS."
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead absorbed — measures factory overhead absorption rate and capacity utilization impact on unit cost."
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead cost — measures volume-driven overhead and efficiency of variable cost management."
    - name: "total_packaging_cost"
      expr: SUM(CAST(packaging_cost AS DOUBLE))
      comment: "Total packaging cost component — measures packaging spend as a driver of COGS; relevant for sustainability and cost reduction initiatives."
    - name: "total_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Total inbound freight cost — measures logistics cost embedded in COGS; informs supply chain cost optimization."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. standard) — primary manufacturing performance KPI; large variances trigger operational investigation."
    - name: "total_depreciation_cost"
      expr: SUM(CAST(depreciation_cost AS DOUBLE))
      comment: "Total depreciation cost absorbed into COGS — measures capital asset cost impact on product cost structure."
    - name: "avg_total_cost_per_allocation"
      expr: AVG(CAST(total_cost_amount AS DOUBLE))
      comment: "Average total cost per allocation record — benchmarks unit cost levels across SKUs and facilities."
    - name: "raw_material_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(raw_material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cost_amount AS DOUBLE)), 0), 2)
      comment: "Raw material cost as a percentage of total COGS — measures material intensity of product cost structure; drives procurement and formulation decisions."
    - name: "variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_cost_amount AS DOUBLE)), 0), 2)
      comment: "Cost variance as a percentage of total standard cost — measures manufacturing cost control effectiveness; high rate triggers operational review."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with cost allocations — measures breadth of product cost coverage in the costing run."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, reversal rates, SOX compliance, and period-close activity for financial controls and audit oversight."
  source: "`vibe_consumer_goods_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g. SA, AA, KR) — segments entries by accounting purpose for audit and controls analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry (e.g. Posted, Parked, Held) — primary filter for period-close completeness."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity GL reporting and intercompany reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry — required for multi-currency GL analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry — supports year-over-year GL activity comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry — critical for period-close completeness and cut-off analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month — enables monthly GL posting volume trending."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Whether the journal entry is subject to SOX controls — segments controlled vs. non-controlled entries for audit."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the journal entry is a reversal — identifies accrual reversals and error corrections in the GL."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Whether the entry is an intercompany transaction — enables intercompany elimination and reconciliation analysis."
  measures:
    - name: "total_journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted — baseline volume metric for GL activity and period-close workload assessment."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries — measures accrual and error correction activity; high count may indicate process quality issues."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals — financial controls KPI; high reversal rate signals posting quality or accrual management issues."
    - name: "sox_controlled_entry_count"
      expr: COUNT(CASE WHEN sox_control_flag = TRUE THEN 1 END)
      comment: "Number of journal entries subject to SOX controls — measures SOX-controlled GL activity volume for audit planning."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries — measures intercompany transaction volume requiring elimination in consolidation."
    - name: "distinct_gl_account_count"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts posted to — measures chart of accounts utilization and posting concentration."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to journal entries — monitors currency conversion rates used in multi-currency GL postings."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics covering recognized revenue, deferred revenue, variable consideration, trade promotion deductions, and ASC 606/IFRS 15 compliance KPIs for financial reporting."
  source: "`vibe_consumer_goods_v1`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of the revenue recognition event (e.g. Recognized, Deferred, Reversed) — primary filter for revenue reporting completeness."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (e.g. Point-in-Time, Over-Time) — segments revenue by ASC 606 recognition pattern."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity revenue reporting and consolidation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue analysis."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel (e.g. Direct, Distributor, eCommerce) — enables channel-level revenue recognition analysis."
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line associated with the revenue event — enables product portfolio revenue analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the recognition event — supports year-over-year revenue comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the recognition event — critical for period-close revenue completeness."
    - name: "recognition_date_month"
      expr: DATE_TRUNC('month', recognition_date)
      comment: "Recognition date truncated to month — enables monthly revenue trending."
    - name: "sox_compliant_flag"
      expr: sox_compliant_flag
      comment: "Whether the recognition event is SOX compliant — segments compliant vs. exception revenue for audit."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the recognition event is a reversal — identifies revenue corrections and adjustments."
    - name: "constraint_applied_flag"
      expr: constraint_applied_flag
      comment: "Whether a variable consideration constraint was applied — measures conservatism in revenue recognition under ASC 606."
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognized in the period — primary top-line revenue KPI for financial reporting and investor communications."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods — measures backlog of unearned revenue; key balance sheet liability KPI."
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations — measures contracted revenue before recognition timing adjustments."
    - name: "total_variable_consideration_estimate"
      expr: SUM(CAST(variable_consideration_estimate AS DOUBLE))
      comment: "Total estimated variable consideration (rebates, returns, discounts) — measures revenue at risk from variable pricing arrangements."
    - name: "total_trade_promotion_deduction"
      expr: SUM(CAST(trade_promotion_deduction AS DOUBLE))
      comment: "Total trade promotion deductions applied to revenue — measures trade spend impact on net revenue; key for trade ROI analysis."
    - name: "total_rebate_accrual"
      expr: SUM(CAST(rebate_accrual AS DOUBLE))
      comment: "Total rebate accruals reducing recognized revenue — measures customer rebate liability and net revenue impact."
    - name: "total_estimated_returns_reserve"
      expr: SUM(CAST(estimated_returns_reserve AS DOUBLE))
      comment: "Total estimated returns reserve — measures revenue at risk from product returns; informs demand planning and revenue quality assessment."
    - name: "total_cumulative_catch_up_adjustment"
      expr: SUM(CAST(cumulative_catch_up_adjustment AS DOUBLE))
      comment: "Total cumulative catch-up adjustments to recognized revenue — measures prior-period revenue corrections; large amounts signal estimation quality issues."
    - name: "net_revenue_after_deductions"
      expr: SUM((CAST(recognized_revenue_amount AS DOUBLE)) - (CAST(trade_promotion_deduction AS DOUBLE)) - (CAST(rebate_accrual AS DOUBLE)))
      comment: "Net revenue after trade promotion deductions and rebate accruals — measures true net revenue available for margin calculation."
    - name: "deferred_revenue_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Deferred revenue as a percentage of total transaction price — measures proportion of contracted revenue not yet earned; high rate indicates long-duration performance obligations."
    - name: "trade_deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(trade_promotion_deduction AS DOUBLE)) / NULLIF(SUM(CAST(recognized_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Trade promotion deductions as a percentage of recognized revenue — measures trade spend intensity; strategic KPI for revenue management and pricing strategy."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of distinct customers with revenue recognition events — measures active revenue-generating customer base."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial budget metrics covering planned spend, budget utilization, and variance analysis by cost center, fiscal period, and business area for financial planning and performance management."
  source: "`vibe_consumer_goods_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget (e.g. OPEX, CAPEX, Marketing) — primary segmentation for budget analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget (e.g. Approved, Draft, Rejected) — filters for approved vs. draft budget data."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity budget reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the budget — required for multi-currency budget analysis."
    - name: "group_currency_code"
      expr: group_currency_code
      comment: "Group/reporting currency of the budget — used for consolidated budget reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget — primary time dimension for annual budget planning and tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget — supports monthly budget vs. actual analysis."
    - name: "ebitda_category"
      expr: ebitda_category
      comment: "EBITDA line item category — enables P&L-aligned budget analysis (Revenue, COGS, SG&A, etc.)."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales or distribution channel — enables channel-level budget allocation analysis."
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line associated with the budget — enables product portfolio budget analysis."
    - name: "methodology"
      expr: methodology
      comment: "Budgeting methodology used (e.g. Zero-Based, Incremental) — informs budget process quality and rigor."
    - name: "lock_indicator"
      expr: lock_indicator
      comment: "Whether the budget is locked for changes — distinguishes finalized from editable budget versions."
  measures:
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned budget amount in local currency — primary budget KPI for financial planning and resource allocation decisions."
    - name: "total_planned_amount_group"
      expr: SUM(CAST(planned_amount_group AS DOUBLE))
      comment: "Total planned budget amount in group currency — used for consolidated budget reporting and cross-entity comparison."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity (units, headcount, etc.) — measures volume-based budget planning for operational capacity decisions."
    - name: "avg_planned_amount_local"
      expr: AVG(CAST(planned_amount_local AS DOUBLE))
      comment: "Average planned budget amount per budget line — benchmarks typical budget allocation size for anomaly detection."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines — measures budget granularity and planning completeness."
    - name: "approved_budget_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved budget lines — measures budget approval completeness for period-close readiness."
    - name: "approved_budget_amount_local"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN planned_amount_local ELSE 0 END)
      comment: "Total approved budget amount in local currency — measures committed financial resources available for spending."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage across budget lines — measures tolerance levels set for budget monitoring and escalation triggers."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard cost metrics covering product cost structure, cost variances, and cost component analysis by SKU and manufacturing facility for product profitability and cost management."
  source: "`vibe_consumer_goods_v1`.`finance`.`standard_cost`"
  dimensions:
    - name: "costing_type"
      expr: costing_type
      comment: "Type of cost estimate (e.g. Standard, Modified Standard) — primary segmentation for cost analysis."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the standard cost (e.g. Released, Preliminary) — filters for approved vs. draft cost data."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the cost estimate — ensures only approved costs are used in financial reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the standard cost — required for multi-currency cost reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the standard cost — supports year-over-year cost structure comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the standard cost — supports period-level cost analysis."
    - name: "costing_version"
      expr: costing_version
      comment: "Version of the cost estimate — enables comparison of cost scenarios and what-if analysis."
    - name: "valid_from_date_month"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Standard cost validity start date truncated to month — enables cost change trending over time."
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(total_standard_cost AS DOUBLE))
      comment: "Total standard cost across all SKUs — primary product cost KPI for inventory valuation and gross margin calculation."
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material standard cost — measures material cost component; key input for procurement and formulation cost management."
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor standard cost — measures labor cost component; informs workforce planning and automation investment decisions."
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead standard cost — measures factory overhead absorption; informs capacity utilization and fixed cost leverage analysis."
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead standard cost — measures volume-driven overhead component of product cost."
    - name: "total_packaging_material_cost"
      expr: SUM(CAST(packaging_material_cost AS DOUBLE))
      comment: "Total packaging material standard cost — measures packaging spend embedded in product cost; relevant for sustainability and cost reduction."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. standard) — primary manufacturing performance KPI; large variances trigger operational investigation."
    - name: "avg_total_standard_cost"
      expr: AVG(CAST(total_standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU/facility record — benchmarks typical unit cost levels for product portfolio analysis."
    - name: "avg_cost_variance_pct"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage — measures typical deviation from standard cost; high average signals systemic costing or operational issues."
    - name: "raw_material_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(raw_material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_standard_cost AS DOUBLE)), 0), 2)
      comment: "Raw material cost as a percentage of total standard cost — measures material intensity of product cost structure; drives procurement and formulation strategy."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial accrual metrics covering accrual volumes, amounts, reversal activity, and SOX compliance for period-close accuracy and financial controls management."
  source: "`vibe_consumer_goods_v1`.`finance`.`finance_accrual`"
  dimensions:
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g. Trade, Rebate, Bonus, Warranty) — primary segmentation for accrual analysis."
    - name: "accrual_category"
      expr: accrual_category
      comment: "Category of the accrual — enables sub-type analysis within accrual types."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the accrual (e.g. Open, Reversed, Cleared) — primary filter for outstanding accrual liability."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual — ensures only approved accruals are included in financial reporting."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity accrual reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the accrual — required for multi-currency accrual analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual — supports year-over-year accrual comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the accrual — critical for period-close accrual completeness."
    - name: "sox_compliant_flag"
      expr: sox_compliant_flag
      comment: "Whether the accrual is SOX compliant — segments controlled vs. exception accruals for audit."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month — enables monthly accrual activity trending."
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrual amount posted — primary accrual liability KPI for balance sheet and period-close reporting."
    - name: "total_accrual_count"
      expr: COUNT(1)
      comment: "Total number of accrual entries — measures accrual volume and period-close workload."
    - name: "reversed_accrual_count"
      expr: COUNT(CASE WHEN reversal_date IS NOT NULL THEN 1 END)
      comment: "Number of accruals that have been reversed — measures accrual reversal activity and estimation accuracy."
    - name: "sox_compliant_accrual_count"
      expr: COUNT(CASE WHEN sox_compliant_flag = TRUE THEN 1 END)
      comment: "Number of SOX-compliant accruals — measures compliance coverage of accrual population for audit purposes."
    - name: "sox_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sox_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accruals that are SOX compliant — financial controls KPI; low rate triggers compliance remediation."
    - name: "avg_accrual_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average accrual amount per entry — benchmarks typical accrual size; large deviations may indicate estimation errors."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with accruals — measures vendor accrual concentration and trade liability breadth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics covering disbursement volumes, amounts, error rates, and processing performance for treasury operations and cash management. Note: bank_account_id is a PII-sensitive field (VREQ-072) and should be handled with restricted/confidential classification."
  source: "`vibe_consumer_goods_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current status of the payment run (e.g. Completed, Failed, In Progress) — primary filter for payment execution monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (e.g. Regular, Emergency, Intercompany) — segments payment runs by business purpose."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment run — required for multi-currency treasury analysis."
    - name: "priority_flag"
      expr: priority_flag
      comment: "Whether the payment run was flagged as priority — identifies urgent disbursements for treasury escalation."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Scheduled payment run date truncated to month — enables monthly cash disbursement planning analysis."
  measures:
    - name: "total_payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed — baseline volume metric for treasury operations throughput."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount disbursed across payment runs — primary cash outflow KPI for treasury management."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount disbursed after fees — actual cash disbursed net of payment processing fees."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred — measures cost of payment operations; informs payment method optimization."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of individual payment transactions across all runs — measures payment operations throughput."
    - name: "total_error_count"
      expr: SUM(CAST(error_count AS DOUBLE))
      comment: "Total number of payment errors across runs — measures payment quality and exception rate; high count triggers process review."
    - name: "error_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(error_count AS DOUBLE)) / NULLIF(SUM(CAST(transaction_count AS DOUBLE)), 0), 2)
      comment: "Payment error rate as a percentage of total transactions — primary payment quality KPI; high rate signals system or data issues requiring remediation."
    - name: "avg_gross_amount_per_run"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross disbursement amount per payment run — benchmarks typical run size for capacity planning and anomaly detection."
    - name: "avg_transactions_per_run"
      expr: AVG(CAST(transaction_count AS DOUBLE))
      comment: "Average number of transactions per payment run — measures payment run efficiency and batch processing performance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics covering asset base value, depreciation, net book value, impairment, and disposal activity for capital management and financial reporting."
  source: "`vibe_consumer_goods_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset (e.g. Active, Disposed, Under Construction) — primary filter for active asset base analysis."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class (e.g. Buildings, Machinery, Vehicles) — primary segmentation for capital asset analysis."
    - name: "asset_group_code"
      expr: asset_group_code
      comment: "Asset group — enables sub-class level capital analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity fixed asset reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the asset valuation — required for multi-currency asset reporting."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. Straight-Line, Declining Balance) — informs depreciation expense forecasting."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Asset acquisition date truncated to year — enables capital investment vintage analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant/facility where the asset is located — enables facility-level capital asset analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets — measures total capital invested; primary CAPEX tracking KPI."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets — measures remaining asset value on the balance sheet; key capital management KPI."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures asset age and remaining useful life across the asset base."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recorded — measures asset value write-downs; large amounts signal operational or market deterioration."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total asset revaluation adjustments — measures fair value adjustments to the asset base."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — measures capital recovery from asset sales and retirements."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of assets — measures residual value in the asset base for depreciation planning."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets — measures asset base size for capital management and insurance purposes."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset — benchmarks typical asset value; used in asset portfolio analysis."
    - name: "depreciation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Accumulated depreciation as a percentage of acquisition cost — measures average asset age/utilization; high rate signals aging asset base requiring capital reinvestment."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets in years — informs depreciation expense forecasting and capital replacement planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics covering transaction volumes, amounts, elimination status, netting, and transfer pricing compliance for consolidation and intercompany reconciliation."
  source: "`vibe_consumer_goods_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (e.g. Sale, Loan, Service) — primary segmentation for intercompany analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the intercompany transaction — primary filter for open vs. settled intercompany balances."
    - name: "matching_status"
      expr: matching_status
      comment: "Intercompany matching status (e.g. Matched, Unmatched, Disputed) — critical for consolidation elimination accuracy."
    - name: "netting_status"
      expr: netting_status
      comment: "Netting status of the transaction — identifies transactions included in intercompany netting arrangements."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Whether the transaction has been eliminated in consolidation — measures consolidation completeness."
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Company code of the sending entity — enables entity-level intercompany flow analysis."
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Company code of the receiving entity — enables entity-level intercompany flow analysis."
    - name: "group_currency_code"
      expr: group_currency_code
      comment: "Group reporting currency — required for consolidated intercompany analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the intercompany transaction — supports year-over-year intercompany volume comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction — critical for period-close intercompany reconciliation."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Whether the transaction is subject to SOX controls — segments controlled intercompany transactions for audit."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method applied (e.g. CUP, Cost-Plus, TNMM) — enables transfer pricing compliance analysis."
  measures:
    - name: "total_transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions — baseline volume metric for intercompany activity and consolidation workload."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount — measures gross intercompany flows requiring elimination in consolidation."
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in group currency — primary KPI for consolidated intercompany elimination reporting."
    - name: "total_transfer_price"
      expr: SUM(CAST(transfer_price AS DOUBLE))
      comment: "Total transfer prices applied to intercompany transactions — measures transfer pricing exposure for tax compliance."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total intercompany matching variances — measures reconciliation gaps requiring resolution before consolidation close."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on intercompany transactions — measures cross-border tax cost of intercompany arrangements."
    - name: "unmatched_transaction_count"
      expr: COUNT(CASE WHEN matching_status <> 'Matched' THEN 1 END)
      comment: "Number of unmatched intercompany transactions — measures consolidation reconciliation backlog; high count delays period close."
    - name: "elimination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intercompany transactions eliminated in consolidation — measures consolidation completeness; low rate signals elimination gaps."
    - name: "arms_length_validated_count"
      expr: COUNT(CASE WHEN arms_length_validated_flag = TRUE THEN 1 END)
      comment: "Number of transactions validated as arm's length — measures transfer pricing compliance coverage for tax audit readiness."
    - name: "distinct_entity_pair_count"
      expr: COUNT(DISTINCT CONCAT(sending_company_code, '-', receiving_company_code))
      comment: "Number of distinct intercompany entity pairs — measures intercompany relationship complexity and consolidation scope."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOX internal controls metrics covering control effectiveness, deficiency rates, remediation status, and testing coverage for financial compliance and audit management."
  source: "`vibe_consumer_goods_v1`.`finance`.`sox_control`"
  dimensions:
    - name: "control_status"
      expr: control_status
      comment: "Current status of the SOX control (e.g. Active, Retired, Under Review) — primary filter for active controls analysis."
    - name: "control_type"
      expr: control_type
      comment: "Type of control (e.g. Preventive, Detective, Manual, Automated) — segments controls by nature for risk assessment."
    - name: "control_nature"
      expr: control_nature
      comment: "Nature of the control (e.g. Manual, Automated, IT-Dependent) — informs control reliability and testing approach."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Effectiveness rating of the control (e.g. Effective, Ineffective, Needs Improvement) — primary KPI dimension for control quality."
    - name: "deficiency_classification"
      expr: deficiency_classification
      comment: "Classification of control deficiency (e.g. Material Weakness, Significant Deficiency, Control Deficiency) — critical for SOX disclosure decisions."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of deficiency remediation — tracks progress on resolving identified control weaknesses."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables multi-entity SOX controls reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the SOX testing — supports year-over-year controls effectiveness comparison."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the SOX testing — enables quarterly controls monitoring and reporting."
    - name: "key_control_indicator"
      expr: key_control_indicator
      comment: "Whether the control is designated as a key control — focuses analysis on highest-risk controls."
    - name: "itgc_dependent_indicator"
      expr: itgc_dependent_indicator
      comment: "Whether the control depends on IT General Controls — identifies controls with IT dependency risk."
    - name: "risk_area"
      expr: risk_area
      comment: "Business risk area covered by the control (e.g. Revenue, Payroll, Procurement) — enables risk-area level controls analysis."
  measures:
    - name: "total_control_count"
      expr: COUNT(1)
      comment: "Total number of SOX controls in scope — measures SOX compliance program breadth and audit scope."
    - name: "effective_control_count"
      expr: COUNT(CASE WHEN effectiveness_rating = 'Effective' THEN 1 END)
      comment: "Number of controls rated effective — primary SOX compliance KPI; low count signals material weakness risk."
    - name: "control_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_rating = 'Effective' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls rated effective — strategic SOX compliance KPI; declining rate triggers audit escalation and remediation programs."
    - name: "deficiency_count"
      expr: COUNT(CASE WHEN deficiency_classification IS NOT NULL AND deficiency_classification <> '' THEN 1 END)
      comment: "Number of controls with identified deficiencies — measures SOX risk exposure; material weaknesses require public disclosure."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN deficiency_classification = 'Material Weakness' THEN 1 END)
      comment: "Number of material weaknesses identified — highest-severity SOX KPI; any material weakness requires SEC disclosure and immediate remediation."
    - name: "open_remediation_count"
      expr: COUNT(CASE WHEN remediation_status NOT IN ('Completed', 'Closed') AND deficiency_classification IS NOT NULL THEN 1 END)
      comment: "Number of deficiencies with open remediation — measures outstanding compliance risk requiring management action."
    - name: "key_control_count"
      expr: COUNT(CASE WHEN key_control_indicator = TRUE THEN 1 END)
      comment: "Number of key controls in scope — measures highest-risk control coverage for audit prioritization."
    - name: "key_control_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN key_control_indicator = TRUE AND effectiveness_rating = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN key_control_indicator = TRUE THEN 1 END), 0), 2)
      comment: "Effectiveness rate for key controls specifically — most critical SOX KPI; key control failures have highest audit and disclosure impact."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance obligation KPI metrics."
  source: "`vibe_consumer_goods_v1`.`finance`.`performance_obligation`"
  dimensions:
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code linked to the obligation."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of performance obligation."
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
  comment: "Revenue contract performance and value metrics."
  source: "`vibe_consumer_goods_v1`.`finance`.`revenue_contract`"
  dimensions:
    - name: "contract_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the contract became effective."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of the contract."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates if the contract is set for renewal."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms defined in the contract."
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of revenue contracts."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all contracts."
    - name: "total_annual_recurring_revenue"
      expr: SUM(CAST(annual_recurring_revenue AS DOUBLE))
      comment: "Sum of annual recurring revenue from contracts."
    - name: "average_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value."
$$;