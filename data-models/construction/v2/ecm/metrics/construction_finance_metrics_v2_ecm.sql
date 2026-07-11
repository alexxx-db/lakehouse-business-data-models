-- Metric views for domain: finance | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_accounts_receivable_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice KPIs tracking outstanding balances, collection performance, dispute rates, and revenue recognition for construction project billing."
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., Open, Paid, Disputed, Written-Off) for pipeline segmentation."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Progress, Milestone, Final) to segment billing patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency receivables reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute, enabling dispute rate analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for trend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g., Net 30, Net 60) for DSO benchmarking."
  measures:
    - name: "total_gross_receivable"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed across all invoices. Core revenue pipeline indicator for CFO reporting."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts withheld by clients. Tracks cash tied up in retention pending project completion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed across invoices. Required for tax compliance reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing throughput analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. Drives dispute resolution prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_payment_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment application KPIs for progress billing, certification rates, retention management, and subcontractor payment performance in construction projects."
  source: "`vibe_construction_v1`.`finance`.`payment_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the payment application (e.g., Submitted, Certified, Paid) for pipeline tracking."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment application (e.g., Progress, Final, Milestone) for billing pattern analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency payment application reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the payment application is under dispute."
    - name: "lien_waiver_received"
      expr: lien_waiver_received
      comment: "Indicates whether a lien waiver has been received, critical for payment release compliance."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start month for trend analysis of payment application volumes."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of application submission for billing cycle analysis."
  measures:
    - name: "total_amount_claimed"
      expr: SUM(CAST(amount_claimed_current AS DOUBLE))
      comment: "Total amount claimed in current period across all payment applications. Measures billing throughput."
    - name: "total_amount_certified"
      expr: SUM(CAST(amount_certified_current AS DOUBLE))
      comment: "Total amount certified by the engineer/client. Measures approved billing value."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after deductions. Primary cash flow input for treasury forecasting."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_withheld_current AS DOUBLE))
      comment: "Total retention withheld in current period. Tracks cash tied up in retention."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_released_current AS DOUBLE))
      comment: "Total retention released in current period. Signals project completion milestones."
    - name: "total_liquidated_damages_deducted"
      expr: SUM(CAST(liquidated_damages_deducted AS DOUBLE))
      comment: "Total liquidated damages deducted from payment applications. Key schedule performance consequence metric."
    - name: "total_work_completed_to_date"
      expr: SUM(CAST(work_completed_to_date AS DOUBLE))
      comment: "Cumulative work completed value across all applications. Tracks overall project billing progress."
    - name: "total_back_charges_applied"
      expr: SUM(CAST(back_charges_applied AS DOUBLE))
      comment: "Total back charges applied against payment applications. Measures cost recovery from subcontractors."
    - name: "payment_application_count"
      expr: COUNT(1)
      comment: "Total number of payment applications submitted. Baseline billing activity volume metric."
    - name: "avg_percent_complete_certified"
      expr: AVG(CAST(percent_complete_certified AS DOUBLE))
      comment: "Average certified completion percentage across applications. Tracks project progress as recognized by client."
    - name: "avg_certification_gap_pct"
      expr: AVG(CAST(percent_complete_claimed AS DOUBLE) - CAST(percent_complete_certified AS DOUBLE))
      comment: "Average gap between claimed and certified completion percentage. Identifies systematic under-certification risk."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied. Benchmarks contractual retention terms across projects."
    - name: "disputed_application_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of payment applications under dispute. Drives dispute resolution prioritization."
    - name: "lien_waiver_pending_count"
      expr: COUNT(CASE WHEN lien_waiver_received = FALSE THEN 1 END)
      comment: "Number of applications where lien waiver has not been received. Compliance risk indicator for payment release."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial commitment (encumbrance) KPIs tracking committed costs, budget utilization, and vendor obligation management across construction projects."
  source: "`vibe_construction_v1`.`finance`.`commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of commitment (e.g., Purchase Order, Subcontract, Work Order) for cost category analysis."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (e.g., Active, Closed, Cancelled) for pipeline management."
    - name: "commitment_category"
      expr: commitment_category
      comment: "Business category of the commitment (e.g., Labor, Material, Equipment) for cost breakdown."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency commitment reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the commitment for annual budget control reporting."
    - name: "is_retention"
      expr: is_retention
      comment: "Indicates whether the commitment includes a retention component."
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document originating the commitment (e.g., PO, Contract) for audit traceability."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the commitment became effective for trend analysis."
  measures:
    - name: "total_amount_committed"
      expr: SUM(CAST(amount_committed AS DOUBLE))
      comment: "Total financial commitments (encumbrances) outstanding. Core budget control metric for project cost management."
    - name: "total_retention_percentage_avg"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across commitments. Benchmarks subcontractor retention terms."
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Total number of active commitments. Measures procurement and contracting activity volume."
    - name: "confidential_commitment_count"
      expr: COUNT(CASE WHEN is_confidential = TRUE THEN 1 END)
      comment: "Number of confidential commitments. Governance and access control indicator for sensitive contracts."
    - name: "avg_committed_amount"
      expr: AVG(CAST(amount_committed AS DOUBLE))
      comment: "Average commitment value. Identifies typical contract size for benchmarking and risk assessment."
    - name: "retention_commitment_count"
      expr: COUNT(CASE WHEN is_retention = TRUE THEN 1 END)
      comment: "Number of commitments with retention. Tracks retention exposure across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budget KPIs tracking budget utilization, variance, forecast accuracy, and cost control performance across construction projects."
  source: "`vibe_construction_v1`.`finance`.`project_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Original, Revised, Contingency) for budget version analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., Approved, Draft, Superseded) for active budget filtering."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency project portfolio reporting."
    - name: "is_baseline_budget"
      expr: is_baseline_budget
      comment: "Indicates whether this is the approved baseline budget for EVM and variance analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g., Client, JV, Internal) for funding mix analysis."
    - name: "budget_period_start_month"
      expr: DATE_TRUNC('MONTH', budget_period_start_date)
      comment: "Budget period start month for temporal budget analysis."
    - name: "budget_unit_of_measure"
      expr: budget_unit_of_measure
      comment: "Unit of measure for budgeted quantities (e.g., m3, tonnes, hours) for productivity analysis."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget. Baseline for all variance and change order impact analysis."
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget AS DOUBLE))
      comment: "Total current approved budget including all approved changes. Reflects live budget authority."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred against budget. Primary cost performance indicator."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs (encumbrances) against budget. Measures future cash obligations."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance (budget minus actual). Negative values signal cost overrun requiring management action."
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve_amount AS DOUBLE))
      comment: "Total contingency reserve available. Tracks risk buffer remaining for project cost management."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve held. Measures discretionary budget buffer at project level."
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Total forecast cost at completion. Key EAC input for project financial close-out planning."
    - name: "total_approved_change_order_amount"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Total approved change order value added to budget. Measures scope growth impact on project cost."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items. Measures budget granularity and WBS decomposition depth."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across budget lines. Benchmarks productivity assumptions in the budget."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity across all budget lines. Supports productivity and quantity variance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_earned_value_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) KPIs tracking schedule and cost performance indices, variance at completion, and forecast accuracy for construction project control."
  source: "`vibe_construction_v1`.`finance`.`earned_value_record`"
  dimensions:
    - name: "record_status"
      expr: record_status
      comment: "Status of the EVM record (e.g., Approved, Draft) for data quality filtering."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of EVM values for multi-currency project portfolio analysis."
    - name: "eac_calculation_method"
      expr: eac_calculation_method
      comment: "Method used to calculate EAC (e.g., CPI-based, Bottom-up) for forecast methodology analysis."
    - name: "forecast_confidence_level"
      expr: forecast_confidence_level
      comment: "Confidence level assigned to the EAC forecast for risk-adjusted reporting."
    - name: "data_date_month"
      expr: DATE_TRUNC('MONTH', data_date)
      comment: "Data date month for EVM trend analysis over time."
    - name: "reporting_period_end_month"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Reporting period end month for period-over-period EVM comparison."
  measures:
    - name: "total_budget_at_completion"
      expr: SUM(CAST(bac_budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion (BAC) across all WBS elements. Baseline for EVM variance calculations."
    - name: "total_earned_value"
      expr: SUM(CAST(bcwp_earned_value AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (BCWP/EV). Measures value of work actually accomplished."
    - name: "total_planned_value"
      expr: SUM(CAST(bcws_planned_value AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (BCWS/PV). Measures planned work value at data date."
    - name: "total_actual_cost"
      expr: SUM(CAST(acwp_actual_cost AS DOUBLE))
      comment: "Total Actual Cost of Work Performed (ACWP/AC). Measures actual spend against earned value."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total Cost Variance (EV - AC). Negative values indicate cost overrun requiring corrective action."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total Schedule Variance (EV - PV). Negative values indicate schedule slippage."
    - name: "total_eac"
      expr: SUM(CAST(eac_estimate_at_completion AS DOUBLE))
      comment: "Total Estimate at Completion (EAC). Primary project cost forecast for executive reporting."
    - name: "total_etc"
      expr: SUM(CAST(etc_estimate_to_complete AS DOUBLE))
      comment: "Total Estimate to Complete (ETC). Measures remaining cost to finish the project."
    - name: "total_vac"
      expr: SUM(CAST(vac_variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion (BAC - EAC). Negative values signal projected final cost overrun."
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average CPI (EV/AC) across WBS elements. CPI < 1.0 signals cost inefficiency requiring management intervention."
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average SPI (EV/PV) across WBS elements. SPI < 1.0 signals schedule underperformance."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi_to_complete_performance_index AS DOUBLE))
      comment: "Average To-Complete Performance Index. Values > 1.0 indicate increasingly difficult cost recovery targets."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across WBS elements. Overall project progress indicator."
    - name: "avg_percent_spent"
      expr: AVG(CAST(percent_spent AS DOUBLE))
      comment: "Average percent of budget spent. Compared against percent complete to identify cost efficiency gaps."
    - name: "evm_record_count"
      expr: COUNT(1)
      comment: "Total number of EVM records. Measures WBS coverage of earned value reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_retention_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention ledger KPIs tracking retention withheld, released, and outstanding balances across construction contracts and billing periods."
  source: "`vibe_construction_v1`.`finance`.`finance_retention_ledger`"
  dimensions:
    - name: "retention_type"
      expr: retention_type
      comment: "Type of retention (e.g., Performance, Defects Liability) for retention category analysis."
    - name: "retention_status"
      expr: retention_status
      comment: "Current status of the retention (e.g., Held, Released, Disputed) for cash flow planning."
    - name: "retention_release_type"
      expr: retention_release_type
      comment: "Type of retention release trigger (e.g., Practical Completion, DLP Expiry) for milestone tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of retention amounts for multi-currency reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual retention balance reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the retention is under dispute."
    - name: "retention_bond_indicator"
      expr: retention_bond_indicator
      comment: "Indicates whether a retention bond has been provided in lieu of cash retention."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of retention posting for trend analysis."
  measures:
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_withheld_amount AS DOUBLE))
      comment: "Total retention withheld from payments. Measures cash tied up in retention across all contracts."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total retention released to date. Tracks cash returned to subcontractors/clients upon milestone achievement."
    - name: "total_cumulative_retention_balance"
      expr: SUM(CAST(cumulative_retention_balance AS DOUBLE))
      comment: "Total cumulative retention balance outstanding. Primary retention exposure metric for treasury management."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Total gross invoice value against which retention is applied. Provides context for retention rate analysis."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied across ledger entries. Benchmarks contractual retention terms."
    - name: "retention_ledger_count"
      expr: COUNT(1)
      comment: "Total number of retention ledger entries. Measures retention transaction volume."
    - name: "disputed_retention_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of retention entries under dispute. Signals retention recovery risk."
    - name: "retention_bond_count"
      expr: COUNT(CASE WHEN retention_bond_indicator = TRUE THEN 1 END)
      comment: "Number of entries where retention bond is in place. Tracks non-cash retention arrangements."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecast KPIs tracking projected inflows, outflows, net cash position, working capital gaps, and peak funding requirements for construction project treasury management."
  source: "`vibe_construction_v1`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of cash flow forecast (e.g., Weekly, Monthly, Quarterly) for granularity analysis."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g., Draft, Approved, Superseded) for active forecast filtering."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Time granularity of the forecast (e.g., Weekly, Monthly) for reporting period alignment."
    - name: "currency_code"
      expr: currency_code
      comment: "Forecast currency for multi-currency treasury reporting."
    - name: "s_curve_profile_indicator"
      expr: s_curve_profile_indicator
      comment: "S-curve profile type for cash flow shape analysis and project phase identification."
    - name: "forecast_period_start_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Forecast period start month for temporal cash flow trend analysis."
    - name: "forecast_date_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month the forecast was prepared for version tracking and accuracy measurement."
  measures:
    - name: "total_forecasted_inflow"
      expr: SUM(CAST(forecasted_inflow_amount AS DOUBLE))
      comment: "Total projected cash inflows. Primary revenue collection forecast for treasury planning."
    - name: "total_forecasted_outflow"
      expr: SUM(CAST(forecasted_outflow_amount AS DOUBLE))
      comment: "Total projected cash outflows. Measures total payment obligations for liquidity management."
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow (inflows minus outflows). Core liquidity indicator for project finance decisions."
    - name: "total_working_capital_gap"
      expr: SUM(CAST(working_capital_gap AS DOUBLE))
      comment: "Total working capital gap across forecasts. Identifies financing needs for project execution."
    - name: "total_peak_funding_requirement"
      expr: SUM(CAST(peak_funding_requirement AS DOUBLE))
      comment: "Total peak funding requirement. Drives credit facility sizing and bonding capacity decisions."
    - name: "total_payroll_amount"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Total forecasted payroll outflows. Largest single cost category for workforce-intensive construction projects."
    - name: "total_subcontractor_payment_amount"
      expr: SUM(CAST(subcontractor_payment_amount AS DOUBLE))
      comment: "Total forecasted subcontractor payments. Tracks supply chain payment obligations."
    - name: "total_material_procurement_amount"
      expr: SUM(CAST(material_procurement_amount AS DOUBLE))
      comment: "Total forecasted material procurement spend. Supports procurement planning and cash flow timing."
    - name: "total_retention_release_amount"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total forecasted retention releases. Tracks expected cash inflows from retention recovery."
    - name: "avg_variance_to_prior_forecast"
      expr: AVG(CAST(variance_to_prior_forecast AS DOUBLE))
      comment: "Average variance between current and prior forecast versions. Measures forecast accuracy and stability."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from prior forecast. Signals forecast reliability for treasury decisions."
    - name: "avg_credit_facility_utilization"
      expr: AVG(CAST(credit_facility_utilization AS DOUBLE))
      comment: "Average credit facility utilization rate. Monitors proximity to credit limits for financial risk management."
    - name: "avg_bonding_capacity_utilization"
      expr: AVG(CAST(bonding_capacity_utilization AS DOUBLE))
      comment: "Average bonding capacity utilization. Tracks available bonding headroom for new project bids."
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Total number of cash flow forecast records. Measures forecasting activity and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_revenue_recognition_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition KPIs tracking recognized revenue, deferred revenue, gross profit, and completion percentage under IFRS 15 / ASC 606 for construction contracts."
  source: "`vibe_construction_v1`.`finance`.`revenue_recognition_entry`"
  dimensions:
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (e.g., Percentage of Completion, Completed Contract) for accounting policy analysis."
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Status of the recognition entry (e.g., Posted, Reversed, Pending) for period-end close management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue reporting and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly revenue reporting and period-end close analysis."
    - name: "contract_currency_code"
      expr: contract_currency_code
      comment: "Contract currency for multi-currency revenue reporting."
    - name: "prior_period_adjustment_flag"
      expr: prior_period_adjustment_flag
      comment: "Indicates prior period adjustments for audit and restatement tracking."
    - name: "recognition_date_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month of revenue recognition for trend analysis."
  measures:
    - name: "total_revenue_recognized_in_period"
      expr: SUM(CAST(revenue_recognized_in_period AS DOUBLE))
      comment: "Total revenue recognized in the current period. Primary top-line P&L metric for construction reporting."
    - name: "total_revenue_recognized_to_date"
      expr: SUM(CAST(revenue_recognized_to_date AS DOUBLE))
      comment: "Cumulative revenue recognized to date. Tracks total revenue earned against contract value."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all recognition entries. Measures total revenue backlog and pipeline."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue AS DOUBLE))
      comment: "Total deferred revenue (billed but not yet earned). Balance sheet liability indicator for financial reporting."
    - name: "total_unbilled_revenue"
      expr: SUM(CAST(unbilled_revenue AS DOUBLE))
      comment: "Total unbilled revenue (earned but not yet invoiced). Measures revenue recognition ahead of billing."
    - name: "total_gross_profit_to_date"
      expr: SUM(CAST(gross_profit_to_date AS DOUBLE))
      comment: "Total gross profit recognized to date. Core profitability metric for project portfolio management."
    - name: "total_estimated_gross_profit_at_completion"
      expr: SUM(CAST(estimated_gross_profit_at_completion AS DOUBLE))
      comment: "Total estimated gross profit at project completion. Forward-looking profitability indicator for executive review."
    - name: "total_loss_provision"
      expr: SUM(CAST(loss_provision AS DOUBLE))
      comment: "Total loss provisions on onerous contracts. Critical risk indicator requiring immediate management action."
    - name: "total_cumulative_costs_incurred"
      expr: SUM(CAST(cumulative_costs_incurred AS DOUBLE))
      comment: "Total cumulative costs incurred across contracts. Input for cost-to-cost percentage of completion calculation."
    - name: "total_estimated_total_costs"
      expr: SUM(CAST(estimated_total_costs AS DOUBLE))
      comment: "Total estimated costs at completion. Denominator for percentage of completion and EAC analysis."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across contracts. Portfolio-level progress indicator for executive reporting."
    - name: "avg_gross_profit_percentage"
      expr: AVG(CAST(gross_profit_percentage AS DOUBLE))
      comment: "Average gross profit margin percentage. Key profitability benchmark for project portfolio steering."
    - name: "total_change_order_value_included"
      expr: SUM(CAST(change_order_value_included AS DOUBLE))
      comment: "Total change order value included in recognized revenue. Measures scope growth impact on revenue."
    - name: "recognition_entry_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition entries. Measures period-end close activity volume."
    - name: "prior_period_adjustment_count"
      expr: COUNT(CASE WHEN prior_period_adjustment_flag = TRUE THEN 1 END)
      comment: "Number of prior period adjustments. Audit quality indicator — high counts signal revenue recognition issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice KPIs tracking payable volumes, approval cycle times, dispute rates, and three-way match compliance for construction procurement."
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (e.g., Pending, Approved, Paid, Disputed) for payables pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (e.g., Standard, Credit Note, Advance) for payables categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice for workflow bottleneck analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO/GR/Invoice) for procurement compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency payables reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the invoice is on payment hold."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual payables reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice receipt for payables trend analysis."
  measures:
    - name: "total_gross_payable"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices. Measures total vendor payment obligations."
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and retention. Actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on AP invoices. Required for VAT/GST compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization from prompt payment."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from vendor invoices. Tracks subcontractor retention obligations."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed. Baseline payables throughput metric."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed AP invoices. Signals vendor relationship issues and payment delays."
    - name: "held_invoice_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of invoices on payment hold. Identifies blocked payments requiring resolution."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average AP invoice value. Benchmarks typical vendor transaction size for process efficiency analysis."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied to vendor invoices. Benchmarks subcontractor retention terms."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_job_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job cost transaction KPIs tracking actual cost postings, cost category breakdown, billability, and cost recovery across construction project WBS elements."
  source: "`vibe_construction_v1`.`finance`.`job_cost_transaction`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category (e.g., Labor, Material, Equipment, Subcontract) for cost breakdown analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the cost transaction (e.g., Posted, Reversed, Pending) for data quality filtering."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transaction for workflow compliance monitoring."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the cost is billable to the client. Drives revenue recovery analysis."
    - name: "billed_flag"
      expr: billed_flag
      comment: "Indicates whether the cost has been billed. Identifies unbilled cost exposure."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the transaction is a reversal. Monitors correction activity volume."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency cost reporting."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of cost posting for trend analysis and period-end cost reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based cost analysis (e.g., hours, m3, tonnes)."
  measures:
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total job cost posted across all transactions. Primary actual cost metric for project cost control."
    - name: "total_base_currency_cost"
      expr: SUM(CAST(base_currency_cost AS DOUBLE))
      comment: "Total cost in base/functional currency. Enables consistent cross-project cost comparison."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of resources consumed. Supports productivity and unit rate analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across transactions. Benchmarks resource productivity and cost efficiency."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost transactions. Measures cost posting activity volume."
    - name: "billable_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN total_cost ELSE 0 END)
      comment: "Total billable cost. Measures revenue-recoverable cost for billing and margin analysis."
    - name: "unbilled_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE AND billed_flag = FALSE THEN total_cost ELSE 0 END)
      comment: "Total billable but not yet billed cost. Identifies revenue recognition lag and unbilled exposure."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversal transactions. High reversal rates signal data quality or approval process issues."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to transactions. Monitors FX exposure in multi-currency projects."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_payment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment record KPIs tracking actual cash disbursements, payment performance, withholding tax, and bank reconciliation status for construction project treasury."
  source: "`vibe_construction_v1`.`finance`.`payment_record`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Cleared, Pending, Rejected) for cash management."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., Regular, Advance, Retention Release) for payment category analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., EFT, Cheque, SWIFT) for payment channel analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel (e.g., Online Banking, Manual) for process efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cash management reporting."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Bank clearing status for reconciliation monitoring."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for bank statement matching compliance."
    - name: "advance_payment_flag"
      expr: advance_payment_flag
      comment: "Indicates advance payments for working capital and cash flow analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash disbursement trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash disbursed. Primary cash outflow metric for treasury and liquidity management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after discounts and charges. Actual cash outflow for bank reconciliation."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payments in functional currency. Enables consistent cross-currency cash flow reporting."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments. Required for tax compliance and vendor reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization from prompt payment."
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred. Monitors transaction cost efficiency across payment channels."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention deducted from payments. Tracks retention cash flow impact."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment records. Baseline payment throughput metric."
    - name: "advance_payment_count"
      expr: COUNT(CASE WHEN advance_payment_flag = TRUE THEN 1 END)
      comment: "Number of advance payments made. Tracks working capital deployed as advances to vendors."
    - name: "partial_payment_count"
      expr: COUNT(CASE WHEN partial_payment_flag = TRUE THEN 1 END)
      comment: "Number of partial payments. Identifies payment disputes or cash flow constraints."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to payments. Monitors FX cost in multi-currency payment runs."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_budget_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget revision KPIs tracking scope of budget changes, cost category revisions, change order impacts, and approval cycle performance for construction project cost control."
  source: "`vibe_construction_v1`.`finance`.`finance_budget_revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Status of the budget revision (e.g., Approved, Pending, Rejected) for approval pipeline management."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of budget revision (e.g., Scope Change, Contingency Draw, Error Correction) for root cause analysis."
    - name: "revision_reason_code"
      expr: revision_reason_code
      comment: "Reason code for the revision for trend analysis of budget change drivers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revision for multi-currency budget reporting."
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Indicates whether client approval is required for the revision. Tracks contractual change control compliance."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month of revision approval for trend analysis of budget change frequency."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required to approve the revision for delegation of authority compliance."
  measures:
    - name: "total_revision_amount"
      expr: SUM(CAST(revision_amount AS DOUBLE))
      comment: "Total budget revision amount. Measures cumulative scope and cost growth across the project."
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original budget before revisions. Baseline for measuring budget growth."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget after all approved changes. Current budget authority for cost control."
    - name: "total_labor_cost_revision"
      expr: SUM(CAST(labor_cost_revision AS DOUBLE))
      comment: "Total labor cost revisions. Identifies workforce cost growth as a driver of budget overruns."
    - name: "total_material_cost_revision"
      expr: SUM(CAST(material_cost_revision AS DOUBLE))
      comment: "Total material cost revisions. Tracks material price escalation impact on project budget."
    - name: "total_subcontractor_cost_revision"
      expr: SUM(CAST(subcontractor_cost_revision AS DOUBLE))
      comment: "Total subcontractor cost revisions. Measures supply chain cost growth impact."
    - name: "total_equipment_cost_revision"
      expr: SUM(CAST(equipment_cost_revision AS DOUBLE))
      comment: "Total equipment cost revisions. Tracks plant and equipment cost growth."
    - name: "total_contingency_revision"
      expr: SUM(CAST(contingency_revision AS DOUBLE))
      comment: "Total contingency draw-downs or additions. Monitors risk reserve consumption rate."
    - name: "total_impact_on_contract_value"
      expr: SUM(CAST(impact_on_contract_value AS DOUBLE))
      comment: "Total impact of revisions on contract value. Measures revenue-side implications of budget changes."
    - name: "budget_revision_count"
      expr: COUNT(1)
      comment: "Total number of budget revisions. High frequency signals poor initial estimating or scope instability."
    - name: "client_approval_required_count"
      expr: COUNT(CASE WHEN client_approval_required = TRUE THEN 1 END)
      comment: "Number of revisions requiring client approval. Tracks contractual change control workload."
    - name: "avg_evm_cpi_impact"
      expr: AVG(CAST(evm_cpi_impact AS DOUBLE))
      comment: "Average CPI impact of budget revisions. Measures how budget changes affect cost performance indices."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_progress_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Progress billing KPIs tracking billing completeness, payment performance, retention management, and outstanding balances for construction contract administration."
  source: "`vibe_construction_v1`.`finance`.`progress_billing`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (e.g., Submitted, Certified, Paid, Overdue) for billing pipeline management."
    - name: "payment_certificate_type"
      expr: payment_certificate_type
      comment: "Type of payment certificate (e.g., Interim, Final, Milestone) for billing category analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for multi-currency contract reporting."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification for overdue billing analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start month for trend analysis of billing activity."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date month for billing cycle analysis."
  measures:
    - name: "total_current_period_claim"
      expr: SUM(CAST(current_period_claim AS DOUBLE))
      comment: "Total amount claimed in the current billing period. Measures billing throughput for the period."
    - name: "total_work_completed_to_date"
      expr: SUM(CAST(work_completed_to_date AS DOUBLE))
      comment: "Cumulative work completed value billed to date. Tracks overall project billing progress."
    - name: "total_gross_amount_due"
      expr: SUM(CAST(gross_amount_due AS DOUBLE))
      comment: "Total gross amount due before deductions. Measures total billing value."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after retention and deductions. Actual cash receivable from client."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding unpaid balance. Primary receivables exposure metric."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from progress billings. Tracks cash tied up in retention."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash received against progress billings. Measures collection effectiveness."
    - name: "total_materials_stored_on_site"
      expr: SUM(CAST(materials_stored_on_site AS DOUBLE))
      comment: "Total value of materials stored on site included in billing. Tracks material-at-risk exposure."
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average project completion percentage across billing records. Portfolio progress indicator."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied. Benchmarks contractual retention terms."
    - name: "billing_record_count"
      expr: COUNT(1)
      comment: "Total number of progress billing records. Measures billing activity volume."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_financial_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial guarantee KPIs tracking bond/guarantee exposure, premium costs, compliance status, and bonding capacity utilization for construction contract risk management."
  source: "`vibe_construction_v1`.`finance`.`financial_guarantee`"
  dimensions:
    - name: "guarantee_type"
      expr: guarantee_type
      comment: "Type of guarantee (e.g., Performance Bond, Advance Payment Bond, Retention Bond) for risk category analysis."
    - name: "guarantee_status"
      expr: guarantee_status
      comment: "Current status of the guarantee (e.g., Active, Expired, Called) for exposure management."
    - name: "issuer_type"
      expr: issuer_type
      comment: "Type of guarantee issuer (e.g., Bank, Insurance Company) for counterparty risk analysis."
    - name: "beneficiary_type"
      expr: beneficiary_type
      comment: "Type of beneficiary (e.g., Client, Employer, Government) for guarantee obligation categorization."
    - name: "call_type"
      expr: call_type
      comment: "Type of guarantee call (e.g., On-Demand, Conditional) for risk exposure assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Guarantee currency for multi-currency exposure reporting."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the guarantee is compliant with contractual requirements."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of guarantee issuance for trend analysis."
  measures:
    - name: "total_face_value"
      expr: SUM(CAST(face_value_amount AS DOUBLE))
      comment: "Total face value of all financial guarantees. Primary bonding exposure metric for risk management."
    - name: "total_risk_exposure"
      expr: SUM(CAST(risk_exposure_amount AS DOUBLE))
      comment: "Total risk exposure from guarantees. Measures maximum potential liability from guarantee calls."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium paid for guarantees. Measures cost of bonding as a project overhead component."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total amount claimed against guarantees. Critical risk indicator — guarantee calls signal project distress."
    - name: "total_bonding_capacity_impact"
      expr: SUM(CAST(bonding_capacity_impact_amount AS DOUBLE))
      comment: "Total bonding capacity consumed by active guarantees. Monitors headroom for new project bids."
    - name: "guarantee_count"
      expr: COUNT(1)
      comment: "Total number of financial guarantees. Measures bonding portfolio size."
    - name: "non_compliant_guarantee_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of non-compliant guarantees. Signals contractual default risk requiring immediate action."
    - name: "avg_premium_rate"
      expr: AVG(CAST(premium_rate_percent AS DOUBLE))
      comment: "Average premium rate across guarantees. Benchmarks bonding cost efficiency."
    - name: "collateral_required_count"
      expr: COUNT(CASE WHEN collateral_required_flag = TRUE THEN 1 END)
      comment: "Number of guarantees requiring collateral. Measures cash collateral tied up in bonding arrangements."
$$;