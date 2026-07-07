-- Metric views for domain: finance | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core general ledger posting metrics tracking debit/credit volumes, reversal rates, and posting activity by period, company code, and document type — essential for period-close governance and audit readiness."
  source: "`vibe_manufacturing_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for period-over-period trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) within the fiscal year for granular period-close tracking."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period used to slice GL activity by accounting period."
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g., SA, KR, DR) for categorizing posting activity."
    - name: "company_code"
      expr: company_code
      comment: "Company code associated with the journal entry for legal-entity-level reporting."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the posting (posted, parked, reversed) for close-process monitoring."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date for monthly GL activity trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency GL analysis."
    - name: "segment"
      expr: segment
      comment: "Business segment for segment-level P&L reporting."
    - name: "reversal_flag"
      expr: CAST(reversal_flag AS STRING)
      comment: "Indicates whether the journal entry is a reversal, used to measure reversal rate."
  measures:
    - name: "total_journal_entries"
      expr: COUNT(1)
      comment: "Total number of journal entries posted — baseline volume metric for period-close workload assessment."
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Sum of all debit postings in transaction currency — measures total debit-side GL activity."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Sum of all credit postings in transaction currency — measures total credit-side GL activity."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net amount across all journal entries — used to verify balanced ledger (should approach zero for balanced periods)."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount_total AS DOUBLE))
      comment: "Total tax posted across journal entries — supports tax liability reporting and compliance."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Count of reversal journal entries — high reversal counts signal posting quality issues or period-close rework."
    - name: "manual_adjusted_entry_count"
      expr: COUNT(CASE WHEN is_adjusted = TRUE THEN 1 END)
      comment: "Count of manually adjusted entries — elevated counts indicate control weaknesses requiring audit attention."
    - name: "avg_net_amount_per_entry"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per journal entry — helps detect anomalous large postings that may require review."
    - name: "local_currency_total"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total local currency amount posted — used for statutory reporting in entity's functional currency."
    - name: "transaction_currency_total"
      expr: SUM(CAST(transaction_currency_amount AS DOUBLE))
      comment: "Total transaction currency amount — supports foreign currency exposure analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics covering invoice volumes, payment performance, discount capture, tax liability, and three-way match compliance — critical for cash flow management and supplier payment governance."
  source: "`vibe_manufacturing_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (standard, credit memo, etc.) for categorizing payables activity."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval status for tracking bottlenecks in the AP approval workflow."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (matched, unmatched, exception) — key control metric for procurement compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency payables analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice for tax liability segmentation."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date for monthly AP accrual and cash flow planning."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month-truncated due date for cash outflow forecasting."
    - name: "tax_exempt_flag"
      expr: CAST(tax_exempt_flag AS STRING)
      comment: "Whether the invoice is tax-exempt — used for tax compliance segmentation."
    - name: "bank_statement_reconciliation_status"
      expr: bank_statement_reconciliation_status
      comment: "Reconciliation status of the invoice against bank statement — supports treasury reconciliation."
  measures:
    - name: "total_ap_invoices"
      expr: COUNT(1)
      comment: "Total number of AP invoices — baseline volume for AP workload and vendor activity measurement."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount — represents total payables liability before discounts and tax adjustments."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts — actual cash outflow obligation to suppliers."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices — supports input tax recovery and VAT reporting."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices — measures actual cash disbursements to suppliers."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts captured — measures effectiveness of discount capture program."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted — required for statutory withholding tax compliance reporting."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'MATCHED' THEN 1 END)
      comment: "Count of invoices failing three-way match — high count signals procurement control failures requiring intervention."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount — benchmarks typical invoice size for anomaly detection and vendor spend analysis."
    - name: "pending_approval_invoice_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('APPROVED','PAID') THEN 1 END)
      comment: "Count of invoices pending approval — measures AP processing backlog and workflow efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_ar_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable metrics covering outstanding balances, aging, collection performance, dispute rates, and write-off exposure — essential for working capital management and credit risk oversight."
  source: "`vibe_manufacturing_v1`.`finance`.`ar_item`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (current, 30-60, 60-90, 90+ days) for receivables aging analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AR analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the AR item for tracking collections effectiveness."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status for measuring disputed receivables exposure."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level reached for the AR item — higher levels indicate escalating collection risk."
    - name: "cleared_flag"
      expr: CAST(cleared_flag AS STRING)
      comment: "Whether the AR item has been cleared/paid — used to segment open vs. closed receivables."
    - name: "write_off_flag"
      expr: CAST(write_off_flag AS STRING)
      comment: "Whether the AR item has been written off — used to measure bad debt exposure."
    - name: "credit_memo_flag"
      expr: CAST(credit_memo_flag AS STRING)
      comment: "Whether the item is a credit memo — used to net credit adjustments against gross AR."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date for monthly AR trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month-truncated due date for cash inflow forecasting."
    - name: "segment"
      expr: segment
      comment: "Business segment for segment-level AR and revenue reporting."
  measures:
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open (uncollected) AR amount — primary measure of outstanding receivables and working capital tied up in AR."
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount — gross AR before payments and adjustments."
    - name: "total_cleared_amount"
      expr: SUM(CAST(cleared_amount AS DOUBLE))
      comment: "Total amount cleared/collected — measures collections effectiveness and cash conversion."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as bad debt — critical risk metric for credit loss provisioning."
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credit memo adjustments — measures volume of billing corrections and customer credits."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR items — measures cost of early payment incentives."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of AR items — supports output tax reporting and VAT compliance."
    - name: "overdue_ar_count"
      expr: COUNT(CASE WHEN cleared_flag = FALSE AND aging_bucket NOT IN ('CURRENT','0-30') THEN 1 END)
      comment: "Count of overdue AR items — measures collections backlog and credit risk exposure."
    - name: "disputed_ar_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'RESOLVED' THEN 1 END)
      comment: "Count of AR items under active dispute — high count signals billing quality or customer satisfaction issues."
    - name: "avg_open_amount_per_item"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open amount per AR item — benchmarks typical receivable size for anomaly detection."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total AR in local/functional currency — required for statutory balance sheet reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center performance metrics tracking budget utilization, actual vs. planned cost variance, and overhead classification — used by CFO and controllers to manage departmental spending and cost efficiency."
  source: "`vibe_manufacturing_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Cost center hierarchy level for organizational drill-down in cost reporting."
    - name: "hierarchy_path"
      expr: hierarchy_path
      comment: "Full hierarchy path for cost center tree navigation in management reporting."
    - name: "controlling_area_code"
      expr: controlling_area_code
      comment: "Controlling area for multi-entity cost management segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Cost center currency for multi-currency cost analysis."
    - name: "is_overhead"
      expr: CAST(is_overhead AS STRING)
      comment: "Whether the cost center is classified as overhead — used to separate direct vs. indirect cost analysis."
    - name: "owner_department"
      expr: owner_department
      comment: "Owning department for accountability-based cost reporting."
    - name: "location_code"
      expr: location_code
      comment: "Physical location of the cost center for geographic cost analysis."
    - name: "valid_from"
      expr: DATE_TRUNC('year', valid_from)
      comment: "Year the cost center became valid — used for lifecycle and vintage analysis."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual costs incurred across cost centers — primary measure for cost performance monitoring."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across cost centers — baseline for budget vs. actual variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budget) — negative values indicate overspend requiring management action."
    - name: "avg_actual_cost_per_center"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per cost center — benchmarks cost center spending for peer comparison."
    - name: "avg_budget_utilization_amount"
      expr: AVG(CAST(actual_cost AS DOUBLE) / NULLIF(CAST(budget_amount AS DOUBLE), 0))
      comment: "Average ratio of actual cost to budget per cost center — measures budget utilization efficiency across the portfolio."
    - name: "overspent_cost_center_count"
      expr: COUNT(CASE WHEN actual_cost > budget_amount THEN 1 END)
      comment: "Count of cost centers exceeding their budget — key governance metric for financial control and corrective action."
    - name: "total_cost_centers"
      expr: COUNT(1)
      comment: "Total number of active cost centers — baseline for organizational cost structure sizing."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise budget performance metrics tracking planned vs. actual spend, committed amounts, budget approval status, and variance by fiscal year, cost center, and budget type — core CFO dashboard KPIs."
  source: "`vibe_manufacturing_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget cycle analysis and year-over-year comparison."
    - name: "period"
      expr: period
      comment: "Budget period (month/quarter) for intra-year budget tracking."
    - name: "budget_status"
      expr: budget_status
      comment: "Budget approval and execution status for governance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency financial planning."
    - name: "department_code"
      expr: department_code
      comment: "Department owning the budget line for accountability reporting."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional budget allocation analysis."
    - name: "is_capex"
      expr: CAST(is_capex AS STRING)
      comment: "Whether the budget line is capital expenditure — used to separate CapEx from OpEx budget analysis."
    - name: "is_opex"
      expr: CAST(is_opex AS STRING)
      comment: "Whether the budget line is operational expenditure — used for OpEx budget tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status for tracking budget governance and sign-off completeness."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the budget period starts — used for budget timeline analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget amount — primary measure of planned financial commitment for the period."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget — measures execution against financial plan."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) amount — critical for cash flow forecasting and budget availability."
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned amount across all budget lines — baseline for budget planning completeness."
    - name: "total_revised_amount"
      expr: SUM(CAST(total_revised_amount AS DOUBLE))
      comment: "Total revised budget amount after amendments — measures budget flexibility and reforecast activity."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold set across budget lines — indicates organizational tolerance for budget deviation."
    - name: "unapproved_budget_count"
      expr: COUNT(CASE WHEN approved_flag = FALSE THEN 1 END)
      comment: "Count of budget lines not yet approved — measures budget governance completeness and approval backlog."
    - name: "total_budget_lines"
      expr: COUNT(1)
      comment: "Total number of budget lines — baseline for budget structure complexity and planning coverage."
    - name: "capex_budget_total"
      expr: SUM(CASE WHEN is_capex = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total CapEx budget — used by CFO to monitor capital investment commitments against board-approved CapEx envelope."
    - name: "opex_budget_total"
      expr: SUM(CASE WHEN is_opex = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total OpEx budget — used to track operational cost commitments and manage P&L impact."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio metrics covering net book value, accumulated depreciation, acquisition cost, and asset lifecycle status — essential for balance sheet accuracy, CapEx ROI tracking, and asset management governance."
  source: "`vibe_manufacturing_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (machinery, buildings, vehicles, etc.) for asset portfolio segmentation."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, declining balance) for accounting policy analysis."
    - name: "fixed_asset_status"
      expr: fixed_asset_status
      comment: "Current status of the fixed asset (active, retired, disposed) for lifecycle management."
    - name: "currency_code"
      expr: currency_code
      comment: "Asset currency for multi-currency balance sheet reporting."
    - name: "capitalized_flag"
      expr: CAST(capitalized_flag AS STRING)
      comment: "Whether the asset has been capitalized — used to separate capitalized vs. expensed assets."
    - name: "plant"
      expr: plant
      comment: "Plant location of the fixed asset for geographic asset distribution analysis."
    - name: "department_responsible"
      expr: department_responsible
      comment: "Department responsible for the asset for accountability and cost allocation."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year of acquisition for asset vintage analysis and depreciation schedule planning."
    - name: "asset_origin"
      expr: asset_origin
      comment: "Origin of the asset (purchased, leased, transferred) for asset sourcing analysis."
  measures:
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all fixed assets — primary balance sheet measure for PP&E reporting."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets — measures total capital invested in the asset base."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures asset aging and remaining useful life across the portfolio."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total estimated replacement cost — used for insurance adequacy assessment and CapEx planning."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total residual/salvage value of assets — used in depreciation calculations and disposal planning."
    - name: "total_tax_net_book_value"
      expr: SUM(CAST(tax_net_book_value AS DOUBLE))
      comment: "Total tax net book value — required for deferred tax calculation and tax compliance reporting."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across fixed assets — used to assess insurance adequacy vs. replacement cost."
    - name: "avg_net_book_value_per_asset"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset — benchmarks asset value for portfolio health assessment."
    - name: "total_fixed_assets"
      expr: COUNT(1)
      comment: "Total count of fixed assets in the register — baseline for asset portfolio size and management scope."
    - name: "fully_depreciated_asset_count"
      expr: COUNT(CASE WHEN net_book_value <= 0 THEN 1 END)
      comment: "Count of fully depreciated assets still in service — signals aging asset base requiring CapEx refresh planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request pipeline metrics tracking approval rates, requested vs. approved amounts, ROI expectations, and CapEx pipeline by category and priority — used by CFO and investment committee for CapEx governance."
  source: "`vibe_manufacturing_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "CapEx request status (submitted, approved, rejected, in-progress) for pipeline stage analysis."
    - name: "approval_stage"
      expr: approval_stage
      comment: "Current approval stage for tracking CapEx governance workflow progress."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (machinery, IT, infrastructure) for CapEx portfolio segmentation."
    - name: "priority"
      expr: priority
      comment: "Business priority of the CapEx request for investment prioritization analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Request currency for multi-currency CapEx portfolio analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (internal, debt, equity) for CapEx financing analysis."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department requesting the CapEx for departmental investment allocation analysis."
    - name: "capitalized_flag"
      expr: CAST(capitalized_flag AS STRING)
      comment: "Whether the request has been capitalized — tracks conversion from request to asset."
    - name: "regulatory_approval_needed"
      expr: CAST(regulatory_approval_needed AS STRING)
      comment: "Whether regulatory approval is required — used to flag compliance-sensitive CapEx requests."
    - name: "request_date_year"
      expr: DATE_TRUNC('year', request_date)
      comment: "Year of request submission for annual CapEx pipeline trend analysis."
  measures:
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total CapEx amount requested — measures the full investment pipeline before approval filtering."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total CapEx amount approved — measures committed capital investment and board-approved spend envelope."
    - name: "total_estimated_amount"
      expr: SUM(CAST(estimated_amount AS DOUBLE))
      comment: "Total estimated CapEx amount — used for budget planning and cash flow forecasting."
    - name: "avg_expected_roi_percent"
      expr: AVG(CAST(expected_roi_percent AS DOUBLE))
      comment: "Average expected ROI across CapEx requests — used by investment committee to prioritize highest-return projects."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across approved CapEx — measures portfolio-level return on capital investment."
    - name: "total_capex_requests"
      expr: COUNT(1)
      comment: "Total number of CapEx requests submitted — baseline for investment pipeline volume and governance workload."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN request_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved CapEx requests — measures investment committee throughput and approval rate."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN request_status NOT IN ('APPROVED','REJECTED','CANCELLED') THEN 1 END)
      comment: "Count of CapEx requests pending approval — measures governance backlog and decision cycle time."
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved CapEx amount per request — benchmarks typical investment size for portfolio planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics tracking allocation volumes, amounts, methods, and posting status — used by controllers to validate cost distribution accuracy and ensure overhead is correctly absorbed across cost objects."
  source: "`vibe_manufacturing_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method used (percentage, statistical key figure, fixed amount) for methodology analysis."
    - name: "allocation_category"
      expr: allocation_category
      comment: "Category of cost allocation (overhead, direct, indirect) for cost type segmentation."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation posting for close-process monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation for period-over-period trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation for monthly cost distribution tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Allocation currency for multi-currency cost management."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the allocation for period-close completeness monitoring."
    - name: "is_manual_allocation"
      expr: CAST(is_manual_allocation AS STRING)
      comment: "Whether the allocation was manually created — high manual rates indicate automation gaps."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Whether the allocation was reversed — used to measure allocation correction activity."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation for monthly cost distribution trend analysis."
  measures:
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total cost allocated across all allocation records — measures total overhead and indirect cost distributed."
    - name: "avg_allocation_amount"
      expr: AVG(CAST(allocation_amount AS DOUBLE))
      comment: "Average allocation amount per record — benchmarks typical allocation size for anomaly detection."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage applied — used to validate allocation basis consistency across cost centers."
    - name: "manual_allocation_count"
      expr: COUNT(CASE WHEN is_manual_allocation = TRUE THEN 1 END)
      comment: "Count of manual allocations — high manual counts signal automation gaps in cost distribution processes."
    - name: "reversal_allocation_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of reversed allocations — measures allocation correction activity and posting quality."
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of cost allocation records — baseline for allocation process volume and complexity."
    - name: "unposted_allocation_count"
      expr: COUNT(CASE WHEN posting_status != 'POSTED' THEN 1 END)
      comment: "Count of allocations not yet posted — measures period-close completeness for cost distribution."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking elimination status, transfer pricing, reconciliation gaps, and cross-entity transaction volumes — critical for consolidated financial reporting and transfer pricing compliance."
  source: "`vibe_manufacturing_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (sale, loan, service, royalty) for elimination categorization."
    - name: "transaction_subtype"
      expr: transaction_subtype
      comment: "Sub-type for granular intercompany transaction classification."
    - name: "intercompany_transaction_status"
      expr: intercompany_transaction_status
      comment: "Transaction status for tracking intercompany processing and elimination completeness."
    - name: "elimination_status"
      expr: elimination_status
      comment: "Elimination status — uneliminated transactions cause consolidation errors and must be resolved before close."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between sending and receiving entities — mismatches require investigation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency intercompany analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the intercompany transaction for governance monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany volume and elimination analysis."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for monthly intercompany reconciliation tracking."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method applied (arm's length, cost-plus, etc.) for tax compliance analysis."
    - name: "elimination_flag"
      expr: CAST(elimination_flag AS STRING)
      comment: "Whether the transaction has been flagged for elimination in consolidation."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount — measures scale of cross-entity activity requiring elimination in consolidation."
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross intercompany amount — used for elimination journal preparation in group consolidation."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net intercompany amount after tax — measures net intercompany exposure for consolidation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on intercompany transactions — supports transfer pricing tax compliance and deferred tax analysis."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in local currency — used for entity-level statutory reporting."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage on intercompany transactions — key transfer pricing compliance metric monitored by tax authorities."
    - name: "uneliminated_transaction_count"
      expr: COUNT(CASE WHEN elimination_flag = FALSE OR elimination_status != 'ELIMINATED' THEN 1 END)
      comment: "Count of intercompany transactions not yet eliminated — uneliminated items cause consolidation errors and must be resolved before close."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'RECONCILED' THEN 1 END)
      comment: "Count of unreconciled intercompany transactions — measures intercompany matching gaps requiring entity-to-entity resolution."
    - name: "total_intercompany_transactions"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions — baseline for consolidation workload and intercompany activity volume."
    - name: "avg_transfer_price"
      expr: AVG(CAST(transfer_price AS DOUBLE))
      comment: "Average transfer price across intercompany transactions — used to benchmark pricing consistency for transfer pricing documentation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance metrics tracking actual vs. planned profit, budget utilization, and OEE targets — used by segment leaders and CFO to evaluate business unit financial performance."
  source: "`vibe_manufacturing_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (product line, geography, business unit) for portfolio segmentation."
    - name: "profit_center_group"
      expr: profit_center_group
      comment: "Profit center group for hierarchical P&L reporting."
    - name: "segment"
      expr: segment
      comment: "Business segment for segment-level profitability analysis."
    - name: "region"
      expr: region
      comment: "Geographic region for regional P&L performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Profit center currency for multi-currency profitability reporting."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Status of the profit center (active, inactive) for portfolio management."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level for organizational drill-down in P&L reporting."
    - name: "valid_from_year"
      expr: DATE_TRUNC('year', valid_from)
      comment: "Year the profit center became valid — used for lifecycle analysis."
  measures:
    - name: "total_actual_profit"
      expr: SUM(CAST(actual_profit AS DOUBLE))
      comment: "Total actual profit across profit centers — primary P&L measure for business unit performance evaluation."
    - name: "total_planned_profit"
      expr: SUM(CAST(planned_profit AS DOUBLE))
      comment: "Total planned profit across profit centers — baseline for profit vs. plan variance analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to profit centers — measures financial resource allocation across business units."
    - name: "avg_oee_target_percent"
      expr: AVG(CAST(oee_target_percent AS DOUBLE))
      comment: "Average OEE target across profit centers — links financial performance to operational efficiency targets."
    - name: "profit_vs_plan_variance"
      expr: SUM(CAST(actual_profit AS DOUBLE) - CAST(planned_profit AS DOUBLE))
      comment: "Total profit variance (actual minus planned) — negative values trigger management intervention and reforecast."
    - name: "total_profit_centers"
      expr: COUNT(1)
      comment: "Total number of profit centers — baseline for business unit portfolio size and reporting complexity."
    - name: "underperforming_profit_center_count"
      expr: COUNT(CASE WHEN actual_profit < planned_profit THEN 1 END)
      comment: "Count of profit centers below plan — measures breadth of underperformance requiring strategic intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_internal_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Internal order financial metrics tracking budget consumption, actual vs. planned costs, commitment levels, and settlement status — used by project controllers and cost managers to govern discretionary spend."
  source: "`vibe_manufacturing_v1`.`finance`.`internal_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Internal order type (CapEx, maintenance, marketing, R&D) for spend category analysis."
    - name: "internal_order_status"
      expr: internal_order_status
      comment: "Order status (created, released, technically complete, settled) for lifecycle monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance and authorization tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Order currency for multi-currency cost management."
    - name: "capex_flag"
      expr: CAST(capex_flag AS STRING)
      comment: "Whether the order is CapEx — used to separate capital from operational spend."
    - name: "opex_flag"
      expr: CAST(opex_flag AS STRING)
      comment: "Whether the order is OpEx — used for operational cost tracking."
    - name: "controlling_area"
      expr: controlling_area
      comment: "Controlling area for multi-entity cost management."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the internal order for workflow governance."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the order was created for trend analysis of discretionary spend initiation."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual costs posted to internal orders — measures discretionary spend execution against authorization."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget authorized for internal orders — baseline for budget vs. actual variance analysis."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated) amount on internal orders — critical for available budget calculation."
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned cost on internal orders — used for cost forecasting and budget adequacy assessment."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual minus budget) — negative values indicate overspend requiring management action."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average variance percentage across internal orders — measures overall budget discipline for discretionary spend."
    - name: "total_internal_orders"
      expr: COUNT(1)
      comment: "Total number of internal orders — baseline for discretionary spend portfolio size."
    - name: "overbudget_order_count"
      expr: COUNT(CASE WHEN actual_cost > budget_amount THEN 1 END)
      comment: "Count of internal orders exceeding budget — key governance metric for cost control and authorization compliance."
    - name: "unsettled_order_count"
      expr: COUNT(CASE WHEN internal_order_status NOT IN ('SETTLED','CLOSED') THEN 1 END)
      comment: "Count of internal orders not yet settled — measures period-close completeness for cost object settlement."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_cost_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product and project cost estimate metrics tracking estimated vs. actual cost components, estimate accuracy, and costing coverage — used by cost engineers and CFO to validate standard costs and support pricing decisions."
  source: "`vibe_manufacturing_v1`.`finance`.`cost_estimate`"
  dimensions:
    - name: "estimate_type"
      expr: estimate_type
      comment: "Type of cost estimate (standard, preliminary, actual) for estimate lifecycle analysis."
    - name: "estimate_status"
      expr: estimate_status
      comment: "Status of the cost estimate (draft, released, marked) for costing governance."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the estimate for risk-adjusted cost planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Estimate currency for multi-currency costing analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the cost estimate for quantity-normalized cost analysis."
    - name: "estimate_date_year"
      expr: DATE_TRUNC('year', estimate_date)
      comment: "Year of estimate creation for vintage and trend analysis."
    - name: "valid_from_year"
      expr: DATE_TRUNC('year', valid_from)
      comment: "Year the estimate became valid for costing period analysis."
  measures:
    - name: "total_estimated_cost_gross"
      expr: SUM(CAST(estimate_amount_gross AS DOUBLE))
      comment: "Total gross estimated cost — measures total cost commitment in the estimate portfolio."
    - name: "total_estimated_cost_net"
      expr: SUM(CAST(estimate_amount_net AS DOUBLE))
      comment: "Total net estimated cost — used for pricing and margin analysis."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component across estimates — used to analyze material cost as a driver of total product cost."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component across estimates — measures labor cost contribution to product/project cost."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component — measures overhead absorption rate and its impact on product cost."
    - name: "total_estimated_cost_all"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all estimates — primary measure for cost portfolio sizing and budget adequacy."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across cost estimates — used for pricing benchmarking and margin analysis."
    - name: "total_cost_estimates"
      expr: COUNT(1)
      comment: "Total number of cost estimates — baseline for costing coverage and standard cost maintenance workload."
    - name: "avg_total_estimated_cost"
      expr: AVG(CAST(total_estimated_cost AS DOUBLE))
      comment: "Average total estimated cost per estimate — benchmarks typical cost estimate size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_allocation_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation cycle execution metrics tracking cycle completion, allocated amounts, and cycle frequency — used by controllers to monitor overhead allocation process health and period-close readiness."
  source: "`vibe_manufacturing_v1`.`finance`.`allocation_cycle`"
  dimensions:
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of allocation cycle (assessment, distribution, settlement) for process categorization."
    - name: "cycle_status"
      expr: cycle_status
      comment: "Execution status of the allocation cycle for period-close monitoring."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method used in the cycle for methodology governance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation cycle for annual trend analysis."
    - name: "period"
      expr: period
      comment: "Accounting period of the cycle for monthly close tracking."
    - name: "frequency"
      expr: frequency
      comment: "Cycle frequency (monthly, quarterly, annual) for scheduling analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Cycle currency for multi-currency allocation analysis."
    - name: "effective_from_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the cycle became effective for lifecycle analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(total_allocated_amount AS DOUBLE))
      comment: "Total amount allocated across all cycles — measures scale of overhead distribution activity."
    - name: "total_allocation_amount"
      expr: SUM(CAST(total_allocation_amount AS DOUBLE))
      comment: "Total allocation amount planned for cycles — used to compare planned vs. executed allocation volumes."
    - name: "total_allocation_cycles"
      expr: COUNT(1)
      comment: "Total number of allocation cycles — baseline for period-close workload and allocation process complexity."
    - name: "completed_cycle_count"
      expr: COUNT(CASE WHEN cycle_status = 'COMPLETED' THEN 1 END)
      comment: "Count of completed allocation cycles — measures period-close progress for overhead distribution."
    - name: "pending_cycle_count"
      expr: COUNT(CASE WHEN cycle_status NOT IN ('COMPLETED','CANCELLED') THEN 1 END)
      comment: "Count of allocation cycles not yet completed — measures period-close backlog for cost allocation."
    - name: "avg_allocated_amount_per_cycle"
      expr: AVG(CAST(total_allocated_amount AS DOUBLE))
      comment: "Average allocated amount per cycle — benchmarks typical cycle size for anomaly detection and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treasury bank account metrics tracking cash balances, transaction limits, and account health — used by treasury to manage liquidity, cash pooling, and banking relationship governance."
  source: "`vibe_manufacturing_v1`.`finance`.`bank_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Bank account type (current, savings, escrow) for liquidity classification."
    - name: "account_status"
      expr: account_status
      comment: "Account status (active, dormant, closed) for account portfolio management."
    - name: "currency_code"
      expr: currency_code
      comment: "Account currency for multi-currency cash position analysis."
    - name: "bank_country_code"
      expr: bank_country_code
      comment: "Country of the bank for geographic cash distribution analysis."
    - name: "bank_name"
      expr: bank_name
      comment: "Bank name for banking relationship concentration analysis."
    - name: "treasury_region"
      expr: treasury_region
      comment: "Treasury region for regional cash management and pooling analysis."
    - name: "cash_pool_membership"
      expr: cash_pool_membership
      comment: "Cash pool membership for notional pooling and cash concentration analysis."
    - name: "active_flag"
      expr: CAST(active_flag AS STRING)
      comment: "Whether the account is active — used to filter active accounts for cash position reporting."
    - name: "effective_from_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the account became effective for account lifecycle analysis."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current cash balance across all bank accounts — primary treasury metric for enterprise liquidity position."
    - name: "total_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance across bank accounts — used for cash position reporting and liquidity management."
    - name: "total_daily_transaction_limit"
      expr: SUM(CAST(daily_transaction_limit AS DOUBLE))
      comment: "Total daily transaction limit across accounts — measures authorized payment capacity for treasury operations."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per bank account — benchmarks typical account balance for idle cash detection."
    - name: "total_bank_accounts"
      expr: COUNT(1)
      comment: "Total number of bank accounts — baseline for banking relationship complexity and account rationalization analysis."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Count of active bank accounts — used for banking relationship governance and account rationalization."
$$;