-- Metric views for domain: finance | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for project budget health, variance tracking, cost-at-completion forecasting, and contingency utilization. Used by CFOs, project controllers, and PMO leadership to steer budget performance across the construction portfolio."
  source: "`vibe_construction_v1`.`finance`.`project_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Classifies the budget as original, revised, supplemental, etc. — enables comparison across budget lifecycle stages."
    - name: "budget_status"
      expr: budget_status
      comment: "Current approval/active status of the budget record (e.g. Draft, Approved, Closed) — filters to active budgets for operational reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated — essential for multi-currency portfolio analysis."
    - name: "budget_owner"
      expr: budget_owner
      comment: "Person or team responsible for the budget — enables accountability and ownership-based drill-down."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g. equity, debt, grant) — critical for capital allocation and funding mix analysis."
    - name: "budget_period_start_date"
      expr: DATE_TRUNC('month', budget_period_start_date)
      comment: "Month-truncated budget period start — enables time-series trending of budget cycles."
    - name: "is_baseline_budget"
      expr: is_baseline_budget
      comment: "Flags whether this is the approved baseline budget — used to isolate baseline vs. revised budget comparisons."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the budget record is currently active — standard filter for live portfolio views."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget across selected projects. Baseline for all variance and overrun analysis."
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget AS DOUBLE))
      comment: "Total current approved budget including all approved change orders. Reflects the live authorized spend ceiling."
    - name: "total_approved_change_order_amount"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Total value of approved change orders. Measures scope growth and contract modification impact on budget."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred to date. Core cost performance indicator for budget consumption tracking."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs (purchase orders, subcontracts) not yet invoiced. Represents financial obligations already locked in."
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Total estimated cost at project completion (EAC). The primary forward-looking cost performance metric for executive steering."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total variance between budgeted and actual/forecast costs. Negative values signal overruns requiring executive intervention."
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve_amount AS DOUBLE))
      comment: "Total contingency reserve held across projects. Indicates risk buffer available before budget breach."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve held. Represents discretionary funds controlled by senior leadership for unforeseen risks."
    - name: "avg_budget_variance_amount"
      expr: AVG(CAST(budget_variance_amount AS DOUBLE))
      comment: "Average budget variance per budget record. Useful for benchmarking typical variance magnitude across the portfolio."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_approved_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of current approved budget consumed by actual costs. Key burn-rate indicator — values above 100% signal overrun."
    - name: "change_order_growth_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_change_order_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_budget_amount AS DOUBLE)), 0), 2)
      comment: "Approved change orders as a percentage of original budget. Measures scope creep and contract volatility — high values indicate poor initial scoping."
    - name: "cost_at_completion_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(forecast_at_completion AS DOUBLE)) - SUM(CAST(current_approved_budget AS DOUBLE))) / NULLIF(SUM(CAST(current_approved_budget AS DOUBLE)), 0), 2)
      comment: "Forecast-at-completion vs. current approved budget as a percentage. Positive values indicate projected overrun — primary EAC health indicator for the CFO."
    - name: "contingency_consumption_rate"
      expr: ROUND(100.0 * (SUM(CAST(current_approved_budget AS DOUBLE)) - SUM(CAST(original_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(contingency_reserve_amount AS DOUBLE)), 0), 2)
      comment: "Rate at which contingency reserve has been consumed by approved changes. Values approaching 100% signal contingency exhaustion risk."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Total number of budget records in scope. Used as a denominator for per-budget averages and portfolio sizing."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_job_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for job cost performance, cost category analysis, and transaction-level cost control. Used by project controllers, cost engineers, and CFOs to monitor actual cost accumulation against budgets."
  source: "`vibe_construction_v1`.`finance`.`job_cost_transaction`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g. Labour, Materials, Equipment, Subcontract) — primary dimension for cost breakdown analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the cost transaction (e.g. Posted, Pending, Reversed) — filters to valid posted costs."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the transaction — identifies unapproved costs requiring action."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — enables multi-currency cost analysis and FX impact assessment."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction — enables period-over-period cost trend analysis aligned to financial close."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date — enables monthly cost accrual trending and burn-rate analysis."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the cost is billable to the client — critical for revenue recovery and margin analysis."
    - name: "billed_flag"
      expr: billed_flag
      comment: "Indicates whether the billable cost has been invoiced — identifies unbilled revenue exposure."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed transactions — used to exclude or analyze correction activity in cost ledgers."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the cost transaction (e.g. hours, tonnes, m²) — enables unit-rate benchmarking."
  measures:
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total job cost incurred across all transactions. Primary cost accumulation KPI for project financial control."
    - name: "total_base_currency_cost"
      expr: SUM(CAST(base_currency_cost AS DOUBLE))
      comment: "Total cost converted to base/functional currency. Enables consistent cross-project cost comparison eliminating FX distortion."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units consumed (hours, materials, etc.). Supports productivity and unit-rate benchmarking."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per transaction. Benchmarks cost efficiency — deviations from standard rates signal procurement or productivity issues."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost transactions. Volume indicator for cost activity and processing load."
    - name: "distinct_cost_code_count"
      expr: COUNT(DISTINCT cost_code_id)
      comment: "Number of distinct cost codes charged. Measures cost code spread — high values may indicate poor cost discipline or scope fragmentation."
    - name: "billable_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost classified as billable to the client. Represents the revenue-recoverable cost base — key for margin and billing gap analysis."
    - name: "unbilled_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE AND billed_flag = FALSE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total billable costs not yet invoiced to the client. Represents unbilled revenue exposure — a critical cash flow and revenue recognition risk indicator."
    - name: "reversal_cost_total"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost in reversal transactions. High reversal volumes indicate data quality issues, rework, or posting errors requiring investigation."
    - name: "billable_cost_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of total cost that is billable. Measures revenue recoverability — low rates indicate high non-billable overhead eroding project margin."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice management KPIs covering invoice volumes, payment performance, dispute rates, and retention tracking. Used by finance controllers, AP managers, and CFOs to manage payables and cash outflow."
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. Received, Approved, Paid, Disputed) — primary filter for AP workflow analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. Progress, Final, Advance, Retention) — enables invoice mix and payment pattern analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — identifies invoices pending approval that may delay payment and affect vendor relationships."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — supports multi-currency AP analysis and FX exposure tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g. EFT, Cheque, SWIFT) — used for payment channel optimization and bank fee analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. Net 30, Net 60) — enables payment terms compliance and early payment discount analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — aligns AP reporting to financial close cycles."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice — supports annual AP volume and spend trend analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month-truncated invoice date — enables monthly AP accrual and invoice volume trending."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flags invoices under dispute — critical for vendor relationship management and cash flow risk identification."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/Invoice three-way match — identifies invoices failing controls that require manual intervention."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value before discounts and tax. Primary AP spend volume indicator for cash outflow planning."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable after discounts and adjustments. Represents actual cash obligation to vendors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax (GST/VAT/withholding) on invoices. Required for tax compliance reporting and cash flow forecasting."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from vendor invoices. Represents deferred payment obligations — critical for subcontractor cash flow management."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment or negotiated discounts captured. Measures procurement savings and discount capture efficiency."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices processed. Volume baseline for AP workload, processing efficiency, and vendor activity analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. High counts signal vendor relationship issues, contract ambiguity, or quality problems."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of disputed invoices. Quantifies financial exposure from AP disputes — a key risk metric for cash flow and vendor management."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute. Benchmark for AP quality and vendor invoice accuracy — high rates indicate systemic procurement or contract issues."
    - name: "avg_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Useful for detecting anomalous invoices and benchmarking vendor billing patterns."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied across invoices. Monitors contractual retention compliance and subcontractor cash flow impact."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_progress_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition and billing performance KPIs for construction progress claims. Tracks billed amounts, outstanding balances, retention, and payment status. Used by project finance teams, contract managers, and CFOs to manage revenue and receivables."
  source: "`vibe_construction_v1`.`finance`.`progress_billing`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the progress billing (e.g. Submitted, Certified, Paid, Overdue) — primary filter for receivables management."
    - name: "payment_certificate_type"
      expr: payment_certificate_type
      comment: "Type of payment certificate (e.g. Interim, Final, Milestone) — enables billing type mix and revenue recognition analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency — supports multi-currency revenue and receivables analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Receivables aging classification (e.g. Current, 30-60 days, 60-90 days, 90+ days) — critical for cash flow risk and collections prioritization."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month-truncated billing period start — enables monthly revenue recognition trending aligned to project progress."
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Contractual payment terms in days — used to assess payment compliance and identify overdue receivables."
  measures:
    - name: "total_gross_amount_due"
      expr: SUM(CAST(gross_amount_due AS DOUBLE))
      comment: "Total gross amount billed to clients across all progress claims. Primary revenue billing volume indicator."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after retention and adjustments. Represents actual receivables balance owed by clients."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash received against progress billings. Measures actual revenue collected — key cash inflow performance indicator."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance. Represents uncollected revenue — a critical liquidity and credit risk indicator for the CFO."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld by clients from progress billings. Represents deferred revenue — tracked for release timing and cash flow planning."
    - name: "total_current_period_claim"
      expr: SUM(CAST(current_period_claim AS DOUBLE))
      comment: "Total value of claims submitted in the current billing period. Measures billing activity and revenue recognition pace."
    - name: "total_work_completed_to_date"
      expr: SUM(CAST(work_completed_to_date AS DOUBLE))
      comment: "Cumulative value of work completed and certified to date. Tracks earned revenue against contract value for portfolio-level progress assessment."
    - name: "total_scheduled_value"
      expr: SUM(CAST(scheduled_value AS DOUBLE))
      comment: "Total scheduled contract value across all billing records. Denominator for completion percentage and billing coverage analysis."
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average percentage completion across progress billing records. Portfolio-level progress indicator for executive dashboards."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amounts collected. Measures receivables collection efficiency — low rates signal client payment risk or disputes."
    - name: "retention_rate"
      expr: ROUND(100.0 * SUM(CAST(retention_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount_due AS DOUBLE)), 0), 2)
      comment: "Retention withheld as a percentage of gross billings. Monitors contractual retention levels and deferred cash flow exposure."
    - name: "billing_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(work_completed_to_date AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_value AS DOUBLE)), 0), 2)
      comment: "Work completed to date as a percentage of total scheduled value. Measures revenue recognition progress against contract — key for earned value and project health reporting."
    - name: "progress_billing_count"
      expr: COUNT(1)
      comment: "Total number of progress billing records. Volume indicator for billing activity and contract claim frequency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_payment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash disbursement and payment execution KPIs covering payment volumes, retention releases, withholding tax, and payment status. Used by treasury, AP, and CFO to manage outgoing cash flows and payment compliance."
  source: "`vibe_construction_v1`.`finance`.`payment_record`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Pending, Cleared, Rejected) — primary filter for payment execution monitoring."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Progress, Retention Release, Advance, Final) — enables payment mix and cash flow pattern analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment channel used (e.g. EFT, SWIFT, Cheque) — supports payment channel optimization and bank fee management."
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval workflow status of the payment — identifies payments pending authorization that may delay disbursement."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency — enables multi-currency cash outflow analysis and FX exposure tracking."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month-truncated payment date — enables monthly cash disbursement trending and treasury planning."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Bank clearing status of the payment — identifies uncleared payments affecting cash position accuracy."
    - name: "advance_payment_flag"
      expr: advance_payment_flag
      comment: "Flags advance payments to vendors — tracks mobilization funding and advance recovery exposure."
    - name: "partial_payment_flag"
      expr: partial_payment_flag
      comment: "Flags partial payments — identifies invoices with outstanding balances requiring follow-up."
    - name: "payment_priority"
      expr: payment_priority
      comment: "Priority classification of the payment — used for cash flow scheduling and critical vendor payment management."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed. Primary cash outflow KPI for treasury and AP management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after retention, discounts, and withholding tax. Represents actual cash disbursed to vendors."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payments converted to functional currency. Enables consistent cross-currency cash outflow reporting for the CFO."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from payments. Tracks deferred payment obligations and retention release scheduling."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments. Required for tax compliance reporting and vendor net payment reconciliation."
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments. Measures transaction cost of payment execution — used for bank fee optimization."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization through discount capture programs."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment records. Volume indicator for AP disbursement activity and processing throughput."
    - name: "advance_payment_total"
      expr: SUM(CASE WHEN advance_payment_flag = TRUE THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total advance payments made to vendors. Tracks mobilization funding exposure and advance recovery risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Benchmarks payment size distribution and identifies anomalous disbursements."
    - name: "retention_withholding_rate"
      expr: ROUND(100.0 * SUM(CAST(retention_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Retention withheld as a percentage of gross payment. Monitors contractual retention compliance across the vendor payment portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treasury and liquidity KPIs derived from cash flow forecasts. Tracks projected inflows, outflows, net cash position, working capital gaps, and peak funding requirements. Used by CFOs and treasury teams to manage project liquidity and financing strategy."
  source: "`vibe_construction_v1`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of cash flow forecast (e.g. Weekly, Monthly, Scenario) — enables comparison across forecast horizons and methodologies."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Approval/publication status of the forecast (e.g. Draft, Approved, Superseded) — filters to active approved forecasts."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Time granularity of the forecast (e.g. Weekly, Monthly, Quarterly) — used to align forecast views to planning horizons."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast — enables multi-currency liquidity analysis."
    - name: "forecast_period_start_month"
      expr: DATE_TRUNC('month', forecast_period_start_date)
      comment: "Month-truncated forecast period start — enables time-series cash flow trending and liquidity planning."
    - name: "s_curve_profile_indicator"
      expr: s_curve_profile_indicator
      comment: "S-curve profile classification — indicates the cash flow shape (front-loaded, back-loaded, standard) for portfolio cash flow pattern analysis."
    - name: "forecast_version"
      expr: forecast_version
      comment: "Version identifier of the forecast — enables version-over-version variance analysis and forecast accuracy tracking."
  measures:
    - name: "total_forecasted_inflow"
      expr: SUM(CAST(forecasted_inflow_amount AS DOUBLE))
      comment: "Total projected cash inflows across forecast periods. Primary revenue cash receipt planning metric for treasury."
    - name: "total_forecasted_outflow"
      expr: SUM(CAST(forecasted_outflow_amount AS DOUBLE))
      comment: "Total projected cash outflows across forecast periods. Represents total disbursement obligations for liquidity planning."
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow (inflows minus outflows). Core liquidity indicator — negative values signal funding gaps requiring financing action."
    - name: "total_working_capital_gap"
      expr: SUM(CAST(working_capital_gap AS DOUBLE))
      comment: "Total working capital gap across forecast periods. Quantifies short-term financing requirements — a critical input for credit facility sizing."
    - name: "total_peak_funding_requirement"
      expr: SUM(CAST(peak_funding_requirement AS DOUBLE))
      comment: "Total peak funding requirement across projects. Identifies maximum simultaneous cash demand — used for credit facility and bonding capacity planning."
    - name: "total_payroll_amount"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Total forecasted payroll cash outflow. Largest recurring cost component — critical for workforce cost planning and cash scheduling."
    - name: "total_subcontractor_payment_amount"
      expr: SUM(CAST(subcontractor_payment_amount AS DOUBLE))
      comment: "Total forecasted subcontractor payment outflows. Typically the largest single cost category in construction — key for supply chain cash flow management."
    - name: "total_material_procurement_amount"
      expr: SUM(CAST(material_procurement_amount AS DOUBLE))
      comment: "Total forecasted material procurement outflows. Tracks procurement cash demand for supply chain and working capital planning."
    - name: "total_retention_release_amount"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total forecasted retention releases to subcontractors. Tracks deferred payment obligations becoming due — important for cash flow scheduling."
    - name: "total_milestone_payment_amount"
      expr: SUM(CAST(milestone_payment_amount AS DOUBLE))
      comment: "Total forecasted milestone-triggered payments. Tracks event-driven cash flows tied to project delivery milestones."
    - name: "avg_variance_to_prior_forecast"
      expr: AVG(CAST(variance_to_prior_forecast AS DOUBLE))
      comment: "Average variance between current and prior forecast versions. Measures forecast accuracy and stability — high variance indicates unreliable cash planning."
    - name: "avg_credit_facility_utilization"
      expr: AVG(CAST(credit_facility_utilization AS DOUBLE))
      comment: "Average credit facility utilization rate across forecast periods. Monitors debt headroom — values approaching 100% signal liquidity stress."
    - name: "avg_bonding_capacity_utilization"
      expr: AVG(CAST(bonding_capacity_utilization AS DOUBLE))
      comment: "Average bonding capacity utilization. Tracks surety bond headroom — critical for bid eligibility and contract award capacity."
    - name: "inflow_to_outflow_ratio"
      expr: ROUND(SUM(CAST(forecasted_inflow_amount AS DOUBLE)) / NULLIF(SUM(CAST(forecasted_outflow_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of forecasted inflows to outflows. Values below 1.0 indicate net cash consumption periods requiring financing — key treasury health indicator."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger posting KPIs for financial close quality, journal entry volumes, intercompany activity, and revenue recognition. Used by controllers, auditors, and CFOs to monitor GL integrity and period-close performance."
  source: "`vibe_construction_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Processing status of the journal entry (e.g. Draft, Posted, Reversed) — primary filter for GL integrity analysis."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g. Standard, Accrual, Reversal, Intercompany) — enables posting type mix analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry — aligns GL analysis to financial close cycles."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry — supports annual GL volume and financial performance trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry — enables multi-currency GL analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date — enables monthly GL activity trending and close-cycle analysis."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied (e.g. Percentage of Completion, Completed Contract) — critical for IFRS 15/ASC 606 compliance reporting."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flags intercompany journal entries — used for intercompany elimination and consolidation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversed journal entries — high reversal rates indicate posting errors or accrual quality issues."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit postings in the GL. Measures gross debit activity — used for GL volume analysis and period-close completeness checks."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit postings in the GL. Paired with total debits for GL balance verification and period-close integrity checks."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts posted in journal entries. Required for tax provision and compliance reporting."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries. Volume indicator for GL activity, close complexity, and automation opportunity assessment."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. High counts indicate posting errors or accrual quality issues — a key GL integrity metric for auditors."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Tracks intercompany transaction volume for consolidation and elimination analysis."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. Benchmark for GL posting quality — high rates signal systemic accrual or posting discipline issues."
    - name: "avg_percentage_of_completion"
      expr: AVG(CAST(percentage_of_completion AS DOUBLE))
      comment: "Average percentage of completion recorded on journal entries. Tracks revenue recognition progress under POC method — key for IFRS 15 compliance and revenue forecasting."
    - name: "total_local_currency_debit"
      expr: SUM(CAST(local_currency_debit_amount AS DOUBLE))
      comment: "Total debit amounts in local/functional currency. Enables consistent cross-entity GL comparison eliminating transaction currency distortion."
    - name: "total_local_currency_credit"
      expr: SUM(CAST(local_currency_credit_amount AS DOUBLE))
      comment: "Total credit amounts in local/functional currency. Paired with local currency debits for functional currency GL balance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center financial governance KPIs covering budget utilization, overhead rates, and cost center portfolio health. Used by finance controllers and CFOs to manage organizational cost structures and overhead allocation."
  source: "`vibe_construction_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (e.g. Project, Overhead, Administrative) — primary dimension for cost structure analysis."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Active/inactive status of the cost center — filters to active cost centers for operational reporting."
    - name: "category"
      expr: category
      comment: "Business category of the cost center — enables cost center grouping by function or business unit."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost center budget — supports multi-currency cost center analysis."
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period (e.g. FY2024, Q1-2024) — enables period-specific budget utilization analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the cost center — enables regional cost structure and overhead analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the cost center is billable to clients — separates direct project costs from overhead for margin analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs from this center (e.g. Direct, Proportional, Activity-Based) — used for overhead allocation governance."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the cost center hierarchy — enables roll-up analysis from project to division to enterprise."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across cost centers. Baseline for cost center budget utilization and variance analysis."
    - name: "avg_overhead_rate_percentage"
      expr: AVG(CAST(overhead_rate_percentage AS DOUBLE))
      comment: "Average overhead rate applied across cost centers. Benchmarks overhead burden — high rates signal inefficiency and erode project margins."
    - name: "cost_center_count"
      expr: COUNT(1)
      comment: "Total number of cost centers. Measures organizational cost structure complexity — used for governance and rationalization analysis."
    - name: "billable_cost_center_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable cost centers. Measures the proportion of the cost structure directly recoverable from clients."
    - name: "billable_cost_center_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_billable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cost centers classified as billable. Indicates the revenue-generating proportion of the organizational cost structure."
    - name: "total_billable_budget"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget allocated to billable cost centers. Represents the directly recoverable cost base — key for margin and recovery rate analysis."
    - name: "avg_budget_per_cost_center"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per cost center. Benchmarks cost center sizing and identifies outliers requiring governance review."
$$;