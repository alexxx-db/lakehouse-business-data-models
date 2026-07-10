-- Metric views for domain: project | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive-level KPIs for the project portfolio: budget health, schedule adherence, cost performance, and OEE targets across all active projects."
  source: "`vibe_manufacturing_v1`.`project`.`project_header`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Classifies projects by type (capital, operational, R&D, etc.) for portfolio segmentation."
    - name: "project_category"
      expr: project_category
      comment: "Business category of the project for cross-portfolio analysis."
    - name: "project_phase"
      expr: project_phase
      comment: "Current lifecycle phase of the project (planning, execution, closeout, etc.)."
    - name: "project_header_status"
      expr: project_header_status
      comment: "Current status of the project header (active, on-hold, completed, cancelled)."
    - name: "priority"
      expr: priority
      comment: "Project priority level for resource allocation decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the project for executive risk monitoring."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the project for regional portfolio analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (capex, opex, grant, etc.) for financial planning."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned project start date for timeline analysis."
    - name: "planned_end_date"
      expr: DATE_TRUNC('month', planned_end_date)
      comment: "Month bucket of planned project end date for delivery forecasting."
    - name: "governance_approval_status"
      expr: governance_approval_status
      comment: "Governance approval status for compliance and gate-review tracking."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of projects in the portfolio. Baseline measure for portfolio size."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all projects. Drives capital allocation decisions."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all projects. Used to track spend vs. budget."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average project budget. Useful for benchmarking project sizing."
    - name: "total_actual_work_hours"
      expr: SUM(CAST(actual_work_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across all projects. Drives workforce capacity planning."
    - name: "total_planned_work_hours"
      expr: SUM(CAST(total_work_hours AS DOUBLE))
      comment: "Total planned labor hours across all projects. Baseline for resource demand forecasting."
    - name: "avg_actual_oee_percent"
      expr: AVG(CAST(actual_oee_percent AS DOUBLE))
      comment: "Average actual OEE percentage across projects. Measures operational efficiency delivered by projects."
    - name: "avg_expected_oee_percent"
      expr: AVG(CAST(expected_oee_percent AS DOUBLE))
      comment: "Average expected OEE percentage across projects. Baseline for OEE target-setting."
    - name: "avg_environmental_impact_score"
      expr: AVG(CAST(environmental_impact_score AS DOUBLE))
      comment: "Average environmental impact score across projects. Supports ESG reporting and sustainability steering."
    - name: "projects_on_hold_count"
      expr: COUNT(CASE WHEN project_header_status = 'ON_HOLD' THEN 1 END)
      comment: "Number of projects currently on hold. Signals portfolio blockage requiring executive intervention."
    - name: "projects_at_high_risk_count"
      expr: COUNT(CASE WHEN risk_level = 'HIGH' THEN 1 END)
      comment: "Number of projects assessed at high risk. Drives risk mitigation prioritization."
    - name: "projects_pending_governance_count"
      expr: COUNT(CASE WHEN governance_approval_status NOT IN ('APPROVED', 'CLOSED') THEN 1 END)
      comment: "Number of projects awaiting governance approval. Identifies portfolio bottlenecks in approval pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance KPIs at the project and WBS level: original vs. revised budget, spend rate, variance, and commitment tracking."
  source: "`vibe_manufacturing_v1`.`project`.`project_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (capital, operating, contingency) for financial classification."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (labor, material, equipment, overhead) for cost breakdown analysis."
    - name: "project_budget_status"
      expr: project_budget_status
      comment: "Current status of the budget record (active, locked, closed)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual financial planning and reporting."
    - name: "budget_source"
      expr: budget_source
      comment: "Source of budget funding for financial traceability."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the budget is locked, preventing further changes."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month bucket of budget effective start date for temporal analysis."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget. Baseline for budget variance analysis."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget after change orders. Reflects current authorized spend ceiling."
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total amount spent against the budget. Core measure for budget consumption tracking."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) budget. Critical for cash flow forecasting."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining budget available. Drives go/no-go decisions on new project spend."
    - name: "total_transferred_in_amount"
      expr: SUM(CAST(transferred_in_amount AS DOUBLE))
      comment: "Total budget transferred into projects. Tracks inter-project budget reallocation."
    - name: "total_transferred_out_amount"
      expr: SUM(CAST(transferred_out_amount AS DOUBLE))
      comment: "Total budget transferred out of projects. Tracks inter-project budget reallocation."
    - name: "avg_remaining_amount"
      expr: AVG(CAST(remaining_amount AS DOUBLE))
      comment: "Average remaining budget per budget record. Useful for identifying underfunded project elements."
    - name: "budget_records_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Baseline for budget structure complexity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_earned_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) KPIs: CPI, SPI, cost variance, schedule variance, EAC, and ETC for project performance monitoring."
  source: "`vibe_manufacturing_v1`.`project`.`earned_value_record`"
  dimensions:
    - name: "earned_value_record_status"
      expr: earned_value_record_status
      comment: "Status of the EVM record (draft, approved, final) for data quality filtering."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost being tracked (labor, material, overhead) for cost breakdown analysis."
    - name: "forecast_method"
      expr: forecast_method
      comment: "EAC forecast method used (CPI-based, ETC-based, etc.) for methodology transparency."
    - name: "is_forecast"
      expr: is_forecast
      comment: "Indicates whether the record is a forecast vs. actuals for data segmentation."
    - name: "reporting_date"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month bucket of reporting date for trend analysis over time."
    - name: "baseline_version"
      expr: baseline_version
      comment: "Baseline version reference for comparing performance against approved baselines."
  measures:
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value (BCWP) across all WBS elements. Core EVM measure of work accomplished."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (BCWS) across all WBS elements. Baseline for schedule performance."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost (ACWP) incurred. Used to compute cost variance and CPI."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (EV - AC). Negative values indicate cost overrun requiring executive action."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total schedule variance (EV - PV). Negative values indicate schedule slippage."
    - name: "total_estimate_at_completion"
      expr: SUM(CAST(estimate_at_completion AS DOUBLE))
      comment: "Total EAC across all WBS elements. Forecasted final cost for budget-to-complete planning."
    - name: "total_estimate_to_complete"
      expr: SUM(CAST(estimate_to_complete AS DOUBLE))
      comment: "Total ETC across all WBS elements. Remaining cost to finish all project work."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total variance at completion (BAC - EAC). Measures projected final over/under-run."
    - name: "avg_cost_performance_index"
      expr: AVG(CAST(cost_performance_index AS DOUBLE))
      comment: "Average CPI across WBS elements. CPI < 1.0 signals cost overrun; drives corrective action."
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_performance_index AS DOUBLE))
      comment: "Average SPI across WBS elements. SPI < 1.0 signals schedule delay; drives recovery planning."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across WBS elements. High-level progress indicator for executive dashboards."
    - name: "evm_records_count"
      expr: COUNT(1)
      comment: "Total number of EVM records. Baseline for EVM coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Activity-level execution KPIs: labor efficiency, cost performance, critical path exposure, and schedule adherence for project delivery management."
  source: "`vibe_manufacturing_v1`.`project`.`activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (not started, in progress, complete, delayed)."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity (engineering, procurement, construction, testing) for work breakdown analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the activity is on the critical path. Critical for schedule risk management."
    - name: "milestone_flag"
      expr: milestone_flag
      comment: "Indicates whether the activity is a milestone for milestone tracking."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned activity start for schedule distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost amounts for multi-currency portfolio analysis."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of activities. Baseline for project scope and complexity measurement."
    - name: "critical_path_activities_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of activities on the critical path. Drives schedule risk prioritization."
    - name: "total_labor_hours_estimated"
      expr: SUM(CAST(labor_hours_estimated AS DOUBLE))
      comment: "Total estimated labor hours across all activities. Drives workforce demand planning."
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours consumed. Used to compute labor efficiency vs. estimate."
    - name: "total_material_cost_estimated"
      expr: SUM(CAST(material_cost_estimated AS DOUBLE))
      comment: "Total estimated material cost across activities. Drives procurement budget planning."
    - name: "total_material_cost_actual"
      expr: SUM(CAST(material_cost_actual AS DOUBLE))
      comment: "Total actual material cost incurred. Used to track material spend vs. estimate."
    - name: "total_equipment_cost_estimated"
      expr: SUM(CAST(equipment_cost_estimated AS DOUBLE))
      comment: "Total estimated equipment cost. Drives asset utilization and rental planning."
    - name: "total_equipment_cost_actual"
      expr: SUM(CAST(equipment_cost_actual AS DOUBLE))
      comment: "Total actual equipment cost incurred. Tracks equipment spend vs. plan."
    - name: "total_earned_value_bcwp"
      expr: SUM(CAST(earned_value_bcwp AS DOUBLE))
      comment: "Total budgeted cost of work performed (BCWP) at activity level. Core EVM input."
    - name: "total_earned_value_bcws"
      expr: SUM(CAST(earned_value_bcws AS DOUBLE))
      comment: "Total budgeted cost of work scheduled (BCWS) at activity level. Schedule baseline for EVM."
    - name: "total_earned_value_acwp"
      expr: SUM(CAST(earned_value_acwp AS DOUBLE))
      comment: "Total actual cost of work performed (ACWP) at activity level. Cost actuals for EVM."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across activities. Indicates overall execution progress."
    - name: "avg_float_days"
      expr: AVG(CAST(float_days AS DOUBLE))
      comment: "Average schedule float in days. Low float signals schedule tightness and risk."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_cost_estimated AS DOUBLE))
      comment: "Total estimated cost across all activities. Drives project cost baseline management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commitment and obligation KPIs: total committed spend, variance, and funds reservation status for project cash flow and procurement control."
  source: "`vibe_manufacturing_v1`.`project`.`commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of commitment (purchase order, contract, reservation) for obligation classification."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (open, partially delivered, closed) for liability tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the commitment for governance and control monitoring."
    - name: "is_funds_reserved"
      expr: is_funds_reserved
      comment: "Indicates whether funds are formally reserved against the budget."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of commitment amounts for multi-currency analysis."
    - name: "commitment_date"
      expr: DATE_TRUNC('month', commitment_date)
      comment: "Month bucket of commitment date for cash flow timing analysis."
    - name: "expected_delivery_date"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month bucket of expected delivery date for procurement schedule planning."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated) amount. Core measure for project liability and cash flow forecasting."
    - name: "total_net_committed_amount"
      expr: SUM(CAST(net_committed_amount AS DOUBLE))
      comment: "Total net committed amount after adjustments. Reflects true outstanding obligations."
    - name: "total_actual_spent_amount"
      expr: SUM(CAST(actual_spent_amount AS DOUBLE))
      comment: "Total actual amount spent against commitments. Tracks commitment liquidation rate."
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount for commitments. Baseline for commitment vs. budget analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between committed and budgeted amounts. Signals budget pressure from procurement."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on commitments. Required for accurate total cost of ownership calculations."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed across all commitment records. Drives material requirements planning."
    - name: "commitments_count"
      expr: COUNT(1)
      comment: "Total number of commitment records. Baseline for procurement obligation volume."
    - name: "open_commitments_count"
      expr: COUNT(CASE WHEN commitment_status = 'OPEN' THEN 1 END)
      comment: "Number of open (unresolved) commitments. Drives accounts payable and cash flow management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_cost_actual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actual cost posting KPIs at the project and WBS level: total spend, variance, overhead allocation, and budget utilization for financial control."
  source: "`vibe_manufacturing_v1`.`project`.`cost_actual`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (labor, material, overhead, equipment) for cost breakdown analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category for financial classification and reporting."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the cost posting (posted, reversed, pending) for financial accuracy."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the cost record for governance and audit."
    - name: "is_budgeted"
      expr: is_budgeted
      comment: "Indicates whether the cost was budgeted. Distinguishes planned vs. unplanned spend."
    - name: "is_manual_entry"
      expr: is_manual_entry
      comment: "Indicates manual vs. system-generated cost entries for data quality monitoring."
    - name: "overhead_allocation_flag"
      expr: overhead_allocation_flag
      comment: "Indicates overhead allocation entries for overhead rate analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost posting for annual financial reporting."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of posting date for period-over-period cost trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost amounts for multi-currency financial consolidation."
  measures:
    - name: "total_actual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total actual cost amount posted. Primary measure for project cost tracking."
    - name: "total_amount_controlling_currency"
      expr: SUM(CAST(amount_controlling_currency AS DOUBLE))
      comment: "Total cost in controlling currency. Enables cross-project financial consolidation."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget amount associated with cost records. Baseline for variance calculation."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance (actual vs. budget). Negative values signal overrun requiring action."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on cost postings. Required for accurate total cost reporting."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to cost postings. Monitors FX exposure on project costs."
    - name: "cost_postings_count"
      expr: COUNT(1)
      comment: "Total number of cost postings. Baseline for cost posting volume and audit trail completeness."
    - name: "manual_entry_count"
      expr: COUNT(CASE WHEN is_manual_entry = TRUE THEN 1 END)
      comment: "Number of manual cost entries. High counts signal data quality risk and audit exposure."
    - name: "avg_cost_allocation_percentage"
      expr: AVG(CAST(cost_allocation_percentage AS DOUBLE))
      comment: "Average cost allocation percentage. Monitors overhead distribution methodology."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone performance KPIs: on-time delivery, cost variance, payment trigger tracking, and critical milestone exposure for project governance."
  source: "`vibe_manufacturing_v1`.`project`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (planned, in progress, achieved, delayed, cancelled)."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (contractual, internal, payment, regulatory) for classification."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the milestone is on the critical path for schedule risk monitoring."
    - name: "payment_trigger"
      expr: payment_trigger
      comment: "Indicates whether milestone achievement triggers a customer payment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the milestone for risk-based prioritization."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the milestone for regulatory and contractual adherence."
    - name: "planned_date"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Month bucket of planned milestone date for delivery timeline analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of milestones. Baseline for project scope and governance checkpoint coverage."
    - name: "critical_milestones_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical milestones. Drives schedule risk management focus."
    - name: "payment_trigger_milestones_count"
      expr: COUNT(CASE WHEN payment_trigger = TRUE THEN 1 END)
      comment: "Number of milestones that trigger customer payments. Drives revenue recognition planning."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount tied to milestone triggers. Drives project cash inflow forecasting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred at milestone level. Tracks cost performance at key delivery points."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost for milestones. Baseline for milestone cost variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance at milestone level. Negative values indicate cost overrun at key deliverables."
    - name: "achieved_milestones_count"
      expr: COUNT(CASE WHEN milestone_status = 'ACHIEVED' THEN 1 END)
      comment: "Number of achieved milestones. Measures project delivery progress against plan."
    - name: "delayed_milestones_count"
      expr: COUNT(CASE WHEN milestone_status = 'DELAYED' THEN 1 END)
      comment: "Number of delayed milestones. Key indicator for schedule recovery planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change control KPIs: change request volume, cost and schedule impact, approval cycle performance, and critical change exposure."
  source: "`vibe_manufacturing_v1`.`project`.`project_change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change request (scope, cost, schedule, technical) for change impact classification."
    - name: "project_change_request_status"
      expr: project_change_request_status
      comment: "Current status of the change request (submitted, under review, approved, rejected)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change request for governance tracking."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the change request is critical to project delivery."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change request for prioritization."
    - name: "priority"
      expr: priority
      comment: "Priority of the change request for processing queue management."
    - name: "request_timestamp"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month bucket of change request submission for trend analysis."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests. High volume signals scope instability requiring executive attention."
    - name: "total_cost_delta_amount"
      expr: SUM(CAST(cost_delta_amount AS DOUBLE))
      comment: "Total cost impact of all change requests. Measures cumulative budget pressure from scope changes."
    - name: "avg_cost_delta_amount"
      expr: AVG(CAST(cost_delta_amount AS DOUBLE))
      comment: "Average cost impact per change request. Benchmarks change order sizing."
    - name: "approved_change_requests_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved change requests. Tracks authorized scope changes."
    - name: "rejected_change_requests_count"
      expr: COUNT(CASE WHEN approval_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected change requests. High rejection rates signal poor change quality or governance."
    - name: "critical_change_requests_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical change requests. Drives executive escalation and fast-track approval."
    - name: "pending_change_requests_count"
      expr: COUNT(CASE WHEN project_change_request_status NOT IN ('APPROVED', 'REJECTED', 'CLOSED') THEN 1 END)
      comment: "Number of change requests pending decision. Measures change control backlog."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor utilization and cost KPIs from timesheets: hours worked, overtime, billable vs. non-billable split, and cost rate analysis."
  source: "`vibe_manufacturing_v1`.`project`.`timesheet`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity recorded on the timesheet for labor category analysis."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether hours are billable to the customer. Drives revenue recognition and margin analysis."
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category (engineering, management, skilled trades) for workforce cost analysis."
    - name: "labor_grade"
      expr: labor_grade
      comment: "Labor grade for cost rate benchmarking and workforce planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the timesheet for payroll and billing accuracy."
    - name: "expense_flag"
      expr: expense_flag
      comment: "Indicates whether the timesheet record includes an expense claim."
    - name: "work_date"
      expr: DATE_TRUNC('week', work_date)
      comment: "Week bucket of work date for weekly labor utilization trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost amounts for multi-currency labor cost analysis."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all timesheet records. Primary labor utilization measure."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours. High overtime signals resource constraints or schedule pressure."
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total labor cost from timesheets. Core measure for project labor spend tracking."
    - name: "total_expense_amount"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense amount claimed on timesheets. Tracks project-related expense reimbursements."
    - name: "avg_cost_rate"
      expr: AVG(CAST(cost_rate AS DOUBLE))
      comment: "Average cost rate per hour. Benchmarks labor cost efficiency across projects."
    - name: "billable_hours_total"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total billable hours. Drives revenue recognition and customer invoicing."
    - name: "non_billable_hours_total"
      expr: SUM(CASE WHEN billable_flag = FALSE THEN CAST(hours_worked AS DOUBLE) ELSE 0 END)
      comment: "Total non-billable hours. High non-billable ratio signals margin leakage."
    - name: "timesheet_records_count"
      expr: COUNT(1)
      comment: "Total number of timesheet records. Baseline for labor data completeness."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier applied. Monitors premium pay exposure on projects."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_invoice_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project billing KPIs: invoice request volume, gross/net amounts, tax, discount, and billing cycle performance for revenue management."
  source: "`vibe_manufacturing_v1`.`project`.`invoice_request`"
  dimensions:
    - name: "invoice_request_status"
      expr: invoice_request_status
      comment: "Current status of the invoice request (draft, submitted, approved, invoiced) for billing pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice request for revenue recognition gating."
    - name: "billing_basis"
      expr: billing_basis
      comment: "Basis for billing (milestone, time-and-material, fixed-price) for contract type analysis."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied for financial reporting compliance."
    - name: "is_advance"
      expr: is_advance
      comment: "Indicates advance billing for cash flow and working capital analysis."
    - name: "is_final"
      expr: is_final
      comment: "Indicates final invoice request for project closeout tracking."
    - name: "billing_period_start"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Month bucket of billing period start for revenue timing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of invoice amounts for multi-currency revenue analysis."
  measures:
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross invoice request amount. Primary revenue pipeline measure for project billing."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net invoice request amount after discounts. Measures net revenue recognized."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on invoice requests. Required for tax liability reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on invoice requests. Monitors discount policy compliance."
    - name: "avg_percent_complete_at_billing"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average project percent complete at time of billing. Validates billing aligns with progress."
    - name: "invoice_requests_count"
      expr: COUNT(1)
      comment: "Total number of invoice requests. Baseline for billing activity volume."
    - name: "approved_invoice_requests_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved invoice requests ready for invoicing. Drives AR pipeline forecasting."
    - name: "avg_amount_net"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net invoice request amount. Benchmarks billing transaction size."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource utilization KPIs: planned vs. actual hours, utilization rate, overtime exposure, and cost rate analysis for workforce planning."
  source: "`vibe_manufacturing_v1`.`project`.`resource_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment (active, completed, cancelled)."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of resource assignment (primary, backup, consultant) for workforce planning."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the assigned resource for skills-based capacity analysis."
    - name: "billing_rate_type"
      expr: billing_rate_type
      comment: "Billing rate type (standard, overtime, blended) for revenue and cost analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the assignment for revenue recognition tracking."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Indicates overtime assignments for premium cost monitoring."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the assigned resource for competency-based planning."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month bucket of assignment start for resource demand timeline analysis."
  measures:
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours across all resource assignments. Drives capacity demand forecasting."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked by assigned resources. Measures labor consumption vs. plan."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours on assignments. High overtime signals resource shortage or schedule pressure."
    - name: "avg_utilization_percent"
      expr: AVG(CAST(utilization_percent AS DOUBLE))
      comment: "Average resource utilization percentage. Core KPI for workforce efficiency and capacity management."
    - name: "avg_cost_rate_amount"
      expr: AVG(CAST(cost_rate_amount AS DOUBLE))
      comment: "Average cost rate per resource assignment. Benchmarks labor cost across project roles."
    - name: "total_cost_rate_amount"
      expr: SUM(CAST(cost_rate_amount AS DOUBLE))
      comment: "Total cost rate value across all assignments. Approximates total labor cost commitment."
    - name: "resource_assignments_count"
      expr: COUNT(1)
      comment: "Total number of resource assignments. Baseline for workforce deployment volume."
    - name: "overtime_assignments_count"
      expr: COUNT(CASE WHEN is_overtime = TRUE THEN 1 END)
      comment: "Number of overtime assignments. Monitors premium pay exposure and workforce stress."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project settlement KPIs: gross and net settlement amounts, manual settlement volume, and reversal tracking for financial close management."
  source: "`vibe_manufacturing_v1`.`project`.`settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement (pending, posted, reversed) for financial close tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the settlement for governance and audit."
    - name: "receiver_object_type"
      expr: receiver_object_type
      comment: "Type of receiving cost object (cost center, GL account, asset) for settlement distribution analysis."
    - name: "is_manual_settlement"
      expr: is_manual_settlement
      comment: "Indicates manual vs. automatic settlement for data quality and audit monitoring."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the settlement has been reversed for financial accuracy."
    - name: "settlement_date"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month bucket of settlement date for period-end financial close analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of settlement amounts for multi-currency consolidation."
  measures:
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross settlement amount. Measures total project cost settled to receiving objects."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net settlement amount. Core measure for project financial close completeness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on settlements. Required for tax reporting accuracy."
    - name: "settlements_count"
      expr: COUNT(1)
      comment: "Total number of settlement records. Baseline for settlement activity volume."
    - name: "manual_settlements_count"
      expr: COUNT(CASE WHEN is_manual_settlement = TRUE THEN 1 END)
      comment: "Number of manual settlements. High counts signal process gaps and audit risk."
    - name: "reversed_settlements_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed settlements. High reversal rates indicate posting errors or disputes."
    - name: "avg_amount_net"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net settlement amount. Benchmarks settlement transaction size for process efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`project_procurement_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project procurement KPIs: spend, receipt performance, invoice status, and lead time tracking for supply chain and cost control."
  source: "`vibe_manufacturing_v1`.`project`.`procurement_item`"
  dimensions:
    - name: "procurement_category"
      expr: procurement_category
      comment: "Category of procurement (materials, services, equipment) for spend analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method (competitive bid, sole source, framework) for compliance monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the procurement item for governance tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the procurement item for AP management."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status for three-way matching and AP processing."
    - name: "is_received"
      expr: is_received
      comment: "Indicates whether goods/services have been received for GR/IR reconciliation."
    - name: "is_invoiced"
      expr: is_invoiced
      comment: "Indicates whether the item has been invoiced for AP liability tracking."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month bucket of delivery date for procurement schedule analysis."
  measures:
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net procurement spend. Core measure for project procurement cost tracking."
    - name: "total_total_price"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total price including all charges. Measures full procurement obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on procurement items. Required for total cost of ownership and tax reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount obtained on procurement. Measures procurement savings performance."
    - name: "total_line_quantity"
      expr: SUM(CAST(line_quantity AS DOUBLE))
      comment: "Total quantity procured. Drives material requirements and inventory planning."
    - name: "total_receipt_quantity"
      expr: SUM(CAST(receipt_quantity AS DOUBLE))
      comment: "Total quantity received. Used to compute receipt rate vs. ordered quantity."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across procurement items. Benchmarks supplier pricing performance."
    - name: "procurement_items_count"
      expr: COUNT(1)
      comment: "Total number of procurement items. Baseline for procurement activity volume."
    - name: "received_items_count"
      expr: COUNT(CASE WHEN is_received = TRUE THEN 1 END)
      comment: "Number of received procurement items. Measures goods receipt completion rate."
    - name: "invoiced_items_count"
      expr: COUNT(CASE WHEN is_invoiced = TRUE THEN 1 END)
      comment: "Number of invoiced procurement items. Tracks AP invoice processing completeness."
$$;