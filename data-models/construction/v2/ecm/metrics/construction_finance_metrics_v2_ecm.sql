-- Metric views for domain: finance | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecast metrics — tracks projected inflows, outflows, net cash position, working capital gaps, and peak funding requirements to support treasury management and project financing decisions."
  source: "`vibe_construction_v1`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for cash flow analysis."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of cash flow forecast (e.g., base case, optimistic, pessimistic) for scenario analysis."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g., approved, draft, superseded) for filtering active forecasts."
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Time granularity of the forecast (e.g., weekly, monthly, quarterly) for planning horizon analysis."
    - name: "forecast_period_start_date"
      expr: forecast_period_start_date
      comment: "Start of the forecast period for time-series cash flow trending."
    - name: "forecast_period_end_date"
      expr: forecast_period_end_date
      comment: "End of the forecast period for time-series cash flow trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of forecast amounts for multi-currency treasury analysis."
    - name: "s_curve_profile_indicator"
      expr: s_curve_profile_indicator
      comment: "S-curve profile indicator — used to classify cash flow shape for project lifecycle analysis."
  measures:
    - name: "total_forecasted_inflow"
      expr: SUM(CAST(forecasted_inflow_amount AS DOUBLE))
      comment: "Sum of forecasted cash inflows — total expected receipts from clients and other sources."
    - name: "total_forecasted_outflow"
      expr: SUM(CAST(forecasted_outflow_amount AS DOUBLE))
      comment: "Sum of forecasted cash outflows — total expected payments to vendors, labor, and subcontractors."
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Sum of net cash flow (inflows minus outflows) — primary treasury metric for liquidity management."
    - name: "total_working_capital_gap"
      expr: SUM(CAST(working_capital_gap AS DOUBLE))
      comment: "Sum of working capital gaps — measures funding shortfalls requiring financing or credit facility drawdown."
    - name: "total_peak_funding_requirement"
      expr: SUM(CAST(peak_funding_requirement AS DOUBLE))
      comment: "Sum of peak funding requirements — used to size credit facilities and bonding capacity."
    - name: "total_subcontractor_payment_outflow"
      expr: SUM(CAST(subcontractor_payment_amount AS DOUBLE))
      comment: "Sum of forecasted subcontractor payment outflows — largest single cash outflow category on most projects."
    - name: "total_payroll_outflow"
      expr: SUM(CAST(payroll_amount AS DOUBLE))
      comment: "Sum of forecasted payroll outflows — tracks labor cash commitment for workforce planning."
    - name: "total_material_procurement_outflow"
      expr: SUM(CAST(material_procurement_amount AS DOUBLE))
      comment: "Sum of forecasted material procurement outflows — tracks supply chain cash commitment."
    - name: "total_retention_release_inflow"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Sum of forecasted retention release inflows — tracks deferred cash expected from client retention releases."
    - name: "avg_variance_to_prior_forecast"
      expr: AVG(CAST(variance_to_prior_forecast AS DOUBLE))
      comment: "Average variance between current and prior forecast — measures forecast accuracy and revision frequency."
    - name: "avg_credit_facility_utilization_pct"
      expr: AVG(CAST(credit_facility_utilization AS DOUBLE))
      comment: "Average credit facility utilization percentage — measures financing headroom and liquidity risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commitment metrics — tracks committed costs by type, vendor, and project to manage cost exposure, budget consumption, and procurement liability before invoices are received."
  source: "`vibe_construction_v1`.`finance`.`commitment`"
  dimensions:
    - name: "project_id"
      expr: project_id
      comment: "Foreign key to the construction project — primary grouping for commitment analysis."
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of commitment (e.g., purchase order, subcontract, rental) for cost category analysis."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (e.g., active, closed, cancelled) for filtering live commitments."
    - name: "commitment_category"
      expr: commitment_category
      comment: "High-level category of the commitment for cost breakdown analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the commitment for annual cost exposure reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Commitment currency for multi-currency cost exposure analysis."
    - name: "is_retention"
      expr: is_retention
      comment: "Indicates whether the commitment includes retention — used to track retention liability."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the commitment for organizational cost allocation."
  measures:
    - name: "total_amount_committed"
      expr: SUM(CAST(amount_committed AS DOUBLE))
      comment: "Sum of committed amounts — total cost exposure from active commitments before invoicing."
    - name: "total_retention_percentage_avg"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across commitments — measures retention policy application consistency."
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Count of commitment records — measures procurement activity volume and contract management workload."
    - name: "active_commitment_total"
      expr: SUM(CASE WHEN commitment_status = 'ACTIVE' THEN amount_committed ELSE 0 END)
      comment: "Sum of active commitment amounts — measures live cost exposure requiring cash outflow management."
    - name: "cancelled_commitment_total"
      expr: SUM(CASE WHEN commitment_status = 'CANCELLED' THEN amount_committed ELSE 0 END)
      comment: "Sum of cancelled commitment amounts — measures scope reduction and procurement savings from cancellations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_earned_value_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) performance metrics — tracks CPI, SPI, cost variance, schedule variance, and forecast accuracy to give executives a real-time view of project cost and schedule health."
  source: "`vibe_construction_v1`.`finance`.`earned_value_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for EVM analysis."
    - name: "data_date"
      expr: data_date
      comment: "The status date of the EVM record — used for time-series trending of performance indices."
    - name: "record_status"
      expr: record_status
      comment: "Lifecycle status of the EVM record (e.g., approved, draft) for filtering active records."
    - name: "eac_calculation_method"
      expr: eac_calculation_method
      comment: "Method used to calculate EAC (e.g., CPI-based, ETC-based) — affects forecast interpretation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of EVM monetary values."
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start of the reporting period for period-over-period EVM trending."
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End of the reporting period for period-over-period EVM trending."
    - name: "forecast_confidence_level"
      expr: forecast_confidence_level
      comment: "Confidence level assigned to the EAC forecast — used to risk-weight financial outlooks."
  measures:
    - name: "total_budget_at_completion"
      expr: SUM(CAST(bac_budget_at_completion AS DOUBLE))
      comment: "Sum of BAC across all WBS elements — total authorized budget for the project scope."
    - name: "total_earned_value"
      expr: SUM(CAST(bcwp_earned_value AS DOUBLE))
      comment: "Sum of BCWP (Earned Value) — measures the budgeted value of work actually performed."
    - name: "total_planned_value"
      expr: SUM(CAST(bcws_planned_value AS DOUBLE))
      comment: "Sum of BCWS (Planned Value) — measures the budgeted value of work scheduled to be done."
    - name: "total_actual_cost"
      expr: SUM(CAST(acwp_actual_cost AS DOUBLE))
      comment: "Sum of ACWP (Actual Cost of Work Performed) — total spend incurred for completed work."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Sum of cost variance (EV minus AC) — negative values indicate cost overrun."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Sum of schedule variance (EV minus PV) — negative values indicate schedule slippage."
    - name: "total_estimate_at_completion"
      expr: SUM(CAST(eac_estimate_at_completion AS DOUBLE))
      comment: "Sum of EAC — the current best estimate of total project cost at completion."
    - name: "total_estimate_to_complete"
      expr: SUM(CAST(etc_estimate_to_complete AS DOUBLE))
      comment: "Sum of ETC — remaining cost needed to complete the project scope."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(vac_variance_at_completion AS DOUBLE))
      comment: "Sum of VAC (BAC minus EAC) — negative values signal projected cost overrun at completion."
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average CPI across records — CPI below 1.0 signals cost inefficiency; used in executive dashboards."
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average SPI across records — SPI below 1.0 signals schedule slippage; key steering metric."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete — measures overall project progress against plan."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi_to_complete_performance_index AS DOUBLE))
      comment: "Average TCPI — values above 1.0 indicate the remaining work must be done more efficiently than historical performance, signaling recovery risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_budget_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget revision metrics — tracks the frequency, magnitude, and drivers of budget changes to assess project cost control discipline and change order impact on financial performance."
  source: "`vibe_construction_v1`.`finance`.`finance_budget_revision`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for budget revision analysis."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of budget revision (e.g., change order, scope change, contingency draw) for root cause analysis."
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the revision (e.g., approved, pending, rejected) for filtering approved changes."
    - name: "revision_reason_code"
      expr: revision_reason_code
      comment: "Coded reason for the budget revision — used to identify systemic cost drivers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revision amounts for multi-currency project analysis."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the revision became effective — used for time-series budget change trending."
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Indicates whether client approval was required — used to track contractual change management compliance."
  measures:
    - name: "total_revision_amount"
      expr: SUM(CAST(revision_amount AS DOUBLE))
      comment: "Sum of budget revision amounts — total budget growth from all approved changes."
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Sum of original budget amounts at time of revision — baseline for measuring revision magnitude."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Sum of revised budget amounts — post-revision budget authority."
    - name: "total_labor_cost_revision"
      expr: SUM(CAST(labor_cost_revision AS DOUBLE))
      comment: "Sum of labor cost revisions — measures labor cost growth from scope changes and productivity variances."
    - name: "total_material_cost_revision"
      expr: SUM(CAST(material_cost_revision AS DOUBLE))
      comment: "Sum of material cost revisions — measures material cost growth from price escalation and scope changes."
    - name: "total_subcontractor_cost_revision"
      expr: SUM(CAST(subcontractor_cost_revision AS DOUBLE))
      comment: "Sum of subcontractor cost revisions — measures subcontract cost growth from change orders."
    - name: "total_contingency_revision"
      expr: SUM(CAST(contingency_revision AS DOUBLE))
      comment: "Sum of contingency revisions — tracks contingency consumption and replenishment over project life."
    - name: "revision_count"
      expr: COUNT(1)
      comment: "Count of budget revisions — measures change management frequency and project cost control discipline."
    - name: "avg_revision_magnitude_pct"
      expr: AVG(ROUND(100.0 * revision_amount / NULLIF(original_budget_amount, 0), 2))
      comment: "Average revision magnitude as a percentage of original budget — measures typical budget change size for benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_retention_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention ledger metrics — tracks retention withheld, released, and outstanding balances across projects and contracts to manage deferred cash and DLP obligations."
  source: "`vibe_construction_v1`.`finance`.`finance_retention_ledger`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for retention analysis."
    - name: "retention_type"
      expr: retention_type
      comment: "Type of retention (e.g., performance, defects liability) for retention category analysis."
    - name: "retention_status"
      expr: retention_status
      comment: "Current status of the retention balance (e.g., held, partially released, fully released)."
    - name: "retention_release_type"
      expr: retention_release_type
      comment: "Type of retention release (e.g., practical completion, DLP expiry) for release trigger analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the retention is under dispute — used to isolate at-risk retention balances."
    - name: "retention_bond_indicator"
      expr: retention_bond_indicator
      comment: "Indicates whether a retention bond has been substituted for cash retention — affects cash flow."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the retention transaction for annual retention reporting."
    - name: "posting_date"
      expr: posting_date
      comment: "GL posting date of the retention transaction for period-over-period trending."
  measures:
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_withheld_amount AS DOUBLE))
      comment: "Sum of retention amounts withheld — total deferred cash held from client payments."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Sum of retention amounts released — measures cash returned to contractors upon milestone achievement."
    - name: "total_cumulative_retention_balance"
      expr: SUM(CAST(cumulative_retention_balance AS DOUBLE))
      comment: "Sum of cumulative retention balances — total outstanding retention liability on the balance sheet."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts associated with retention transactions — provides billing context for retention rates."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across ledger entries — measures retention rate policy application."
    - name: "disputed_retention_total"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN cumulative_retention_balance ELSE 0 END)
      comment: "Sum of retention balances under dispute — measures at-risk retention requiring resolution."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_financial_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial guarantee and bond metrics — tracks face value, premium costs, claim exposure, and bonding capacity utilization to manage contingent liabilities and surety risk."
  source: "`vibe_construction_v1`.`finance`.`financial_guarantee`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for guarantee exposure analysis."
    - name: "guarantee_type"
      expr: guarantee_type
      comment: "Type of financial guarantee (e.g., performance bond, advance payment guarantee, retention bond) for liability categorization."
    - name: "guarantee_status"
      expr: guarantee_status
      comment: "Current status of the guarantee (e.g., active, expired, called, released) for filtering live exposures."
    - name: "issuer_type"
      expr: issuer_type
      comment: "Type of guarantee issuer (e.g., bank, surety, insurance company) for counterparty risk analysis."
    - name: "beneficiary_type"
      expr: beneficiary_type
      comment: "Type of beneficiary (e.g., client, government, lender) for guarantee obligation analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the guarantee is compliant with contractual requirements — used for compliance monitoring."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the guarantee became effective — used for guarantee lifecycle tracking."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the guarantee — used to identify guarantees requiring renewal or release."
  measures:
    - name: "total_face_value"
      expr: SUM(CAST(face_value_amount AS DOUBLE))
      comment: "Sum of guarantee face values — total contingent liability exposure from financial guarantees."
    - name: "total_risk_exposure"
      expr: SUM(CAST(risk_exposure_amount AS DOUBLE))
      comment: "Sum of risk exposure amounts — measures the financial risk if guarantees are called."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Sum of guarantee premium amounts — total cost of maintaining financial guarantees."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Sum of amounts claimed against guarantees — measures realized guarantee losses."
    - name: "total_bonding_capacity_impact"
      expr: SUM(CAST(bonding_capacity_impact_amount AS DOUBLE))
      comment: "Sum of bonding capacity impact amounts — measures how guarantees consume available bonding capacity."
    - name: "guarantee_count"
      expr: COUNT(1)
      comment: "Count of financial guarantees — measures guarantee portfolio size and administrative workload."
    - name: "avg_premium_rate_pct"
      expr: AVG(CAST(premium_rate_percent AS DOUBLE))
      comment: "Average premium rate percentage — measures cost of guarantee financing relative to face value."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_accounts_receivable_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics — tracks outstanding receivables, collection performance, dispute exposure, and retention to manage client credit risk and cash flow."
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for AR analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., open, paid, disputed, written-off) for AR aging analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., progress, milestone, final) for revenue category analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute — used to isolate disputed AR exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AR analysis."
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued — used for time-series AR trending."
    - name: "due_date"
      expr: due_date
      comment: "Invoice due date — used for overdue analysis and payment terms compliance."
  measures:
    - name: "total_gross_invoiced"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts — total revenue billed to clients."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Sum of retention amounts withheld by clients — tracks deferred cash tied up in retention."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts on invoices — required for tax reporting and compliance."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute — measures billing quality and client relationship health."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics — tracks vendor invoice volumes, amounts, approval cycle times, dispute rates, and payment status to manage payables efficiency and vendor relationships."
  source: "`vibe_construction_v1`.`finance`.`invoice`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for AP analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the vendor invoice (e.g., approved, pending, disputed, paid) for AP aging analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of vendor invoice (e.g., standard, credit note, advance) for payables category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — used to identify invoices pending approval and at risk of late payment."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute — used to isolate disputed payables."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the invoice is on payment hold — used to manage cash flow timing."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/invoice three-way match — measures procurement compliance and invoice quality."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for annual AP reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for monthly AP reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., EFT, cheque, wire) for payment channel analysis."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross vendor invoice amounts — total payables liability incurred."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Sum of net payable amounts after discounts and retention — actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts on vendor invoices — required for tax compliance and reporting."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Sum of retention withheld from vendor invoices — tracks subcontractor retention liability."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of early payment discounts captured — measures procurement savings from payment terms optimization."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Count of vendor invoices — measures AP transaction volume and processing workload."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Count of disputed invoices — measures vendor invoice quality and dispute resolution workload."
    - name: "three_way_match_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status = 'MATCHED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices passing three-way match — measures procurement compliance and invoice processing efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_job_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job cost transaction metrics — tracks actual cost incurred by category, project, and period to support cost control, variance analysis, and billing decisions."
  source: "`vibe_construction_v1`.`finance`.`job_cost_transaction`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary cost grouping dimension."
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g., labor, material, equipment, subcontract) for cost breakdown analysis."
    - name: "cost_code"
      expr: cost_code
      comment: "WBS-aligned cost code for granular cost tracking and budget comparison."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the cost transaction (e.g., posted, reversed, pending) for filtering valid actuals."
    - name: "posting_date"
      expr: posting_date
      comment: "GL posting date — used for period-over-period cost trending."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction for financial reporting alignment."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the cost is billable to the client — used to separate recoverable vs. non-recoverable costs."
    - name: "billed_flag"
      expr: billed_flag
      comment: "Indicates whether the cost has already been billed — used to track unbilled cost exposure."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed transactions — used to exclude corrections from actuals reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency project cost analysis."
  measures:
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Sum of total job cost transactions — primary actual cost metric for project cost control."
    - name: "total_base_currency_cost"
      expr: SUM(CAST(base_currency_cost AS DOUBLE))
      comment: "Sum of costs in base (functional) currency — used for consolidated financial reporting across multi-currency projects."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Sum of quantities transacted — used to compute unit cost rates and productivity benchmarks."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per transaction — used to benchmark against standard rates and identify cost anomalies."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Count of job cost transactions — used to assess transaction volume and identify periods of high cost activity."
    - name: "billable_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN total_cost ELSE 0 END)
      comment: "Sum of billable costs — measures recoverable cost exposure and supports progress billing calculations."
    - name: "unbilled_cost_total"
      expr: SUM(CASE WHEN billable_flag = TRUE AND billed_flag = FALSE THEN total_cost ELSE 0 END)
      comment: "Sum of billable but not yet billed costs — tracks revenue leakage risk and billing backlog."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics — tracks posting volumes, debit/credit balances, intercompany activity, and revenue recognition entries to support financial close quality and audit readiness."
  source: "`vibe_construction_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for project-level GL analysis."
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the journal entry (e.g., posted, reversed, draft) for filtering valid GL entries."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., vendor invoice, customer invoice, manual entry) for GL analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for annual financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry for monthly financial close analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates intercompany transactions — used to identify and eliminate intercompany balances in consolidation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates reversed entries — used to exclude reversals from net balance calculations."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied on the entry — used for POC vs. completed contract analysis."
    - name: "posting_date"
      expr: posting_date
      comment: "GL posting date — used for period-over-period financial trending."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Sum of debit amounts posted — measures total debit activity in the GL for the period."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Sum of credit amounts posted — measures total credit activity in the GL for the period."
    - name: "total_local_currency_debit"
      expr: SUM(CAST(local_currency_debit_amount AS DOUBLE))
      comment: "Sum of debit amounts in local currency — used for statutory reporting in local GAAP."
    - name: "total_local_currency_credit"
      expr: SUM(CAST(local_currency_credit_amount AS DOUBLE))
      comment: "Sum of credit amounts in local currency — used for statutory reporting in local GAAP."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Count of journal entries — measures GL posting volume and financial close workload."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of reversed journal entries — measures error correction frequency and GL quality."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Count of intercompany journal entries — measures intercompany transaction volume requiring elimination in consolidation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_payment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment execution metrics — tracks payment amounts, timing, advance payments, and reconciliation status to manage cash outflow, vendor payment compliance, and working capital."
  source: "`vibe_construction_v1`.`finance`.`payment_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for payment analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., cleared, pending, rejected) for cash management."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., progress, advance, retention release, final) for cash flow categorization."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., EFT, wire, cheque) for payment channel analysis."
    - name: "payment_date"
      expr: payment_date
      comment: "Date payment was executed — used for cash flow timing analysis."
    - name: "advance_payment_flag"
      expr: advance_payment_flag
      comment: "Indicates advance payments — used to track advance payment exposure and recovery."
    - name: "partial_payment_flag"
      expr: partial_payment_flag
      comment: "Indicates partial payments — used to identify underpayment patterns."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status — used to identify unreconciled payments and cash book discrepancies."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cash flow analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Sum of all payment amounts — total cash outflow for the period."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Sum of net payment amounts after deductions — actual cash disbursed to vendors."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Sum of payments in functional currency — used for consolidated cash flow reporting."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Sum of retention amounts released in payments — tracks retention cash outflow timing."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Sum of withholding tax deducted from payments — required for tax compliance reporting."
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Sum of bank charges incurred on payments — measures transaction cost of payment processing."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of early payment discounts captured — measures savings from proactive payment management."
    - name: "advance_payment_total"
      expr: SUM(CASE WHEN advance_payment_flag = TRUE THEN payment_amount ELSE 0 END)
      comment: "Sum of advance payments made — tracks advance payment exposure requiring recovery through future invoices."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Count of payment transactions — measures payment processing volume and operational workload."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance metrics — tracks revenue, EBIT, EBITDA, gross margin, and budget utilization at the profit center level to support divisional P&L management and capital allocation decisions."
  source: "`vibe_construction_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (e.g., project, division, region) for organizational P&L segmentation."
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Category of the profit center for financial reporting hierarchy analysis."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Current status of the profit center (e.g., active, closed) for filtering active entities."
    - name: "region"
      expr: region
      comment: "Geographic region of the profit center — used for regional P&L analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency of the profit center for multi-currency P&L analysis."
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Indicates whether the profit center is included in group consolidation."
    - name: "financial_reporting_standard"
      expr: financial_reporting_standard
      comment: "Accounting standard applied (e.g., IFRS, US GAAP) for compliance reporting."
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Sum of revenue across profit centers — top-line financial performance metric."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Sum of cost of goods sold — measures direct cost of revenue for gross margin analysis."
    - name: "total_ebit"
      expr: SUM(CAST(ebit AS DOUBLE))
      comment: "Sum of EBIT (Earnings Before Interest and Tax) — primary operating profitability metric."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda AS DOUBLE))
      comment: "Sum of EBITDA — measures operating cash generation before financing and non-cash charges."
    - name: "total_actual_profit"
      expr: SUM(CAST(actual_profit AS DOUBLE))
      comment: "Sum of actual profit — bottom-line profitability metric for profit center performance evaluation."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Sum of budgeted amounts — baseline for profit center budget vs. actual variance analysis."
    - name: "avg_profit_margin_pct"
      expr: AVG(CAST(profit_margin_percent AS DOUBLE))
      comment: "Average profit margin percentage across profit centers — measures overall portfolio profitability."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across profit centers — used for tax planning and after-tax return analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_progress_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Progress billing metrics — tracks amounts billed, received, outstanding, and retention across billing periods to manage cash flow and client payment performance."
  source: "`vibe_construction_v1`.`finance`.`progress_billing`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for billing analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the billing record (e.g., paid, outstanding, disputed)."
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start of the billing period for time-series revenue and cash flow trending."
    - name: "billing_period_end_date"
      expr: billing_period_end_date
      comment: "End of the billing period for time-series revenue and cash flow trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of billing amounts for multi-currency project analysis."
    - name: "payment_certificate_type"
      expr: payment_certificate_type
      comment: "Type of payment certificate (e.g., interim, final, milestone) for billing category analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of outstanding balances (e.g., 0-30, 31-60, 61-90 days) for receivables management."
  measures:
    - name: "total_gross_amount_due"
      expr: SUM(CAST(gross_amount_due AS DOUBLE))
      comment: "Sum of gross amounts due across all billing records — total revenue claimed from clients."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Sum of net amounts due after retention and deductions — actual cash expected from clients."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Sum of amounts actually received from clients — measures cash collection performance."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Sum of outstanding receivable balances — key metric for working capital and cash flow management."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Sum of retention withheld by clients — tracks deferred cash tied up in retention."
    - name: "total_current_period_claim"
      expr: SUM(CAST(current_period_claim AS DOUBLE))
      comment: "Sum of current period billing claims — measures revenue generation velocity in the period."
    - name: "total_work_completed_to_date"
      expr: SUM(CAST(work_completed_to_date AS DOUBLE))
      comment: "Sum of cumulative work completed to date — tracks earned revenue against contract value."
    - name: "total_materials_stored_on_site"
      expr: SUM(CAST(materials_stored_on_site AS DOUBLE))
      comment: "Sum of materials stored on site included in billing — tracks stored material billing exposure."
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average percentage complete across billing records — measures overall project progress for revenue recognition."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amounts collected — measures client payment compliance and cash collection efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budget health metrics for construction projects — tracks original vs. current approved budget, variance, contingency consumption, and forecast-at-completion to steer cost control decisions."
  source: "`vibe_construction_v1`.`finance`.`project_budget`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for budget analysis."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., original, revised, supplemental) for segmenting budget views."
    - name: "budget_status"
      expr: budget_status
      comment: "Current lifecycle status of the budget record (e.g., approved, draft, closed)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which budget amounts are denominated."
    - name: "is_baseline_budget"
      expr: is_baseline_budget
      comment: "Flag indicating whether this record represents the approved baseline budget."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g., equity, debt, client advance) for financial planning."
    - name: "budget_period_start_date"
      expr: budget_period_start_date
      comment: "Start of the budget period for time-series trending."
    - name: "budget_period_end_date"
      expr: budget_period_end_date
      comment: "End of the budget period for time-series trending."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Sum of original approved budget amounts — baseline for all variance analysis."
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget AS DOUBLE))
      comment: "Sum of current approved budget including all change orders — reflects live budget authority."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Sum of actual costs incurred to date — key input for cost performance monitoring."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Sum of committed costs (POs, subcontracts) not yet invoiced — critical for cash exposure."
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Sum of forecast-at-completion amounts — primary EAC indicator for project financial outlook."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Sum of budget variance (approved budget minus actual cost) — negative values signal cost overrun."
    - name: "total_contingency_reserve"
      expr: SUM(CAST(contingency_reserve_amount AS DOUBLE))
      comment: "Sum of contingency reserves held — tracks risk buffer consumption across projects."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Sum of management reserves — tracks discretionary buffer available to project leadership."
    - name: "total_approved_change_order_amount"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Sum of approved change order amounts — measures scope growth impact on budget."
    - name: "avg_budget_utilization_pct"
      expr: AVG(ROUND(100.0 * actual_cost_amount / NULLIF(current_approved_budget, 0), 2))
      comment: "Average budget utilization percentage across budget records — flags projects burning budget faster than planned."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Count of active budget records — used to assess budget structure complexity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`finance_revenue_recognition_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics — tracks recognized revenue, deferred revenue, unbilled revenue, and gross profit percentage to support accurate P&L reporting and IFRS 15 / ASC 606 compliance."
  source: "`vibe_construction_v1`.`finance`.`revenue_recognition_entry`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — primary grouping for revenue analysis."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (e.g., percentage-of-completion, completed contract) for accounting policy analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the recognition entry for annual P&L reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the recognition entry for monthly P&L reporting."
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Status of the recognition entry (e.g., posted, draft, reversed) for filtering valid entries."
    - name: "recognition_date"
      expr: recognition_date
      comment: "Date revenue was recognized — used for time-series revenue trending."
    - name: "prior_period_adjustment_flag"
      expr: prior_period_adjustment_flag
      comment: "Flags prior period adjustments — used to isolate restatements from current period revenue."
    - name: "auditor_reviewed_flag"
      expr: auditor_reviewed_flag
      comment: "Indicates auditor review completion — used for financial close quality control."
  measures:
    - name: "total_revenue_recognized_in_period"
      expr: SUM(CAST(revenue_recognized_in_period AS DOUBLE))
      comment: "Sum of revenue recognized in the current period — primary P&L revenue metric."
    - name: "total_revenue_recognized_to_date"
      expr: SUM(CAST(revenue_recognized_to_date AS DOUBLE))
      comment: "Sum of cumulative revenue recognized to date — measures total earned revenue against contract value."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Sum of contract values — total revenue backlog and performance obligation measure."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue AS DOUBLE))
      comment: "Sum of deferred revenue (billed but not yet earned) — balance sheet liability metric."
    - name: "total_unbilled_revenue"
      expr: SUM(CAST(unbilled_revenue AS DOUBLE))
      comment: "Sum of unbilled revenue (earned but not yet invoiced) — measures billing lag and working capital impact."
    - name: "total_cumulative_costs_incurred"
      expr: SUM(CAST(cumulative_costs_incurred AS DOUBLE))
      comment: "Sum of cumulative costs incurred — used to compute cost-to-cost percentage of completion."
    - name: "total_estimated_total_costs"
      expr: SUM(CAST(estimated_total_costs AS DOUBLE))
      comment: "Sum of estimated total costs at completion — denominator for POC calculation and EAC analysis."
    - name: "total_gross_profit_to_date"
      expr: SUM(CAST(gross_profit_to_date AS DOUBLE))
      comment: "Sum of gross profit recognized to date — key profitability metric for project P&L."
    - name: "total_loss_provision"
      expr: SUM(CAST(loss_provision AS DOUBLE))
      comment: "Sum of loss provisions on onerous contracts — measures anticipated project losses requiring immediate recognition."
    - name: "avg_gross_profit_pct"
      expr: AVG(CAST(gross_profit_percentage AS DOUBLE))
      comment: "Average gross profit percentage across recognition entries — measures project margin performance."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average percentage of completion across projects — measures overall portfolio progress for revenue forecasting."
$$;
