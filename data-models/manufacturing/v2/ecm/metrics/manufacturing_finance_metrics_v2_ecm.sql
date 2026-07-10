-- Metric views for domain: finance | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics covering payment performance, discount capture, tax exposure, and three-way match compliance. Used by CFO and AP leadership to manage supplier payment obligations and working capital."
  source: "`vibe_manufacturing_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (standard, credit memo, etc.) for segmenting payables by document category."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the invoice (open, paid, blocked) for cash flow and aging analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (ACH, wire, check) to analyze payment channel mix."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/invoice three-way match for compliance and exception management."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval workflow status to track bottlenecks in the AP process."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice for tax reporting and jurisdiction analysis."
    - name: "currency"
      expr: currency
      comment: "Invoice currency for multi-currency payables analysis."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the invoice was posted to the ledger for period-based payables reporting."
    - name: "due_date"
      expr: due_date
      comment: "Invoice due date for aging and cash flow forecasting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (Net 30, Net 60) for working capital analysis."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount. Core payables liability measure used by CFO to assess total supplier obligations."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts and adjustments. Used for cash flow planning."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across AP invoices. Used for tax liability reporting and compliance."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount already paid against AP invoices. Used to compute outstanding payables balance."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in leveraging supplier discount terms."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments. Required for tax authority reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices. Baseline volume metric for AP workload and process benchmarking."
    - name: "avg_gross_amount_per_invoice"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Indicates typical transaction size and helps detect anomalies."
    - name: "avg_cash_discount_percentage"
      expr: AVG(CAST(cash_discount_percentage AS DOUBLE))
      comment: "Average early payment discount percentage available. Benchmarks supplier discount terms portfolio."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across AP invoices. Used for tax planning and jurisdiction benchmarking."
    - name: "tax_exempt_invoice_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE THEN 1 END)
      comment: "Number of tax-exempt AP invoices. Used for tax compliance audits and exemption certificate management."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'MATCHED' THEN 1 END)
      comment: "Number of invoices failing three-way match. Critical risk metric for AP fraud prevention and audit compliance."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_reason IS NOT NULL THEN 1 END)
      comment: "Number of invoices with a payment block. Indicates AP exceptions requiring resolution before payment."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers invoiced. Used for supplier concentration and spend diversification analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_ar_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable item metrics covering outstanding balances, aging, collection performance, and dispute management. Used by CFO, AR leadership, and credit managers to optimize cash collection and reduce DSO."
  source: "`vibe_manufacturing_v1`.`finance`.`ar_item`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification (current, 30-60, 60-90, 90+) for receivables aging analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status of the AR item for collections team prioritization."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the AR item to track contested receivables and resolution pipeline."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level indicating how many collection notices have been sent."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or expected for the AR item."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR item for multi-currency receivables reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms governing the receivable for DSO and working capital analysis."
    - name: "due_date"
      expr: due_date
      comment: "Due date of the AR item for cash flow forecasting and overdue identification."
    - name: "posting_date"
      expr: posting_date
      comment: "Posting date for period-based AR reporting."
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status (open, cleared, written off) for AR portfolio health assessment."
  measures:
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding AR balance. Primary receivables KPI used by CFO to assess cash collection exposure."
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount across AR items. Baseline revenue recognition and billing completeness measure."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR amount after discounts and adjustments. Used for accurate receivables valuation."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectable. Key bad debt metric for credit risk management and provisioning."
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credit memo value issued against AR. Tracks returns, disputes, and billing corrections."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts granted to customers. Measures cost of accelerating cash collection."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR items. Required for VAT/GST reporting and tax authority reconciliation."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent payments received. Used to assess recent collection activity and cash inflow."
    - name: "ar_item_count"
      expr: COUNT(1)
      comment: "Total number of AR line items. Baseline volume metric for AR workload and portfolio size."
    - name: "overdue_item_count"
      expr: COUNT(CASE WHEN cleared_flag = FALSE AND aging_bucket != 'CURRENT' THEN 1 END)
      comment: "Number of overdue AR items. Critical collections KPI driving dunning and escalation decisions."
    - name: "written_off_item_count"
      expr: COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END)
      comment: "Number of AR items written off. Measures bad debt incidence for credit policy evaluation."
    - name: "disputed_item_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'RESOLVED' THEN 1 END)
      comment: "Number of AR items under active dispute. Tracks billing quality and customer satisfaction issues."
    - name: "avg_open_amount_per_item"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open AR balance per item. Indicates typical receivable size for portfolio benchmarking."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to AR items. Used for currency risk monitoring."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with open AR. Used for customer concentration and credit exposure analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, debit/credit balances, reversal rates, and compliance flags. Used by controllers and auditors to ensure ledger integrity and period-close quality."
  source: "`vibe_manufacturing_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (SA, AB, etc.) for categorizing posting activity by transaction class."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (posted, parked, simulated) for period-close completeness monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for year-over-year financial trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close and period-end reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency ledger analysis."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the entry was posted to the ledger for time-series analysis."
    - name: "business_area"
      expr: business_area
      comment: "Business area dimension for segment-level P&L and balance sheet reporting."
    - name: "segment"
      expr: segment
      comment: "Reporting segment for IFRS 8 / ASC 280 segment disclosure requirements."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code on the journal entry for indirect tax reporting."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit postings in the ledger. Core measure for ledger activity volume and balance verification."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit postings in the ledger. Used with total debits to verify double-entry balance integrity."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net posting amount (debits minus credits) per journal entry. Used for period P&L and balance sheet impact."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount_total AS DOUBLE))
      comment: "Total tax amount posted via journal entries. Required for indirect tax reconciliation and reporting."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total posting amount in local currency. Used for statutory reporting and local GAAP compliance."
    - name: "total_transaction_currency_amount"
      expr: SUM(CAST(transaction_currency_amount AS DOUBLE))
      comment: "Total posting amount in transaction currency. Used for FX exposure and multi-currency consolidation."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline volume metric for close workload and audit scope."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. High reversal rates signal posting errors and process quality issues."
    - name: "adjusted_entry_count"
      expr: COUNT(CASE WHEN is_adjusted = TRUE THEN 1 END)
      comment: "Number of adjusted journal entries. Tracks post-close adjustments that may indicate control weaknesses."
    - name: "gaap_compliant_entry_count"
      expr: COUNT(CASE WHEN gaap_compliance_flag = TRUE THEN 1 END)
      comment: "Number of entries flagged as GAAP compliant. Used for audit readiness and compliance reporting."
    - name: "ifrs_compliant_entry_count"
      expr: COUNT(CASE WHEN ifrs_compliance_flag = TRUE THEN 1 END)
      comment: "Number of entries flagged as IFRS compliant. Required for dual-reporting entities."
    - name: "avg_net_amount_per_entry"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net posting amount per journal entry. Helps detect unusually large or small entries for audit."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX rate applied across journal entries. Used for currency translation analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center financial performance metrics covering budget utilization, variance, and overhead analysis. Used by CFO, controllers, and department heads to manage cost discipline and budget adherence."
  source: "`vibe_manufacturing_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (production, overhead, admin) for cost structure analysis."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Active/inactive status of the cost center for portfolio management."
    - name: "cost_center_group"
      expr: cost_center_group
      comment: "Grouping of cost centers for hierarchical reporting and consolidation."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the cost center for drill-down reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost center for multi-currency cost reporting."
    - name: "owner_department"
      expr: owner_department
      comment: "Department owning the cost center for accountability and chargeback analysis."
    - name: "valid_from"
      expr: valid_from
      comment: "Effective start date of the cost center for temporal cost analysis."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual costs incurred across cost centers. Primary cost management KPI for CFO and controllers."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted cost across cost centers. Baseline for budget vs. actual variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budget). Negative variance signals overspend requiring management action."
    - name: "cost_center_count"
      expr: COUNT(1)
      comment: "Total number of cost centers. Used for organizational complexity and cost structure benchmarking."
    - name: "overhead_cost_center_count"
      expr: COUNT(CASE WHEN is_overhead = TRUE THEN 1 END)
      comment: "Number of overhead cost centers. Used to assess overhead burden and rationalization opportunities."
    - name: "avg_actual_cost_per_center"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per cost center. Benchmarks cost center size and identifies outliers."
    - name: "avg_budget_amount_per_center"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budgeted amount per cost center. Used for budget allocation benchmarking."
    - name: "avg_variance_amount_per_center"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance per cost center. Identifies systemic over/under-spending patterns."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance metrics covering actual vs. planned profit, budget utilization, and OEE targets. Used by CFO and business unit leaders to evaluate segment profitability and resource allocation."
  source: "`vibe_manufacturing_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (product line, geography, business unit) for profitability segmentation."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Active/inactive status for profit center portfolio management."
    - name: "profit_center_group"
      expr: profit_center_group
      comment: "Grouping of profit centers for hierarchical P&L reporting."
    - name: "segment"
      expr: segment
      comment: "Reporting segment for IFRS 8 / ASC 280 segment disclosure."
    - name: "region"
      expr: region
      comment: "Geographic region of the profit center for regional P&L analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the profit center for multi-currency profitability reporting."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level for drill-down P&L analysis."
    - name: "valid_from"
      expr: valid_from
      comment: "Effective start date for temporal profit center analysis."
  measures:
    - name: "total_actual_profit"
      expr: SUM(CAST(actual_profit AS DOUBLE))
      comment: "Total actual profit across profit centers. Primary P&L KPI used by CFO and business unit leaders."
    - name: "total_planned_profit"
      expr: SUM(CAST(planned_profit AS DOUBLE))
      comment: "Total planned profit across profit centers. Baseline for actual vs. plan variance analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across profit centers. Used for budget adherence and resource allocation decisions."
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Total number of profit centers. Used for organizational structure and reporting complexity analysis."
    - name: "reportable_profit_center_count"
      expr: COUNT(CASE WHEN is_reportable = TRUE THEN 1 END)
      comment: "Number of profit centers included in external reporting. Used for segment disclosure compliance."
    - name: "avg_actual_profit_per_center"
      expr: AVG(CAST(actual_profit AS DOUBLE))
      comment: "Average actual profit per profit center. Benchmarks profitability across business units."
    - name: "avg_oee_target_percent"
      expr: AVG(CAST(oee_target_percent AS DOUBLE))
      comment: "Average OEE target percentage across profit centers. Links financial targets to operational efficiency goals."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial budget metrics covering planned, committed, and revised spend by category, fiscal year, and approval status. Used by CFO, FP&A, and department heads to manage budget cycles and variance."
  source: "`vibe_manufacturing_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, project) for budget portfolio analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for granular spend classification and reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status for governance and authorization tracking."
    - name: "finance_budget_status"
      expr: finance_budget_status
      comment: "Lifecycle status of the budget record for active vs. archived budget management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "period"
      expr: period
      comment: "Budget period for monthly/quarterly budget tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency planning."
    - name: "department_code"
      expr: department_code
      comment: "Department owning the budget for accountability and chargeback analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the budget for regional financial planning."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount. Primary FP&A KPI for annual budget size and resource allocation decisions."
    - name: "total_committed_amount"
      expr: SUM(CAST(total_committed_amount AS DOUBLE))
      comment: "Total committed spend against budget. Measures budget consumption and remaining availability."
    - name: "total_revised_amount"
      expr: SUM(CAST(total_revised_amount AS DOUBLE))
      comment: "Total revised budget amount after reforecasting. Tracks budget agility and mid-year adjustments."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Baseline for budget complexity and planning process scope."
    - name: "capex_budget_count"
      expr: COUNT(CASE WHEN is_capex = TRUE THEN 1 END)
      comment: "Number of CapEx budget records. Used for capital investment planning and approval governance."
    - name: "opex_budget_count"
      expr: COUNT(CASE WHEN is_opex = TRUE THEN 1 END)
      comment: "Number of OpEx budget records. Used for operating cost planning and efficiency benchmarking."
    - name: "active_budget_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active budgets. Used for budget portfolio management and governance."
    - name: "avg_planned_amount_per_budget"
      expr: AVG(CAST(total_planned_amount AS DOUBLE))
      comment: "Average planned budget amount per record. Benchmarks budget size across departments and periods."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance tolerance threshold across budgets. Used to calibrate budget control tightness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset financial metrics covering net book value, depreciation, acquisition cost, and insurance coverage. Used by CFO, asset managers, and auditors to manage the capital asset base and depreciation schedules."
  source: "`vibe_manufacturing_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (machinery, buildings, vehicles) for capital asset portfolio segmentation."
    - name: "fixed_asset_status"
      expr: fixed_asset_status
      comment: "Lifecycle status of the fixed asset (active, retired, disposed) for asset portfolio management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, declining balance) for depreciation policy analysis."
    - name: "asset_origin"
      expr: asset_origin
      comment: "Origin of the asset (purchased, leased, constructed) for capital structure analysis."
    - name: "plant"
      expr: plant
      comment: "Plant location of the fixed asset for geographic asset distribution analysis."
    - name: "department_responsible"
      expr: department_responsible
      comment: "Department responsible for the asset for accountability and cost allocation."
    - name: "capitalized_flag"
      expr: capitalized_flag
      comment: "Whether the asset has been capitalized. Used to distinguish active capital assets from pending items."
    - name: "acquisition_date"
      expr: acquisition_date
      comment: "Date of asset acquisition for asset age and replacement cycle analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets. Primary capital base metric for balance sheet and investment analysis."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Core balance sheet metric for asset valuation and impairment assessment."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation. Measures asset aging and remaining useful life across the portfolio."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of fixed assets. Used for depreciation base calculation and disposal planning."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total replacement cost of fixed assets. Used for insurance adequacy and capital replacement planning."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across fixed assets. Used to assess insurance adequacy vs. replacement cost."
    - name: "total_tax_net_book_value"
      expr: SUM(CAST(tax_net_book_value AS DOUBLE))
      comment: "Total tax net book value. Used for deferred tax calculation and tax depreciation reporting."
    - name: "total_tax_accumulated_depreciation"
      expr: SUM(CAST(tax_accumulated_depreciation AS DOUBLE))
      comment: "Total tax accumulated depreciation. Required for tax basis reporting and deferred tax liability calculation."
    - name: "fixed_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets. Baseline for asset portfolio size and management complexity."
    - name: "capitalized_asset_count"
      expr: COUNT(CASE WHEN capitalized_flag = TRUE THEN 1 END)
      comment: "Number of capitalized fixed assets. Tracks active capital base for balance sheet reporting."
    - name: "avg_net_book_value_per_asset"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Benchmarks asset value and identifies high-value asset concentrations."
    - name: "avg_tax_depreciation_rate"
      expr: AVG(CAST(tax_depreciation_rate AS DOUBLE))
      comment: "Average tax depreciation rate across fixed assets. Used for tax planning and deferred tax modeling."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics covering allocation amounts, methods, and posting status. Used by controllers and FP&A to ensure accurate cost distribution across cost objects and validate allocation cycle integrity."
  source: "`vibe_manufacturing_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for cost allocation (activity-based, percentage, statistical) for methodology analysis."
    - name: "allocation_category"
      expr: allocation_category
      comment: "Category of cost allocation for classification and reporting."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the allocation (posted, pending, reversed) for period-close monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation for annual cost distribution analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cost allocation reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation for multi-currency cost reporting."
    - name: "cost_object_type"
      expr: cost_object_type
      comment: "Type of cost object receiving the allocation for cost structure analysis."
    - name: "allocation_date"
      expr: allocation_date
      comment: "Date of the allocation posting for time-series cost distribution analysis."
    - name: "is_manual_allocation"
      expr: is_manual_allocation
      comment: "Flag indicating manual vs. automated allocation. Used to assess allocation process automation maturity."
  measures:
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total cost allocated across all allocation records. Primary measure for cost distribution volume and completeness."
    - name: "allocation_record_count"
      expr: COUNT(1)
      comment: "Total number of cost allocation records. Baseline for allocation cycle complexity and workload."
    - name: "manual_allocation_count"
      expr: COUNT(CASE WHEN is_manual_allocation = TRUE THEN 1 END)
      comment: "Number of manual allocations. High manual counts indicate automation gaps and control risks."
    - name: "reversal_allocation_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed allocations. Indicates allocation errors and rework in the cost distribution process."
    - name: "avg_allocation_amount"
      expr: AVG(CAST(allocation_amount AS DOUBLE))
      comment: "Average allocation amount per record. Benchmarks typical allocation size for anomaly detection."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage applied. Used to validate allocation driver consistency across cycles."
    - name: "distinct_cost_object_count"
      expr: COUNT(DISTINCT cost_object_id)
      comment: "Number of distinct cost objects receiving allocations. Measures allocation breadth and cost distribution coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request metrics covering estimated amounts, ROI, approval pipeline, and payback analysis. Used by CFO, investment committee, and FP&A to govern capital allocation decisions."
  source: "`vibe_manufacturing_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Approval status of the CapEx request (submitted, approved, rejected) for pipeline management."
    - name: "approval_stage"
      expr: approval_stage
      comment: "Current approval stage for tracking CapEx governance workflow."
    - name: "asset_category"
      expr: asset_category
      comment: "Category of asset being requested (equipment, IT, infrastructure) for capital portfolio analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the CapEx request for capital structure analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the CapEx request for investment prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the CapEx request for multi-currency capital planning."
    - name: "capitalized_flag"
      expr: capitalized_flag
      comment: "Whether the requested asset has been capitalized. Tracks CapEx execution completion."
    - name: "request_date"
      expr: request_date
      comment: "Date the CapEx request was submitted for pipeline age and cycle time analysis."
    - name: "regulatory_approval_needed"
      expr: regulatory_approval_needed
      comment: "Flag indicating regulatory approval requirement. Used for compliance-gated CapEx tracking."
  measures:
    - name: "total_estimated_amount"
      expr: SUM(CAST(estimated_amount AS DOUBLE))
      comment: "Total estimated CapEx investment requested. Primary capital planning KPI for investment committee decisions."
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Total number of CapEx requests. Baseline for capital pipeline volume and governance workload."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN request_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved CapEx requests. Tracks capital authorization rate and investment pipeline."
    - name: "capitalized_request_count"
      expr: COUNT(CASE WHEN capitalized_flag = TRUE THEN 1 END)
      comment: "Number of CapEx requests that have been capitalized. Measures CapEx execution completion rate."
    - name: "avg_estimated_amount"
      expr: AVG(CAST(estimated_amount AS DOUBLE))
      comment: "Average estimated CapEx amount per request. Benchmarks investment size and identifies outliers."
    - name: "avg_expected_roi_percent"
      expr: AVG(CAST(expected_roi_percent AS DOUBLE))
      comment: "Average expected ROI across CapEx requests. Key investment quality metric for capital allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics covering transfer pricing, elimination status, and cross-entity flows. Used by group controllers and tax teams to manage consolidation eliminations and transfer pricing compliance."
  source: "`vibe_manufacturing_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (sale, loan, service) for elimination and consolidation analysis."
    - name: "transaction_subtype"
      expr: transaction_subtype
      comment: "Subtype for granular intercompany transaction classification."
    - name: "intercompany_transaction_status"
      expr: intercompany_transaction_status
      comment: "Processing status of the intercompany transaction for period-close monitoring."
    - name: "elimination_status"
      expr: elimination_status
      comment: "Consolidation elimination status. Critical for group reporting accuracy and audit compliance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the intercompany transaction for governance tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany flow analysis."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for monthly intercompany reconciliation."
    - name: "amount_currency"
      expr: amount_currency
      comment: "Transaction currency for multi-currency intercompany analysis."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing methodology applied (CUP, cost-plus, TNMM) for tax compliance analysis."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross intercompany transaction amount. Primary measure for group consolidation elimination scope."
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net intercompany amount. Used for transfer pricing analysis and arm's-length compliance."
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax on intercompany transactions. Required for indirect tax and withholding tax compliance."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in local currency. Used for statutory reporting and FX translation."
    - name: "total_transfer_price"
      expr: SUM(CAST(transfer_price AS DOUBLE))
      comment: "Total transfer price across intercompany transactions. Core transfer pricing compliance metric."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions. Baseline for consolidation complexity and elimination workload."
    - name: "eliminated_transaction_count"
      expr: COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END)
      comment: "Number of intercompany transactions eliminated in consolidation. Tracks group reporting completeness."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed intercompany transactions. Indicates posting errors in the intercompany process."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage on intercompany transactions. Used for transfer pricing policy compliance monitoring."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX rate applied to intercompany transactions. Used for currency translation analysis."
    - name: "distinct_sending_entity_count"
      expr: COUNT(DISTINCT intercompany_company_code_id)
      comment: "Number of distinct sending legal entities. Measures intercompany network complexity for consolidation planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_cost_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost estimate metrics covering estimated vs. actual cost accuracy, unit pricing, and estimate portfolio management. Used by FP&A, product costing teams, and operations to validate standard costs and pricing decisions."
  source: "`vibe_manufacturing_v1`.`finance`.`cost_estimate`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost estimate (material, labor, overhead) for cost structure analysis."
    - name: "cost_estimate_status"
      expr: cost_estimate_status
      comment: "Status of the cost estimate (draft, approved, released) for estimate lifecycle management."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the estimate for risk-adjusted cost planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost estimate for multi-currency standard costing."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the cost estimate for per-unit cost analysis."
    - name: "estimate_date"
      expr: estimate_date
      comment: "Date the estimate was created for temporal cost trend analysis."
    - name: "valid_from"
      expr: valid_from
      comment: "Effective start date of the cost estimate for standard cost period management."
    - name: "risk_factor"
      expr: risk_factor
      comment: "Risk factor applied to the estimate for contingency and risk-adjusted cost analysis."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all estimates. Primary standard costing KPI for product pricing and margin planning."
    - name: "total_estimate_amount_gross"
      expr: SUM(CAST(estimate_amount_gross AS DOUBLE))
      comment: "Total gross estimate amount. Used for cost baseline and budget planning."
    - name: "total_estimate_amount_net"
      expr: SUM(CAST(estimate_amount_net AS DOUBLE))
      comment: "Total net estimate amount after adjustments. Used for net cost planning and margin analysis."
    - name: "total_estimate_tax_amount"
      expr: SUM(CAST(estimate_tax_amount AS DOUBLE))
      comment: "Total tax amount on cost estimates. Used for tax-inclusive cost planning."
    - name: "cost_estimate_count"
      expr: COUNT(1)
      comment: "Total number of cost estimates. Baseline for costing portfolio size and standard cost coverage."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across cost estimates. Benchmarks standard cost per unit for pricing decisions."
    - name: "avg_total_estimated_cost"
      expr: AVG(CAST(total_estimated_cost AS DOUBLE))
      comment: "Average total estimated cost per estimate. Used to benchmark estimate size and detect outliers."
    - name: "avg_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per cost estimate. Used for volume-based cost analysis and economies of scale assessment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_gl_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger account metrics covering account portfolio composition, balance analysis, and account type distribution. Used by controllers and auditors to manage the chart of accounts and ledger health."
  source: "`vibe_manufacturing_v1`.`finance`.`gl_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "GL account type (asset, liability, equity, revenue, expense) for financial statement classification."
    - name: "account_category"
      expr: account_category
      comment: "Account category for sub-classification within account types."
    - name: "account_group"
      expr: account_group
      comment: "Account group for hierarchical chart of accounts reporting."
    - name: "gl_account_status"
      expr: gl_account_status
      comment: "Active/inactive status of the GL account for account portfolio management."
    - name: "balance_type"
      expr: balance_type
      comment: "Balance type (debit/credit normal balance) for financial statement presentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the GL account for multi-currency ledger analysis."
    - name: "segment"
      expr: segment
      comment: "Reporting segment for segment-level financial reporting."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area for cost-of-sales and functional expense reporting."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across GL accounts. Core balance sheet and P&L measure for financial position assessment."
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance across GL accounts. Used for period movement analysis and reconciliation."
    - name: "gl_account_count"
      expr: COUNT(1)
      comment: "Total number of GL accounts. Baseline for chart of accounts complexity and rationalization analysis."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN gl_account_status = 'ACTIVE' AND is_deprecated = FALSE THEN 1 END)
      comment: "Number of active, non-deprecated GL accounts. Used for chart of accounts hygiene and simplification."
    - name: "budget_enabled_account_count"
      expr: COUNT(CASE WHEN is_budget_enabled = TRUE THEN 1 END)
      comment: "Number of GL accounts enabled for budgeting. Measures budget coverage across the chart of accounts."
    - name: "intercompany_account_count"
      expr: COUNT(CASE WHEN is_intercompany = TRUE THEN 1 END)
      comment: "Number of intercompany GL accounts. Used for consolidation elimination scope and intercompany reconciliation."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per GL account. Used to identify high-balance accounts for audit focus."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_allocation_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation cycle metrics covering cycle amounts, frequency, and status. Used by controllers to monitor allocation cycle execution and ensure complete cost distribution each period."
  source: "`vibe_manufacturing_v1`.`finance`.`allocation_cycle`"
  dimensions:
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of allocation cycle (assessment, distribution, settlement) for cycle classification."
    - name: "allocation_cycle_status"
      expr: allocation_cycle_status
      comment: "Execution status of the allocation cycle for period-close monitoring."
    - name: "frequency"
      expr: frequency
      comment: "Frequency of the allocation cycle (monthly, quarterly) for scheduling analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used in the allocation cycle for methodology governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation cycle for multi-currency cost distribution."
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the allocation cycle for temporal analysis."
  measures:
    - name: "total_allocation_amount"
      expr: SUM(CAST(total_allocation_amount AS DOUBLE))
      comment: "Total amount allocated across all cycles. Primary measure for cost distribution completeness and volume."
    - name: "allocation_cycle_count"
      expr: COUNT(1)
      comment: "Total number of allocation cycles. Baseline for allocation process complexity and governance scope."
    - name: "avg_allocation_amount_per_cycle"
      expr: AVG(CAST(total_allocation_amount AS DOUBLE))
      comment: "Average allocation amount per cycle. Benchmarks cycle size and identifies unusually large or small cycles."
$$;