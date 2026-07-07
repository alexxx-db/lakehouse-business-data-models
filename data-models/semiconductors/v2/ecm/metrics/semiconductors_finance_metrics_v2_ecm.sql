-- Metric views for domain: finance | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_amortization_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intangible asset amortization KPIs tracking amortization charges, remaining balances, and net book values for capitalized R&D and IP assets. Used by Controllers and CFO to manage intangible asset lifecycle and P&L amortization impact."
  source: "`vibe_semiconductors_v1`.`finance`.`amortization_schedule`"
  dimensions:
    - name: "amortization_method"
      expr: amortization_method
      comment: "Amortization method (e.g., Straight-Line, Units of Production) for accounting policy analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of amortization schedule for asset category classification."
    - name: "amortization_schedule_status"
      expr: amortization_schedule_status
      comment: "Status of the amortization schedule (e.g., Active, Completed, Suspended)."
    - name: "period_year"
      expr: period_year
      comment: "Year of the amortization period for annual amortization trend analysis."
    - name: "period_type"
      expr: period_type
      comment: "Period type (e.g., Monthly, Quarterly, Annual) for amortization frequency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amortization schedule for multi-currency analysis."
  measures:
    - name: "total_amortization_amount"
      expr: SUM(CAST(amortization_amount AS DOUBLE))
      comment: "Total amortization charged. Core P&L impact KPI for intangible asset expense management."
    - name: "total_accumulated_amortization"
      expr: SUM(CAST(accumulated_amortization AS DOUBLE))
      comment: "Total accumulated amortization. Tracks cumulative intangible asset consumption on the balance sheet."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining unamortized balance. Tracks future amortization obligations and intangible asset value."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of intangible assets after amortization. Key balance sheet metric."
    - name: "avg_annual_amortization_amount"
      expr: AVG(CAST(annual_amortization_amount AS DOUBLE))
      comment: "Average annual amortization amount. Used for forward-looking P&L amortization forecasting."
    - name: "amortization_schedule_count"
      expr: COUNT(1)
      comment: "Total active amortization schedules. Tracks intangible asset portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular budget line KPIs enabling FP&A to track planned vs. actual spend, variance analysis, and budget utilization by cost center, GL account, and fiscal period. Drives operational budget steering."
  source: "`vibe_semiconductors_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line for annual budget tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for intra-year budget monitoring."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget line (e.g., Labor, Materials, Overhead) for spend classification."
    - name: "cost_element_type"
      expr: cost_element_type
      comment: "Cost element type for granular cost structure analysis."
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Status of the budget line (e.g., Active, Frozen, Closed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget line for governance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line for multi-currency analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all lines. Primary KPI for budget envelope management."
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned spend amount. Used to compare against actuals for variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (planned vs. actual). Negative values signal overspend requiring intervention."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average variance percentage across budget lines. Tracks overall budget discipline."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity (e.g., wafer starts, headcount) for volume-based budget tracking."
    - name: "frozen_budget_line_count"
      expr: COUNT(CASE WHEN is_frozen = TRUE THEN 1 END)
      comment: "Count of frozen budget lines. High freeze counts signal budget lock-down or cost control actions."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines. Used to assess budget granularity and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics tracking planned vs actual spend, approval status, and budget utilization for financial control and resource allocation"
  source: "`vibe_semiconductors_v1`.`finance`.`budget_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget plan for annual planning cycle tracking"
    - name: "budget_type"
      expr: budget_type
      comment: "Budget type (operating, capital, R&D) for budget category analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status for planning cycle and governance tracking"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Budget lifecycle status (draft, active, closed) for budget execution monitoring"
    - name: "chips_act_funded"
      expr: CASE WHEN chips_act_funding_indicator = TRUE THEN 'CHIPS Act Funded' ELSE 'Non-CHIPS' END
      comment: "CHIPS Act funding indicator for government subsidy tracking and compliance"
    - name: "planning_method"
      expr: planning_method
      comment: "Planning methodology (zero-based, incremental, driver-based) for process improvement"
    - name: "plan_version"
      expr: plan_version
      comment: "Budget version for reforecast and revision tracking"
  measures:
    - name: "total_budget_plans"
      expr: COUNT(1)
      comment: "Total count of budget plans for planning complexity and governance tracking"
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned amount in local currency for budget allocation and resource planning"
    - name: "total_planned_amount_group"
      expr: SUM(CAST(planned_amount_group AS DOUBLE))
      comment: "Total planned amount in group currency for consolidated budget reporting"
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget amount for overall budget size and resource commitment tracking"
    - name: "avg_variance_to_prior_year_pct"
      expr: AVG(CAST(variance_to_prior_year_percent AS DOUBLE))
      comment: "Average year-over-year budget variance percentage for growth trend analysis"
    - name: "total_variance_to_prior_year"
      expr: SUM(CAST(variance_to_prior_year_amount AS DOUBLE))
      comment: "Total variance to prior year for budget growth and strategic investment tracking"
    - name: "distinct_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centers with budgets for organizational scope tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request and approval metrics tracking capex pipeline, approval rates, and funding sources for capital planning and investment decisions"
  source: "`vibe_semiconductors_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Request status (submitted, approved, rejected, cancelled) for capex pipeline tracking"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance and authorization tracking"
    - name: "approval_stage"
      expr: approval_stage
      comment: "Current approval stage for multi-level authorization workflow tracking"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category (fab tool, test equipment, facility) for capital allocation by asset type"
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for node-specific capital investment and capacity planning"
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source (internal, debt, equity, grant) for capital structure and financing analysis"
    - name: "chips_act_eligible"
      expr: CASE WHEN chips_act_funding_eligible = TRUE THEN 'CHIPS Act Eligible' ELSE 'Non-Eligible' END
      comment: "CHIPS Act eligibility for government subsidy tracking and grant application"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating for capital investment risk assessment and portfolio management"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year of request for annual capex demand and investment trend analysis"
  measures:
    - name: "total_capex_requests"
      expr: COUNT(1)
      comment: "Total count of capex requests for investment pipeline volume and demand tracking"
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total requested capex amount for capital demand and budget planning"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved capex amount for authorized capital spending and commitment tracking"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget amount for capex budget allocation and financial planning"
    - name: "avg_request_amount"
      expr: AVG(CAST(request_amount AS DOUBLE))
      comment: "Average capex request size for investment scale and project complexity analysis"
    - name: "distinct_requestors"
      expr: COUNT(DISTINCT capex_requestor_employee_id)
      comment: "Number of distinct requestors for capex demand breadth and organizational engagement"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers for vendor concentration and sourcing strategy analysis"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_consolidation_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidation entry KPIs tracking elimination amounts, consolidation adjustments, and intercompany eliminations. Used by Group Controllers and CFO to ensure accurate consolidated financial statements."
  source: "`vibe_semiconductors_v1`.`finance`.`consolidation_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the consolidation entry for annual consolidation analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly consolidation close monitoring."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of consolidation entry (e.g., Elimination, Reclassification, Adjustment) for close analysis."
    - name: "consolidation_method"
      expr: consolidation_method
      comment: "Consolidation method applied (e.g., Full, Proportional, Equity) for accounting policy tracking."
    - name: "consolidation_entry_status"
      expr: consolidation_entry_status
      comment: "Status of the consolidation entry for close completeness tracking."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Flag indicating whether the entry is an intercompany elimination."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the consolidation entry for multi-currency consolidation analysis."
  measures:
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross consolidation entry amount. Tracks the scale of consolidation adjustments."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net consolidation entry amount. Core KPI for consolidated P&L and balance sheet accuracy."
    - name: "total_amount_adjustment"
      expr: SUM(CAST(amount_adjustment AS DOUBLE))
      comment: "Total consolidation adjustment amounts. Tracks the magnitude of consolidation corrections."
    - name: "elimination_entry_count"
      expr: COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END)
      comment: "Count of intercompany elimination entries. Tracks consolidation elimination completeness."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Count of reversal consolidation entries. Tracks consolidation corrections and restatements."
    - name: "consolidation_entry_count"
      expr: COUNT(1)
      comment: "Total consolidation entries. Used to assess consolidation close workload and complexity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation and overhead distribution metrics tracking allocation methods, rates, and amounts for accurate product costing and profitability analysis"
  source: "`vibe_semiconductors_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost allocation trend analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cost allocation tracking and close process"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method (direct, step-down, activity-based) for costing methodology tracking"
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Allocation basis (headcount, square footage, usage) for driver-based costing analysis"
    - name: "cost_allocation_status"
      expr: cost_allocation_status
      comment: "Allocation status for cost close and posting tracking"
    - name: "reversal_flag"
      expr: CASE WHEN reversal_indicator = TRUE THEN 'Reversal' ELSE 'Original' END
      comment: "Reversal indicator for allocation correction and adjustment tracking"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of allocation for monthly cost distribution analysis"
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total count of cost allocations for allocation complexity and process efficiency tracking"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total allocated cost amount for overhead distribution and product costing"
    - name: "avg_allocation_rate"
      expr: AVG(CAST(allocation_rate AS DOUBLE))
      comment: "Average allocation rate for cost driver efficiency and rate stability analysis"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage for distribution pattern analysis"
    - name: "total_allocation_base_quantity"
      expr: SUM(CAST(allocation_base_quantity AS DOUBLE))
      comment: "Total allocation base quantity for driver volume tracking and rate calculation"
    - name: "distinct_sender_cost_centers"
      expr: COUNT(DISTINCT source_cost_center_id)
      comment: "Number of distinct source cost centers for overhead pool complexity tracking"
    - name: "distinct_receiver_cost_centers"
      expr: COUNT(DISTINCT target_cost_center_id)
      comment: "Number of distinct target cost centers for allocation breadth and impact analysis"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_depreciation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation run execution KPIs tracking total depreciation charges, accumulated depreciation, and run completion status by fiscal period. Used by Controllers and CFO to validate period-close depreciation accuracy."
  source: "`vibe_semiconductors_v1`.`finance`.`depreciation_run`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation run for annual depreciation trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the depreciation run for monthly close monitoring."
    - name: "depreciation_run_status"
      expr: depreciation_run_status
      comment: "Status of the depreciation run (e.g., Completed, Failed, In Progress) for close process governance."
    - name: "run_type"
      expr: run_type
      comment: "Type of depreciation run (e.g., Planned, Unplanned, Reversal) for audit trail."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method used in the run for accounting policy consistency checks."
    - name: "run_date"
      expr: DATE_TRUNC('month', run_date)
      comment: "Month of run execution for close cycle timing analysis."
  measures:
    - name: "total_depreciation_amount"
      expr: SUM(CAST(total_depreciation_amount AS DOUBLE))
      comment: "Total depreciation charged in the period. Core P&L impact KPI for period-close validation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(total_accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all runs. Tracks cumulative asset aging on the balance sheet."
    - name: "total_book_value"
      expr: SUM(CAST(total_book_value AS DOUBLE))
      comment: "Total net book value after depreciation. Key balance sheet metric for asset valuation."
    - name: "total_net_depreciation_amount"
      expr: SUM(CAST(net_depreciation_amount AS DOUBLE))
      comment: "Net depreciation amount after adjustments. Used for accurate P&L impact assessment."
    - name: "avg_depreciation_rate"
      expr: AVG(CAST(depreciation_rate AS DOUBLE))
      comment: "Average depreciation rate applied across runs. Monitors policy consistency and rate changes."
    - name: "depreciation_run_count"
      expr: COUNT(1)
      comment: "Number of depreciation runs executed. Tracks close process completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_nre_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) agreement financial KPIs tracking total NRE commitments, revenue recognition methods, and agreement status. Used by CFO and Finance to govern NRE revenue recognition and customer engineering investment recovery."
  source: "`vibe_semiconductors_v1`.`finance`.`finance_nre_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of NRE agreement (e.g., Design, Mask, Process) for NRE portfolio classification."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the NRE agreement (e.g., Active, Completed, Terminated) for pipeline tracking."
    - name: "finance_nre_agreement_status"
      expr: finance_nre_agreement_status
      comment: "Finance-specific status of the NRE agreement for revenue recognition governance."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method (e.g., Milestone, Percentage of Completion) for ASC 606 compliance."
    - name: "recovery_method"
      expr: recovery_method
      comment: "NRE recovery method (e.g., Upfront, Amortized over Units) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the NRE agreement for multi-currency revenue analysis."
    - name: "agreement_date"
      expr: DATE_TRUNC('quarter', agreement_date)
      comment: "Quarter of agreement signing for NRE pipeline timing analysis."
  measures:
    - name: "total_nre_amount"
      expr: SUM(CAST(total_nre_amount AS DOUBLE))
      comment: "Total NRE agreement value. Core KPI for NRE revenue pipeline and engineering investment recovery."
    - name: "active_nre_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Count of active NRE agreements. Tracks current engineering engagement volume with customers."
    - name: "nre_agreement_count"
      expr: COUNT(1)
      comment: "Total NRE agreements. Used to assess NRE business scale and customer engineering activity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_nre_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE milestone billing and revenue recognition KPIs tracking milestone completion, billing status, and revenue recognized. Used by Finance and Revenue Accounting to ensure timely NRE billing and ASC 606 compliance."
  source: "`vibe_semiconductors_v1`.`finance`.`finance_nre_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of NRE milestone (e.g., Design Complete, Tapeout, Silicon Delivery) for billing trigger analysis."
    - name: "finance_nre_milestone_status"
      expr: finance_nre_milestone_status
      comment: "Status of the milestone (e.g., Pending, Completed, Invoiced) for billing pipeline tracking."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status of the milestone for AR and cash collection tracking."
    - name: "billing_trigger_event"
      expr: billing_trigger_event
      comment: "Event that triggers billing (e.g., Tapeout Completion, First Silicon) for revenue recognition governance."
    - name: "is_revenue_recognized"
      expr: is_revenue_recognized
      comment: "Flag indicating whether revenue has been recognized for the milestone."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the milestone for multi-currency NRE revenue analysis."
    - name: "due_date"
      expr: DATE_TRUNC('quarter', due_date)
      comment: "Quarter of milestone due date for NRE billing schedule analysis."
  measures:
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total NRE milestone billing amount. Tracks NRE revenue pipeline by milestone stage."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net milestone amount after adjustments. Used for net NRE revenue recognition tracking."
    - name: "total_amount_tax"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax on NRE milestones. Tracks tax obligations on engineering service revenue."
    - name: "recognized_revenue_milestone_count"
      expr: COUNT(CASE WHEN is_revenue_recognized = TRUE THEN 1 END)
      comment: "Count of milestones with recognized revenue. Tracks ASC 606 revenue recognition completeness."
    - name: "pending_billing_milestone_count"
      expr: COUNT(CASE WHEN invoice_status = 'Pending' THEN 1 END)
      comment: "Count of milestones pending invoicing. Tracks unbilled NRE revenue at risk of delay."
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total NRE milestones. Used to assess NRE billing schedule completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital asset performance metrics tracking asset values, depreciation, utilization, and lifecycle for capital planning and asset management"
  source: "`vibe_semiconductors_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (equipment, building, infrastructure) for capital allocation analysis"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for detailed asset type segmentation and depreciation policy application"
    - name: "asset_status"
      expr: asset_status
      comment: "Current asset status (active, disposed, impaired) for asset lifecycle tracking"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, accelerated) for accounting policy compliance"
    - name: "technology_node_segment"
      expr: CASE WHEN technology_node_nm <= 7 THEN 'Advanced (≤7nm)' WHEN technology_node_nm <= 28 THEN 'Mainstream (8-28nm)' ELSE 'Mature (>28nm)' END
      comment: "Technology node segment for semiconductor-specific capital efficiency analysis"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition for vintage analysis and capital spending trends"
    - name: "impairment_flag"
      expr: CASE WHEN impairment_indicator = TRUE THEN 'Impaired' ELSE 'Not Impaired' END
      comment: "Asset impairment indicator for financial risk and asset quality monitoring"
    - name: "grant_funded_flag"
      expr: CASE WHEN grant_amount > 0 THEN 'Grant Funded' ELSE 'Non-Grant' END
      comment: "Government grant funding indicator for CHIPS Act and subsidy tracking"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total count of fixed assets for asset portfolio size and complexity tracking"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost for capital investment tracking and balance sheet valuation"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value for balance sheet reporting and asset value monitoring"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation for asset aging analysis and replacement planning"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average asset utilization percentage for capacity planning and capital efficiency"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges for financial risk assessment and asset quality monitoring"
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total government grant funding for CHIPS Act compliance and subsidy tracking"
    - name: "avg_remaining_useful_life"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years for replacement planning and capital forecasting"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction and transfer pricing metrics tracking cross-entity flows, pricing methods, and elimination amounts for consolidation and tax compliance"
  source: "`vibe_semiconductors_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany activity and transfer pricing analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany reconciliation and close tracking"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Transaction type (goods, services, royalty, financing) for intercompany flow classification"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method (CUP, cost-plus, TNMM) for tax compliance and OECD alignment"
    - name: "intercompany_transaction_status"
      expr: intercompany_transaction_status
      comment: "Transaction status for intercompany reconciliation and dispute tracking"
    - name: "elimination_flag"
      expr: CASE WHEN elimination_flag = TRUE THEN 'Elimination Required' ELSE 'No Elimination' END
      comment: "Consolidation elimination indicator for group reporting and GAAP compliance"
    - name: "regulatory_reporting_flag"
      expr: CASE WHEN regulatory_reporting_flag = TRUE THEN 'Regulatory Reportable' ELSE 'Non-Reportable' END
      comment: "Regulatory reporting requirement for tax authority and customs compliance"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for monthly intercompany volume and trend analysis"
  measures:
    - name: "total_intercompany_transactions"
      expr: COUNT(1)
      comment: "Total count of intercompany transactions for cross-entity activity volume tracking"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount for cross-border flow and tax base analysis"
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount before tax for revenue recognition and pricing analysis"
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net amount after tax for cash flow and settlement tracking"
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax amount for withholding tax and VAT compliance tracking"
    - name: "avg_transfer_pricing_margin"
      expr: AVG(CAST(transfer_pricing_margin AS DOUBLE))
      comment: "Average transfer pricing margin for arm's length compliance and tax risk assessment"
    - name: "distinct_target_entities"
      expr: COUNT(DISTINCT target_legal_entity_id)
      comment: "Number of distinct target legal entities for cross-entity relationship mapping"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial transaction metrics tracking journal entry volumes, amounts, and posting patterns for financial close and audit analysis"
  source: "`vibe_semiconductors_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for year-over-year financial analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly financial close tracking"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (standard, adjustment, accrual, reversal) for transaction classification"
    - name: "document_type"
      expr: document_type
      comment: "Document type for source system traceability and audit trail"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (draft, posted, reversed) for financial close monitoring"
    - name: "intercompany_flag"
      expr: CASE WHEN intercompany_indicator = TRUE THEN 'Intercompany' ELSE 'Non-Intercompany' END
      comment: "Intercompany transaction flag for consolidation and elimination tracking"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for monthly financial reporting and trend analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency financial analysis"
  measures:
    - name: "total_journal_entries"
      expr: COUNT(1)
      comment: "Total count of journal entries for transaction volume monitoring and close efficiency"
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit AS DOUBLE))
      comment: "Total debit amount for double-entry validation and financial statement preparation"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit AS DOUBLE))
      comment: "Total credit amount for double-entry validation and balance verification"
    - name: "net_amount_sum"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts for financial impact analysis and P&L tracking"
    - name: "avg_entry_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average journal entry amount for transaction size analysis and anomaly detection"
    - name: "distinct_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of distinct legal entities with journal activity for consolidation scope tracking"
    - name: "reversal_entry_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal entries for error correction tracking and process quality monitoring"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance metrics tracking budget vs actual, variance, and allocation for business unit profitability and accountability"
  source: "`vibe_semiconductors_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Profit center type (product line, geography, customer segment) for organizational structure analysis"
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Profit center category for business unit classification and reporting hierarchy"
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Profit center status (active, inactive, closed) for organizational change tracking"
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for semiconductor-specific profit center segmentation"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional profitability and market performance analysis"
    - name: "product_line"
      expr: product_line
      comment: "Product line for portfolio profitability and strategic investment decisions"
    - name: "sox_compliant"
      expr: CASE WHEN sox_compliant = TRUE THEN 'SOX Compliant' ELSE 'Non-SOX' END
      comment: "SOX compliance indicator for internal control and audit scope tracking"
    - name: "consolidated_flag"
      expr: CASE WHEN is_consolidated = TRUE THEN 'Consolidated' ELSE 'Non-Consolidated' END
      comment: "Consolidation indicator for group reporting and segment analysis"
  measures:
    - name: "total_profit_centers"
      expr: COUNT(1)
      comment: "Total count of profit centers for organizational complexity and span of control tracking"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget amount for resource allocation and financial planning"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend for budget execution and cost control monitoring"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance for financial performance and accountability tracking"
    - name: "avg_allocation_pct"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average allocation percentage for cost distribution and overhead assignment analysis"
    - name: "distinct_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of distinct legal entities for cross-entity profit center scope tracking"
    - name: "active_profit_centers"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active profit centers for current organizational structure monitoring"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_rd_capitalization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R&D capitalization and amortization metrics tracking capitalized development costs, useful life, and asset creation for financial reporting and tax compliance"
  source: "`vibe_semiconductors_v1`.`finance`.`rd_capitalization`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual R&D capitalization trend and policy compliance tracking"
    - name: "capitalization_status"
      expr: capitalization_status
      comment: "Capitalization status (pending, approved, capitalized, expensed) for accounting treatment tracking"
    - name: "rd_capitalization_status"
      expr: rd_capitalization_status
      comment: "R&D capitalization status for lifecycle and approval workflow tracking"
    - name: "capitalized_asset_type"
      expr: capitalized_asset_type
      comment: "Asset type (software, IP core, process technology) for intangible asset classification"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for amortization policy and useful life tracking"
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "Technology readiness level (TRL) for R&D stage and capitalization eligibility assessment"
    - name: "external_audit_flag"
      expr: CASE WHEN external_audit_flag = TRUE THEN 'External Audit Required' ELSE 'No External Audit' END
      comment: "External audit requirement for financial statement audit and SOX compliance"
    - name: "reversal_flag"
      expr: CASE WHEN is_reversal = TRUE THEN 'Reversal' ELSE 'Original' END
      comment: "Reversal indicator for capitalization correction and adjustment tracking"
    - name: "capitalization_year"
      expr: YEAR(capitalization_date)
      comment: "Year of capitalization for annual R&D asset creation and investment tracking"
  measures:
    - name: "total_capitalization_events"
      expr: COUNT(1)
      comment: "Total count of R&D capitalization events for intangible asset creation volume tracking"
    - name: "total_capitalized_amount"
      expr: SUM(CAST(capitalized_amount AS DOUBLE))
      comment: "Total capitalized R&D amount for balance sheet intangible asset value and investment tracking"
    - name: "total_expensed_amount"
      expr: SUM(CAST(expensed_amount AS DOUBLE))
      comment: "Total expensed R&D amount for P&L impact and tax deduction tracking"
    - name: "total_original_expense"
      expr: SUM(CAST(original_expense_amount AS DOUBLE))
      comment: "Total original expense amount for capitalization rate and policy compliance analysis"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years for amortization period and asset lifecycle planning"
    - name: "distinct_projects"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of distinct R&D projects with capitalization for innovation portfolio tracking"
    - name: "distinct_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centers with R&D capitalization for organizational scope tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product standard cost and variance metrics tracking cost components, yield assumptions, and cost per die for profitability analysis and pricing decisions"
  source: "`vibe_semiconductors_v1`.`finance`.`standard_cost`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Cost type (material, labor, overhead, equipment) for cost structure analysis"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category for detailed cost classification and driver analysis"
    - name: "cost_status"
      expr: cost_status
      comment: "Cost status (active, frozen, expired) for cost version control and lifecycle tracking"
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for node-specific cost analysis and pricing strategy"
    - name: "product_family"
      expr: product_family
      comment: "Product family for portfolio-level cost and margin analysis"
    - name: "product_line"
      expr: product_line
      comment: "Product line for business unit cost performance tracking"
    - name: "cost_version"
      expr: cost_version
      comment: "Cost version for standard cost revision and reforecast tracking"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost trend and inflation analysis"
  measures:
    - name: "total_cost_records"
      expr: COUNT(1)
      comment: "Total count of standard cost records for cost model complexity tracking"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost for bill-of-material cost analysis and procurement efficiency"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for workforce efficiency and productivity analysis"
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost for indirect cost management and absorption rate tracking"
    - name: "avg_cost_per_good_die"
      expr: AVG(CAST(cost_per_good_die AS DOUBLE))
      comment: "Average cost per good die for semiconductor unit economics and pricing strategy"
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage for manufacturing efficiency and cost competitiveness"
    - name: "total_wafer_cost"
      expr: SUM(CAST(total_wafer_cost AS DOUBLE))
      comment: "Total wafer cost for fab cost analysis and capacity utilization economics"
    - name: "avg_fab_overhead_rate"
      expr: AVG(CAST(fab_overhead_rate AS DOUBLE))
      comment: "Average fab overhead rate for manufacturing cost structure and efficiency benchmarking"
    - name: "distinct_products"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct products with standard costs for portfolio breadth tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax provision KPIs tracking effective tax rates, deferred tax positions, and provision accuracy. Used by Tax Directors and CFO to manage tax risk, optimize tax positions, and ensure ASC 740 / IAS 12 compliance."
  source: "`vibe_semiconductors_v1`.`finance`.`tax_provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax provision for annual effective tax rate analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for quarterly tax provision review and interim reporting."
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., Corporate Income Tax, Deferred Tax, Withholding) for tax category analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Tax jurisdiction for multi-jurisdiction tax exposure analysis."
    - name: "tax_provision_status"
      expr: tax_provision_status
      comment: "Status of the tax provision (e.g., Estimated, Final, Reversed) for close governance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tax provision for governance and audit readiness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the provision for multi-currency tax analysis."
  measures:
    - name: "total_provision_amount"
      expr: SUM(CAST(provision_amount AS DOUBLE))
      comment: "Total tax provision amount. Core KPI for tax liability management and financial statement accuracy."
    - name: "total_tax_expense_amount"
      expr: SUM(CAST(tax_expense_amount AS DOUBLE))
      comment: "Total current tax expense. Tracks cash tax obligation for treasury planning."
    - name: "total_deferred_tax_asset"
      expr: SUM(CAST(deferred_tax_asset_amount AS DOUBLE))
      comment: "Total deferred tax asset. Tracks future tax benefit positions on the balance sheet."
    - name: "total_deferred_tax_liability"
      expr: SUM(CAST(deferred_tax_liability_amount AS DOUBLE))
      comment: "Total deferred tax liability. Tracks future tax obligations requiring balance sheet management."
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate. Key executive KPI for tax efficiency and jurisdiction optimization."
    - name: "total_tax_credit_carryforward"
      expr: SUM(CAST(tax_credit_carryforward_amount AS DOUBLE))
      comment: "Total tax credit carryforward amounts. Tracks unutilized tax credits for future tax planning."
    - name: "total_pretax_income"
      expr: SUM(CAST(pretax_income AS DOUBLE))
      comment: "Total pre-tax income subject to provision. Used to validate effective tax rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_transfer_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer pricing KPIs tracking intercompany pricing rates, margins, and OECD compliance. Used by Tax Directors and CFO to manage transfer pricing risk, ensure arm's length compliance, and optimize global tax positions."
  source: "`vibe_semiconductors_v1`.`finance`.`transfer_price`"
  dimensions:
    - name: "transfer_price_type"
      expr: transfer_price_type
      comment: "Type of transfer price (e.g., Goods, Services, IP Royalty) for pricing category analysis."
    - name: "price_method"
      expr: price_method
      comment: "Transfer pricing method (e.g., CUP, Cost Plus, TNMM) for OECD compliance tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transfer price for governance and audit readiness."
    - name: "transfer_price_status"
      expr: transfer_price_status
      comment: "Current status of the transfer price record (e.g., Active, Expired, Under Review)."
    - name: "product_category"
      expr: product_category
      comment: "Product category for transfer pricing analysis by product type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transfer price for multi-currency analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year of transfer price effective date for annual pricing review cycle."
  measures:
    - name: "avg_effective_price_per_unit"
      expr: AVG(CAST(effective_price_per_unit AS DOUBLE))
      comment: "Average effective transfer price per unit. Core KPI for intercompany pricing benchmarking."
    - name: "avg_margin_rate"
      expr: AVG(CAST(margin_rate AS DOUBLE))
      comment: "Average transfer pricing margin rate. Monitors arm's length margin compliance."
    - name: "avg_markup_percent"
      expr: AVG(CAST(markup_percent AS DOUBLE))
      comment: "Average markup percentage applied. Tracks cost-plus pricing consistency across entities."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate on transfer prices. Used for cross-jurisdiction tax burden analysis."
    - name: "non_compliant_price_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Count of transfer prices flagged as non-compliant. High counts signal transfer pricing audit risk."
    - name: "transfer_price_record_count"
      expr: COUNT(1)
      comment: "Total transfer price records. Tracks pricing coverage across intercompany flows."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_wafer_cost_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer cost model KPIs providing detailed fab economics analysis including cost per wafer, yield assumptions, and overhead rates by technology node and fab location. Used by CFO and Fab Finance to optimize wafer economics and set competitive pricing."
  source: "`vibe_semiconductors_v1`.`finance`.`wafer_cost_model`"
  dimensions:
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for node-level wafer cost benchmarking."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for precise technology cost comparison."
    - name: "fab_location"
      expr: fab_location
      comment: "Fab location for geographic cost comparison and fab efficiency analysis."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer size (e.g., 200mm, 300mm) for wafer economics comparison."
    - name: "wafer_cost_model_status"
      expr: wafer_cost_model_status
      comment: "Status of the cost model (e.g., Active, Draft, Archived) for version governance."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter of model effective date for cost trend analysis."
  measures:
    - name: "avg_cost_per_wafer_usd"
      expr: AVG(CAST(cost_per_wafer_usd AS DOUBLE))
      comment: "Average cost per wafer in USD. Primary fab economics KPI for pricing and profitability analysis."
    - name: "avg_total_cost_per_wafer_usd"
      expr: AVG(CAST(total_cost_per_wafer_usd AS DOUBLE))
      comment: "Average total all-in cost per wafer. Used for comprehensive wafer economics benchmarking."
    - name: "avg_silicon_wafer_cost_usd"
      expr: AVG(CAST(silicon_wafer_cost_usd AS DOUBLE))
      comment: "Average silicon wafer substrate cost. Tracks raw material cost component of wafer economics."
    - name: "avg_equipment_depreciation_usd_per_wafer"
      expr: AVG(CAST(equipment_depreciation_usd_per_wafer AS DOUBLE))
      comment: "Average equipment depreciation per wafer. Tracks capital cost absorption in wafer cost structure."
    - name: "avg_fab_overhead_rate_percent"
      expr: AVG(CAST(fab_overhead_rate_percent AS DOUBLE))
      comment: "Average fab overhead rate percentage. High overhead rates signal underutilization or inefficiency."
    - name: "avg_yield_assumption_percent"
      expr: AVG(CAST(yield_assumption_percent AS DOUBLE))
      comment: "Average yield assumption used in cost models. Directly impacts cost per good die calculations."
    - name: "avg_mask_set_cost_usd"
      expr: AVG(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Average mask set cost in USD. Key NRE cost driver at advanced technology nodes."
    - name: "wafer_cost_model_count"
      expr: COUNT(1)
      comment: "Total wafer cost models. Tracks cost model coverage across technology nodes and fabs."
$$;
